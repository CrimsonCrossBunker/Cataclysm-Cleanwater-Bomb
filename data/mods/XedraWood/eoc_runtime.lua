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

-- EVENT triggers
ccb.runtime.handler("eoc_ev:avatar_enters_omt", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XW_CHIRURGEONS_ATTACK", ctx)
    H.run_eoc("EOC_XEDRAWOOD_VERY_RARE_GHOSTS_SPAWN_ON_ROADS", ctx)
    H.run_eoc("EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER_INDOORS", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XW_KILLED_BY_CHIRURGEONS_AWAKEN", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XEDRAWOOD_THE_WISE_NO_STAFF_HARDER_SORCERY", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_XEDRAWOOD_SORCERY_XP_GAIN", ctx)
    H.run_eoc("EOC_XEDRAWOOD_WEARINESS_COST", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_XW_KILLED_BY_CHIRURGEONS", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS", function(_)
    local dk = "eoc_deact:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS", ctx)
    local t = math.max(1, math.floor(60))
    ccb.tasks.after(t, "eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS", {})
end)
ccb.runtime.handler("eoc_glob:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS", function(_)
    local dk = "eoc_deact:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS", {})
end)
ccb.runtime.handler("eoc_glob:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN", function(_)
    local dk = "eoc_deact:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN", {})
end)
ccb.runtime.handler("eoc_glob:EOC_XedraWood_RandEnc_remove", function(_)
    local dk = "eoc_deact:EOC_XedraWood_RandEnc_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_XedraWood_RandEnc_remove", ctx)
    local t = math.max(1, math.floor(200))
    ccb.tasks.after(t, "eoc_glob:EOC_XedraWood_RandEnc_remove", {})
end)
ccb.runtime.handler("eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC", function(_)
    local dk = "eoc_deact:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC", ctx)
    local t = math.max(1, math.floor(21600))
    ccb.tasks.after(t, "eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS") then
        ccb.state.world.set("eoc_glob_started:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS", true)
        ccb.tasks.after(1, "eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS") then
        ccb.state.world.set("eoc_glob_started:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS", true)
        ccb.tasks.after(1, "eoc_glob:EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN") then
        ccb.state.world.set("eoc_glob_started:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_XedraWood_RandEnc_remove") then
        ccb.state.world.set("eoc_glob_started:EOC_XedraWood_RandEnc_remove", true)
        ccb.tasks.after(1, "eoc_glob:EOC_XedraWood_RandEnc_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC") then
        ccb.state.world.set("eoc_glob_started:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC", true)
        ccb.tasks.after(1, "eoc_glob:EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
