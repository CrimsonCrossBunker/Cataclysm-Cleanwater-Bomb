"""Mutation migration regressions using a Lua service test double."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import migrate_lua_first as migration


class MutationMigrationTest(unittest.TestCase):
    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_trait_query_ids_and_lists_preserve_participants_and_short_circuit(
        self,
    ):
        queries = []
        for prefix, target, observer in (
            ("u_", "actor", "partner"),
            ("npc_", "partner", "actor"),
        ):
            queries.extend(
                [
                    ({prefix + "has_any_trait": []}, "false", None, None),
                    (
                        {
                            prefix + "has_any_trait": [
                                "QUICK",
                                {"context_val": "missing"},
                            ]
                        },
                        "true",
                        target,
                        None,
                    ),
                    (
                        {
                            prefix + "has_any_trait": ["QUICK"] * 64 +
                            [{"context_val": "trait"}]
                        },
                        "true",
                        target,
                        None,
                    ),
                    (
                        {
                            prefix + "is_trait_purifiable": {
                                "context_val": "trait"
                            }
                        },
                        "true",
                        target,
                        None,
                    ),
                    (
                        {
                            prefix + "has_visible_trait": {
                                "context_val": "trait"
                            }
                        },
                        "true",
                        target,
                        observer,
                    ),
                    (
                        {prefix + "has_trait": {"u_val": "trait"}},
                        "true",
                        target,
                        None,
                    ),
                    (
                        {prefix + "has_trait": {"npc_val": "trait"}},
                        "true",
                        target,
                        None,
                    ),
                ]
            )
        for condition, expected, target, observer in queries:
            with self.subTest(condition=condition):
                expression = migration.render_eoc_condition_expression(
                    condition,
                    avatar_actor_proven=True,
                    npc_actor_expression="partner",
                )
                self.assertIsNotNone(expression)
                script = """
local actor, partner = {}, {}
local context = {data={trait='FELINE_EARS'}}
local function service_value(result) assert(result.ok); return result.value end
local services = {types={}, mutations={}, variables={}}
services.types.id = function(kind, id)
 assert(kind == 'mutation' and id ~= ''); return id
end
services.variables.resolve = function(data, owner, scope, key)
 assert(owner == (scope == 'u' and actor or partner))
 return {ok=true,value={value='FELINE_EARS'}}
end
"""
                raw = next(iter(condition.values()))
                match_quick = (
                    "false"
                    if isinstance(raw, list) and len(raw) > 64
                    else "true"
                )
                script += f"local match_quick = {match_quick}\n"
                if target is not None:
                    script += f"""
services.mutations.has = function(owner, id)
 assert(owner == {target});
 return {{ok=true,value=id == 'FELINE_EARS' or match_quick}}
end
services.mutations.is_purifiable = function(owner, id)
 assert(owner == {target} and id == 'FELINE_EARS');
 return {{ok=true,value=true}}
end
services.mutations.is_visible_to = function(subject, viewer, id)
 assert(subject == {target} and viewer == {observer or "nil"}
        and id == 'FELINE_EARS')
 return {{ok=true,value=true}}
