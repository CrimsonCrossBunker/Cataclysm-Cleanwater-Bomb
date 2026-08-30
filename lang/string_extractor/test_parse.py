import json
import tempfile
import unittest
from pathlib import Path

try:
    from .parse import (
        NON_GAME_DATA_DIRECTORIES,
        is_non_game_data_json,
        parse_json_file,
    )
except ImportError:
    try:
        from lang.string_extractor.parse import (
            NON_GAME_DATA_DIRECTORIES,
            is_non_game_data_json,
            parse_json_file,
        )
    except ImportError:
        from string_extractor.parse import (
            NON_GAME_DATA_DIRECTORIES,
            is_non_game_data_json,
            parse_json_file,
        )


class JsonFileParsingTest(unittest.TestCase):
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
