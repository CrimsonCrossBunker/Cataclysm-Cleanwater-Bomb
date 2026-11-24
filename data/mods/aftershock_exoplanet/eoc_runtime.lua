local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H.eoc_run_fixed_zone_eocs = function(actor, ctx, eids, range_val, zmin, zmax)
    local cs = H.creature_snap(actor)
    if not cs then return end
    local apos = cs.position
    local r = services.zones.list({ kind = "global", limit = 256 })
    if not r or not r.ok or not r.value or not r.value.items then return end
    for _, z in ipairs(r.value.items) do
        local zpos = z.start
        if zpos then
            local ok_z = true
            if zmin ~= nil and (zpos.z or 0) < math.floor(zmin) then ok_z = false end
            if zmax ~= nil and (zpos.z or 0) > math.floor(zmax) then ok_z = false end
            if ok_z and range_val ~= nil then
                local dist = math.max(math.abs((apos.x or 0) - (zpos.x or 0)), math.abs((apos.y or 0) - (zpos.y or 0)), math.abs((apos.z or 0) - (zpos.z or 0)))
                if dist > math.floor(range_val) then ok_z = false end
            end
            if ok_z then
                local sub = H.ctx_new(ctx and ctx.u or actor, nil, ctx and ctx.vars or {}, {
                    proxy_pos = zpos,
                    proxy_teleport = function(dest, _)
                        local dx = (dest.x or 0) - (zpos.x or 0)
                        local dy = (dest.y or 0) - (zpos.y or 0)
                        local dz = (dest.z or 0) - (zpos.z or 0)
                        local s = services.coords.tripoint_abs_ms((z.start.x or 0) + dx, (z.start.y or 0) + dy, (z.start.z or 0) + dz)
                        local e_pt = z["end"]
                        local e = services.coords.tripoint_abs_ms((e_pt.x or 0) + dx, (e_pt.y or 0) + dy, (e_pt.z or 0) + dz)
                        services.zones.set_position(z.token, s, e)
                    end
                })
                for _, eid in ipairs(eids) do H.run_eoc(eid, sub) end
            end
        end
    end
end
H.eoc_run_vehicle_eocs = function(actor, ctx, eids, range_val, zmin, zmax)
    local cs = H.creature_snap(actor)
    if not cs then return end
    local opts = { center = cs.position }
    if range_val ~= nil then opts.radius = math.floor(range_val) end
    if zmin ~= nil then opts.z_min = math.floor(zmin) end
    if zmax ~= nil then opts.z_max = math.floor(zmax) end
    local r = services.vehicles.loaded(opts)
    if not r or not r.ok or not r.value or not r.value.items then return end
    for _, item in ipairs(r.value.items) do
        local sub = H.ctx_new(ctx and ctx.u or actor, nil, ctx and ctx.vars or {}, {
            proxy_pos = item.position,
            proxy_teleport = function(dest, tp_opts)
                services.vehicles.teleport(item.handle, dest, tp_opts)
            end
        })
        for _, eid in ipairs(eids) do H.run_eoc(eid, sub) end
    end
