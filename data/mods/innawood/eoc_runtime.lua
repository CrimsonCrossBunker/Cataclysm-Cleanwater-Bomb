local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

require("eoc_handlers_01")(E, H)

-- Generic EOC runtime handlers for cross-mod & scheduled calls
for eid, fn in pairs(E.run) do
    ccb.runtime.handler("eoc:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        fn(H.ctx_new(u, npc, vars))
    end)
end
for eid, cfn in pairs(E.cond) do
    ccb.runtime.handler("eoc_test:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        return cfn(H.ctx_new(u, npc, vars)) == true
    end)
end

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_ACTIVATE_SHADOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("Lieutenants_active") >= 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_LIEUTENANT_ACTIVATE_SHADOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_ACTIVATE_SHADOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_ACTIVATE_SHADOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