end
"""
                script += f"assert(({expression}) == {expected})"
                result = subprocess.run(
                    ["lua", "-"], input=script, text=True, capture_output=True
                )
                self.assertEqual(result.returncode, 0, result.stderr)

    def test_checked_in_trait_condition_fragments(self):
        root = Path(__file__).resolve().parents[1]
        cases = [
            ("data/json/npcs/holdouts/Mr_Lapin.json", "u_has_any_trait"),
            (
                "data/json/npcs/refugee_center/surface_visitors/"
                "NPC_arsonist.json",
                "npc_has_visible_trait",
            ),
            (
                "data/mods/Xedra_Evolved/mutations/gracken_trait_eocs.json",
                "u_has_trait",
            ),
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
                found = list(
                    fragments(
                        json.loads((root / filename).read_text()), selector
                    )
                )
                self.assertTrue(found)
                for condition in found:
                    expression = migration.render_eoc_condition_expression(
                        condition,
                        avatar_actor_proven=True,
                        npc_actor_expression="partner",
                    )
                    self.assertIsNotNone(expression, condition)
                    self.assertIn("services.mutations.", expression)
                if selector == "npc_has_visible_trait":
                    self.assertIn("is_visible_to(partner, actor,", expression)
                if "gracken" in filename:
                    dynamic = [
                        condition
                        for condition in found
                        if isinstance(condition[selector], dict)
                    ]
                    self.assertTrue(dynamic)
                    expression = migration.render_eoc_condition_expression(
                        dynamic[0], avatar_actor_proven=True
                    )
                    self.assertIn('context.data["mutation_id"]', expression)

    def test_mutation_replacement_uses_native_action(self):
        for prefix, event in (
            ("u_", "game_start"),
            ("npc_", "npc_becomes_hostile"),
        ):
            for operation in (
                "add_trait",
            ):
                for trait in ("VULNERABLECHILL", {"context_val": "mutation"}):
                    with self.subTest(
                        prefix=prefix, operation=operation, trait=trait
                    ):
                        effect = {prefix + operation: trait}
                        result = self.migrate_effect(event, effect)
                        self.assertEqual(len(result.converted), 1)
                        self.assertEqual(result.partial, [])
                        self.assertFalse(
                            any(
                                todo.category == "semantic_choice"
                                for todo in result.todos
                            )
                        )
                        main = result.files[Path("main.lua")]
                        for method in ("grant", "remove", "set_active"):
                            self.assertNotIn(
                                "services.mutations." + method + "(", main
                            )
                        self.assertIsNotNone(
                            migration.render_static_false_effect(
                                effect, prefix == "u_", prefix == "npc_", {}
                            )
                        )

    @unittest.skipUnless(
        shutil.which("lua"),
        "Lua interpreter required for generated mutation execution",
    )
    def test_character_mutation_callback_uses_proven_alpha_and_empty_topic_item(self):
        eoc_id = "non_avatar_alpha_mutation"
        source = migration.SourceObject(
            Path("mutation_fixture.json"),
            0,
            {
                "type": "effect_on_condition",
                "id": eoc_id,
                "effect": {
                    "u_add_trait": {"u_val": "trait_id"},
                    "variant": {"mutator": "topic_item"},
                },
            },
        )
        rendered = migration.render_eoc(
            source,
            migration.MigrationResult(),
            eoc_actor_requirements={eoc_id: "character"},
            eoc_referenced_ids=frozenset({eoc_id}),
        )
        self.assertNotIn(
            "TODO", rendered.replace("review every TODO before enabling", "")
        )
        script = r"""
local selected = {is_avatar=false}
local calls = 0
local services = {
  variables = {resolve=function(data, owner, scope, key, participants)
    assert(owner == nil and scope == 'u' and key == 'trait_id')
    assert(participants.alpha == selected)
    return {ok=true, value={exists=true, value=data[key]}}
  end},
  types = {id=function(kind, id)
    assert(kind == 'mutation' and id == 'QUICK')
    return id
  end},
  mutations = {replace=function(target, id, variant)
    assert(target == selected and id == 'QUICK' and variant == '')
    calls = calls + 1
    return {ok=true, value={present=true}}
  end},
  characters = {avatar=function() error('must not select the avatar') end},
}
local function service_value(result)
  if not result.ok then error(result.error.message) end
  return result.value
end
local migrated_eoc_functions = {}
BODY
migrated_eoc_functions.non_avatar_alpha_mutation(
  {data={trait_id='QUICK', topic_item='LIVE_ITEM'}, item='LIVE_ITEM'}, selected)
