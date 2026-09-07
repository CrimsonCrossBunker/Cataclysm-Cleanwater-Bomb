"""Focused mutation migration regressions; Lua execution uses a service test double."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import migrate_lua_first as migration


class MutationMigrationTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_trait_query_ids_and_lists_preserve_participants_and_short_circuit(self):
        queries = []
        for prefix, target, observer in (("u_", "actor", "partner"), ("npc_", "partner", "actor")):
            queries.extend([
                ({prefix + "has_any_trait": []}, "false", None, None),
                ({prefix + "has_any_trait": ["QUICK", {"context_val": "missing"}]}, "true", target, None),
                ({prefix + "has_any_trait": ["QUICK"] * 64 + [{"context_val": "trait"}]}, "true", target, None),
                ({prefix + "is_trait_purifiable": {"context_val": "trait"}}, "true", target, None),
                ({prefix + "has_visible_trait": {"context_val": "trait"}}, "true", target, observer),
                ({prefix + "has_trait": {"u_val": "trait"}}, "true", target, None),
                ({prefix + "has_trait": {"npc_val": "trait"}}, "true", target, None),
            ])
        for condition, expected, target, observer in queries:
            with self.subTest(condition=condition):
                expression = migration.render_eoc_condition_expression(
                    condition, avatar_actor_proven=True, npc_actor_expression="partner")
                self.assertIsNotNone(expression)
                script = """
local actor, partner = {}, {}
local context = {data={trait='FELINE_EARS'}}
local function service_value(result) assert(result.ok); return result.value end
local services = {types={}, mutations={}, variables={}}
services.types.id = function(kind, id) assert(kind == 'mutation' and id ~= ''); return id end
services.variables.resolve = function(data, owner, scope, key)
 assert(owner == (scope == 'u' and actor or partner))
 return {ok=true,value={value='FELINE_EARS'}}
end
"""
                raw = next(iter(condition.values()))
                script += "local match_quick = " + ("false" if isinstance(raw, list) and len(raw) > 64 else "true") + "\n"
                if target is not None:
                    script += f"""
services.mutations.has = function(owner, id)
 assert(owner == {target}); return {{ok=true,value=id == 'FELINE_EARS' or match_quick}}
end
services.mutations.is_purifiable = function(owner, id)
 assert(owner == {target} and id == 'FELINE_EARS'); return {{ok=true,value=true}}
end
services.mutations.is_visible_to = function(subject, viewer, id)
 assert(subject == {target} and viewer == {observer or "nil"} and id == 'FELINE_EARS')
 return {{ok=true,value=true}}
