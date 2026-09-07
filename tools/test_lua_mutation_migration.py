"""Focused mutation migration regressions; Lua execution uses a service test double."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import migrate_lua_first as migration


class MutationMigrationTest(unittest.TestCase):
    def migrate_effect(self, event, effect):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "source.json"
            source.write_text(json.dumps({
                "type": "effect_on_condition", "id": "mutation_effect",
                "required_event": event, "effect": effect,
            }), encoding="utf-8")
            return migration.migrate(migration.load_objects([source]), "mutation_mod")

    def test_mutation_type_removal_lowers_only_proven_literal_targets(self):
        for selector, event in (
            ("u_lose_mutation_type", "game_start"),
            ("npc_lose_mutation_type", "npc_becomes_hostile"),
        ):
            with self.subTest(selector=selector):
                result = self.migrate_effect(event, {selector: "ACCLIMATIZATION"})
                self.assertEqual(len(result.converted), 1)
                self.assertEqual(result.todos, [])
                self.assertIn(
                    'services.mutations.remove_type(actor, "ACCLIMATIZATION")',
                    result.files[Path("main.lua")],
                )

    def test_mutation_type_removal_keeps_unsupported_shapes_as_todos(self):
        for event, effect in (
            ("game_start", {"u_lose_mutation_type": {"context_val": "type"}}),
            ("game_start", {"u_lose_mutation_type": "ACCLIMATIZATION", "extra": 1}),
            ("game_start", {"npc_lose_mutation_type": "ACCLIMATIZATION"}),
            ("npc_becomes_hostile", {"u_lose_mutation_type": "ACCLIMATIZATION"}),
            ("game_start", {"u_lose_mutation_type": ""}),
            ("game_start", {"u_lose_mutation_type": "x" * 257}),
            ("game_start", {"u_lose_mutation_type": "type\0ignored"}),
        ):
            with self.subTest(event=event, effect=effect):
                result = self.migrate_effect(event, effect)
                self.assertEqual(result.converted, [])
                self.assertEqual(len(result.partial), 1)
                self.assertTrue(result.todos)
                self.assertNotIn("services.mutations.remove_type(", result.files[Path("main.lua")])
                self.assertIn("mutation-type removal requires a proven Character actor",
                              result.files[Path("MIGRATION_REPORT.md")])

    def test_purifiability_requires_supported_id_and_proven_actor(self):
        for prefix in ("u", "npc"):
            selector = prefix + "_is_trait_purifiable"
            self.assertIsNone(migration.render_eoc_condition_expression({selector: "QUICK"}))
            proof = {"avatar_actor_proven" if prefix == "u" else "npc_actor_proven": True}
            for value in ({"u_val": "trait"}, "", "x" * 257, "trait\0ignored"):
                with self.subTest(selector=selector, value=value):
                    self.assertIsNone(migration.render_eoc_condition_expression(
                        {selector: value}, **proof))

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required for generated predicate execution")
    def test_generated_purifiability_reads_live_actor_and_propagates_errors(self):
        for condition, proof in (
            ({"u_is_trait_purifiable": "VULNERABLECHILL"}, {"avatar_actor_proven": True}),
            ({"npc_is_trait_purifiable": "VULNERABLECHILL"}, {"npc_actor_proven": True}),
            ({"npc_is_trait_purifiable": "VULNERABLECHILL"}, {"npc_actor_expression": "partner"}),
        ):
            with self.subTest(condition=condition, proof=proof):
                expression = migration.render_eoc_condition_expression(condition, **proof)
                self.assertIsNotNone(expression)
                target = "partner" if "npc_actor_expression" in proof else "actor"
                # The static definition is deliberately always true. Runtime
                # state flips independently and must be consulted on every call.
                script = """
local actor = { purifiable = true }
local partner = { purifiable = true }
local calls = 0
local services = {
  types = { id = function(kind, id) assert(kind == 'mutation'); return id end },
  mutations = {
    definition = function() return { availability = { purifiable = true } } end,
    is_purifiable = function(character, id)
      calls = calls + 1
      assert(character == EXPECTED_TARGET)
      assert(id == 'VULNERABLECHILL')
      if character.stale then return { ok = false, error = { message = 'stale_world' } } end
      return { ok = true, value = character.purifiable }
    end,
  },
}
local function service_value(result)
  if not result.ok then error(result.error.message) end
  return result.value
end
local function predicate() return EXPRESSION end
assert(predicate() == true)
EXPECTED_TARGET.purifiable = false
assert(predicate() == false)
EXPECTED_TARGET.purifiable = true
assert(predicate() == true)
EXPECTED_TARGET.stale = true
local ok, message = pcall(predicate)
assert(not ok and string.find(message, 'stale_world', 1, true))
assert(calls == 4)
""".replace("EXPECTED_TARGET", target).replace("EXPRESSION", expression)
                completed = subprocess.run([shutil.which("lua"), "-"], input=script,
                                           text=True, capture_output=True, timeout=10)
                self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
