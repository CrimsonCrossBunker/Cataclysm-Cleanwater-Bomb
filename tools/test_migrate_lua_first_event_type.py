"""EOC trigger classification against the native loader's type gate."""

from pathlib import Path
import unittest

import migrate_lua_first


class LuaFirstEventTypeTest(unittest.TestCase):
    def test_required_event_is_a_trigger_only_for_event_eocs(self) -> None:
        for eoc_type in (None, "ACTIVATION", "EVENT"):
            with self.subTest(eoc_type=eoc_type):
                value = {
                    "type": "effect_on_condition",
                    "id": "type_gated_game_start",
                    "required_event": "game_start",
                    "effect": {"message": "type gate"},
                }
                if eoc_type is not None:
                    value["eoc_type"] = eoc_type
                rendered = migrate_lua_first.render_eoc(
                    migrate_lua_first.SourceObject(Path("source.json"), 0, value),
                    migrate_lua_first.MigrationResult(),
                )
                self.assertIn(
                    'runtime.handler("migrated.type_gated_game_start"', rendered
                )
                subscription = (
                    'runtime.on("game:game_start", '
                    '"migrated.type_gated_game_start")'
                )
                self.assertEqual(subscription in rendered, eoc_type == "EVENT")


if __name__ == "__main__":
    unittest.main()
