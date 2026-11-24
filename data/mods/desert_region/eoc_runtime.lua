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
ccb.runtime.handler("eoc_glob:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING", function(_)
    local dk = "eoc_deact:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor((((H.global_var_num("ds_min_woc")) ~= 0) and (H.global_var_num("ds_min_woc")) or 86400)), math.floor((((H.global_var_num("ds_max_woc")) ~= 0) and (H.global_var_num("ds_max_woc")) or 172800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING", {})
end)
ccb.runtime.handler("eoc_glob:EOC_DUST_EARLY_MESSAGES", function(_)
    local dk = "eoc_deact:EOC_DUST_EARLY_MESSAGES"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_DUST_EARLY_MESSAGES", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(120), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_DUST_EARLY_MESSAGES", {})
end)
ccb.runtime.handler("eoc_glob:EOC_DUST_WIND", function(_)
    local dk = "eoc_deact:EOC_DUST_WIND"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_DUST_WIND", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_DUST_WIND", {})
end)
ccb.runtime.handler("eoc_glob:EOC_DUST_SMOKE", function(_)
    local dk = "eoc_deact:EOC_DUST_SMOKE"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_DUST_SMOKE", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_DUST_SMOKE", {})
end)
ccb.runtime.handler("eoc_glob:EOC_DUST_WIND_STRONG", function(_)
    local dk = "eoc_deact:EOC_DUST_WIND_STRONG"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_DUST_WIND_STRONG", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_DUST_WIND_STRONG", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING") then
        ccb.state.world.set("eoc_glob_started:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_DUST_EARLY_MESSAGES") then
        ccb.state.world.set("eoc_glob_started:EOC_DUST_EARLY_MESSAGES", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DUST_EARLY_MESSAGES", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_DUST_WIND") then
        ccb.state.world.set("eoc_glob_started:EOC_DUST_WIND", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DUST_WIND", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_DUST_SMOKE") then
        ccb.state.world.set("eoc_glob_started:EOC_DUST_SMOKE", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DUST_SMOKE", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_DUST_WIND_STRONG") then
        ccb.state.world.set("eoc_glob_started:EOC_DUST_WIND_STRONG", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DUST_WIND_STRONG", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
