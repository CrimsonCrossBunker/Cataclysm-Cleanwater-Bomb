import contextlib
import io
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from extract_translations import extract, main


class ExtractTranslationsTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.source = self.root / "main.lua"
        self.source.write_text('ccb.services.translate("hello")\n', encoding="utf-8")

    @unittest.skipUnless(shutil.which("xgettext"), "GNU xgettext is not installed")
    def test_no_messages_produces_a_valid_empty_template(self):
        self.source.write_text("local value = 42\n", encoding="utf-8")
        output = extract([self.source])
        self.assertIn('charset=UTF-8', output)
        self.assertEqual(output.count('msgid '), 1)
        self.assertNotIn("POT-Creation-Date", output)

    @unittest.skipUnless(shutil.which("xgettext"), "GNU xgettext is not installed")
    def test_format_flags_follow_enclosing_string_format(self):
        self.source.write_text('string.format(ccb.services.translate_plural('
                               '"%d apple", "%d apples", n, "fruit"), n)', encoding="utf-8")
        output = extract([self.source])
        self.assertIn("#, lua-format", output)
        self.assertIn('msgctxt "fruit"', output)

    def test_failed_extractor_is_not_success(self):
        with patch("extract_translations.subprocess.run", return_value=
                   subprocess.CompletedProcess([], 1, "", "parse error")):
            with self.assertRaisesRegex(ValueError, "parse error"):
                extract([self.source])

    def test_missing_tool_has_actionable_error(self):
        with patch("extract_translations.subprocess.run", side_effect=FileNotFoundError("missing")):
            with self.assertRaisesRegex(ValueError, "cannot run GNU xgettext"):
                extract([self.source])

    def test_no_source_execution_or_directory_traversal(self):
        with self.assertRaisesRegex(ValueError, "existing Lua source"):
            extract([self.root])
        with self.assertRaisesRegex(ValueError, "at least one"):
            extract([])

    @unittest.skipUnless(shutil.which("xgettext"), "GNU xgettext is not installed")
    def test_context_plural_literals_and_no_execution(self):
        self.source.write_text('''
error("must never execute")
ccb.services.translate("Hello")
ccb.services.translate("Open", "verb")
ccb.services.translate_plural("apple", "apples", n)
ccb.services.translate_plural("pear", "pears", n, "fruit")
ccb.services.translate([[多行
文字]])
-- ccb.services.translate("comment is not a message")
ccb.services.translate(variable)
''', encoding="utf-8")
        output = extract([self.source])
        self.assertIn('msgid "Hello"', output)
        self.assertIn('msgctxt "verb"\nmsgid "Open"', output)
        self.assertIn('msgid "apple"\nmsgid_plural "apples"', output)
        self.assertIn('msgctxt "fruit"\nmsgid "pear"\nmsgid_plural "pears"', output)
        self.assertIn("多行", output)
        self.assertNotIn("comment is not a message", output)
        self.assertNotIn("must never execute", output)
        self.assertEqual(output, extract([self.source, self.source]))

    @unittest.skipUnless(shutil.which("xgettext"), "GNU xgettext is not installed")
    def test_check_does_not_write_and_rejects_input_overwrite(self):
        destination = self.root / "messages.pot"
        args = [str(self.source), "--output", str(destination)]
        with contextlib.redirect_stderr(io.StringIO()):
            self.assertEqual(main(args + ["--check"]), 1)
            self.assertFalse(destination.exists())
            self.assertEqual(main(args), 0)
            original = destination.read_bytes()
            self.assertEqual(main(args + ["--check"]), 0)
            self.source.write_text('ccb.services.translate("changed")', encoding="utf-8")
            self.assertEqual(main(args + ["--check"]), 1)
            self.assertEqual(destination.read_bytes(), original)
            source_bytes = self.source.read_bytes()
            self.assertEqual(main([str(self.source), "--output", str(self.source)]), 2)
            self.assertEqual(self.source.read_bytes(), source_bytes)


if __name__ == "__main__":
    unittest.main()