assert(calls == 1)
""".replace("BODY", rendered)
        completed = subprocess.run(
            [shutil.which("lua"), "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(
        shutil.which("lua"),
        "Lua interpreter required for generated mutation execution",
    )
    def test_topic_item_id_lowers_to_empty_but_empty_variant_executes(self):
        rendered_functions = []
        for eoc_id, mutation_id, variant in (
            ("topic_item_mutation_id", {"mutator": "topic_item"}, "red"),
            ("topic_item_mutation_variant", "QUICK", {"mutator": "topic_item"}),
        ):
            source = migration.SourceObject(
                Path("mutation_fixture.json"),
                0,
                {
                    "type": "effect_on_condition",
                    "id": eoc_id,
                    "effect": {
                        "u_add_trait": mutation_id,
                        "variant": variant,
                    },
                },
            )
            rendered = migration.render_eoc(
                source,
                migration.MigrationResult(),
                eoc_actor_requirements={eoc_id: "character"},
                eoc_referenced_ids=frozenset({eoc_id}),
            )
            self.assertNotIn(
                "TODO", rendered.replace("review every TODO before enabling", "")
            )
            rendered_functions.append(rendered)
        self.assertIn('services.types.id("mutation", "")', rendered_functions[0])

        script = r"""
local selected = {is_avatar=false}
local calls = {}
local services = {
  types = {id=function(kind, id)
    assert(kind == 'mutation')
    if id == '' then error('invalid empty mutation ID') end
    return id
  end},
  mutations = {replace=function(target, id, variant)
    assert(target == selected)
    calls[#calls + 1] = {id=id, variant=variant}
    return {ok=true, value={present=id ~= ''}}
  end},
}
local function service_value(result)
  if not result.ok then error(result.error.message) end
  return result.value
end
local migrated_eoc_functions = {}
BODY
local copied_context = {data={topic_item='LIVE_ITEM'}, item='LIVE_ITEM'}
local ok, message = pcall(function()
  migrated_eoc_functions.topic_item_mutation_id(copied_context, selected)
end)
assert(not ok and string.find(message, 'invalid empty mutation ID', 1, true))
assert(#calls == 0)
migrated_eoc_functions.topic_item_mutation_variant(copied_context, selected)
assert(#calls == 1)
assert(calls[1].id == 'QUICK' and calls[1].variant == '')
""".replace("BODY", "\n".join(rendered_functions))
        completed = subprocess.run(
            [shutil.which("lua"), "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(
        shutil.which("lua"),
        "Lua interpreter required for generated mutation execution",
    )
    def test_mutation_alpha_proof_uses_character_fields_and_keeps_npc_as_beta(self):
        sources = (
            ("character_event_mutation", "character_takes_damage", "u_add_trait"),
            ("item_event_mutation", "character_wields_item", "u_add_trait"),
            ("npc_event_mutation", "npc_becomes_hostile", "npc_add_trait"),
        )
        rendered_functions = []
        for eoc_id, event, selector in sources:
            source = migration.SourceObject(
                Path("mutation_fixture.json"),
                0,
                {
                    "type": "effect_on_condition",
                    "id": eoc_id,
                    "required_event": event,
                    "effect": {selector: "QUICK"},
                },
            )
            rendered = migration.render_eoc(source, migration.MigrationResult())
            self.assertNotIn(
                "TODO", rendered.replace("review every TODO before enabling", "")
            )
            rendered_functions.append(rendered)

        unproven_source = migration.SourceObject(
            Path("mutation_fixture.json"),
            0,
            {
                "type": "effect_on_condition",
                "id": "npc_event_does_not_prove_u_alpha",
                "required_event": "npc_becomes_hostile",
                "effect": {"u_add_trait": "QUICK"},
            },
        )
        unproven = migration.render_eoc(
            unproven_source, migration.MigrationResult()
        )
        self.assertIn(
            "TODO: resolve an exact Character target", unproven
        )
        self.assertNotIn("services.mutations.replace(", unproven)

        script = r"""
local primary = {role='primary'}
local beta = {role='beta'}
local calls = {}
local services = {
  types = {id=function(kind, id)
    assert(kind == 'mutation' and id == 'QUICK'); return id
  end},
  mutations = {replace=function(target, id, variant)
    calls[#calls + 1] = {target=target, id=id, variant=variant}
    return {ok=true, value={present=true}}
  end},
}
local function service_value(result)
  if not result.ok then error(result.error.message) end
  return result.value
end
local runtime = {handler=function() end, on=function() end}
local migrated_eoc_functions = {}
BODY
migrated_eoc_functions.character_event_mutation(
  {actors={character=primary, beta=beta}}, nil)
migrated_eoc_functions.item_event_mutation(
  {actors={character=primary}}, nil)
migrated_eoc_functions.npc_event_mutation(
  {actors={npc=beta}}, nil)
assert(#calls == 3)
assert(calls[1].target == primary and calls[1].id == 'QUICK')
assert(calls[2].target == primary and calls[2].id == 'QUICK')
assert(calls[3].target == beta and calls[3].id == 'QUICK')
""".replace("BODY", "\n".join(rendered_functions))
        completed = subprocess.run(
            [shutil.which("lua"), "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    def test_false_branch_uses_native_mutation_replacement(self):
        for prefix, event in (
            ("u_", "game_start"),
            ("npc_", "npc_becomes_hostile"),
        ):
            for operation in (
                "add_trait",
            ):
                with self.subTest(prefix=prefix, operation=operation):
                    result = self.migrate_effect(
                        event,
                        "nothing",
                        condition={prefix + "has_trait": "QUICK"},
                        false_effect={prefix + operation: "VULNERABLECHILL"},
                    )
                    self.assertEqual(len(result.converted), 1)
                    self.assertFalse(
                        any(
                            todo.category == "semantic_choice"
                            for todo in result.todos
                        )
                    )
                    self.assertIn("services.mutations.replace(",
                                  result.files[Path("main.lua")])
                    for method in ("grant", "remove", "set_active"):
                        self.assertNotIn(
                            "services.mutations." + method + "(",
                            result.files[Path("main.lua")],
                        )

    def test_shipped_mutation_effects_keep_semantic_choices_located(self):
        root = Path(__file__).resolve().parents[1]
        for relative, identifier, expected_choices in (
            (
                "data/mods/Magiclysm/Spells/druid.json",
                "EOC_GAIN_WHISPER_LEAVES",
                1,
            ),
            (
                "data/mods/Xedra_Evolved/mutations/xe_lilin_trait_eocs.json",
                "EOC_LILIN_TEMPORARY_GLORIOUS_deactivate_future",
                1,
            ),
        ):
            with self.subTest(source=relative):
                objects = migration.load_objects([root / relative])
                selected = [
                    source
                    for source in objects
                    if source.value.get("id") == identifier
                ]
                self.assertEqual(len(selected), 1)
                result = migration.migrate(
                    selected, "shipped_mutation_regression"
                )
                choices = [
                    todo
                    for todo in result.todos
                    if todo.category == "semantic_choice"
                ]
                self.assertEqual(len(choices), expected_choices)
                if expected_choices:
                    self.assertEqual(result.converted, [])
                report = result.files[Path("MIGRATION_REPORT.md")]
                self.assertIn(relative, report)
                self.assertIn(identifier, report)
                self.assertIn("needs an explicit Platform trigger", report)
                self.assertIn("resolve an exact Character target", report)
                self.assertNotIn(
                    "choose mutation conflict replacement", report)
                for method in ("grant", "remove", "set_active"):
                    self.assertNotIn(
                        "services.mutations." + method + "(",
                        result.files[Path("main.lua")],
                    )

    def migrate_effect(self, event, effect, **extra):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "source.json"
            source.write_text(
                json.dumps(
                    {
                        "type": "effect_on_condition",
                        "id": "mutation_effect",
                        "required_event": event,
                        "effect": effect,
                        **extra,
                    }
                ),
                encoding="utf-8",
            )
            return migration.migrate(
                migration.load_objects([source]), "mutation_mod"
            )

    def test_mutation_type_removal_lowers_only_proven_literal_targets(self):
        for selector, event in (
            ("u_lose_mutation_type", "game_start"),
            ("npc_lose_mutation_type", "npc_becomes_hostile"),
        ):
            with self.subTest(selector=selector):
                result = self.migrate_effect(
                    event, {selector: "ACCLIMATIZATION"}
                )
                self.assertEqual(len(result.converted), 1)
                self.assertEqual(result.todos, [])
                self.assertIn(
                    'services.mutations.remove_type(actor, "ACCLIMATIZATION")',
                    result.files[Path("main.lua")],
                )

    def test_mutation_type_removal_keeps_unsupported_shapes_as_todos(self):
        for event, effect in (
            ("game_start", {"u_lose_mutation_type": {"context_val": "type"}}),
            (
                "game_start",
                {"u_lose_mutation_type": "ACCLIMATIZATION", "extra": 1},
            ),
            ("game_start", {"npc_lose_mutation_type": "ACCLIMATIZATION"}),
            (
                "npc_becomes_hostile",
                {"u_lose_mutation_type": "ACCLIMATIZATION"},
            ),
            ("game_start", {"u_lose_mutation_type": ""}),
            ("game_start", {"u_lose_mutation_type": "x" * 257}),
            ("game_start", {"u_lose_mutation_type": "type\0ignored"}),
        ):
            with self.subTest(event=event, effect=effect):
                result = self.migrate_effect(event, effect)
                self.assertEqual(result.converted, [])
                self.assertEqual(len(result.partial), 1)
                self.assertTrue(result.todos)
                self.assertNotIn(
                    "services.mutations.remove_type(",
                    result.files[Path("main.lua")],
                )
                self.assertIn(
                    "mutation-type removal requires a proven Character actor",
                    result.files[Path("MIGRATION_REPORT.md")],
                )

    def test_purifiability_requires_supported_id_and_proven_actor(self):
        for prefix in ("u", "npc"):
            selector = prefix + "_is_trait_purifiable"
            self.assertIsNone(
                migration.render_eoc_condition_expression({selector: "QUICK"})
            )
            proof = {
                "avatar_actor_proven"
                if prefix == "u"
                else "npc_actor_proven": True
            }
            for value in (
                {"npc_val" if prefix == "u" else "u_val": "trait"},
                "",
                "x" * 257,
                "trait\0ignored",
            ):
                with self.subTest(selector=selector, value=value):
                    self.assertIsNone(
                        migration.render_eoc_condition_expression(
                            {selector: value}, **proof
                        )
                    )

    @unittest.skipUnless(
        shutil.which("lua"),
        "Lua interpreter required for generated predicate execution",
    )
    def test_generated_purifiability_reads_live_actor_and_propagates_errors(
        self,
    ):
        for condition, proof in (
            (
                {"u_is_trait_purifiable": "VULNERABLECHILL"},
                {"avatar_actor_proven": True},
            ),
            (
                {"npc_is_trait_purifiable": "VULNERABLECHILL"},
                {"npc_actor_proven": True},
            ),
            (
                {"npc_is_trait_purifiable": "VULNERABLECHILL"},
                {"npc_actor_expression": "partner"},
            ),
        ):
            with self.subTest(condition=condition, proof=proof):
                expression = migration.render_eoc_condition_expression(
                    condition, **proof
                )
                self.assertIsNotNone(expression)
                target = (
                    "partner" if "npc_actor_expression" in proof else "actor"
                )
                # The static definition is deliberately always true. Runtime
                # Each call must consult the independently changing state.
                script = """
local actor = { purifiable = true }
local partner = { purifiable = true }
local calls = 0
local services = {
  types = { id = function(kind, id)
    assert(kind == 'mutation'); return id
  end },
  mutations = {
    definition = function()
      return { availability = { purifiable = true } }
    end,
    is_purifiable = function(character, id)
      calls = calls + 1
      assert(character == EXPECTED_TARGET)
      assert(id == 'VULNERABLECHILL')
      if character.stale then
        return { ok = false, error = { message = 'stale_world' } }
      end
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
                completed = subprocess.run(
                    [shutil.which("lua"), "-"],
                    input=script,
                    text=True,
                    capture_output=True,
                    timeout=10,
                )
                self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
