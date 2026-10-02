"""Numeric migration boundaries independent of the retired expression API."""

import shutil
import subprocess
import unittest

import migrate_lua_first as migration


class LuaNumericMigrationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.namespace = migration._migration_math_function_ids.set(
            migration.native_core_math_function_ids() | {"custom_numeric"})

    def tearDown(self) -> None:
        migration._migration_math_function_ids.reset(self.namespace)

    def test_numeric_math_requires_read_owners_and_known_namespace(self) -> None:
        render = migration.render_eoc_numeric_expression
        targets = {"u": ("mutation_recipient", "character"),
                   "npc": ("mutation_fallback", "character"),
                   "read_u": ("alpha", "character"), "read_npc": None}
        self.assertIsNone(render({"math": ["u_value"]}, "0", "mutation_recipient"))
        self.assertIsNone(render({"math": ["n_value"]}, "0", "mutation_recipient", targets))
        self.assertIsNone(render({"math": ["v_pointer"]}, "0", "mutation_recipient", targets))
        self.assertIsNone(render({"math": ["custom_numeric"]}, "0"))
        self.assertIsNone(render({"math": ["unknown_function(2)"]}, "0"))
        self.assertIsNone(render({"math": ["u_value = 3"]}, "0", "alpha", targets))
        for token in ("global_value", "_context_value", "u_", "n_", "v_", "_"):
            self.assertIsNotNone(render({"math": [token]}, "0"), token)
        targets["read_npc"] = ("beta", "character")
        rendered = render({"math": ["u_value + n_value"]}, "0", "mutation_recipient", targets)
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
    def test_numeric_math_uses_typed_reads_and_aborts_the_whole_expression(self) -> None:
        targets = {"read_u": ("alpha", "character"), "read_npc": ("beta", "character")}
        expression = migration.render_eoc_numeric_expression(
            {"math": ["u_value + n_value + _value + global_value"]}, "0", "other", targets)
        self.assertIsNotNone(expression)
        script = r"""
local alpha, beta, other = {}, {}, {}
local context = {data={value=3}}
local calls,diagnostics,bad,stale = {},0,false,false
local function read(owner,key,options,value)
    assert(options.strict and key=='value')
    calls[#calls+1]=owner
    if bad and owner==beta then
        return {ok=false,error={code='variable_type_mismatch',message='not numeric'}}
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
assert(calls[1]==alpha and calls[2]==beta and calls[3]=='context' and calls[4]=='global')
bad,calls=true,{}
assert(evaluate()==0 and #calls==2 and diagnostics==1)
bad,stale,calls=false,true,{}
local ok,message=pcall(evaluate)
assert(not ok and message=='stale_runtime' and #calls==2 and diagnostics==1)
""".replace("EXPRESSION", expression)
        completed = subprocess.run(["lua", "-"], input=script, text=True,
                                   capture_output=True, timeout=10)
        self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
