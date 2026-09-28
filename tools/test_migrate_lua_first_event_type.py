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

    def test_event_actor_requirement_needs_native_event_type(self) -> None:
        for eoc_type in (None, "ACTIVATION", "EVENT"):
            with self.subTest(eoc_type=eoc_type):
                value = {
                    "type": "effect_on_condition",
                    "id": "type_gated_damage",
                    "required_event": "character_takes_damage",
                    "effect": {"message": "type gate"},
                }
                if eoc_type is not None:
                    value["eoc_type"] = eoc_type
                source = migrate_lua_first.SourceObject(Path("source.json"), 0, value)
                requirements = migrate_lua_first._eoc_actor_requirements(
                    [source], frozenset(), frozenset(), frozenset(), frozenset()
                )
                self.assertEqual(
                    requirements["type_gated_damage"],
                    "character" if eoc_type == "EVENT" else "none",
                )

    def test_inline_callback_does_not_inherit_a_stray_event_actor(self) -> None:
        for eoc_type in (None, "ACTIVATION", "EVENT"):
            with self.subTest(eoc_type=eoc_type):
                value = {
                    "type": "effect_on_condition",
                    "id": "type_gated_parent",
                    "required_event": "game_start",
                    "effect": {"if": True, "then": {"message": "nested"}},
                }
                if eoc_type is not None:
                    value["eoc_type"] = eoc_type
                source = migrate_lua_first.SourceObject(Path("source.json"), 0, value)
                normalized = migrate_lua_first.normalize_inline_eocs([source], False)[0]
                self.assertEqual(len(normalized), 2)
                self.assertEqual(
                    normalized[1].value["__inline_actor_kind"],
                    "avatar" if eoc_type == "EVENT" else "inherit",
                )


if __name__ == "__main__":
    unittest.main()
