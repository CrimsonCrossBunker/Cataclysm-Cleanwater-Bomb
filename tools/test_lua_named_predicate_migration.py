"""Execute generated named predicates; native integration is a separate gate."""

import shutil
import subprocess
import unittest

import migrate_lua_first as migration


@unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
class NamedPredicateMigrationTest(unittest.TestCase):
    def test_stored_predicate_uses_evaluating_dialogue_beta(self):
        lines = migration.render_static_set_condition(
            {"set_condition": "beta_test", "condition": {"npc_has_trait": "QUICK"}},
            True, False, True, False, None, "actor", "actor",
        )
        self.assertIsNotNone(lines)
        query = migration.render_eoc_condition_expression(
            {"get_condition": "beta_test"}, avatar_actor_proven=True,
            npc_actor_expression="context.actors.beta",
        )
        self.assertIsNotNone(query)
        script = "\n".join([
            "local actor, new_partner = {}, {}",
            "local context = { actors = { alpha = actor, beta = actor } }",
            "local function service_value(result) assert(result.ok); return result.value end",
            "local services = { types = { id = function(kind, id) return id end },",
            "mutations = { has = function(owner, id)",
            "assert(id == 'QUICK'); return {ok=true, value=owner == new_partner} end } }",
            "\n".join(lines),
            "assert(not (" + query + "))",
            "local parent = context",
            "local child = {actors={alpha=actor, beta=new_partner}, conditions={}}",
            "for name, predicate in pairs(context.conditions) do child.conditions[name]=predicate end",
            "context = child",
            "assert(" + query + ", 'stored predicate reused the defining participant mapping')",
            "context = parent",
            "assert(not (" + query + "))",
        ])
        result = subprocess.run(
            [shutil.which("lua"), "-"], input=script, text=True,
            capture_output=True, check=False, timeout=10,
        )
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_empty_named_predicate_can_be_written_read_and_replaced(self):
        def setter(expression):
            lines = migration.render_static_set_condition(
                {"set_condition": "", "condition": {"math": [expression]}},
                True, False, False, False, None, "actor", None,
            )
            self.assertIsNotNone(lines)
            return "\n".join(lines)

        query = migration.render_eoc_condition_expression(
            {"get_condition": ""}, avatar_actor_proven=True,
        )
        self.assertIsNotNone(query)
        # const_dialogue stores empty keys normally, returns false when absent,
        # and replaces the predicate on a second assignment to the same key.
        script = "\n".join([
            "local actor = {}",
            "local context = {}",
            "assert(not (" + query + "))",
            setter("1 == 1"),
            "assert(type(context.conditions[\"\"]) == \"function\")",
            "assert(" + query + ")",
            setter("1 == 2"),
            "assert(not (" + query + "))",
        ])
        result = subprocess.run(
            [shutil.which("lua"), "-"], input=script, text=True,
            capture_output=True, check=False, timeout=10,
        )
        self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == "__main__":
    unittest.main()
