local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES"] = function(ctx)
        return ((not (H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "LILIN_TRAITS" })))) == true
    end
    EOC["EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES"] = function(ctx)
    if ((not (H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "LILIN_TRAITS" })))) then
        services.messages.add(ctx:expand_text(services.translate("You are ineligible for sunrises.")), "debug")
        return true
    end
    return false
    end
    COND["EOC_STARE"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) == true
    end
    EOC["EOC_STARE"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a strange reverberation across your body.")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE1", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_STARE1"] = function(ctx)
        return ((H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true)) == true
    end
    EOC["EOC_STARE1"] = function(ctx)
    if ((H.u(ctx) ~= nil and H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "MAGICAL_MIND_PROTECTION")).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("You sense <npc_name> trying to enter your mind, but your magic protects you!")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE1_5", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true))) and (not (H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION"))))) == true
    end
    EOC["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true))) and (not (H.char_has_flag(H.u(ctx), "MAGICAL_MIND_PROTECTION"))))) then
        return true
    end
    return false
    end
    EOC["EOC_YUGG_DEATH"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "death_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do
        local _sw21 = services.random.native_int(0, H.round_half_away(4))
        if _sw21 == 0 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "black_glass_shard"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(services.random.native_int(750, 2250))) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature quickly begins to darken and turn translucent, shattering like glass soon after.")), "info")
            end
        elseif _sw21 == 1 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_rubber"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature's skin turns darker and it falls limp like a pool noodle.")), "info")
            end
        elseif _sw21 == 2 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_mutflesh"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature seems to lose all detail and falls limply on the ground with a wet thud.")), "info")
            end
        elseif _sw21 == 3 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_jade"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_jade_fragments"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(services.random.native_int(1, 4))) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature seems to stiffen as it skins seems to harden and take a form not dissimilar to stone.")), "info")
            end
        elseif _sw21 == 4 then
            if H.npc(ctx) then services.characters.emit(H.npc(ctx), "emit_fog_plume", 1) end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it falls to the ground, strands of fog seem to tear away from the corpse.  The giant worm dissolves in the air in front of your eyes.")), "info")
            end
        end
    end
    return true
    end
    COND["EOC_GIVE_NIGHTMARES"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.global_var_num("dream_counter") == 0))) == true
    end
    EOC["EOC_GIVE_NIGHTMARES"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.global_var_num("dream_counter") == 0))) then
        services.messages.add((services.snippets.native_random("nightmares") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_NOW"] = function(ctx)
    H.set_var("global", nil, ctx, "Shadow_Lurking", (H.global_var_num("Shadow_Lurking")) - (1))
    do local _g = H.safe_id('mission', "MISSION_KILL_SHADOW"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_lieutenant_shadow") or H.safe_id('monster_group', "mon_lieutenant_shadow"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(10), max_radius = math.floor(15) }); 
    end end
    H.eoc_loc_var(H.u(ctx), ctx, "global", "shadow_encounter_XYZ_pos", nil, nil, nil, { min_radius = math.floor(1), max_radius = math.floor(1) }, nil, false, true, {  }, {  })
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LIEUTENANT_SPAWN_SHADOW_MESSAGE"), nil) end end
    return true
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_changeling_stop_nether_conditions"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_changeling_stop_nether_conditions"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW"] = function(ctx)
        return ((H.truthy((H.var_exists("global", nil, ctx, "shadow_encounter_XYZ_pos") and 1 or 0)) and ((services.npcs.count_allies(false) >= (3)) or H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY") or (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or (not services.gameplay.environment.is_night()) or (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("global", nil, ctx, "shadow_encounter_XYZ_pos"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) >= 180)) and (H.mons_nearby(H.u(ctx), { "mon_lieutenant_shadow" }, 60, nil) > 0))) == true
    end
    EOC["EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW"] = function(ctx)
    if ((H.truthy((H.var_exists("global", nil, ctx, "shadow_encounter_XYZ_pos") and 1 or 0)) and ((services.npcs.count_allies(false) >= (3)) or H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY") or (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or (not services.gameplay.environment.is_night()) or (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("global", nil, ctx, "shadow_encounter_XYZ_pos"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) >= 180)) and (H.mons_nearby(H.u(ctx), { "mon_lieutenant_shadow" }, 60, nil) > 0))) then
        H.set_var("global", nil, ctx, "Shadow_Lurking", 1)
        H.eoc_add_effect(H.u(ctx), "blind_no_msg", 0, nil, nil, nil)
        do local _mid = "MISSION_KILL_SHADOW"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        services.messages.add(ctx:expand_text(services.translate("The wind laughs through the night")), "bad")
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Shadow_monster", nil, nil, { kind = "monster", id = H.safe_id("monster", "mon_lieutenant_shadow") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(60) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_KILL_SHADOW", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("…but it grows more distant for now.")), "good")
        return true
    end
    return false
    end
    COND["EOC_XE_ALCHEMY_PERK_WAKE_UP_RUN"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.char_has_any_trait(H.u(ctx), { "perk_ALCHEMY1", "perk_ALCHEMY2", "perk_ALCHEMY3", "perk_ALCHEMY3_COLD_IRON", "perk_ALCHEMY4", "perk_ALCHEMY5" }))) == true
    end
    EOC["EOC_XE_ALCHEMY_PERK_WAKE_UP_RUN"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.char_has_any_trait(H.u(ctx), { "perk_ALCHEMY1", "perk_ALCHEMY2", "perk_ALCHEMY3", "perk_ALCHEMY3_COLD_IRON", "perk_ALCHEMY4", "perk_ALCHEMY5" }))) then
        if ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY5") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
            H.run_eoc("EOC_ALCHEMY5", ctx, nil, nil, nil)
        else
            if ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY4") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
                H.run_eoc("EOC_ALCHEMY4", ctx, nil, nil, nil)
            else
                if ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (H.char_has_trait(H.u(ctx), "perk_ALCHEMY3_COLD_IRON") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
                    H.run_eoc("EOC_ALCHEMY3_COLD_IRON", ctx, nil, nil, nil)
                else
                    if ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
                        H.run_eoc("EOC_ALCHEMY3", ctx, nil, nil, nil)
                    else
                        if ((H.char_has_trait(H.u(ctx), "perk_ALCHEMY2") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
                            H.run_eoc("EOC_ALCHEMY2", ctx, nil, nil, nil)
                        else
                            if (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
                                H.run_eoc("EOC_ALCHEMY1", ctx, nil, nil, nil)
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("As you wake up from vivid dreams, you realize your subconscious has revealed to you a new secret of alchemy.")), "neutral")
    return true
    end
    COND["EOC_ALCHEMY1"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY1") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY1"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY1") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "extra_str_aspirin", "blackout_rage_drink", "sixdust", "small_blessing_brigit" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 86400, nil, 1, nil)
        return true
    end
    return false
    end
    COND["EOC_ALCHEMY2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY2") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY2") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "prophets_lsd", "truckers_stamina_pills", "spiritshow_dust", "charm_of_marzanna", "gold_small_from_lead_with_alchemy", "väinämöinens_kantele_imitation" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 172800, nil, 1, nil)
        return true
    else
        H.run_eoc("EOC_ALCHEMY1", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ALCHEMY3"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY3"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "feline_periapta", "lupine_periapta", "cephalopod_periapta", "plant_periapta", "scorpion_periapta", "butterfly_periapta", "spider_periapta", "cold_iron_ingot" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 345600, nil, 1, nil)
        return true
    else
        H.run_eoc("EOC_ALCHEMY2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ALCHEMY3_COLD_IRON"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (H.char_has_trait(H.u(ctx), "perk_ALCHEMY3_COLD_IRON") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY3_COLD_IRON"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY3") == 1) and (H.char_has_trait(H.u(ctx), "perk_ALCHEMY3_COLD_IRON") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "cold_iron_knife", "cold_iron_arming_sword", "cold_iron_warhammer", "cold_iron_battleaxe", "blood_of_saints" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 345600, nil, 1, nil)
        return true
    else
        H.run_eoc("EOC_ALCHEMY3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ALCHEMY4"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY4") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY4"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY4") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "life_extension_potion", "gender_potion", "potion_strength", "potion_dex", "hares_leap_potion", "nether_snare" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 691200, nil, 1, nil)
        return true
    else
        H.run_eoc("EOC_ALCHEMY3_COLD_IRON", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ALCHEMY5"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY5") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ALCHEMY5"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_ALCHEMY5") == 1) and (not (((function() local eg = H.safe_id('effect', "mental_exhaustion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "plant_imbuement", "earth_imbuement", "water_imbuement", "air_imbuement", "fire_imbuement", "doll_imbuement" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESFUL_ROLL_REMAINDER_ALCHEMY", ctx) end
        end
        H.eoc_add_effect(H.u(ctx), "mental_exhaustion", 1382400, nil, 1, nil)
        return true
    else
        H.run_eoc("EOC_ALCHEMY4", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1) and ((("effect_evil_eye") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR")).value == true))) == true
    end
    EOC["EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1) and ((("effect_evil_eye") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR")).value == true))) then
        do local _eg = H.safe_id('effect', "effect_evil_eye"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_ABSIT_INVIDIA_SALT"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1)) == true
    end
    EOC["EOC_PERK_ABSIT_INVIDIA_SALT"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1)) then
        do local _eg = H.safe_id('effect', "effect_evil_eye"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You toss the salt over your shoulder and mutter under your breath the words that you remember from your childhood.")), "mixed")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You toss the salt over your shoulder.  Hey, any luck you can get, right?")), "mixed")
        return false
    end
    end
    EOC["EOC_PERK_GRACKEN_FRIENDSHIP_AGGRESSION_ADJUSTMENT"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "anger", 9, "+=")
    return true
    end
    COND["EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "DHAMPIR_TRAIT" }) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1))) and ((("zombie_virus") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "DHAMPIR_TRAIT" }) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1))) and ((("zombie_virus") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_ddotd_zombie_virus_resistance", 176400, nil, nil, nil)
        if services.random.native_probability((1), (4)) then
            do local _eg = H.safe_id('effect', "zombie_virus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xe_ddotd_zombie_virus_resistance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("You've started feeling a bit better.  Maybe your unique condition has saved you from the zombie bite's inexorable death…this time.")), "good")
        else
            do local _t = math.max(1, math.floor(86400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION_FOLLOWUP"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION_FOLLOWUP"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "zombie_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_xe_ddotd_zombie_virus_resistance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION_FOLLOWUP"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "zombie_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_xe_ddotd_zombie_virus_resistance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        if services.random.native_probability((1), (4)) then
            do local _eg = H.safe_id('effect', "zombie_virus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xe_ddotd_zombie_virus_resistance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("You've started feeling a bit better.  Maybe your unique condition has saved you from the zombie bite's inexorable death…this time.")), "good")
        else
            do local _t = math.max(1, math.floor(86400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_DDOTD_DHAMPIRS_VAMPIRES_RESIST_INFECTION_FOLLOWUP"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_STARE1_5"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) == true
    end
    EOC["EOC_STARE1_5"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) then
        services.messages.add(ctx:expand_text(services.translate("You sense <npc_name> trying to enter your mind, but you repel it!")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CONDITION_SKY_ISLAND_ON_THE_ISLAND"] = function(ctx)
        return ((1 == 0)) == true
    end
    EOC["EOC_CONDITION_SKY_ISLAND_ON_THE_ISLAND"] = function(ctx)
    if ((1 == 0)) then
        return true
    end
    return false
    end
    EOC["EOC_XE_SI_PRE_TELEPORT_LOCATION_CHECKING"] = function(ctx)
    if (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "XE_si_on_sky_island_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 1)
    else
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "XE_si_on_ground_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 0)
    end
    return true
    end
    COND["EOC_XE_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
        return (((((("xedra_chronomancer_revert_location") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("sylph_wind_translocation_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("homullus_road_translocate_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("arvore_forest_translocate") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("ierde_tunnel_translocation_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("changeling_teleport_home_spell") == (H.var_str("context", nil, ctx, "spell", ""))))))) == true
    end
    EOC["EOC_XE_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
    if (((((("xedra_chronomancer_revert_location") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("sylph_wind_translocation_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("homullus_road_translocate_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("arvore_forest_translocate") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("ierde_tunnel_translocation_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("changeling_teleport_home_spell") == (H.var_str("context", nil, ctx, "spell", ""))))))) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_SI_POST_TELEPORT_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XE_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
        return (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) == true
    end
    EOC["EOC_XE_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    if (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) then
        if (H.char_has_trait(H.u(ctx), "awayfromhome") == 1) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "XE_si_on_ground_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            ccb.presentation.notice(ctx:expand_text(services.translate("You briefly see the familiar sights of the floating island before you feel a wrenching sensation and you're suddenly back on the surface.  Whatever powers have put you in this situation must not be happy with you trying to circumvent the rules.")))
            H.set_var("global", nil, ctx, "timeawayfromhome", (H.global_var_num("timeawayfromhome")) + (1))
        end
        return true
    else
        if ((H.var_num(H.u(ctx), "started_teleport_on_island") == 1) and (not ((((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9)))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("As you come out of the darkness and the cold and see the surface, you feel a sudden wrenching sensation.  Pain washes over your entire body as your vision goes red, and the air burns as you take in a ragged breath.  The powers behind your situation are not happy at your attempt to circumvent their rules.")))
            H.eoc_add_effect(H.u(ctx), "warpsickness", -1, nil, 3, nil)
            do local _t = math.max(1, math.floor((180 * (((H.global_var_num("bonuspulses") > 0)) and ((H.global_var_num("bonuspulses") * 60)) or (1))))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"), nil) end end
        end
        return false
    end
    end
    EOC["EOC_XE_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "OM_HQ_origin"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    ccb.presentation.notice(ctx:expand_text(services.translate("With an internal twist, you're suddenly back on the island.")))
    do local _eg = H.safe_id('effect', "warpsickness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_ANATHEMA_CHECK_FOR_START"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_anathema_battle_started"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_hp(H.u(ctx), "ALL", false) < 200))) == true
    end
    EOC["EOC_ANATHEMA_CHECK_FOR_START"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_anathema_battle_started"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_hp(H.u(ctx), "ALL", false) < 200))) then
        H.eoc_cast_spell(H.u(ctx), "VAMPIRE_ANATHEMA_STARTS_BATTLE", false, nil)
        services.messages.add(ctx:expand_text(services.translate("The vampiric anathema's movements are much quicker now!")), "bad")
        return true
    end
    return false
    end
    COND["EOC_ANATHEMA_CHECK_FOR_LATER"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_anathema_final_form"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_hp(H.u(ctx), "ALL", false) < 100))) == true
    end
    EOC["EOC_ANATHEMA_CHECK_FOR_LATER"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_anathema_final_form"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_hp(H.u(ctx), "ALL", false) < 100))) then
        H.eoc_cast_spell(H.u(ctx), "VAMPIRE_ANATHEMA_FINAL_FORM", false, nil)
        services.messages.add(ctx:expand_text(services.translate("The vampiric anathema accelerates to the point your eyes struggle to follow and heal their wounds as shadows surround their body!")), "bad")
        return true
    end
    return false
    end
    EOC["EOC_ANATHEMA_BUFF_ON_HIT"] = function(ctx)
    H.run_eoc("EOC_ANATHEMA_CHECK_FOR_START", ctx, nil, nil, nil)
    H.run_eoc("EOC_ANATHEMA_CHECK_FOR_LATER", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_ACTIVATE_ANATHEMA"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "BLOOD_DRINKER") == 1) and (H.global_var_num("Anathema_Activated") < 1))) == true
    end
    EOC["EOC_ACTIVATE_ANATHEMA"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "BLOOD_DRINKER") == 1) and (H.global_var_num("Anathema_Activated") < 1))) then
        H.set_var("global", nil, ctx, "Anathema_Ready", 1)
        H.set_var("global", nil, ctx, "Anathema_Activated", 1)
        return true
    end
    return false
    end
    COND["EOC_ANATHEMA_WITHDRAWS_FOR_NOW"] = function(ctx)
        return (((H.mons_nearby(H.u(ctx), { "mon_vampire_anathema" }, 60, nil) > 0) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_2ndfloor_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_3rdfloor_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_roof_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_parking", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_basement", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_upper_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(3)) end)()) or (not services.gameplay.environment.is_night()) or (H.mons_nearby(H.u(ctx), { "mon_vampire_anathema" }, 55, nil) == 0)))) == true
    end
    EOC["EOC_ANATHEMA_WITHDRAWS_FOR_NOW"] = function(ctx)
    if (((H.mons_nearby(H.u(ctx), { "mon_vampire_anathema" }, 60, nil) > 0) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_2ndfloor_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_3rdfloor_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_roof_1", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_parking", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_basement", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SW", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SE", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_upper_roof", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(3)) end)()) or (not services.gameplay.environment.is_night()) or (H.mons_nearby(H.u(ctx), { "mon_vampire_anathema" }, 55, nil) == 0)))) then
        H.set_var("global", nil, ctx, "Anathema_Ready", 1)
        H.eoc_add_effect(H.u(ctx), "blind_no_msg", 0, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("The Anathema vanishes in a fine mist")), "good")
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Vampire_Anathema", nil, nil, { kind = "monster", id = H.safe_id("monster", "mon_vampire_anathema") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(60) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_KILL_SHADOW", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("…but they will come back.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_DRINK_BLOOD"] = function(ctx)
        return (((H.npc(ctx) ~= nil) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))))) == true
    end
    EOC["EOC_VAMPIRE_DRINK_BLOOD"] = function(ctx)
    if (((H.npc(ctx) ~= nil) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))))) then
        H.set_var("context", nil, ctx, "vampire_amount_drained", (400 + services.random.native_int(0, H.round_half_away(100))))
        H.eoc_add_effect(H.u(ctx), "star_vampire_blood_drank", 30, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_FERAL_VAMPIRE_GAIN_RANDOM_BUFF"] = function(ctx)
    do
        local _sw22 = services.random.native_int(0, H.round_half_away(6))
        if _sw22 == 0 then
            H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_strength", services.random.native_float(15, 45), nil, nil, nil)
        elseif _sw22 == 2 then
            H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_agility", services.random.native_float(15, 45), nil, nil, nil)
        elseif _sw22 == 4 then
            H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_resilience", services.random.native_float(15, 45), nil, nil, nil)
        elseif _sw22 == 6 then
            H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_speed", services.random.native_float(15, 45), nil, nil, nil)
        end
    end
    return true
    end
    COND["EOC_FERAL_VAMPIRE_DRINK_GAIN_RANDOM_BUFF"] = function(ctx)
        return ((((H.npc(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HUMAN")).value == true))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true)))))) or ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true)))))) or ((H.npc(ctx) ~= nil) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1)))))) == true
    end
    EOC["EOC_FERAL_VAMPIRE_DRINK_GAIN_RANDOM_BUFF"] = function(ctx)
    if ((((H.npc(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HUMAN")).value == true))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true)))))) or ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FERAL")).value == true))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true)))))) or ((H.npc(ctx) ~= nil) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1)))))) then
        do
            local _sw23 = services.random.native_int(0, H.round_half_away(6))
            if _sw23 == 0 then
                H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_strength", services.random.native_float(15, 45), nil, nil, nil)
            elseif _sw23 == 2 then
                H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_agility", services.random.native_float(15, 45), nil, nil, nil)
            elseif _sw23 == 4 then
                H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_resilience", services.random.native_float(15, 45), nil, nil, nil)
            elseif _sw23 == 6 then
                H.eoc_add_effect(H.u(ctx), "effect_vampire_monster_speed", services.random.native_float(15, 45), nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    COND["EOC_ARION_DRINK_BLOOD"] = function(ctx)
        return (((ctx:get_number("damage") or 0) > 0)) == true
    end
    EOC["EOC_ARION_DRINK_BLOOD"] = function(ctx)
    if (((ctx:get_number("damage") or 0) > 0)) then
        H.set_var("context", nil, ctx, "arion_amount_drained", services.random.native_float(250, 650))
        if H.char_has_any_trait(H.npc(ctx), { "VAMPIRE", "DHAMPIR" }) then
            do local _a, _v = H.npc(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (ctx:get_number("arion_amount_drained") or 0); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.npc(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (ctx:get_number("arion_amount_drained") or 0); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.npc(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (ctx:get_number("arion_amount_drained") or 0); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        return true
    end
    return false
    end
    EOC["EOC_THORNHOUND_DEATH"] = function(ctx)
    do local _p, _g = (H.creature_snap(H.npc(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_arvore_summoned_brambles"); if _p and _g then services.world.transform_radius(_p, math.floor(2), _g, nil) end end
    return true
    end
    EOC["EOC_XE_TROLL_HITS_YOU_WITH_GIANT_CLUB"] = function(ctx)
    do
        local _sw24 = H.char_val_extra(H.npc(ctx), "size")
        if _sw24 == 1 then
            H.eoc_add_effect(H.npc(ctx), "downed", (function() local a, b = math.floor(2), math.floor(5); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            H.eoc_add_effect(H.npc(ctx), "stunned", (function() local a, b = math.floor(2), math.floor(5); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        elseif _sw24 == 2 then
            H.eoc_add_effect(H.npc(ctx), "downed", (function() local a, b = math.floor(2), math.floor(4); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            if (services.random.native_int(0, H.round_half_away(4)) >= 1) then
                H.eoc_add_effect(H.npc(ctx), "stunned", (function() local a, b = math.floor(1), math.floor(4); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
        elseif _sw24 == 3 then
            if (services.random.native_int(0, H.round_half_away(2)) >= 1) then
                H.eoc_add_effect(H.npc(ctx), "downed", (function() local a, b = math.floor(1), math.floor(4); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
            if (services.random.native_int(0, H.round_half_away(4)) >= 2) then
                H.eoc_add_effect(H.npc(ctx), "stunned", (function() local a, b = math.floor(1), math.floor(3); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
        elseif _sw24 == 4 then
            if (services.random.native_int(0, H.round_half_away(2)) >= 2) then
                H.eoc_add_effect(H.npc(ctx), "downed", (function() local a, b = math.floor(1), math.floor(3); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
            if (services.random.native_int(0, H.round_half_away(4)) >= 3) then
                H.eoc_add_effect(H.npc(ctx), "stunned", (function() local a, b = math.floor(1), math.floor(2); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
        elseif _sw24 == 5 then
            if (services.random.native_int(0, H.round_half_away(4)) >= 4) then
                H.eoc_add_effect(H.npc(ctx), "stunned", (function() local a, b = math.floor(1), math.floor(2); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            end
        end
    end
    return true
    end
    EOC["EOC_SHABRIRI_REDUCE_ANGER"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "anger", 50, "-=")
    H.set_char_val_extra(H.u(ctx), "morale", 30, "-=")
    return true
    end
    COND["EOC_XE_VAMPIRE_MONSTER_FEAR_GAZE"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))))) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))))) == true
    end
    EOC["EOC_XE_VAMPIRE_MONSTER_FEAR_GAZE"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))))) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "effect_vampire_fear_gazed", 300, nil, nil, nil)
        if (not (H.char_has_flag(H.u(ctx), "MAGIAL_MIND_PROTECTION"))) then
            H.eoc_add_effect(H.u(ctx), "stunned", (function() local a, b = math.floor(2), math.floor(5); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You freeze like a frightened rabbit!")), "bad")
        end
        return true
    end
    return false
    end
    COND["EOC_SOLAR_SPIRIT_AOE_FLARE"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_SOLAR_SPIRIT_AOE_FLARE"] = function(ctx)
    if (ctx:has_speaker()) then
        if ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not (((function() local eg = H.safe_id('effect', "blind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "GLARE_RESIST"))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "SUN_GLASSES") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "SUN_GLASSES")).value == true)))) then
            H.eoc_add_effect(H.u(ctx), "blind", (function() local a, b = math.floor(5), math.floor(12); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        end
        if (H.char_has_flag(H.u(ctx), "SUNDEATH") or H.char_has_flag(H.u(ctx), "SUNBURN_SUPERNATURAL")) then
            H.eoc_cast_spell(H.u(ctx), "solar_spirit_flare_spell_sundeath_hit_monster", false, { hit_self = true })
        end
        return true
    end
    return false
    end
    COND["EOC_WEREWOLF_TRIGGERS_RED_HANDED_RAGE_CHANCE"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(15)) > 14)) == true
    end
    EOC["EOC_WEREWOLF_TRIGGERS_RED_HANDED_RAGE_CHANCE"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(15)) > 14)) then
        H.eoc_add_effect(H.u(ctx), "effect_werewolf_red_handed_rage_monster", 10, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_HEARTWHIP"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1) and (not ((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP") == 1))) and (H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))) and (not (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_HEARTWHIP"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1) and (not ((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP") == 1))) and (H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))) and (not (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_bloodthorn_druid_upgrade_ready", 604800, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(36000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_UPGRADE_FORMICATION"), nil) end end
        H.learn_recipe(H.u(ctx), "xe_bloodthorn_druid_upgrade_recipe")
        return true
    end
    return false
    end
    COND["EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_PROGRESSION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP") == 1) and (not (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))) or (H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1)))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_UPGRADE_GAIN_PROGRESSION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP") == 1) and (not (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and (not (((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()))) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))) or (H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1)))) then
        if ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true))) or (((function() local fg = H.safe_id('json_flag', "MAGIC_FOCUS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()) and ((function() local fg = H.safe_id('json_flag', "REACH3"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
            H.set_var("actor", H.u(ctx), ctx, "bloodthorn_druid_vampire_heartwhip_kills", (H.var_num(H.u(ctx), "bloodthorn_druid_vampire_heartwhip_kills")) + (1))
        else
            H.set_var("actor", H.u(ctx), ctx, "bloodthorn_druid_vampire_heartwhip_kills", (H.var_num(H.u(ctx), "bloodthorn_druid_vampire_heartwhip_kills")) + (0.3334))
        end
        if ((H.var_num(H.u(ctx), "bloodthorn_druid_vampire_heartwhip_kills") >= H.var_num(H.u(ctx), "bloodthorn_druid_vampires_killed_to_upgrade")) and (not (((function() local eg = H.safe_id('effect', "effect_bloodthorn_druid_upgrade_ready"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
            if (not ((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_CREATE_THORN_PRISON") == 1))) then
                if (H.char_sum_traits_cat(H.u(ctx), "ARVORE_ALCHEMY", "ALL") >= H.var_num(H.u(ctx), "bloodthorn_druid_required_arvore_traits")) then
                    H.eoc_add_effect(H.u(ctx), "effect_bloodthorn_druid_upgrade_ready", 604800, nil, nil, nil)
                    do local _t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(36000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_UPGRADE_FORMICATION"), nil) end end
                else
                    services.messages.add(ctx:expand_text(services.translate("Your heartvines twitch as the vampire dies, but soon grow quiescent.  They need more elemental power in order to catalyze the vampire blood into new thornwitchery.")), "mixed")
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_UPGRADE_FORMICATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_bloodthorn_druid_upgrade_ready"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_UPGRADE_FORMICATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_bloodthorn_druid_upgrade_ready"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(36000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_UPGRADE_FORMICATION"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "vampire_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "vampire_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) then
        if (H.test_eoc("EOC_CONDITION_CHECK_ARVORE_ON_NATURAL_TERRAIN", ctx) or H.test_eoc("EOC_CONDITION_CHECK_ARVORE_IN_THE_FOREST", ctx)) then
            ccb.presentation.notice(ctx:expand_text(services.translate("You dream of chalices of flowing blood and endless night, of the moon filling half the sky, of red eyes in the dark, when your dream is interrupted with the sensation of dozens of thorns pricking you from the inside.  You wake with a start, in terrible pain…but free of your curse.")))
            local _a25 = H.u(ctx)
            if _a25 then services.characters.adjust(_a25, { pain = math.floor((30 + services.random.native_int(0, H.round_half_away(30)))) }) end
            do local _eg = H.safe_id('effect', "vampire_virus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            H.lose_trait(H.u(ctx), "VAMPIRE")
            H.lose_trait(H.u(ctx), "VAMPIRE_TRUCE")
            H.lose_trait(H.u(ctx), "VAMPIRE_BLOOD_ARTS")
            H.lose_trait(H.u(ctx), "EYEGLEAM")
            H.lose_trait(H.u(ctx), "BLOOD_FUN")
            H.lose_trait(H.u(ctx), "VAMPIRIC_STRENGTH")
            H.lose_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")
            H.lose_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")
            H.lose_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")
            H.lose_trait(H.u(ctx), "STAMINAFORBLOOD")
            H.lose_trait(H.u(ctx), "COMMUNE_NIGHT")
            H.lose_trait(H.u(ctx), "COAGULANTWEAVE")
            H.lose_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDR")
            H.lose_trait(H.u(ctx), "VAMPIRE2")
            H.lose_trait(H.u(ctx), "BLOODHEAL")
            H.lose_trait(H.u(ctx), "VAMPIRIC_DODGE")
            H.lose_trait(H.u(ctx), "VAMPIRE_STEALTH_BON")
            H.lose_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")
            H.lose_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")
            H.lose_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALL")
            H.lose_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")
            H.lose_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS_")
            H.lose_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")
            H.lose_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPOR")
            H.lose_trait(H.u(ctx), "VAMPIRE3")
            do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        else
            services.messages.add(ctx:expand_text(services.translate("You have terrible dreams of blood and darkness, interrupted by the sensation of prickling thorns.  You need to sleep out in the wild places if you want your curse to be purged.")), "mixed")
            local _a26 = H.u(ctx)
            if _a26 then services.characters.adjust(_a26, { pain = math.floor((10 + services.random.native_int(0, H.round_half_away(10)))) }) end
            do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        end
        return true
    end
    return false
    end
    EOC["EOC_BLOODTHORNE_DRUID_PURGE_VAMPIRISM_IN_OTHER"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "narcosis", 1800, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "sleep", 1800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_GENERIC_EOC"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(1800)))) end end
    do local _t = math.max(1, math.floor(1800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_OPEN_DIALOGUE_VAMPIRE_HUNTER_BLOODTHORNE_PERFORM_CURE"), nil) end end
    if (H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You wait as the heartvines do their work.  Once they're done they retract, leaving you with deep lacerations and terrible pain…but without your curse.")))
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("You wait as the heartvines do their work.  Once they're done they retract, leaving you in terrible pain…but without your curse.")))
    end
    H.set_char_hp(H.u(ctx), "head", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    H.set_char_hp(H.u(ctx), "torso", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    H.set_char_hp(H.u(ctx), "arm_l", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    H.set_char_hp(H.u(ctx), "arm_r", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    H.set_char_hp(H.u(ctx), "leg_l", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    H.set_char_hp(H.u(ctx), "leg_r", services.random.native_float((H._jm_vampire_bloodthorne_maximal_cure_damage(ctx) / 2), H._jm_vampire_bloodthorne_maximal_cure_damage(ctx)), "-=")
    local _a27 = H.u(ctx)
    if _a27 then services.characters.adjust(_a27, { pain = math.floor((30 + services.random.native_int(0, H.round_half_away(30)))) }) end
    do local _eg = H.safe_id('effect', "vampire_virus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    H.lose_trait(H.u(ctx), "VAMPIRE")
    H.lose_trait(H.u(ctx), "VAMPIRE_TRUCE")
    H.lose_trait(H.u(ctx), "VAMPIRE_BLOOD_ARTS")
    H.lose_trait(H.u(ctx), "EYEGLEAM")
    H.lose_trait(H.u(ctx), "BLOOD_FUN")
    H.lose_trait(H.u(ctx), "VAMPIRIC_STRENGTH")
    H.lose_trait(H.u(ctx), "VAMPIRE_HEALTH_BONUS")
    H.lose_trait(H.u(ctx), "VAMPIRE_HEIGHTENED_SENSES")
    H.lose_trait(H.u(ctx), "VAMPIRE_SILENT_MOVE")
    H.lose_trait(H.u(ctx), "STAMINAFORBLOOD")
    H.lose_trait(H.u(ctx), "COMMUNE_NIGHT")
    H.lose_trait(H.u(ctx), "COAGULANTWEAVE")
    H.lose_trait(H.u(ctx), "VAMPIRE_SENSE_CHILDR")
    H.lose_trait(H.u(ctx), "VAMPIRE2")
    H.lose_trait(H.u(ctx), "BLOODHEAL")
    H.lose_trait(H.u(ctx), "VAMPIRIC_DODGE")
    H.lose_trait(H.u(ctx), "VAMPIRE_STEALTH_BON")
    H.lose_trait(H.u(ctx), "VAMPIRE_FEAR_GAZE")
    H.lose_trait(H.u(ctx), "VAMPIRE_FEIGN_DEATH")
    H.lose_trait(H.u(ctx), "VAMPIRE_WALK_ON_WALL")
    H.lose_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS")
    H.lose_trait(H.u(ctx), "VAMPIRE_BEAST_CLAWS_")
    H.lose_trait(H.u(ctx), "VAMPIRE_SEE_HEAT")
    H.lose_trait(H.u(ctx), "VAMPIRE_BLOOD_TEMPOR")
    H.lose_trait(H.u(ctx), "VAMPIRE3")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_MORE_BLOOD")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_GROTESQUE")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_EARTH_SLEEP")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_HOLY_BURN")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_VAST_WATER_BURN")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_ANIMAL_HATE")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_FIRE_VULNERABLE")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_COLD_BLOODED")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING")
    H.lose_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NO_FUN")
    do local _eg = H.safe_id('effect', "vampire_need_living_blood"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _g = H.safe_id('morale', "morale_vw_no_fun"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    EOC["EOC_OPEN_DIALOGUE_VAMPIRE_HUNTER_BLOODTHORNE_PERFORM_CURE"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_VAMPIRE_HUNTER_BLOODTHORNE_PERFORM_CURE") end
    return true
    end
    COND["EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_WARNING"] = function(ctx)
        return ((((("vampire_virus") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_WARNING"] = function(ctx)
    if ((((("vampire_virus") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a burning sensation in your veins and your heartvines twitch.  The blood-drinkers have infected you with their foul curse.  Rest within the wilds to allow your heartvines to purge it, before they destroy you in their attempt.")), "mixed")
        do local _t = math.max(1, math.floor((((3600 - (H._jm_vampire_total_tier_one_traits(ctx) * 15)) - (H._jm_vampire_total_tier_two_traits(ctx) * 45)) - (H._jm_vampire_total_tier_three_traits(ctx) * 135)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_PERIODIC_BLOOD_DRAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_PERIODIC_BLOOD_DRAIN"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "vampire_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_PERIODIC_BLOOD_DRAIN"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "vampire_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) then
        if (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            services.messages.add(ctx:expand_text(services.translate("You feel a burning sensation in your veins and your heartvines writhe.")), "mixed")
            H.eoc_add_effect(H.u(ctx), "bleed", -1, "RANDOM", 1, nil)
            H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
            H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        else
            if (H.char_has_trait(H.u(ctx), "VAMPIRE3") == 1) then
                if services.random.native_probability(1, (4)) then
                    services.messages.add(ctx:expand_text(services.translate("Your heartvines thrash in your sleep.")), "mixed")
                    H.eoc_add_effect(H.u(ctx), "bleed", -1, "RANDOM", 1, nil)
                end
            end
            if ((H.char_has_trait(H.u(ctx), "VAMPIRE2") == 1) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE3") == 1)))) then
                if services.random.native_probability(1, (8)) then
                    services.messages.add(ctx:expand_text(services.translate("Your heartvines twitch in your sleep.")), "mixed")
                    H.eoc_add_effect(H.u(ctx), "bleed", -1, "RANDOM", 1, nil)
                end
            end
            if (((function() local eg = H.safe_id('effect', "vampire_virus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE2") == 1))) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE3") == 1)))) then
                if services.random.native_probability(1, (16)) then
                    services.messages.add(ctx:expand_text(services.translate("Your heartvines stir in your sleep.")), "mixed")
                    H.eoc_add_effect(H.u(ctx), "bleed", -1, "RANDOM", 1, nil)
                end
            end
        end
        if (H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 1) then
            do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 10; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 50; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _t = math.max(1, math.floor((((3600 - (H._jm_vampire_total_tier_one_traits(ctx) * 15)) - (H._jm_vampire_total_tier_two_traits(ctx) * 45)) - (H._jm_vampire_total_tier_three_traits(ctx) * 135)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_VAMPIRE_VIRUS_HEARTVINE_PERIODIC_BLOOD_DRAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)) == true
    end
    EOC["EOC_DHAMPIR_UPDATE_BLOOD_SPENT_AMOUNTS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "dhampir_currently_blood_vitamin_level", H.char_vitamin(H.u(ctx), "human_blood_vitamin"))
        if (H.var_num(H.u(ctx), "dhampir_currently_blood_vitamin_level") < (H.var_num(H.u(ctx), "dhampir_previous_blood_vitamin_level") - 1)) then
            H.set_var("context", nil, ctx, "temp_value", ((ctx:get_number("temp_value") or 0)) + ((H.var_num(H.u(ctx), "dhampir_previous_blood_vitamin_level") - H.var_num(H.u(ctx), "dhampir_currently_blood_vitamin_level"))))
            services.messages.add(ctx:expand_text(services.translate("This round's blood spent was <context_val:temp_value>")), "debug")
            H.set_var("actor", H.u(ctx), ctx, "dhampir_blood_spent_compare_value_for_powers", (H.var_num(H.u(ctx), "dhampir_blood_spent_compare_value_for_powers")) + ((ctx:get_number("temp_value") or 0)))
        end
        H.set_var("actor", H.u(ctx), ctx, "dhampir_previous_blood_vitamin_level", H.char_vitamin(H.u(ctx), "human_blood_vitamin"))
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and (H.var_num(H.u(ctx), "dhampir_blood_spent_compare_value_for_powers") > 0))) == true
    end
    EOC["EOC_DHAMPIR_CHECK_FOR_POWER_UPGRADES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and (H.var_num(H.u(ctx), "dhampir_blood_spent_compare_value_for_powers") > 0))) then
        H.set_var("context", nil, ctx, "target_value", (100000 + (((H._jm_vampire_total_tier_one_traits(ctx) * 5000) + (H._jm_vampire_total_tier_two_traits(ctx) * 7500)) + (H._jm_vampire_total_tier_three_traits(ctx) * 10000))))
        services.messages.add(ctx:expand_text(services.translate("Odds of gaining a new power are <u_val:dhampir_blood_spent_compare_value_for_powers> in <context_val:target_value>.")), "debug")
        if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and services.random.native_probability((H.var_num(H.u(ctx), "dhampir_blood_spent_compare_value_for_powers")), ((ctx:get_number("target_value") or 0)))) then
            H.run_eoc("EOC_DHAMPIR_GAIN_NEW_POWER", ctx, nil, nil, nil)
        else
            H.set_var("actor", H.u(ctx), ctx, "dhampir_blood_spent_compare_value_for_powers", (H.var_num(H.u(ctx), "dhampir_blood_spent_compare_value_for_powers")) - ((services.random.native_int(0, H.round_half_away(2)) + 1)))
        end
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_GAIN_NEW_POWER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)) == true
    end
    EOC["EOC_DHAMPIR_GAIN_NEW_POWER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1)) then
        if (((H._jm_vampire_total_tier_one_traits(ctx) + services.random.native_int(0, H.round_half_away(5))) + services.random.native_int(0, H.round_half_away(5))) >= 11) then
            H.run_eoc("EOC_DHAMPIR_GAIN_NEW_POWER_TIER_2", ctx, nil, nil, nil)
        else
            do local _ok = false; local _ids = {}; for _, s in ipairs({ "EYEGLEAM", "STAMINAFORBLOOD", "COMMUNE_NIGHT", "VAMPIRIC_STRENGTH", "VAMPIRIC_RESILIENCE", "VAMPIRE_HEIGHTENED_SENSES", "VAMPIRE_SILENT_MOVE", "VAMPIRE_HEALTH_BONUS", "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT", "DHAMPIR_REDUCED_COLD_TEMPS" }) do local g = H.safe_id("mutation", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "mutation", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
                if _ok then H.run_eoc("EOC_DHAMPIR_GAIN_NEW_POWER_MESSAGE", ctx) end
                if _ok then H.run_eoc("EOC_DHAMPIR_GAIN_NEW_POWER_RESET_VALUE", ctx) end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_DHAMPIR_GAIN_NEW_POWER_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You have unlocked a new ability from your use of your tainted blood.")), "mixed")
    return true
    end
    EOC["EOC_DHAMPIR_GAIN_NEW_WEAKNESS_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your use of your vampiric powers has caused you to gain a new frailty.")), "bad")
    return true
    end
    EOC["EOC_DHAMPIR_GAIN_NEW_POWER_RESET_VALUE"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "dhampir_blood_spent_compare_value_for_powers", 0)
    return true
    end
    COND["EOC_DHAMPIR_GAIN_WEAKNESSES_TIER_2"] = function(ctx)
        return ((H.var_num(H.u(ctx), "dhampir_have_tier_2_weakness") ~= 1)) == true
    end
    EOC["EOC_DHAMPIR_GAIN_WEAKNESSES_TIER_2"] = function(ctx)
    if ((H.var_num(H.u(ctx), "dhampir_have_tier_2_weakness") ~= 1)) then
        H.run_eoc("EOC_DHAMPIR_GAIN_WEAKNESSES", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "dhampir_have_tier_2_weakness", 1)
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_GAIN_WEAKNESSES_TIER_3"] = function(ctx)
        return ((H.var_num(H.u(ctx), "dhampir_have_tier_3_weakness") ~= 1)) == true
    end
    EOC["EOC_DHAMPIR_GAIN_WEAKNESSES_TIER_3"] = function(ctx)
    if ((H.var_num(H.u(ctx), "dhampir_have_tier_3_weakness") ~= 1)) then
        H.run_eoc("EOC_DHAMPIR_GAIN_WEAKNESSES", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "dhampir_have_tier_3_weakness", 1)
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_GAIN_WEAKNESSES"] = function(ctx)
        return ((H.var_num(H.u(ctx), "dhampir_have_ever_drunk_blood") == 0)) == true
    end
    EOC["EOC_DHAMPIR_GAIN_WEAKNESSES"] = function(ctx)
    if ((H.var_num(H.u(ctx), "dhampir_have_ever_drunk_blood") == 0)) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "DHAMPIR_WEAKNESS_SUN_SENSITIVITY", "DHAMPIR_WEAKNESS_SUN_SLEEPINESS", "DHAMPIR_WEAKNESS_SLOW_HEALING", "DHAMPIR_WEAKNESS_ANIMAL_DISCORD", "DHAMPIR_WEAKNESS_WATER_PAIN", "DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR" }) do local g = H.safe_id("mutation", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "mutation", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_DHAMPIR_GAIN_NEW_WEAKNESS_MESSAGE", ctx) end
        end
        return true
    else
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "DHAMPIR_WEAKNESS_SUN_SENSITIVITY", "DHAMPIR_WEAKNESS_SUN_SLEEPINESS", "DHAMPIR_WEAKNESS_SLOW_HEALING", "DHAMPIR_WEAKNESS_ANIMAL_DISCORD", "DHAMPIR_WEAKNESS_WATER_PAIN", "DHAMPIR_WEAKNESS_CORPSELIKE_PALLOR", "DHAMPIR_WEAKNESS_BLOODTHIRST", "DHAMPIR_WEAKNESS_OVERWHELMING_ARROGANCE", "DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN", "DHAMPIR_WEAKNESS_LOWER_KCAL_FROM_FOOD", "DHAMPIR_WEAKNESS_BURNED_BY_THE_SUN" }) do local g = H.safe_id("mutation", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "mutation", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_DHAMPIR_GAIN_NEW_WEAKNESS_MESSAGE", ctx) end
        end
        return false
    end
    end
end
