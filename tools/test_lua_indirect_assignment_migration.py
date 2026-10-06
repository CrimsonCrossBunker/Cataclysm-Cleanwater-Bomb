from __future__ import annotations

import shutil
import subprocess
import unittest

import migrate_lua_first as migration


class LuaIndirectAssignmentMigrationTest(unittest.TestCase):
    def setUp(self) -> None:
        self.namespace = migration._migration_math_function_ids.set(
            migration.native_core_math_function_ids() | {"test_custom_formula"}
        )
        self.targets = {
            "u": ("mutation_recipient", "character"),
            "npc": ("mutation_npc_fallback", "character"),
            "read_u": ("alpha", "character"),
            "read_npc": ("beta", "character"),
        }

    def tearDown(self) -> None:
        migration._migration_math_function_ids.reset(self.namespace)

    def render(self, expression: str, targets=None) -> list[str] | None:
        return migration.render_static_character_math(
            {"math": [expression]},
            self.targets if targets is None else targets,
        )

    def require_rendered(self, expression: str) -> list[str]:
        lines = self.render(expression)
        self.assertIsNotNone(lines, expression)
        return lines or []

    def execute_lua(self, script: str) -> None:
        completed = subprocess.run(
            ["lua", "-"],
            input=script,
            text=True,
            capture_output=True,
            timeout=10,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_indirect_writes_route_one_pointer_to_proven_scopes_and_raw_keys(
        self,
    ) -> None:
        effects = [
            "v_u_pointer = 11",
            "v_n_pointer = 12",
            "v_context_pointer = 13",
            "v_global_pointer = 14",
            "v_empty_pointer = 15",
            "v_nul_pointer = 16",
            "v_long_pointer = 17",
            "v_next_pointer = 18",
        ]
        generated = [
            line
            for expression in effects
            for line in self.require_rendered(expression)
        ]
        source = "\n".join(generated)
        self.assertIn(
            ('get_context_string(context and context.data, "u_pointer")'),
            source,
        )
        self.assertIn("alpha, string.sub(target_name, 3)", source)
        self.assertIn("beta, string.sub(target_name, 3)", source)
        self.assertNotIn("mutation_recipient", source)
        self.assertNotIn("mutation_npc_fallback", source)

        script = (
            r"""
local nul_key = "raw\000key"
local long_key = string.rep("k", 8193)
local alpha = {values={wrong=71}}
local beta = {values={}}
local context = {data={
    u_pointer="u_target",
    n_pointer="n_target",
    context_pointer="_context_target",
    global_pointer="raw_global_target",
    empty_pointer="",
    nul_pointer=nul_key,
    long_pointer=long_key,
    next_pointer="v_next",
    next="u_nested_target",
}}
local globals = {v_next="u_wrong_target"}
local diagnostics,writes={},{}
local null_value={}
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or
        "service failure",0) end
    return result.value
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error("unproven variable owner")
end
local function number_result(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~="number" then
        return {ok=false,error={code="variable_type_mismatch",
            message="not numeric"}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local services={
    variables={
        get_context_string=function(data,key)
            assert(data==context.data)
            local value=data[key]
            if value==nil then return {ok=true,value={exists=false}} end
            if value==null_value then
                return {ok=true,value={exists=true,value=""}}
            end
            if type(value)~="string" then
                diagnostics[#diagnostics+1]="context string type mismatch"
                return {ok=true,value={exists=true,value=""}}
            end
            return {ok=true,value={exists=true,value=value}}
        end,
        get_number=function(owner,key,options)
            assert(options.strict==true)
            return number_result(actor_store(owner),key)
        end,
        get_context_number=function(data,key,options)
            assert(data==context.data and options.strict==true)
            return number_result(data,key)
        end,
        get_global_number=function(key,options)
            assert(options.strict==true)
            return number_result(globals,key)
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
            writes[#writes+1]={key=key,value=value}
            return {ok=true,value=value}
        end,
    },
    diagnostic=function(message) diagnostics[#diagnostics+1]=message end,
}
""" +
            source +
            r"""
assert(alpha.values.target==11 and math.type(alpha.values.target)=="float")
assert(beta.values.target==12 and math.type(beta.values.target)=="float")
assert(context.data.context_target==13 and math.type(
    context.data.context_target)=="float")
assert(globals.raw_global_target==14 and math.type(
    globals.raw_global_target)=="float")
assert(globals[""]==15 and math.type(globals[""])=="float")
assert(globals[nul_key]==16 and math.type(globals[nul_key])=="float")
assert(globals[long_key]==17 and math.type(globals[long_key])=="float")
assert(globals.v_next==18 and math.type(globals.v_next)=="float")
assert(alpha.values.wrong==71 and alpha.values.nested_target==nil)
assert(context.data.next=="u_nested_target")
assert(#diagnostics==0)
assert(#writes==7, "actor/global pointers use exactly one typed write")
"""
        )
        self.execute_lua(script)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_missing_pointer_and_compound_write_order(
        self,
    ) -> None:
        missing = "\n".join(self.require_rendered("v_missing++"))
        compound = "\n".join(self.require_rendered("v_compound += _rhs"))
        script = (
            r"""
local alpha={values={compound=10.0}}
local beta={values={}}
local context={data={compound="u_compound",rhs=2.5}}
local globals={[""]=31}
local trace,reads,writes={}, {}, {}
local function record(value) trace[#trace+1]=value end
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or
        "service failure",0) end
    return result.value
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error("unproven variable owner")
end
local function number_result(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~="number" then
        return {ok=false,error={code="variable_type_mismatch",
            message="not numeric"}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local services={variables={
    get_context_string=function(data,key)
        assert(data==context.data)
        record("pointer:"..key)
        local value=data[key]
        if value==nil then return {ok=true,value={exists=false}} end
        return {ok=true,value={exists=true,value=value}}
    end,
    get_context_number=function(data,key,options)
        assert(data==context.data and options.strict==true)
        if key=="rhs" then record("rhs") end
        return number_result(data,key)
    end,
    get_number=function(owner,key,options)
        assert(options.strict==true)
        reads[key]=(reads[key] or 0)+1
        record("target-read:"..key)
        return number_result(actor_store(owner),key)
    end,
    get_global_number=function(key,options)
        assert(options.strict==true)
        return number_result(globals,key)
    end,
    set=function(owner,key,value,options)
        assert(options.include_before==false)
        actor_store(owner)[key]=value
        writes[key]=(writes[key] or 0)+1
        record("target-write:"..key)
        return {ok=true,value=value}
    end,
    set_global=function(key,value,options)
        assert(options.include_before==false)
        globals[key]=value
        return {ok=true,value=value}
    end,
},diagnostic=function(message) error(message,0) end}
""" +
            missing +
            r"""
assert(globals[""]==1 and math.type(globals[""])=="float",
       "a missing pointer reads as zero but writes to the empty global key")

trace,reads,writes={},{},{}
""" +
            compound +
            r"""
assert(alpha.values.compound==12.5 and math.type(
    alpha.values.compound)=="float")
assert(reads.compound==1 and writes.compound==1,
       "compound indirect assignment reads and writes the pointed number once")
        local rhs_index,read_index,write_index
        local pointer_indices={}
        for index,event in ipairs(trace) do
            if event=="rhs" then rhs_index=index end
            if event=="pointer:compound" then
                pointer_indices[#pointer_indices+1]=index end
            if event=="target-read:compound" then read_index=index end
            if event=="target-write:compound" then write_index=index end
        end
        assert(rhs_index and read_index and write_index)
        assert(#pointer_indices==2,
               "compound assignment resolves the pointer once for its read " ..
               "and once for its write")
        assert(pointer_indices[1]<read_index)
        assert(math.max(rhs_index,read_index)<pointer_indices[2] and
            pointer_indices[2]<write_index,
               "write-target resolution follows both operand evaluations")
"""
        )
        self.execute_lua(script)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_invalid_pointer_and_rhs_diagnostics(
        self,
    ) -> None:
        effects = [
            "v_null_pointer = 1",
            "v_number_pointer = 2",
            "v_array_pointer = 3",
            "v_bad_rhs_pointer = _bad_rhs",
            "v_after_failure_pointer = 4",
        ]
        generated = [
            line
            for expression in effects
            for line in self.require_rendered(expression)
        ]
        source = "\n".join(generated)
        self.assertIn("get_context_string", source)

        script = (
            r"""
local alpha={values={}}
local beta={values={}}
local null_value={}
local context={data={
    null_pointer=null_value,
    number_pointer=9,
    array_pointer={"not a pointer"},
    bad_rhs_pointer="must_not_write",
    bad_rhs="not numeric",
    after_failure_pointer="after_failure",
}}
local globals={}
local diagnostics,pointer_reads,writes={}, {}, {}
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or
        "service failure",0) end
    return result.value
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error("unproven variable owner")
end
local function number_result(store,key)
    local value=store[key]
    if value==nil then return {ok=true,value={exists=false}} end
    if type(value)~="number" then
        return {ok=false,error={code="variable_type_mismatch",
            message="bad numeric type"}}
    end
    return {ok=true,value={exists=true,value=value}}
end
local services={variables={
    get_context_string=function(data,key)
        assert(data==context.data)
        pointer_reads[key]=(pointer_reads[key] or 0)+1
        local value=data[key]
        if value==nil then return {ok=true,value={exists=false}} end
        if value==null_value then return {ok=true,value={exists=true,
            value=""}} end
        if type(value)~="string" then
            diagnostics[#diagnostics+1]=
                "pointer value has an incompatible string type"
            return {ok=true,value={exists=true,value=""}}
        end
        return {ok=true,value={exists=true,value=value}}
    end,
    get_context_number=function(data,key,options)
        assert(data==context.data and options.strict==true)
        return number_result(data,key)
    end,
    get_number=function(owner,key,options)
        assert(options.strict==true)
        return number_result(actor_store(owner),key)
    end,
    get_global_number=function(key,options)
        assert(options.strict==true)
        return number_result(globals,key)
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
        writes[#writes+1]={key=key,value=value}
        return {ok=true,value=value}
    end,
},diagnostic=function(message) diagnostics[#diagnostics+1]=message end}
""" +
            source +
            r"""
assert(globals[""]==3 and globals.after_failure==4)
assert(pointer_reads.bad_rhs_pointer==nil,
       "a type-invalid RHS must stop before resolving or writing its target")
assert(globals.must_not_write==nil)
assert(#writes==4, "three empty-target writes and the later valid write")
assert(#diagnostics==3,
    "numeric/array string diagnostics plus the bad RHS diagnostic")
"""
        )
        self.execute_lua(script)

    @unittest.skipUnless(shutil.which("lua"), "Lua interpreter required")
    def test_random_draw_and_ambiguous_interaction_todos(
        self,
    ) -> None:
        generated = self.require_rendered("v_draw_pointer = rng(1, 3)")
        source = "\n".join(generated)
        self.assertEqual(source.count("services.random.native_float("), 1)

        script = (
            r"""
local alpha={values={draw=0.0}}
local beta={values={}}
local context={data={draw_pointer="u_draw"}}
local globals={}
local trace,draws={},0
local function record(value) trace[#trace+1]=value end
local function service_value(result)
    if not result.ok then error(result.error and result.error.code or
        "service failure",0) end
    return result.value
end
local function actor_store(owner)
    if owner==alpha then return alpha.values end
    if owner==beta then return beta.values end
    error("unproven variable owner")
end
local services={
    random={native_float=function(lower,upper)
        draws=draws+1
        record("draw")
        assert(lower==1.0 and upper==3.0)
        return 2.5
    end},
    variables={
        get_context_string=function(data,key)
            assert(data==context.data)
            record("pointer")
            return {ok=true,value={exists=true,value=data[key]}}
        end,
        set=function(owner,key,value,options)
            assert(options.include_before==false)
            actor_store(owner)[key]=value
            record("write")
            return {ok=true,value=value}
        end,
        set_global=function(key,value,options)
            assert(options.include_before==false)
            globals[key]=value
            record("write")
            return {ok=true,value=value}
        end,
    },
    diagnostic=function(message) error(message,0) end,
}
""" +
            source +
            r"""
assert(draws==1 and alpha.values.draw==2.5)
assert(trace[1]=="draw" and trace[2]=="pointer" and trace[3]=="write",
       "the RHS draw precedes indirect resolution and write")
"""
        )
        self.execute_lua(script)

        unproven_beta = dict(self.targets)
        unproven_beta["read_npc"] = None
        self.assertIsNone(self.render("v_pointer = 1", unproven_beta))

        for expression in (
            "v_pointer += rng(1, 3)",
            "v_pointer = _bad_rhs + rng(1, 3)",
        ):
            with self.subTest(expression=expression):
                self.assertIsNone(self.render(expression))
                choice = migration._math_assignment_order_choice(
                    {"math": [expression]}, self.targets
                )
                self.assertIn("compiler-dependent", choice or "")


if __name__ == "__main__":
    unittest.main()
