local ccb = require("ccb")
local services = ccb.services
local H = {}

H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end

H.char_at_om_location = function(actor, loc_id)
    local s = H.char_snap(actor)
    if not s or not s.creature then return false end
    return services.overmap.matches_location(s.creature.position:project_to("omt"), loc_id)
end

H.char_cash = function(actor)
    local s = H.char_snap(actor)
    if not s then return 0 end
    return s.cash or 0
end

H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end

H.char_has_any_trait = function(actor, ids)
    if not actor then return false end
    for _, id in ipairs(ids) do
        if H.char_has_trait(actor, id) == 1 then return true end
    end
    return false
end

H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then return 0 end
    return r.value or 0
end

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end

H.creature_has_effect = function(actor, effect_id, body_part, intensity)
    if not actor then return false end
    local gid = H.safe_id("effect", effect_id)
    if not gid then return false end
    local bp_gid = nil
    if body_part and body_part ~= "" then
        bp_gid = H.safe_id("body_part", body_part)
        if not bp_gid then return false end
    end
    local r = services.effects.has(actor, gid, bp_gid, intensity)
    return r.ok and r.value == true
end

H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.set_var = function(scope, actor, ctx, key, val)
    if scope == "context" then
        if val == nil then ctx:remove(key) else ctx:set(key, val) end
        return
    end
    if scope == "global" then
        if val == nil then services.variables.remove_global(key) else services.variables.set_global(key, val) end
        return
    end
    if not actor then return end
    if val == nil then services.variables.remove(actor, key) else services.variables.set(actor, key, val) end
end

H.transform_radius = function(actor, radius, tr_id)
    local s = H.char_snap(actor)
    if not s or not s.creature then return end
    local gid = H.safe_id("terrain_furniture_transform", tr_id)
    if not gid then return end
    services.world.transform_radius(s.creature.position, math.floor(radius), gid)
end

H.truthy = function(v)
    return v ~= false and v ~= nil and v ~= 0
end

H.u = function(ctx)
    return ctx:speaker()
end

H.var_exists = function(scope, actor, ctx, key)
    if scope == "context" then return ctx:get(key) ~= nil end
    if scope == "global" then
        local r = services.variables.get_global(key)
        return r.ok and r.value and r.value.exists == true
    end
    if not actor then return false end
    local r = services.variables.get(actor, key)
    return r.ok and r.value and r.value.exists == true
end

H.var_num = function(actor, key)
    if not actor then return 0 end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

ccb.runtime.handler("dlg_p_aftershock_exoplanet_c1784e867903", function(ctx)
    return ((not H.creature_has_effect(H.npc(ctx), "currently_busy")) and (H.char_cash(H.u(ctx)) >= (0)))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_6d6b923beb69", function(ctx)
    return (((H.char_snap(H.u(ctx)) or {}).environment or {}).safe_space == true)
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_8090a987dd23", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "field")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_04435162cfce", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "water")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_0990569f7b8f", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "subterranean")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_e61133812756", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "forest")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_bf043626a620", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "swamp")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_0322a64a012a", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "Lab")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_7278c42b1690", function(ctx)
    return H.char_at_om_location(H.npc(ctx), "Mansion_Road_1")
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_718eecbe9628", function(ctx)
    return H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "dialogue_gave_you_the_esper_genetech_warning") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_1cc1c1d49db6", function(ctx)
    return (H.char_has_any_trait(H.u(ctx), { "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" }) and (not (H.truthy((H.var_exists("actor", H.npc(ctx), ctx, "dialogue_gave_you_the_esper_genetech_warning") and 1 or 0)))))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_a094262cd7c4", function(ctx)
    return (H.char_skill(H.u(ctx), "computer") > 2)
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_38b9f0150908", function(ctx)
    return H.truthy((H.var_exists("global", nil, ctx, "know_spaceport") and 1 or 0))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_ea5c55dbd47a", function(ctx)
    return ((not (H.truthy((H.var_exists("global", nil, ctx, "know_spaceport") and 1 or 0)))) and (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "augustmoon_kit") and 1 or 0)))))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_3453aafa2375", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "computer"))) > (12))
end)

ccb.runtime.handler("dlg_p_aftershock_exoplanet_f2a4a85cdbb3", function(ctx)
    return (H.global_var_num("your_ship_ramp_up") == 1)
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_dff20e5248e1", function(ctx)
    H.set_var("global", nil, ctx, "afs_leadership_act", 1)
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_57417bc70225", function(ctx)
    H.set_var("global", nil, ctx, "afs_leadership_act", 0)
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_e2d20d8f059a", function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "dialogue_gave_you_the_esper_genetech_warning", 1)
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_e04f10f958b7", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "cash", (H.var_num(H.u(ctx), "cash")) - (400))
    local _a1 = H.npc(ctx)
    local _skg2 = H.safe_id("skill", "speech")
    if _a1 and _skg2 then
        local _lv3 = math.max(0, math.min(10, math.floor(8)))
        local _sr4 = services.skills.get(_a1, _skg2)
        local _kv5 = (_sr4.ok and _sr4.value and _sr4.value.knowledge) or 0
        services.skills.set(_a1, _skg2, { practical = _lv3, knowledge = math.max(_kv5, _lv3) })
    end
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_281bd652ca97", function(ctx)
    local _a6 = H.u(ctx)
    if _a6 then services.characters.adjust(_a6, { cash = math.floor(6000000) }) end
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_c1d7af39b63a", function(ctx)
    local _a7 = H.u(ctx)
    if _a7 then services.characters.adjust(_a7, { cash = math.floor(2000000) }) end
end)

ccb.runtime.handler("dlg_a_aftershock_exoplanet_946f9b1b3869", function(ctx)
    H.transform_radius(H.u(ctx), 3, "afs_unlock_metal_doors")
end)
