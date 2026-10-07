import io
import json
import unittest
from pathlib import Path

import polib

from lang.string_extractor.message import errors, messages, occurrences
from lang.string_extractor.parse import parse_json_file, parse_json_object
from lang.string_extractor.pot_export import write_to_pot


class NamedColorExtractionTest(unittest.TestCase):
    def setUp(self):
        messages.clear()
        occurrences.clear()
        errors.clear()
        self.addCleanup(messages.clear)
        self.addCleanup(occurrences.clear)
        self.addCleanup(errors.clear)

    def test_palette_names_export_with_runtime_context(self):
        palette = (Path(__file__).resolve().parents[2] /
                   "data/json/named_colors.json")
        names = {entry["name"] for entry in
                 json.loads(palette.read_text(encoding="utf-8"))}
        parse_json_file(str(palette))

        self.assertEqual(set(messages),
                         {("named_color", name) for name in names})
        output = io.StringIO()
        write_to_pot(output)
        pot = polib.pofile(output.getvalue())
        self.assertEqual({(entry.msgctxt, entry.msgid) for entry in pot},
                         {("named_color", name) for name in names})
        azure = pot.find("Azure blue", msgctxt="named_color")
        self.assertIsNotNone(azure)
        self.assertIn("Vehicle paint color name", azure.comment)

    def test_color_value_is_not_a_translation(self):
        parse_json_object({"type": "named_color", "name": "Agate grey",
                           "value": "#B2B8B2"}, "palette.json")
        self.assertEqual(set(messages), {("named_color", "Agate grey")})

    def test_explicit_i18n_opt_out_is_respected(self):
        parse_json_object({"type": "named_color", "name": "Test color",
                           "value": "#123456", "//I18N": False},
                          "palette.json")
        self.assertFalse(messages)


if __name__ == "__main__":
    unittest.main()
