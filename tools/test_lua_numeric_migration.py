"""Numeric migration boundaries independent of the retired expression API."""

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import migrate_lua_first as migration


class LuaNumericMigrationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.namespace = migration._migration_math_function_ids.set(
            migration.native_core_math_function_ids() | {"custom_numeric"}
        )

    def tearDown(self) -> None:
        migration._migration_math_function_ids.reset(self.namespace)

    def test_numeric_math_requires_read_owners_and_known_namespace(
        self,
    ) -> None:
        render = migration.render_eoc_numeric_expression
        targets = {
            "u": ("mutation_recipient", "character"),
            "npc": ("mutation_fallback", "character"),
            "read_u": ("alpha", "character"),
            "read_npc": None,
        }
        self.assertIsNone(
            render({"math": ["u_value"]}, "0", "mutation_recipient")
        )
        self.assertIsNone(
            render({"math": ["n_value"]}, "0", "mutation_recipient", targets)
        )
        self.assertIsNone(
            render({"math": ["v_pointer"]}, "0", "mutation_recipient", targets)
        )
        self.assertIsNone(render({"math": ["custom_numeric"]}, "0"))
        self.assertIsNone(render({"math": ["unknown_function(2)"]}, "0"))
        self.assertIsNone(
            render({"math": ["u_value = 3"]}, "0", "alpha", targets)
        )
        for token in ("global_value", "_context_value", "u_", "n_", "v_", "_"):
            self.assertIsNotNone(render({"math": [token]}, "0"), token)
        targets["read_npc"] = ("beta", "character")
        rendered = render(
            {"math": ["u_value + n_value"]}, "0", "mutation_recipient", targets
        )
        self.assertIn('get_number(alpha, "value", {strict=true})', rendered)
        self.assertIn('get_number(beta, "value", {strict=true})', rendered)
        self.assertNotIn("mutation_recipient", rendered)
        self.assertNotIn("mutation_fallback", rendered)
        self.assertNotIn("services.gameplay.math", rendered)
        token = migration._migration_math_function_ids.set(None)
        try:
            self.assertIsNone(render({"math": ["global_value"]}, "0"))
            self.assertIsNotNone(render({"math": ["1 + 2"]}, "0"))
        finally:
            migration._migration_math_function_ids.reset(token)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_numeric_math_uses_typed_reads_and_aborts_the_whole_expression(
        self,
    ) -> None:
        targets = {
            "read_u": ("alpha", "character"),
            "read_npc": ("beta", "character"),
        }
        expression = migration.render_eoc_numeric_expression(
            {"math": [("u_value + n_value + _value + global_value")]},
            "0",
            "other",
            targets,
        )
        self.assertIsNotNone(expression)
        script = r"""
local alpha, beta, other = {}, {}, {}
local context = {data={value=3}}
local calls,diagnostics,bad,stale = {},0,false,false
local function read(owner,key,options,value)
    assert(options.strict and key=='value')
    calls[#calls+1]=owner
    if bad and owner==beta then
        return {ok=false,error={code='variable_type_mismatch',
            message='not numeric'}}
    end
    if stale and owner==beta then
        return {ok=false,error={code='stale_runtime',message='stale'}}
    end
    return {ok=true,value={exists=true,value=value+0.0}}
end
local services={variables={
    get_number=function(owner,key,options)
        assert(owner==alpha or owner==beta)
        return read(owner,key,options,owner==alpha and 1 or 2)
    end,
    get_context_number=function(data,key,options)
        assert(data==context.data)
        return read('context',key,options,data[key])
    end,
    get_global_number=function(key,options)
        assert(key=='global_value')
        return read('global','value',options,4)
    end},
    diagnostic=function(message)
        diagnostics=diagnostics+1
        assert(string.find(message,'not numeric',1,true))
    end}
local function service_value(result)
    if not result.ok then error(result.error.code,0) end
    return result.value
end
local function evaluate() return EXPRESSION end
assert(evaluate()==10 and #calls==4 and diagnostics==0)
assert(calls[1]==alpha and calls[2]==beta and calls[3]=='context' and
    calls[4]=='global')
bad,calls=true,{}
assert(evaluate()==0 and #calls==2 and diagnostics==1)
bad,stale,calls=false,true,{}
local ok,message=pcall(evaluate)
assert(not ok and message=='stale_runtime' and #calls==2 and diagnostics==1)
""".replace("EXPRESSION", expression)
        completed = subprocess.run(
            ["lua", "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_assignment_failure_preserves_both_effect_branches(
        self,
    ) -> None:
        values = []
        for branch in (True, False):
            value = {
                "type": "effect_on_condition",
                "id": "assignment_" + str(branch),
                "eoc_type": "EVENT",
                "required_event": "game_start",
                "condition": {"math": ["1" if branch else "0"]},
            }
            value["effect" if branch else "false_effect"] = [
                {"math": ["_target += _source"]},
                {"math": ["_after = 7"]},
            ]
            values.append(value)
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "assignment.json"
            source.write_text(json.dumps(values), encoding="utf-8")
            result = migration.migrate(
                migration.load_objects([source]), "assignment_flow"
            )
        self.assertEqual(result.todos, [])
        self.assertEqual(len(result.converted), 2)
        main = result.files[Path("main.lua")]
        self.assertNotIn("services.gameplay.math", main)
        script = (
            r"""
local callbacks,diagnostics={},0
package.preload.ccb=function() return {
 content={},runtime={handler=function(id,fn) callbacks[id]=fn end,
     on=function() end},
 services={variables={get_context_number=function(data,key,options)
  assert(options.strict)
  local value=data[key]
  if type(value)=='string' then
   return {ok=false,error={code='variable_type_mismatch',
       message='bad stored type'}}
  end
  return {ok=true,value={exists=value~=nil,value=value}}
 end},diagnostic=function(message)
  diagnostics=diagnostics+1
  assert(message:find('bad stored type',1,true))
 end}}
end
""" +
            main +
            r"""
for _,id in ipairs({'migrated.assignment_True','migrated.assignment_False'}) do
 local context={data={target=19.0,source='bad'}}
 callbacks[id](context)
 assert(context.data.target==19.0 and context.data.after==7.0)
 context.data.source=3.0
 callbacks[id](context)
 assert(context.data.target==22.0 and context.data.after==7.0)
end
assert(diagnostics==2)
"""
        )
        completed = subprocess.run(
            ["lua", "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    def test_assignment_order_reports_known_choices_without_hiding_owner_gaps(
        self,
    ) -> None:
        values = [
            {
                "type": "effect_on_condition",
                "id": "normal_rng_assignment",
                "eoc_type": "EVENT",
                "required_event": "game_start",
                "effect": {"math": ["u_target += rng(1,3)"]},
            },
            {
                "type": "effect_on_condition",
                "id": "false_rng_assignment",
                "eoc_type": "EVENT",
                "required_event": "game_start",
                "condition": False,
                "false_effect": {"math": ["_target += rng(1,3)"]},
            },
            {
                "type": "effect_on_condition",
                "id": "missing_owner_assignment",
                "eoc_type": "EVENT",
                "required_event": "game_start",
                "effect": {"math": ["n_target += rng(1,3)"]},
            },
        ]
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "choices.json"
            source.write_text(json.dumps(values), encoding="utf-8")
            result = migration.migrate(
                migration.load_objects([source]), "assignment_choices"
            )
        choices = [
            todo for todo in result.todos if todo.category == "semantic_choice"
        ]
        self.assertEqual(len(choices), 2)
        self.assertTrue(
            all(
                ("compiler-dependent operand evaluation") in todo.message
                for todo in choices
            )
        )
        self.assertTrue(
            any(
                ("normal_rng_assignment effect #0") in todo.message
                for todo in choices
            )
        )
        self.assertTrue(
            any(
                ("false_rng_assignment false_effect #0") in todo.message
                for todo in choices
            )
        )
        other = [
            todo
            for todo in result.todos
            if ("missing_owner_assignment") in todo.message
        ]
        self.assertEqual(len(other), 1)
        self.assertEqual(other[0].category, "manual_rewrite")


if __name__ == "__main__":
    unittest.main()
