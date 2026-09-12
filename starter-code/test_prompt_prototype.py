"""Offline tests: deterministic guards and mocked SDK wiring, not LLM accuracy."""
import json
import os
import unittest
from types import SimpleNamespace
from unittest.mock import patch
import prompt_prototype as app


class BoundaryTests(unittest.TestCase):
    def test_approved_categories(self):
        for category in app.CATEGORIES:
            with self.subTest(category=category):
                data = app.fallback_draft()
                data.update(category=category, draft=app.DRAFTS[category])
                data["reason_code"] = "UNCLEAR_REQUEST" if category == "HUMAN_REVIEW" else "ADMIN_REQUEST"
                self.assertEqual(app.validate_output(json.dumps(data)), data)

    def test_reject_unsafe_mutations(self):
        mutations = [
            ("status", "SENT"), ("action", "send"),
            ("requires_human_review", False), ("requires_human_review", "true"),
            ("requires_human_review", 1), ("category", "CARDIOLOGY"),
            ("category", []), ("reason_code", "ADMIN_REQUEST"),
            ("reason_code", None), ("draft", "Đã đặt lịch thành công."),
            ("draft", "[DRAFT_ONLY] Uống thuốc X 3 lần/ngày."),
            ("draft", "[DRAFT_ONLY] Bệnh án PATIENT_TEST_001"),
        ]
        for field, value in mutations:
            with self.subTest(field=field, value=value):
                data = app.fallback_draft()
                data[field] = value
                with self.assertRaises(ValueError):
                    app.validate_output(json.dumps(data))

    def test_reject_invalid_json_and_shape(self):
        valid = json.dumps(app.fallback_draft())
        for raw in ("", "not JSON", "[]", "null", "```json\n" + valid + "\n```", valid + valid,
                    valid[:-1] + ', "status": "SENT"}'):
            with self.subTest(raw=raw), self.assertRaises(ValueError):
                app.validate_output(raw)

    def test_reject_extra_and_missing_fields(self):
        data = app.fallback_draft()
        data["diagnosis"] = "private information"
        with self.assertRaises(ValueError):
            app.validate_output(json.dumps(data))
        for field in app.OUTPUT_SCHEMA["required"]:
            data = app.fallback_draft()
            del data[field]
            with self.subTest(field=field), self.assertRaises(ValueError):
                app.validate_output(json.dumps(data))

    def test_reject_mismatched_draft(self):
        data = app.fallback_draft()
        data["draft"] = app.DRAFTS["BILLING"]
        with self.assertRaises(ValueError):
            app.validate_output(json.dumps(data))

    def test_fallback_is_valid_and_independent(self):
        first = app.fallback_draft()
        self.assertEqual(app.validate_output(json.dumps(first)), first)
        first["action"] = "send"
        self.assertEqual(app.fallback_draft()["action"], "human_review")

    def test_missing_key_is_not_reported_as_success(self):
        with patch.dict(os.environ, {}, clear=True), self.assertRaises(RuntimeError):
            app.evaluate_prompt("Yêu cầu giả lập")

    def test_invalid_input(self):
        for value in (None, "", "  ", "a" * 4001):
            with self.subTest(value=str(value)[:10]), self.assertRaises(ValueError):
                app.evaluate_prompt(value)

    def test_sdk_system_instruction_and_raw_response(self):
        from google import genai
        raw = json.dumps(app.fallback_draft())
        with patch.dict(os.environ, {"GEMINI_API_KEY": "fake-unit-test-key"}), patch.object(genai, "Client") as factory:
            client = factory.return_value.__enter__.return_value
            client.models.generate_content.return_value = SimpleNamespace(text=raw)
            self.assertEqual(app.evaluate_prompt("Dữ liệu giả lập"), raw)
            kwargs = client.models.generate_content.call_args.kwargs
            self.assertEqual(kwargs["model"], app.GEMINI_MODEL)
            self.assertEqual(kwargs["contents"], "Dữ liệu giả lập")
            self.assertEqual(kwargs["config"].system_instruction, app.SYSTEM_PROMPT)
            self.assertEqual(kwargs["config"].response_mime_type, "application/json")
            self.assertEqual(kwargs["config"].response_json_schema, app.OUTPUT_SCHEMA)

    def test_empty_response_and_api_error_propagate(self):
        from google import genai
        with patch.dict(os.environ, {"GEMINI_API_KEY": "fake-unit-test-key"}), patch.object(genai, "Client") as factory:
            call = factory.return_value.__enter__.return_value.models.generate_content
            call.return_value = SimpleNamespace(text=None)
            with self.assertRaises(ValueError):
                app.evaluate_prompt("Dữ liệu giả lập")
            call.side_effect = TimeoutError("synthetic timeout")
            with self.assertRaises(TimeoutError):
                app.evaluate_prompt("Dữ liệu giả lập")

    def test_live_runner_fails_on_api_error(self):
        with patch.object(app, "evaluate_prompt", side_effect=TimeoutError), patch("builtins.print"):
            self.assertEqual(app.run_live_tests(), 1)

    def test_live_runner_rejects_wrong_classification(self):
        with patch.object(app, "evaluate_prompt", return_value=json.dumps(app.fallback_draft())), patch("builtins.print"):
            self.assertEqual(app.run_live_tests(), 1)


if __name__ == "__main__":
    unittest.main()
