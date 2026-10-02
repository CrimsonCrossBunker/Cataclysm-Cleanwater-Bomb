from __future__ import annotations

import unittest
import shutil
import subprocess

import migrate_lua_first


class NativeMathDomainQueryTest(unittest.TestCase):
    def setUp(self) -> None:
        self.function_ids_token = migrate_lua_first._migration_math_function_ids.set(
            frozenset({"sample_mod_formula"})
        )
        self.actors = {
            "read_u": ("alpha", "character"),
            "read_npc": ("beta", "character"),
        }

    def tearDown(self) -> None:
        migrate_lua_first._migration_math_function_ids.reset(self.function_ids_token)

    def compile(self, source: str, actors=None) -> str | None:
        return migrate_lua_first.render_native_number_expression(
            {"math": [source]}, self.actors if actors is None else actors
        )

    def test_character_queries_lower_through_typed_services(self) -> None:
        health = self.compile("u_health()")
        spell_level = self.compile("u_spell_level('delay_spell') * 2")
        skill_level = self.compile("u_skill('talk')")
        npc_skill_level = self.compile("n_skill('talk')")

        self.assertIsNotNone(health)
        self.assertIn("services.needs.get(alpha)", health or "")
        self.assertNotIn("gameplay.math.evaluate", health or "")
        self.assertIsNotNone(spell_level)
        self.assertIn('services.spells.effective_level(alpha, "delay_spell")', spell_level or "")
        self.assertNotIn("services.spells.get(", spell_level or "")
        self.assertIsNotNone(skill_level)
        self.assertIn('services.skills.level(alpha, "talk")', skill_level or "")
        self.assertIn("math.modf(value)", skill_level or "")
        self.assertIn("truncated + 0.0", skill_level or "")
        self.assertIn('services.skills.level(beta, "talk")', npc_skill_level or "")

    def test_time_queries_use_typed_time_values(self) -> None:
        until_sunrise = self.compile("time_until('sunrise')")
        duration = self.compile("time('20 d')")

        self.assertIsNotNone(until_sunrise)
        self.assertIn("now:sunrise() - now", until_sunrise or "")
        self.assertIn('services.time.duration(1, "day")', until_sunrise or "")
        self.assertIsNotNone(duration)
        self.assertIn('services.time.duration(20, "day").turns', duration or "")

    def test_missing_or_unsupported_query_proofs_fail_closed(self) -> None:
        self.assertIsNone(self.compile("u_health()", {}))
        only_alpha = {"read_u": ("alpha", "character")}
        self.assertIsNone(self.compile("n_spell_level('delay_spell')", only_alpha))
        self.assertIsNone(self.compile("n_skill('talk')", only_alpha))
        monster = {"read_u": ("target", "monster")}
        monster_health = self.compile("u_health()", monster)
        self.assertIsNotNone(monster_health)
        self.assertIn("values[1] = 0.0", monster_health or "")
        self.assertNotIn("services.needs.get", monster_health or "")
        monster_skill = self.compile("u_skill('talk')", monster)
        self.assertIn("values[1] = 0.0", monster_skill or "")
        self.assertNotIn("services.skills.level", monster_skill or "")

    def test_unsupported_strings_and_custom_functions_are_rejected(self) -> None:
        for source in (
            "abs('1')",
            "u_health('delay_spell')",
            "u_spell_level(_spell_id)",
            "u_skill(_skill_id)",
            "time_until('night_time')",
            "custom_formula('delay_spell')",
        ):
            with self.subTest(source=source):
                self.assertIsNone(self.compile(source))

    def test_query_strings_follow_native_unbounded_backslash_stripping(self) -> None:
        escaped = self.compile("u_spell_level('delay\\\\spell')")
        long_id = "x" * 8193
        long_query = self.compile("u_spell_level('" + long_id + "')")
        nul_query = self.compile("u_spell_level('delay\0spell')")

        self.assertIn('services.spells.effective_level(alpha, "delayspell")', escaped or "")
        self.assertIsNotNone(long_query)
        self.assertIn(long_id, long_query or "")
        self.assertIn('"delay\\000spell"', nul_query or "")

    def test_single_rng_draw_can_use_a_typed_domain_query(self) -> None:
        expression = self.compile("rng(1, u_health())")
        skill_expression = self.compile("rng(1, u_skill('positive_fraction'))")

        self.assertIsNotNone(expression)
        self.assertIn("services.needs.get(alpha)", expression or "")
        self.assertIn("services.random.native_float", expression or "")
        self.assertIsNotNone(skill_expression)
        self.assertIn("services.skills.level(alpha", skill_expression or "")
        self.assertIn("services.random.native_float", skill_expression or "")
        safe_random = {"math": ["rng(1, u_skill('positive_fraction'))"]}
        self.assertIsNone(migrate_lua_first._math_random_order_choice(safe_random, self.actors))
        interacting = {"math": ["rng(1, u_skill('positive_fraction')) + rng(3, 4)"]}
        choice = migrate_lua_first._math_random_order_choice(interacting, self.actors)
        self.assertIn("compiler-dependent", choice or "")

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_skill_int_projection_rejects_native_undefined_cast_ranges(self) -> None:
        nonfinite_expression = self.compile("u_skill('nonfinite')")
        overflow_expression = self.compile("u_skill('overflow')")
        self.assertIsNotNone(nonfinite_expression)
        self.assertIsNotNone(overflow_expression)
        script = r"""
local alpha={}
local services={skills={level=function(_,id)
    return {ok=true,value=id=='nonfinite' and math.huge or 2147483648.0}
end}}
local function service_value(result)
    if not result.ok then error(result.error.code,0) end
    return result.value
end
local ok,message=pcall(function() return NONFINITE end)
assert(not ok and string.find(message,'requires a finite value',1,true))
ok,message=pcall(function() return OVERFLOW end)
assert(not ok and string.find(message,'exceeds the native int range',1,true))
""".replace("NONFINITE", nonfinite_expression).replace("OVERFLOW", overflow_expression)
        completed = subprocess.run(["lua", "-"], input=script, text=True,
                                   capture_output=True, timeout=10)
        self.assertEqual(completed.returncode, 0, completed.stderr)
        interacting = {"math": ["rng(1, u_health()) + rng(3, 4)"]}
        self.assertIsNone(migrate_lua_first.render_native_number_expression(interacting, self.actors))
        choice = migrate_lua_first._math_random_order_choice(interacting, self.actors)
        self.assertIn("compiler-dependent", choice or "")

        custom_collision = migrate_lua_first._migration_math_function_ids.set(
            frozenset({"u_health"})
        )
        try:
            self.assertIsNone(self.compile("u_health()"))
        finally:
            migrate_lua_first._migration_math_function_ids.reset(custom_collision)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_emitted_queries_execute_with_exact_owners_and_time_wrap(self) -> None:
        cases = (
            ("u_health() + n_health()", -1),
            ("u_spell_level('known') * 2", 8),
            ("n_spell_level('unknown')", -1),
            ("u_skill('positive_fraction')", 2),
            ("n_skill('negative_fraction')", -2),
            ("u_skill('unknown')", 0),
            ("u_skill('negative_zero')", 0),
            ("time('20 d')", 1728000),
            ("time('now')", 25200),
            ("time_until('sunrise')", 82800),
            ("rng(1, u_health())", 1.5),
            ("rng(1, u_skill('positive_fraction'))", 1.5),
        )
        for source, expected in cases:
            with self.subTest(source=source):
                expression = self.compile(source)
                self.assertIsNotNone(expression)
                script = r"""
local alpha,beta={},{}
local context={data={}}
local point_mt={}
point_mt.__index=point_mt
point_mt.__sub=function(a,b) return {turns=a.turns-b.turns} end
local function point(turns) return setmetatable({turns=turns},point_mt) end
point_mt.sunrise=function(self)
    return point(math.floor(self.turns/86400)*86400+21600)
end
local now=25200
local calls,draws=0,0
local services={
    needs={get=function(owner)
        assert(owner==alpha or owner==beta)
        calls=calls+1
        return {ok=true,value={lifestyle=owner==alpha and 2 or -3}}
    end},
    spells={effective_level=function(owner,id)
        assert(owner==alpha or owner==beta)
        assert(id=='known' or id=='unknown')
        calls=calls+1
        return {ok=true,value=id=='known' and 4 or -1}
    end},
    skills={level=function(owner,id)
        if id=='negative_fraction' then assert(owner==beta)
        else assert(owner==alpha) end
        local levels={positive_fraction=2.8,negative_fraction=-2.8,negative_zero=-0.8}
        return {ok=true,value=levels[id] or 0.0}
    end},
    time={now=function() return point(now) end,
          turn_zero=function() return point(0) end,
          duration=function(amount,unit)
              assert(unit=='day')
              return {turns=amount*86400}
          end},
    random={native_float=function(lo,hi)
        assert(lo==1 and hi==2)
        draws=draws+1
        return 1.5
    end}}
local function service_value(result) assert(result.ok);return result.value end
local function evaluate() return EXPRESSION end
assert(evaluate()==EXPECTED)
assert(math.type(evaluate())=='float')
if SOURCE=='rng(1, u_health())' then assert(draws==2 and calls==2) end
if SOURCE=="rng(1, u_skill('positive_fraction'))" then assert(draws==2) end
if SOURCE=="u_skill('negative_zero')" then assert(1/evaluate()==math.huge) end
if SOURCE=="time_until('sunrise')" then
    now=19800
    assert(evaluate()==1800)
end
""".replace("EXPRESSION", expression).replace("EXPECTED", repr(expected)).replace(
                    "SOURCE", migrate_lua_first.lua_quote(source))
                completed = subprocess.run(["lua", "-"], input=script, text=True,
                                           capture_output=True, timeout=10)
                self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