end
"""
                script += f"assert(({expression}) == {expected})"
                result = subprocess.run(["lua", "-"], input=script, text=True, capture_output=True)
                self.assertEqual(result.returncode, 0, result.stderr)

    def test_checked_in_trait_condition_fragments(self):
        root = Path(__file__).resolve().parents[1]
        cases = [
            ("data/json/npcs/holdouts/Mr_Lapin.json", "u_has_any_trait"),
            ("data/json/npcs/refugee_center/surface_visitors/NPC_arsonist.json", "npc_has_visible_trait"),
            ("data/mods/Xedra_Evolved/mutations/gracken_trait_eocs.json", "u_has_trait"),
        ]

        def fragments(value, selector):
            if isinstance(value, dict):
                if selector in value:
                    yield {selector: value[selector]}
                for child in value.values():
                    yield from fragments(child, selector)
            elif isinstance(value, list):
                for child in value:
                    yield from fragments(child, selector)

        for filename, selector in cases:
            with self.subTest(filename=filename):
                found = list(fragments(json.loads((root / filename).read_text()), selector))
                self.assertTrue(found)
                for condition in found:
                    expression = migration.render_eoc_condition_expression(
                        condition, avatar_actor_proven=True, npc_actor_expression="partner")
                    self.assertIsNotNone(expression, condition)
                    self.assertIn("services.mutations.", expression)
                if selector == "npc_has_visible_trait":
                    self.assertIn("is_visible_to(partner, actor,", expression)
                if "gracken" in filename:
                    dynamic = [condition for condition in found
                               if isinstance(condition[selector], dict)]
                    self.assertTrue(dynamic)
                    expression = migration.render_eoc_condition_expression(
                        dynamic[0], avatar_actor_proven=True)
                    self.assertIn('context.data["mutation_id"]', expression)

    def test_non_equivalent_mutation_writes_require_an_explicit_choice(self):
        for prefix, event in (("u_", "game_start"), ("npc_", "npc_becomes_hostile")):
            for operation in ("add_trait", "lose_trait", "activate_trait", "deactivate_trait"):
                for trait in ("VULNERABLECHILL", {"context_val": "mutation"}):
                    with self.subTest(prefix=prefix, operation=operation, trait=trait):
                        effect = {prefix + operation: trait}
                        result = self.migrate_effect(event, effect)
                        self.assertEqual(result.converted, [])
                        self.assertEqual(len(result.partial), 1)
                        self.assertTrue(any(todo.category == "semantic_choice" for todo in result.todos))
                        main = result.files[Path("main.lua")]
                        for method in ("grant", "remove", "set_active"):
                            self.assertNotIn("services.mutations." + method + "(", main)
                        self.assertIsNone(migration.render_static_false_effect(
                            effect, prefix == "u_", prefix == "npc_", {}))

    def test_false_branch_preserves_mutation_semantic_choice(self):
        for prefix, event in (("u_", "game_start"), ("npc_", "npc_becomes_hostile")):
            for operation in ("add_trait", "lose_trait", "activate_trait", "deactivate_trait"):
                with self.subTest(prefix=prefix, operation=operation):
                    result = self.migrate_effect(
                        event, "nothing", condition={prefix + "has_trait": "QUICK"},
                        false_effect={prefix + operation: "VULNERABLECHILL"})
                    self.assertEqual(result.converted, [])
                    self.assertTrue(any(todo.category == "semantic_choice" for todo in result.todos))
                    self.assertIn("false_effect #0", result.files[Path("MIGRATION_REPORT.md")])
                    for method in ("grant", "remove", "set_active"):
                        self.assertNotIn("services.mutations." + method + "(",
                                         result.files[Path("main.lua")])

    def test_shipped_mutation_effects_keep_semantic_choices_located(self):
        root = Path(__file__).resolve().parents[1]
        for relative, identifier, expected_choices in (
            ("data/mods/Magiclysm/Spells/druid.json", "EOC_GAIN_WHISPER_LEAVES", 2),
            ("data/mods/Xedra_Evolved/mutations/xe_lilin_trait_eocs.json",
             "EOC_LILIN_TEMPORARY_GLORIOUS_deactivate_future", 2),
        ):
            with self.subTest(source=relative):
                objects = migration.load_objects([root / relative])
                selected = [source for source in objects if source.value.get("id") == identifier]
                self.assertEqual(len(selected), 1)
                result = migration.migrate(selected, "shipped_mutation_regression")
                choices = [todo for todo in result.todos if todo.category == "semantic_choice"]
                self.assertGreaterEqual(len(choices), expected_choices)
                self.assertEqual(result.converted, [])
                report = result.files[Path("MIGRATION_REPORT.md")]
                self.assertIn(relative, report)
                self.assertIn(identifier, report)
                for method in ("grant", "remove", "set_active"):
                    self.assertNotIn("services.mutations." + method + "(",
                                     result.files[Path("main.lua")])

    def migrate_effect(self, event, effect, **extra):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "source.json"
            source.write_text(json.dumps({
                "type": "effect_on_condition", "id": "mutation_effect",
                "required_event": event, "effect": effect, **extra,
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
            for value in ({"npc_val" if prefix == "u" else "u_val": "trait"}, "", "x" * 257, "trait\0ignored"):
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