end
H._jm_afs_hack_bonus = function(ctx, _a0, _a1)
    return (_a0 + ((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((4 * ((_a1 - 100) / 100)))))
end
H._jm_afs_hack_skill = function(ctx, _a0)
    return (((H.char_skill(H.u(ctx), "computer") + ((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 3)) + H.var_num(H.u(ctx), "hack_bonus")) * _a0)
end
H._jm_afs_hack_time_adjust = function(ctx, _a0, _a1, _a2)
    return ((((_a0 - (_a1 * H._jm_afs_hack_skill(ctx, 1))) < _a2)) and (_a2) or ((_a0 - (_a1 * H._jm_afs_hack_skill(ctx, 1)))))
end
H._jm_concentration_calculations = function(ctx)
    return ((((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 4) + H.var_num(H.u(ctx), "bonus_concentration_powers")) + H._jm_concentration_trait_bonuses(ctx))
end
H._jm_concentration_trait_bonuses = function(ctx)
    return (((((((((((((((((((((((H.char_has_trait(H.u(ctx), "INT_ALPHA") + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD2"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD3"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "PER_SLIME"))) and ((-15)) or (0))) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0) * 2)) + (((H.creature_effect_intensity(H.u(ctx), "hallu") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "winded") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 3)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "cold") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "hot") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "asthma") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "datura") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed_zap") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "downed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "boomered") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "conjunctivitis") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "teargas") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_eyes") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_lungs") > 0)) and ((-2)) or (0)))
end
H._jm_esper_potential_trait_handling = function(ctx)
    return ((H.truthy(H.char_has_trait(H.u(ctx), "ESPER_ADVANCEMENT_OKAY"))) and (1) or (((H.truthy(H.char_has_trait(H.u(ctx), "ESPER_STARTER_ADVANCEMENT_OKAY"))) and (1) or (0))))
end
H._jm_psionic_power_experience_formula_maintenance = function(ctx)
    return ((((((((H.char_snap(H.u(ctx)) or {}).needs or {}).effective_focus or 0) / 100) * 80) * (((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * math.min((0.5 + (H.char_skill(H.u(ctx), "metaphysics") / 20)), 1)) * H._jm_esper_potential_trait_handling(ctx))
end
H._jm_psionics_weariness_calculations = function(ctx, _a0)
    return ((12 * _a0) * services.random.native_float(0.3, 1.6))
end
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)

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
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_JETPACK_RUN_ACTIVE", ctx)
    H.run_eoc("EOC_JETPACK_RUN_DEACTIVATE", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:broken_bone", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_ESPER_BROKEN_LIMB_ENDS_POWERS", ctx)
end)
ccb.runtime.on("game:broken_bone", "eoc_ev:broken_bone")
ccb.runtime.handler("eoc_ev:character_armor_destroyed", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_detonate_shield", ctx)
end)
ccb.runtime.on("game:character_armor_destroyed", "eoc_ev:character_armor_destroyed")
ccb.runtime.handler("eoc_ev:character_consumes_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_STIMPACK", ctx)
end)
ccb.runtime.on("game:character_consumes_item", "eoc_ev:character_consumes_item")
ccb.runtime.handler("eoc_ev:character_finished_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_check_drop_shield_gen", ctx)
    H.run_eoc("EOC_AFS_PRECOG_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING", ctx)
end)
ccb.runtime.on("game:character_finished_activity", "eoc_ev:character_finished_activity")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_MEDIGEL_ADD", ctx)
    H.run_eoc("EOC_AFS_ESPER_SLEEP_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_WINDED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_STUNNED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_DAZED_ENDS_POWERS", ctx)
    H.run_eoc("EOC_AFS_ESPER_WEARINESS_ENDS_POWERS", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_MEDIGEL_REMOVE", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_starts_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_PRECOG_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING", ctx)
end)
ccb.runtime.on("game:character_starts_activity", "eoc_ev:character_starts_activity")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_PRECOG_FOREWARNING_REMOVE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_FIND_PORT_AUGUSTMOON", ctx)
    H.run_eoc("EOC_AFS_FIND_LANDING_PAD", ctx)
    H.run_eoc("EOC_AFS_ELECTROKINETIC_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_PRECOG_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_TELEKINETIC_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_TELEPATH_RECIPE_TEACHER", ctx)
    H.run_eoc("EOC_AFS_ESPER_OLD_EFFECTS_REMOVAL", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_UPGRADE_ESPERS_ON_LOAD", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_UPGRADE_ESPERS_ON_GAME_START", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_AFS_ESPER_CHANNEL_COSTS_FOCUS", ctx)
    H.run_eoc("EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER", ctx)
    H.run_eoc("EOC_AFS_PSI_MAKES_YOU_WEARY", ctx)
    H.run_eoc("EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER", ctx)
    H.run_eoc("EOC_AFS_PSIONICS_ADVERSE_EVENTS", ctx)
    H.run_eoc("EOC_AFS_PSI_SKILL_INCREASE_ON_USE_INITIALIZE", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("afs_eoc_blood_brain_heal", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- AVATAR_DEATH subscribers
ccb.runtime.handler("eoc_ev:avatar_death", function(payload)
    local ctx = H.ctx_new(nil, nil, {}, { avatar_death = payload })
    H.run_eoc("EOC_AFS_LEADERSHIP_SWITCH", ctx)
end)
ccb.runtime.on("avatar_death", "eoc_ev:avatar_death")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:afs_spot_spaceport", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:afs_spot_spaceport"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("afs_spot_spaceport", ctx)
end)
ccb.runtime.handler("eoc_int:afs_spot_spaceport", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:afs_spot_spaceport", "eoc_int:afs_spot_spaceport")
ccb.runtime.handler("eoc_rec:afs_night_messages", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:afs_night_messages"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("afs_night_messages", ctx)
end)
ccb.runtime.handler("eoc_int:afs_night_messages", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:afs_night_messages", "eoc_int:afs_night_messages")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", function(_)
    local dk = "eoc_deact:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", function(_)
    local dk = "eoc_deact:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SPAWN_SHADOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(32400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER") then
        ccb.state.world.set("eoc_glob_started:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER") then
        ccb.state.world.set("eoc_glob_started:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
