import json
import tempfile
import unittest
from pathlib import Path

try:
    from .message import messages
    from .parse import (
        NON_GAME_DATA_DIRECTORIES,
        is_non_game_data_json,
        parse_json_file,
    )
except ImportError:
    try:
        from lang.string_extractor.message import messages
        from lang.string_extractor.parse import (
            NON_GAME_DATA_DIRECTORIES,
            is_non_game_data_json,
            parse_json_file,
        )
    except ImportError:
        from string_extractor.message import messages
        from string_extractor.parse import (
            NON_GAME_DATA_DIRECTORIES,
            is_non_game_data_json,
            parse_json_file,
        )


class JsonFileParsingTest(unittest.TestCase):
    def test_climate_station_names_are_not_game_text(self):
        root = Path(__file__).resolve().parents[2]
        messages.clear()
        self.addCleanup(messages.clear)

        parse_json_file(root / "data/json/regional_climate/us_stations.json")
        self.assertFalse(messages)

    def test_mounted_data_extracts_pet_slot_text(self):
        root = Path(__file__).resolve().parents[2]
        messages.clear()
        self.addCleanup(messages.clear)

        parse_json_file(root / "data/json/riding_config.json")
        self.assertFalse(messages)
        parse_json_file(root / "data/json/pet_slots/pet_slots.json")
        self.assertIn(("", "saddle"), messages)
        self.assertIn(("", "Holds tack used to control and ride a mount."),
                      messages)

    def test_thermal_wound_names_and_descriptions_are_translatable(self):
        root = Path(__file__).resolve().parents[2]
        messages.clear()
        self.addCleanup(messages.clear)

        parse_json_file(root / "data/json/thermal_wounds.json")
        for name in ("heat blister", "severe burn"):
            self.assertEqual(messages[("", name)][0].text_plural, name + "s")
        self.assertIn(("", "Painful blisters caused by exposure to heat."),
                      messages)
        self.assertIn(("", "A deep burn that makes it painful to use the "
                           "affected body part."), messages)

    def test_abstract_wound_and_treatment_supply_inherited_text(self):
        messages.clear()
        self.addCleanup(messages.clear)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "wounds.json"
            path.write_text(json.dumps([
                {"type": "wound", "abstract": "wound_template",
                 "name": "bruise", "description": "Tender skin."},
                {"type": "wound", "id": "minor_bruise",
                 "copy-from": "wound_template"},
                {"type": "wound_fix", "abstract": "fix_template",
                 "name": "cooling", "success_msg": "It feels better."},
                {"type": "wound_fix", "id": "cool_bruise",
                 "copy-from": "fix_template"},
            ]), encoding="utf-8")
            parse_json_file(path)
        self.assertEqual(messages[("", "bruise")][0].text_plural, "bruises")
        for text in ("Tender skin.", "cooling", "It feels better."):
            self.assertIn(("", text), messages)

    def test_schema_file_is_skipped_before_type_dispatch(self):
        with tempfile.TemporaryDirectory() as directory:
            schema = Path(directory) / "example.schema.json"
            schema.write_text(json.dumps({"type": "object"}),
                              encoding="utf-8")

            parse_json_file(schema)

    def test_platform_reference_directory_is_classified_as_non_game_data(self):
        reference_file = NON_GAME_DATA_DIRECTORIES[0] / "snapshot.json"

        self.assertTrue(is_non_game_data_json(reference_file))

    def test_unknown_type_in_game_json_still_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            game_data = Path(directory) / "game_data.json"
            game_data.write_text(json.dumps({"type": "unknown_game_type"}),
                                 encoding="utf-8")

            with self.assertRaisesRegex(
                    Exception,
                    "Unrecognized JSON data type 'unknown_game_type'"):
                parse_json_file(game_data)


if __name__ == "__main__":
    unittest.main()
