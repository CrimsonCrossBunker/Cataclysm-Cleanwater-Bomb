from __future__ import annotations

import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import migrate_lua_first


class LuaMathAssignmentMigrationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.namespace_token = migrate_lua_first._migration_math_function_ids.set(
            frozenset({"test_custom_formula"})
        )
        self.targets = {
            "u": ("mutation_recipient", "character"),
            "npc": ("mutation_npc_fallback", "character"),
            "read_u": ("alpha", "character"),
            "read_npc": ("beta", "character"),
        }

    def tearDown(self) -> None:
        migrate_lua_first._migration_math_function_ids.reset(self.namespace_token)

    def render(self, fragments: list[str], targets=None) -> list[str] | None:
        return migrate_lua_first.render_static_character_math(
            {"math": fragments}, self.targets if targets is None else targets
        )

    def require_rendered(self, fragments: list[str]) -> list[str]:
        lines = self.render(fragments)
        self.assertIsNotNone(lines, fragments)
        return lines or []

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_assignments_and_all_compound_operators_execute_as_doubles(self) -> None:
        effects = [
            ["u_from_variable = u_source"],
            ["u_from_expression", " = ", "u_source", " * 1.5"],
            ["(u_compound) += 1.5"],
            ["u_compound -= 0.5"],
            ["u_compound *= 2"],
            ["u_compound /= 4"],
            ["u_compound %= 1"],
            ["u_compound++"],
            ["u_compound--"],
            ["n_result = n_source + 0.75"],
            ["n_result += 0.25"],
            ["u_missing_compound += 3.5"],
            ["u_missing_zero *= 4"],
            ["u_missing_rhs = u_absent_source + 2"],
            ["u_negative_zero = -0"],
            ["u_negative_zero *= -1"],
            ["_context_value = 3"],
            ["global_value = 5"],
        ]
        generated = [
            line
            for fragments in effects
            for line in self.require_rendered(fragments)
        ]
        source = "\n".join(generated)
        self.assertNotIn("mutation_recipient", source)
        self.assertNotIn("mutation_npc_fallback", source)
        self.assertIn("services.variables.get_number(alpha", source)
        self.assertIn('alpha, "from_variable"', source)
        self.assertIn("services.variables.get_number(beta", source)
        self.assertIn('beta, "result"', source)

        script = r"""
local alpha={values={
    source=3.25, compound=2.25
}}
local beta={values={source=8.5}}
local context={data={}}
local globals={}
local writes={}
local diagnostics={}
local function read(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~='number' then
        return {ok=false,error={code='variable_type_mismatch',message='not numeric'}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error('unproven variable owner')
end
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or 'service failure',0) end
    return result.value
end
local services={
    variables={
        get_number=function(owner,key,options)
            assert(options.strict==true)
            return read(actor_store(owner),key)
        end,
        get_global_number=function(key,options)
            assert(options.strict==true)
            return read(globals,key)
        end,
        get_context_number=function(data,key,options)
            assert(data==context.data and options.strict==true)
            return read(data,key)
        end,
        set=function(owner,key,value,options)
            assert(options.include_before==false)
            actor_store(owner)[key]=value
            writes[#writes+1]={owner=owner,key=key,value=value}
            return {ok=true,value=value}
        end,
        set_global=function(key,value,options)
            assert(options.include_before==false)
            globals[key]=value
            writes[#writes+1]={owner=nil,key=key,value=value}
            return {ok=true,value=value}
        end,
    },
    diagnostic=function(message) diagnostics[#diagnostics+1]=message end,
}
""" + source + r"""
assert(alpha.values.from_variable==3.25 and math.type(alpha.values.from_variable)=='float', 'variable RHS assignment')
assert(alpha.values.from_expression==4.875 and math.type(alpha.values.from_expression)=='float', 'expression RHS assignment')
assert(alpha.values.compound==0.625 and math.type(alpha.values.compound)=='float', 'compound operator chain')
assert(beta.values.result==9.5 and math.type(beta.values.result)=='float', 'exact beta compound assignment')
assert(alpha.values.missing_compound==3.5 and math.type(alpha.values.missing_compound)=='float', 'missing compound target defaults to zero')
assert(alpha.values.missing_zero==0 and math.type(alpha.values.missing_zero)=='float', 'missing zero remains double')
assert(alpha.values.missing_rhs==2 and math.type(alpha.values.missing_rhs)=='float', 'missing RHS defaults to zero')
assert(alpha.values.negative_zero==0 and math.type(alpha.values.negative_zero)=='float', 'signed zero double storage')
assert(1.0/alpha.values.negative_zero==-math.huge, 'compound multiplication preserves negative zero')
assert(context.data.context_value==3 and math.type(context.data.context_value)=='float', 'context assignment double storage')
assert(globals.global_value==5 and math.type(globals.global_value)=='float', 'global assignment double storage')
assert(#diagnostics==0, 'valid assignments have no diagnostics')
assert(#writes==17, 'one typed service write per successful actor/global assignment')
"""
        completed = subprocess.run(
            ["lua", "-"], input=script, text=True, capture_output=True, timeout=10
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_type_mismatch_does_not_write_compound_or_assignment_targets(self) -> None:
        effects = [
            ["u_bad_lhs += 4"],
            ["u_good_target = u_bad_rhs + 1"],
            ["u_good_target += u_bad_rhs"],
            ["u_after_failure = 4.5"],
        ]
        generated = [
            line
            for fragments in effects
            for line in self.require_rendered(fragments)
        ]
        script = r"""
local alpha={values={bad_lhs='keep this string',bad_rhs='also a string',good_target=7.25}}
local beta={values={}}
local context={data={}}
local writes,diagnostics={},{}
local function read(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~='number' then
        return {ok=false,error={code='variable_type_mismatch',message='not numeric'}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error('unproven variable owner')
end
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or 'service failure',0) end
    return result.value
end
local services={variables={
    get_number=function(owner,key,options)
        assert(options.strict==true)
        return read(actor_store(owner),key)
    end,
    set=function(owner,key,value,options)
        assert(options.include_before==false)
        actor_store(owner)[key]=value
        writes[#writes+1]={owner=owner,key=key,value=value}
        return {ok=true,value=value}
    end,
},diagnostic=function(message) diagnostics[#diagnostics+1]=message end}
""" + "\n".join(generated) + r"""
assert(alpha.values.bad_lhs=='keep this string')
assert(alpha.values.bad_rhs=='also a string')
assert(alpha.values.good_target==7.25 and math.type(alpha.values.good_target)=='float')
assert(alpha.values.after_failure==4.5 and math.type(alpha.values.after_failure)=='float')
assert(#writes==1)
assert(#diagnostics==3)
"""
        completed = subprocess.run(
            ["lua", "-"], input=script, text=True, capture_output=True, timeout=10
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_ieee_results_survive_one_typed_write_and_strict_readback(self) -> None:
        effects = [
            ["u_infinite /= 0"],
            ["u_infinite += 1"],
            ["u_nan = 0 / 0"],
            ["u_nan += 0"],
            ["global_infinite /= 0"],
            ["global_nan = 0 / 0"],
            ["global_nan += 0"],
        ]
        generated = [
            line
            for fragments in effects
            for line in self.require_rendered(fragments)
        ]
        script = r"""
local alpha={values={infinite=1.0}}
local beta={values={}}
local globals={global_infinite=1.0}
local reads,writes={},{}
local function read(store,key)
    reads[key]=(reads[key] or 0)+1
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~='number' then
        return {ok=false,error={code='variable_type_mismatch',message='not numeric'}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or 'service failure',0) end
    return result.value
end
local services={variables={
    get_number=function(owner,key,options)
        assert(owner==alpha and options.strict==true)
        return read(owner.values,key)
    end,
    get_global_number=function(key,options)
        assert(options.strict==true)
        return read(globals,key)
    end,
    set=function(owner,key,value,options)
        assert(owner==alpha and options.include_before==false)
        owner.values[key]=value
        writes[key]=(writes[key] or 0)+1
        return {ok=true,value=value}
    end,
    set_global=function(key,value,options)
        assert(options.include_before==false)
        globals[key]=value
        writes[key]=(writes[key] or 0)+1
        return {ok=true,value=value}
    end,
},diagnostic=function() error('unexpected numeric diagnostic') end}
""" + "\n".join(generated) + r"""
assert(alpha.values.infinite==math.huge)
assert(math.type(alpha.values.infinite)=='float')
assert(alpha.values.nan~=alpha.values.nan)
assert(alpha.values.nan~=0)
assert(math.type(alpha.values.nan)=='float')
assert(reads.infinite==2 and writes.infinite==2)
assert(reads.nan==1 and writes.nan==2)
assert(globals.global_infinite==math.huge and math.type(globals.global_infinite)=='float')
assert(globals.global_nan~=globals.global_nan and globals.global_nan~=0)
assert(math.type(globals.global_nan)=='float')
assert(reads.global_infinite==1 and writes.global_infinite==1)
assert(reads.global_nan==1 and writes.global_nan==2)
"""
        completed = subprocess.run(
            ["lua", "-"], input=script, text=True, capture_output=True, timeout=10
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    def test_unproven_owner_and_unsupported_assignments_stay_unlowered(self) -> None:
        unproven_u = {
            "u": ("mutation_recipient", "character"),
            "read_u": None,
        }
        self.assertIsNone(self.render(["u_value += 1"], unproven_u))
        unproven_npc = {
            "npc": ("mutation_npc_fallback", "character"),
            "read_npc": None,
        }
        self.assertIsNone(self.render(["n_value += n_increment"], unproven_npc))
        unsupported_owner_kind = {
            "u": ("item", "item"),
            "read_u": ("item", "item"),
        }
        self.assertIsNone(self.render(["u_value = 2"], unsupported_owner_kind))

        for expression in (
            "u_value = unknown_function(2)",
            "u_value = test_custom_formula(2)",
            "u_value = (u_other = 1)",
            "x_value = 3",
        ):
            with self.subTest(expression=expression):
                self.assertIsNone(self.render([expression]))

        compound_rng = {"math": ["u_value += rng(1, 3)"]}
        self.assertIsNone(self.render(compound_rng["math"]))
        choice = migrate_lua_first._math_assignment_order_choice(
            compound_rng, self.targets
        )
        self.assertIn("compiler-dependent", choice or "")

    def test_unsupported_shapes_remain_eoc_todos(self) -> None:
        unsupported = {
            "assignment_unknown_function": "u_value = unknown_function(2)",
            "assignment_nested": "u_value = (u_other = 1)",
            "assignment_bad_scope": "x_value = 3",
        }
        objects = [
            {
                "type": "effect_on_condition",
                "id": eoc_id,
                "eoc_type": "EVENT",
                "required_event": "game_start",
                "effect": {"math": [expression]},
            }
            for eoc_id, expression in unsupported.items()
        ]
        objects.append({
            "type": "effect_on_condition",
            "id": "assignment_unproven_npc",
            "eoc_type": "EVENT",
            "required_event": "npc_becomes_hostile",
            "effect": {"math": ["n_value += n_increment"]},
        })
        objects.append({
            "type": "effect_on_condition",
            "id": "assignment_compound_rng",
            "eoc_type": "EVENT",
            "required_event": "game_start",
            "effect": {"math": ["u_value += rng(1, 3)"]},
        })
        unsupported["assignment_unproven_npc"] = "n_value += n_increment"
        with tempfile.TemporaryDirectory() as temporary:
            source = Path(temporary) / "source.json"
            source.write_text(json.dumps(objects), encoding="utf-8")
            result = migrate_lua_first.migrate(
                migrate_lua_first.load_objects([source]), "math_assignment_test"
            )

        main = result.files[Path("main.lua")]
        report = result.files[Path("MIGRATION_REPORT.md")]
        self.assertNotIn("services.gameplay.math.apply", main)
        for eoc_id in unsupported:
            with self.subTest(eoc_id=eoc_id):
                self.assertIn(f"-- TODO: translate this math expression", main)
                self.assertIn(
                    f"EOC {eoc_id} effect #0 needs domain-service conversion",
                    report,
                )
        compound_rng_todo = [
            todo for todo in result.todos
            if "assignment_compound_rng" in todo.message
        ]
        self.assertEqual(len(compound_rng_todo), 1)
        self.assertEqual(compound_rng_todo[0].category, "semantic_choice")
        self.assertIn("compiler-dependent", main)


if __name__ == "__main__":
    unittest.main()
