from __future__ import annotations

import shutil
import subprocess
from pathlib import Path
import unittest

import migrate_lua_first as migration


class LuaEffectNumericMigrationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.namespace = migration._migration_math_function_ids.set(
            migration.native_core_math_function_ids() | {"test_custom_formula"}
        )
        self.targets = {
            "u": ("alpha_mutator", "character"),
            "npc": ("beta_mutator", "character"),
            "read_u": ("alpha_reader", "character"),
            "read_npc": ("beta_reader", "monster"),
        }

    def tearDown(self) -> None:
        migration._migration_math_function_ids.reset(self.namespace)

    def render(self, effect: dict, targets=None) -> list[str] | None:
        return migration.render_dynamic_character_effect(
            effect,
            "u_add_effect",
            "recipient",
            avatar_expression="alpha_mutator",
            npc_expression="beta_mutator",
            target_kind="character",
            effect_actor_targets=self.targets if targets is None else targets,
        )

    def require_rendered(self, effect: dict) -> list[str]:
        lines = self.render(effect)
        self.assertIsNotNone(lines, effect)
        return lines or []

    def execute_lua(self, script: str) -> None:
        completed = subprocess.run(
            ["lua", "-"], input=script, text=True, capture_output=True, timeout=10
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_permissive_typed_reads_use_proven_owners_and_native_defaults(self) -> None:
        effects = [
            {
                "u_add_effect": "bleed",
                "duration": {"u_val": "missing_duration", "default": 6},
            },
            {
                "u_add_effect": "bleed",
                "duration": {"npc_val": "duration"},
            },
            {
                "u_add_effect": "bleed",
                "duration": 1,
                "intensity": {"context_val": "numeric_text", "default": 9},
            },
            {
                "u_add_effect": "bleed",
                "duration": 1,
                "intensity": {"context_val": "intensity_max"},
            },
            {
                "u_add_effect": "bleed",
                "duration": 1,
                "intensity": {"context_val": "intensity_min"},
            },
        ]
        generated = [line for effect in effects for line in self.require_rendered(effect)]
        source = "\n".join(generated)
        self.assertIn("services.variables.get_number(alpha_reader", source)
        self.assertIn("services.variables.get_number(beta_reader", source)
        self.assertIn("services.variables.get_context_number(context and context.data", source)
        self.assertNotIn("tonumber", source)
        self.assertNotIn("strict=true", source)

        script = r"""
local alpha_reader={values={}}
local beta_reader={values={duration=4.8}}
local alpha_mutator,beta_mutator={},{}
local recipient={}
local context={data={numeric_text="37.5",intensity_max=2147483647.9,
                     intensity_min=-2147483648.9}}
local reads,context_reads,added={}, {}, {}
local function service_value(result)
    assert(result.ok, result.error and result.error.code or "service failure")
    return result.value
end
local function number_result(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false,value=nil}} end
    -- Non-strict diag_value::dbl() returns zero on an incompatible stored type.
    if type(value)~="number" then return {ok=true,value={exists=true,value=0.0}} end
    return {ok=true,value={exists=true,value=value}}
end
local services={
    variables={
        get_number=function(owner,key,options)
            assert(options==nil or options.strict~=true,
                   "value_or_var reads use the permissive typed getter")
            assert(owner==alpha_reader or owner==beta_reader,
                   "math actor proofs must use read_u/read_npc owners")
            reads[#reads+1]={owner=owner,key=key}
            return number_result(owner.values,key)
        end,
        get_context_number=function(data,key,options)
            assert(data==context.data)
            assert(options==nil or options.strict~=true)
            context_reads[#context_reads+1]=key
            return number_result(data,key)
        end,
    },
    types={id=function(kind,value) assert(kind=="effect");return value end},
    time={duration=function(turns,unit) assert(unit=="turn");return turns end},
    effects={add=function(target,id,duration,options)
        assert(target==recipient and id=="bleed")
        added[#added+1]={duration=duration,options=options}
        return {ok=true,value=true}
    end},
}
""" + source + r"""
assert(#reads==2 and reads[1].owner==alpha_reader and reads[1].key=="missing_duration")
assert(reads[2].owner==beta_reader and reads[2].key=="duration")
assert(#context_reads==3 and context_reads[1]=="numeric_text" and
       context_reads[2]=="intensity_max" and context_reads[3]=="intensity_min")
assert(#added==5)
assert(added[1].duration==6.0, "missing values use the authored default")
assert(added[2].duration==4.0, "numeric values truncate toward zero")
assert(added[3].duration==1.0 and added[3].options.intensity==0.0,
       "a numeric string is present but Native's permissive numeric read yields zero")
assert(added[4].options.intensity==2147483647 and
       added[5].options.intensity==-2147483648,
       "dynamic intensity truncates to the signed int32 API range")
"""
        self.execute_lua(script)

        for role, scope in (("read_u", "u_val"), ("read_npc", "npc_val")):
            without_proof = dict(self.targets)
            without_proof[role] = None
            with self.subTest(role=role):
                self.assertIsNone(self.render({
                    "u_add_effect": "bleed", "duration": 1, "intensity": {scope: "dose"},
                }, without_proof))

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_reverse_fractional_and_singleton_ranges_take_native_rng_path(self) -> None:
        cases = [
            ({"duration": ["2 turns", "-1 turn"]}, (-1, 2, 2), 2, None),
            ({"duration": ["4 turns", "4 turns"]}, (4, 4, 4), 4, None),
            ({"intensity": [2.9, -1.9]}, (-1, 2, 2), 1, 2),
            ({"intensity": [4.9, 4.1]}, (4, 4, 4), 1, 4),
        ]
        generated: list[str] = []
        for numeric, _draw, _duration, _intensity in cases:
            effect = {"u_add_effect": "bleed", "duration": 1, **numeric}
            if "duration" in numeric:
                effect["intensity"] = 0
            generated.extend(self.require_rendered(effect))
        source = "\n".join(generated)
        self.assertNotIn("services.random.int(", source)
        self.assertNotIn("services.gameplay.math.evaluate", source)

        script = r"""
local recipient={}
local expected={{-1,2,2},{4,4,4},{-1,2,2},{4,4,4}}
local draws,added={},{}
local function service_value(result)
    assert(result.ok, result.error and result.error.code or "service failure")
    return result.value
end
local services={
    random={native_int=function(lower,upper)
        local call=expected[#draws+1]
        assert(call and lower==call[1] and upper==call[2])
        draws[#draws+1]={lower,upper}
        return call[3]
    end},
    types={id=function(kind,value) assert(kind=="effect");return value end},
    time={duration=function(turns,unit) assert(unit=="turn");return turns end},
    effects={add=function(target,id,duration,options)
        assert(target==recipient and id=="bleed")
        added[#added+1]={duration=duration,options=options}
        return {ok=true,value=true}
    end},
}
""" + source + r"""
assert(#draws==4 and #added==4)
assert(added[1].duration==2 and added[2].duration==4)
assert(added[3].duration==1 and added[3].options.intensity==2)
assert(added[4].duration==1 and added[4].options.intensity==4)
"""
        self.execute_lua(script)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_dynamic_duration_keeps_signed_int32_values_and_guards_invalid_values(self) -> None:
        supported = self.require_rendered({
            "u_add_effect": "bleed", "duration": {"context_val": "duration"},
        })
        math_fraction = self.require_rendered({
            "u_add_effect": "bleed", "duration": {"math": ["-1.8"]},
        })
        missing_with_unit_default = self.require_rendered({
            "u_add_effect": "bleed",
            "duration": {"context_val": "missing_duration", "default": "2 minutes"},
        })
        long_unit = self.require_rendered({
            "u_add_effect": "bleed", "duration": "366 days",
        })
        infinite_unit = self.require_rendered({
            "u_add_effect": "bleed", "duration": "infinite",
        })
        invalid_math = [
            self.require_rendered({"u_add_effect": "bleed", "duration": {"math": [expression]}})
            for expression in ("1/0", "0/0", "2147483648", "-2147483649")
        ]
        for invalid_duration in (
            1.0,
            [1.0, 2],
            {"context_val": "duration", "default": 1.0},
        ):
            with self.subTest(invalid_duration=invalid_duration):
                self.assertIsNone(self.render({"u_add_effect": "bleed", "duration": invalid_duration}))

        script = r"""
local recipient={}
local context={data={duration=0.0}}
local durations,added={},{}
local function service_value(result)
    assert(result.ok, result.error and result.error.code or "service failure")
    return result.value
end
local services={
    variables={get_context_number=function(data,key,options)
        assert(data==context.data and (key=="duration" or key=="missing_duration"))
        assert(options==nil or options.strict~=true)
        if data[key]==nil then return {ok=true,value={exists=false,value=nil}} end
        return {ok=true,value={exists=true,value=data[key]}}
    end},
    types={id=function(kind,value) assert(kind=="effect");return value end},
    time={duration=function(turns,unit)
        assert(unit=="turn")
        durations[#durations+1]=turns
        return turns
    end},
    effects={add=function(target,id,duration)
        assert(target==recipient and id=="bleed")
        added[#added+1]=duration
        return {ok=true,value=true}
    end},
}
local function apply_supported()
SUPPORTED
end
for _,case in ipairs({{-1.8,-1},{31622400,31622400},{-2147483648,-2147483648},
                      {2147483647,2147483647}}) do
    context.data.duration=case[1]
    apply_supported()
    assert(added[#added]==case[2])
end
assert(#added==4 and #durations==4)
assert(durations[1]==-1 and durations[2]==31622400 and
       durations[3]==-2147483648 and durations[4]==2147483647)
""".replace("SUPPORTED", "\n".join(supported))
        script += "\nlocal function apply_math_fraction()\n" + "\n".join(math_fraction) + "\nend\n"
        script += "assert(pcall(apply_math_fraction) and added[5]==-1)\n"
        script += "\nlocal function apply_unit_default()\n" + "\n".join(missing_with_unit_default) + "\nend\n"
        script += "assert(pcall(apply_unit_default) and added[6]==120)\n"
        script += "\nlocal function apply_long_unit()\n" + "\n".join(long_unit) + "\nend\n"
        script += "assert(pcall(apply_long_unit) and added[7]==31622400)\n"
        script += "\nlocal function apply_infinite_unit()\n" + "\n".join(infinite_unit) + "\nend\n"
        script += f"assert(pcall(apply_infinite_unit) and added[8]=={migration.NATIVE_JSON_INFINITE_DURATION_TURNS})\n"
        script += "assert(#added==8 and #durations==8)\n"
        script += "for _,bad in ipairs({2147483648,-2147483649,math.huge,-math.huge,0/0}) do\n"
        script += " context.data.duration=bad; local before=#added; assert(not pcall(apply_supported)); assert(#added==before)\nend\n"
        for index, lines in enumerate(invalid_math, 1):
            script += f"\nlocal function invalid_{index}()\n" + "\n".join(lines) + "\nend\n"
            script += f"assert(not pcall(invalid_{index}), 'invalid math duration {index} must fail')\n"
        script += "assert(#added==8 and #durations==8, 'invalid values must not reach the duration or effect APIs')\n"
        self.execute_lua(script)

        multi_draw = self.render({
            "u_add_effect": "bleed", "duration": ["1 turn", "3 turns"], "intensity": [2, 4],
        })
        self.assertIsNone(multi_draw, "duration and intensity draws have unspecified Native argument order")

    def test_random_argument_conflicts_are_classified_without_hiding_missing_read_proof(self) -> None:
        duration_range = ["1 turn", "3 turns"]
        intensity_range = [2, 4]
        sources = [
            migration.SourceObject(Path("effect_order.json"), 0, {
                "type": "effect_on_condition", "id": "normal_order",
                "required_event": "game_start", "eoc_type": "EVENT",
                "effect": [{
                    "u_add_effect": "bleed", "duration": duration_range,
                    "intensity": intensity_range,
                }],
            }),
            migration.SourceObject(Path("effect_order.json"), 1, {
                "type": "effect_on_condition", "id": "false_order",
                "required_event": "game_start", "eoc_type": "EVENT",
                "condition": {"or": []}, "effect": "nothing",
                "false_effect": [{
                    "u_add_effect": "bleed", "duration": duration_range,
                    "intensity": intensity_range,
                }],
            }),
            migration.SourceObject(Path("effect_order.json"), 2, {
                "type": "effect_on_condition", "id": "unproven_read_order",
                "required_event": "game_start", "eoc_type": "EVENT",
                "effect": [{
                    "u_add_effect": "bleed", "duration": duration_range,
                    "intensity": {"npc_val": "dose"},
                }],
            }),
        ]
        result = migration.migrate(sources, "effect_order_test")
        categories = {
            name: next(todo.category for todo in result.todos if f"EOC {name} " in todo.message)
            for name in ("normal_order", "false_order", "unproven_read_order")
        }
        self.assertEqual(categories["normal_order"], "semantic_choice")
        self.assertEqual(categories["false_order"], "semantic_choice")
        self.assertEqual(categories["unproven_read_order"], "manual_rewrite")
        report = result.files[Path("MIGRATION_REPORT.md")]
        self.assertIn("### `semantic_choice` (2)", report)
        self.assertIn("### `manual_rewrite` (1)", report)
        self.assertIn("unproven_read_order effect #0 needs domain-service conversion", report)


if __name__ == "__main__":
    unittest.main()
