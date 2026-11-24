local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H._jm_wave_spawn_number = function(ctx)
    return math.max(1, (H.global_var_num("wave_number") * H.global_var_num("diffulty_modifier")))
end

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

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_DEFENSE_MODE_PREVENT_DEATH", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:DEFENSE_MODE_RANDOM_EVENT", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:DEFENSE_MODE_RANDOM_EVENT"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("DEFENSE_MODE_RANDOM_EVENT", ctx)
end)
ccb.runtime.handler("eoc_int:DEFENSE_MODE_RANDOM_EVENT", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(172800), math.floor(345600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:DEFENSE_MODE_RANDOM_EVENT", "eoc_int:DEFENSE_MODE_RANDOM_EVENT")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:defense_mode_caravan_spawn", function(_)
    local dk = "eoc_deact:defense_mode_caravan_spawn"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("defense_mode_caravan_spawn", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(345600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:defense_mode_caravan_spawn", {})
end)
ccb.runtime.handler("eoc_glob:DEFENSE_MODE_FORTRESS_TRAP", function(_)
    local dk = "eoc_deact:DEFENSE_MODE_FORTRESS_TRAP"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("DEFENSE_MODE_FORTRESS_TRAP", ctx)
    local t = math.max(1, math.floor(100))
    ccb.tasks.after(t, "eoc_glob:DEFENSE_MODE_FORTRESS_TRAP", {})
end)
ccb.runtime.handler("eoc_glob:DEFENSE_MODE_WAVE_CONTROL", function(_)
    local dk = "eoc_deact:DEFENSE_MODE_WAVE_CONTROL"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("DEFENSE_MODE_WAVE_CONTROL", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(43200), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:DEFENSE_MODE_WAVE_CONTROL", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:defense_mode_caravan_spawn") then
        ccb.state.world.set("eoc_glob_started:defense_mode_caravan_spawn", true)
        ccb.tasks.after(1, "eoc_glob:defense_mode_caravan_spawn", {})
    end
    if not ccb.state.world.get("eoc_glob_started:DEFENSE_MODE_FORTRESS_TRAP") then
        ccb.state.world.set("eoc_glob_started:DEFENSE_MODE_FORTRESS_TRAP", true)
        ccb.tasks.after(1, "eoc_glob:DEFENSE_MODE_FORTRESS_TRAP", {})
    end
    if not ccb.state.world.get("eoc_glob_started:DEFENSE_MODE_WAVE_CONTROL") then
        ccb.state.world.set("eoc_glob_started:DEFENSE_MODE_WAVE_CONTROL", true)
        ccb.tasks.after(1, "eoc_glob:DEFENSE_MODE_WAVE_CONTROL", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
