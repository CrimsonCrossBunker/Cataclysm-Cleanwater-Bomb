local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["STORMWROUGHT_BLOOD_HIGH_CHARGE"] = function(ctx)
        return ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 10)) == true
    end
    EOC["STORMWROUGHT_BLOOD_HIGH_CHARGE"] = function(ctx)
    if ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 10)) then
        services.messages.add(ctx:expand_text(services.translate("The stormwrought blood boils intensely for a moment before returning to its inert state.")), "info")
        return true
    else
        H.run_eoc("STORMWROUGHT_BLOOD_LOW_CHARGE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["STORMWROUGHT_BLOOD_FULL_CHARGE"] = function(ctx)
        return ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 25)) == true
    end
    EOC["STORMWROUGHT_BLOOD_FULL_CHARGE"] = function(ctx)
    if ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 25)) then
        services.messages.add(ctx:expand_text(services.translate("As the stormwrought blood becomes fully charged, it starts simmering.")), "good")
        do local g = H.safe_id('item', "stormwrought_blood_itert"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.eoc_spawn_item(H.u(ctx), "stormwrought_blood_charged", 1, false, false, nil)
        H.set_var("actor", H.u(ctx), ctx, "stormwrought_blood_charge", 0)
        return true
    else
        H.run_eoc("STORMWROUGHT_BLOOD_HIGH_CHARGE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["CHARGE_STORMWROUGHT_BLOOD"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") and services.random.native_probability(1, (12))) or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and H.char_has_item(H.u(ctx), "stormwrought_blood_itert") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["CHARGE_STORMWROUGHT_BLOOD"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") and services.random.native_probability(1, (12))) or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and H.char_has_item(H.u(ctx), "stormwrought_blood_itert") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        H.set_var("actor", H.u(ctx), ctx, "stormwrought_blood_charge", (H.var_num(H.u(ctx), "stormwrought_blood_charge")) + (1))
        H.run_eoc("STORMWROUGHT_BLOOD_FULL_CHARGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_SUMMON_DREAM_DRAINER_2"] = function(ctx)
    do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "dream_drainer_maker_real", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc"), min_level = math.floor(1) }) end end
    do local g = H.safe_id('item', "dream_drainer_catalyst"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local _mid = "MISSION_KILL_DREAM_DRAINER"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
    do local _g = H.safe_id('mission', "MISSION_KILL_DREAM_DRAINER"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
    services.messages.add(ctx:expand_text(services.translate("The mosquito consumes the catalyst and suddenly starts filling with air as it reshapes itself.")), "mixed")
    return true
    end
    EOC["EOC_SUMMON_DREAM_DRAINER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.run_eoc("EOC_SUMMON_DREAM_DRAINER_2", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CHECK_TO_SUMMON_REVENANT_MOON_DARK_OUTSIDE"] = function(ctx)
        return (((H.moon_phase() == 4) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))))) == true
    end
    EOC["EOC_CHECK_TO_SUMMON_REVENANT_MOON_DARK_OUTSIDE"] = function(ctx)
    if (((H.moon_phase() == 4) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))))) then
        services.messages.add(ctx:expand_text(services.translate("You utter the last words of the ritual and the revenant suddently animates, disappears and reappears nearby, a deadly glare in its eyes.")), "mixed")
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_luna_attuned_revenant") or H.safe_id('monster_group', "mon_luna_attuned_revenant"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(20), max_radius = math.floor(25) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("You see a flash of moonlight surrounding a tall, slender being.")), 'warning') end
        end end
        do local g = H.safe_id('item', "revenant_effigy"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _g = H.safe_id('mission', "MISSION_KILL_LUNA_ATTUNED"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_REMOVE_LUNA_MISSION"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The revenant cannot be animated unless a sufficient amount of the light of a full moon shines upon it.")), "bad")
        return false
    end
    end
    EOC["EOC_CHECK_TO_SUMMON_REVENANT"] = function(ctx)
    H.run_eoc("EOC_CHECK_TO_SUMMON_REVENANT_MOON_DARK_OUTSIDE", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_REMOVE_LUNA_MISSION"] = function(ctx)
    do local _mid = "MISSION_KILL_LUNA_ATTUNED"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
    return true
    end
    EOC["EOC_CALL_NEXT_WEATHER"] = function(ctx)
    services.weather.request_update()
    return true
    end
    COND["EOC_SLEEP_NEAR_SEVENOCLOCK"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_sleep_shield_check"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_SLEEP_NEAR_SEVENOCLOCK"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_sleep_shield_check"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_SLEEP_SHIELD_SEVENOCLOCK", ctx, nil, nil, nil)
        H.run_eoc("EOC_MINIMUM_TIME_ASLEEP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MINIMUM_TIME_ASLEEP"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) <= 100)) == true
    end
    EOC["EOC_MINIMUM_TIME_ASLEEP"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) <= 100)) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", 100, "=")
        return true
    end
    return false
    end
    EOC["EOC_SLEEP_SHIELD_SEVENOCLOCK_2"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "sleep", 28800, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_hedge_no_nightmares", 28800, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_sleep_shield", 259200, nil, nil, nil)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "SLEEP_SHIELD_location", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "SLEEP_SHIELD_destination", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, { dz = math.floor(10) }, true, true, {  }, {  })
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "SLEEP_SHIELD_destination"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    COND["EOC_SLEEP_SHIELD_SEVENOCLOCK"] = function(ctx)
        return ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 10)))) == true
    end
    EOC["EOC_SLEEP_SHIELD_SEVENOCLOCK"] = function(ctx)
    if ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 10)))) then
        H.run_eoc("EOC_SLEEP_SHIELD_SEVENOCLOCK_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Distrustful of the shenanigans you used to bring him at such a high altitude, the Man of the Nineteenth Hour refuses to shield you!")), "bad")
        return false
    end
    end
    COND["EOC_WAKE_UP_FROM_SLEEP_SHIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_sleep_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_WAKE_UP_FROM_SLEEP_SHIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_sleep_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_sleep_shield"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "SLEEP_SHIELD_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    end
    return false
    end
    EOC["EOC_FULL_MORALE_NEUTRALIZATION"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_bile"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_food_good"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_food_hot"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_chat"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_chat_uncaring"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_ate_with_table"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_ate_without_table"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_music"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_honey"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_game"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_marloss"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_mutagen"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_support"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_photos"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_nicotine"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_caffeine"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_alcohol"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_opiate"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_speed"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_cocaine"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_crack"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_mutagen"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_diazepam"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_marloss"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_food_bad"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_cannibal"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_demicannibal"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_vegetarian"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_antiveggy"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_meatarian"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_antimeat"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_antifruit"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_lactose"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_antijunk"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_antiwheat"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_sweettooth"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_no_digest"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_wet"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_dried_off"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_cold"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_hot"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_bad_protein_bar"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_killed_innocent"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_killed_friend"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_killed_monster"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_mutilate_corpse"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_mutagen_elf"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_mutagen_chimera"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_mutagen_mutation"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_moodswing"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_book"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_comfy"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_scream"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_masochist"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_radiophile"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_noface"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_fpmode_on"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_hoarder"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_fancy"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_optimist"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_badtemper"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_numb"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_constrained"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_nomad"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_game_found_kitten"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_haircut"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_shave"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_vomited"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_play_with_pet"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_pyromania_startfire"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_pyromania_nearfire"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_pyromania_nofire"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_perm_filthy"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_butcher"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_gravedigger"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_funeral"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_tree_communion"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_accomplishment"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_failure"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_migo_bio_tech"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_impossible_shape"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_social"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_asocial"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_sunrise"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_sunset"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_ate_dross"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_drank_blood"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_craving_lotus_blossom"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_forest_unity"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_broke_fae_ban"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_homullus_self_deception"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_ierde_meditation"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_boring_fruit"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_vw_no_fun"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_VAMPIRE_BLEED_CHECK"] = function(ctx)
        return ((((("bleed") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_VAMPIRE_BLEED_CHECK"] = function(ctx)
    if ((((("bleed") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.run_eoc("EOC_VAMPIRE_BLEED_STOLEN_BLOOD", ctx, nil, nil, nil)
        H.run_eoc("EOC_DHAMPIR_BLEED_STOLEN_BLOOD", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_BLEED_STOLEN_BLOOD"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) and (not ((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) and ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "head") >= 1)))) == true
    end
    EOC["EOC_VAMPIRE_BLEED_STOLEN_BLOOD"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) and (not ((H.char_has_trait(H.u(ctx), "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT") == 1))) and ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "head") >= 1)))) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do
            local _arr = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }
            for _, _v in ipairs(_arr) do
                H.set_var("context", nil, ctx, "id", _v)
                if (H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")) >= 1) then
                    H.set_var("context", nil, ctx, "bleed_intensity", H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")))
                    services.messages.add(ctx:expand_text(services.translate("Bleed intensity for bodypart is <context_val:bleed_intensity>.")), "debug")
                    do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")) * 5); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                end
            end
        end
        services.messages.add(ctx:expand_text(services.translate("You are losing your stolen blood through your bleeding wounds!")), "bad")
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(10); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VAMPIRE_BLEED_STOLEN_BLOOD"), nil) end end
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_INCUBATION"] = function(ctx)
        return (((("xe_hydrating_gout_incubation") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_INCUBATION"] = function(ctx)
    if (((("xe_hydrating_gout_incubation") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("HYDRATING_GOUT_SYMPTOMS_START"), nil) end end
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_START"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "xe_hydrating_gout_incubation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_START"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "xe_hydrating_gout_incubation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "xe_hydrating_gout", (8400 + services.random.native_int(0, H.round_half_away(8400))), nil, nil, nil)
        do local _eg = H.safe_id('effect', "xe_hydrating_gout_incubation"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_LOW"] = function(ctx)
        return ((services.random.native_probability((1), (math.max(1, (35 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) <= 0))) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_LOW"] = function(ctx)
    if ((services.random.native_probability((1), (math.max(1, (35 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) <= 0))) then
        H.eoc_add_effect(H.u(ctx), "shakes", 60, nil, nil, nil)
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_MEDIUM"] = function(ctx)
        return ((services.random.native_probability((1), (math.max(1, (50 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) < (-20)))) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_MEDIUM"] = function(ctx)
    if ((services.random.native_probability((1), (math.max(1, (50 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) < (-20)))) then
        local _a8 = H.u(ctx)
        if _a8 then services.characters.adjust(_a8, { pain = math.floor(1) }) end
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_HIGH"] = function(ctx)
        return ((services.random.native_probability((1), (math.max(1, (110 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) < (-60)))) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_HIGH"] = function(ctx)
    if ((services.random.native_probability((1), (math.max(1, (110 + (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) < (-60)))) then
        H.eoc_add_effect(H.u(ctx), "stunned", 1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS_LETHAL"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) <= (-100))) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS_LETHAL"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) <= (-100))) then
        H.set_char_hp(H.u(ctx), "torso", 1, "-=")
        return true
    end
    return false
    end
    COND["HYDRATING_GOUT_SYMPTOMS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "xe_hydrating_gout"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["HYDRATING_GOUT_SYMPTOMS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "xe_hydrating_gout"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_char_val_extra(H.u(ctx), "thirst", 1, "-=")
        H.run_eoc("HYDRATING_GOUT_SYMPTOMS_LOW", ctx, nil, nil, nil)
        H.run_eoc("HYDRATING_GOUT_SYMPTOMS_MEDIUM", ctx, nil, nil, nil)
        H.run_eoc("HYDRATING_GOUT_SYMPTOMS_HIGH", ctx, nil, nil, nil)
        H.run_eoc("HYDRATING_GOUT_SYMPTOMS_LETHAL", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_XE_KRECK_DEATH"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "death_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if (services.random.native_int(0, H.round_half_away(10)) >= 9) then
        do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "kreck_loot_star_stone"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
    end
    if H.npc(ctx) then services.characters.emit(H.npc(ctx), "emit_kreck_death_stones", 1) end
    return true
    end
    EOC["EOC_XE_SHOGGOTH_DEATH"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "death_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if H.npc(ctx) then services.characters.emit(H.npc(ctx), "emit_shoggoth_dissolution", 1) end
    return true
    end
    COND["EOC_XE_IRON_INTOLERANCE_WEARING_IRON_OR_STEEL"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" }) and (not (((function() local eg = H.safe_id('effect', "effect_changeling_winter_cut_off_fey_nature"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_IRON_OR_STEEL"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" }) and (not (((function() local eg = H.safe_id('effect', "effect_changeling_winter_cut_off_fey_nature"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_XE_IRON_INTOLERANCE_WEARING_IRON_FOLLOWUP", ctx, nil, nil, nil)
        H.run_eoc("EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XE_IRON_INTOLERANCE_UNWEARING_IRON_OR_STEEL"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" })) == true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_UNWEARING_IRON_OR_STEEL"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" })) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_IRON_INTOLERANCE_WEARING_IRON_FOLLOWUP"), nil) end end
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XE_IRON_INTOLERANCE_WIELDING_IRON_OR_STEEL"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" }) and (not (((function() local eg = H.safe_id('effect', "effect_changeling_winter_cut_off_fey_nature"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WIELDING_IRON_OR_STEEL"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW", "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER", "HOMULLUS", "IRON_ALLERGY" }) and (not (((function() local eg = H.safe_id('effect', "effect_changeling_winter_cut_off_fey_nature"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_XE_IRON_INTOLERANCE_WEARING_IRON_FOLLOWUP", ctx, nil, nil, nil)
        H.run_eoc("EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_FOLLOWUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_IRON_RESULT_TRUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) or (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_iron_tier_1", -1, nil, nil, nil)
    end
    if (((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER" })))) or (H.char_has_any_trait(H.u(ctx), { "IERDE", "SALAMANDER" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_iron_tier_2", -1, nil, nil, nil)
    end
    if ((H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) or (H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)))) or (H.char_has_any_trait(H.u(ctx), { "IERDE", "SALAMANDER" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_iron_tier_3", -1, nil, nil, nil)
    end
    if (H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_iron_tier_4", -1, nil, nil, nil)
    end
    return true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_IRON_RESULT_FALSE"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_iron_tier_1"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_iron_tier_2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_iron_tier_3"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_iron_tier_4"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_IRON_FOLLOWUP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, { wielded_only = true } }, { "EOC_XE_IRON_INTOLERANCE_WEARING_IRON_RESULT_TRUE" }, { "EOC_XE_IRON_INTOLERANCE_WEARING_IRON_RESULT_FALSE" })
    return true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_RESULT_TRUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) or (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_steel_tier_1", -1, nil, nil, nil)
    end
    if (((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE", "IERDE", "SALAMANDER" })))) or (H.char_has_any_trait(H.u(ctx), { "IERDE", "SALAMANDER" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)))) or (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "FAIR_FOLK_COMMONER_SELECTOR", "UNKNOWING_CHANGELING_COMMONER_BROWNIE", "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE", "UNKNOWING_CHANGELING_COMMONER_TROW" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_steel_tier_2", -1, nil, nil, nil)
    end
    if ((H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE" }) and (not ((H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)))) or (H.char_has_any_trait(H.u(ctx), { "IERDE", "SALAMANDER" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1))) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_steel_tier_3", -1, nil, nil, nil)
    end
    if (H.char_has_any_trait(H.u(ctx), { "ARVORE", "SYLPH", "UNDINE" }) and (H.char_has_trait(H.u(ctx), "IRON_ALLERGY") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_xe_iron_intolerance_wearing_steel_tier_4", -1, nil, nil, nil)
    end
    return true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_RESULT_FALSE"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_steel_tier_1"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_steel_tier_2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_steel_tier_3"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_xe_iron_intolerance_wearing_steel_tier_4"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_FOLLOWUP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true } }, { "EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_RESULT_TRUE" }, { "EOC_XE_IRON_INTOLERANCE_WEARING_STEEL_RESULT_FALSE" })
    return true
    end
    COND["EOC_BREAK_VAMPIRE_TRUCE_2"] = function(ctx)
        return (((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1) and (not (((function() local eg = H.safe_id('effect', "vampire_attacked_vampire_or_renfield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_BREAK_VAMPIRE_TRUCE_2"] = function(ctx)
    if (((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1) and (not (((function() local eg = H.safe_id('effect', "vampire_attacked_vampire_or_renfield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.npc(ctx), "vampire_attacked_vampire_or_renfield", (10800 + services.random.native_int(0, H.round_half_away(43200))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BREAK_VAMPIRE_TRUCE"] = function(ctx)
        return ((((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true)))) and (H.npc(ctx) ~= nil))) == true
    end
    EOC["EOC_BREAK_VAMPIRE_TRUCE"] = function(ctx)
    if ((((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true)))) and (H.npc(ctx) ~= nil))) then
        H.run_eoc("EOC_BREAK_VAMPIRE_TRUCE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "XE_NETHER_SORCERY") == 1)))) == true
    end
    EOC["EOC_XE_NETHER_SORCERY_REQUIRES_UNLOCK_SETUP"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "XE_NETHER_SORCERY") == 1)))) then
        do local _g = H.safe_id('mutation', "XE_NO_NETHER_SORCERY"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_XE_NETHER_SORCERY_WEARINESS_COST"] = function(ctx)
        return (((("XE_NETHER_SORCERY") == (H.var_str("context", nil, ctx, "school", ""))))) == true
    end
    EOC["EOC_XE_NETHER_SORCERY_WEARINESS_COST"] = function(ctx)
    if (((("XE_NETHER_SORCERY") == (H.var_str("context", nil, ctx, "school", ""))))) then
        H.set_var("actor", H.u(ctx), ctx, "spell_weariness_cost", 0)
        H.set_var("actor", H.u(ctx), ctx, "spell_weariness_cost", ((6 * ((ctx:get_number("difficulty") or 0) * 0.4)) * math.max(((30 - H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))) / 30), 0.5)))
        if ((ctx:get_number("success") or 0) ~= H.global_var_num("false")) then
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "spell_weariness_cost") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "spell_weariness_cost"); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "spell_weariness_cost") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "spell_weariness_cost"); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        else
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((H.var_num(H.u(ctx), "spell_weariness_cost") / 2) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (H.var_num(H.u(ctx), "spell_weariness_cost") / 2); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((H.var_num(H.u(ctx), "spell_weariness_cost") / 2) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (H.var_num(H.u(ctx), "spell_weariness_cost") / 2); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        end
        return true
    end
    return false
    end
    COND["EOC_XE_NETHER_SORCERY_RESONANCE_CONSEQUENCES"] = function(ctx)
        return ((services.gameplay.mods.is_loaded("mindovermatter") and ((("XE_NETHER_SORCERY") == (H.var_str("context", nil, ctx, "school", "")))))) == true
    end
    EOC["EOC_XE_NETHER_SORCERY_RESONANCE_CONSEQUENCES"] = function(ctx)
    if ((services.gameplay.mods.is_loaded("mindovermatter") and ((("XE_NETHER_SORCERY") == (H.var_str("context", nil, ctx, "school", "")))))) then
        H.set_var("context", nil, ctx, "consequence_duration", (((ctx:get_number("difficulty") or 0) * 25) * services.random.native_float(0.66, 1.33)))
        H.eoc_add_effect(H.u(ctx), "effect_xe_nether_resonance_consequences", (ctx:get_number("consequence_duration") or 0), nil, nil, nil)
        if services.random.native_probability(((ctx:get_number("difficulty") or 0)), (400)) then
            H.eoc_add_effect(H.u(ctx), "attention", (((ctx:get_number("difficulty") or 0) * 250) * services.random.native_float(0.66, 1.33)), nil, nil, nil)
        end
        if services.random.native_probability(((ctx:get_number("difficulty") or 0)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "taint", (((ctx:get_number("difficulty") or 0) * 250) * services.random.native_float(0.66, 1.33)), nil, nil, nil)
        end
        if (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") ~= 0) and services.random.native_probability(((ctx:get_number("consequence_duration") or 0)), (1000))) then
            do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (((ctx:get_number("difficulty") or 0) / 10) * services.random.native_float(0.66, 1.33)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        return true
    end
    return false
    end
    COND["EOC_XE_XE_OPERATIVE_MAGIC_SQUARES_BOOK_UNDERSTANDING"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "xe_hedge_mage_magic_squares").value == true)) == true
    end
    EOC["EOC_XE_XE_OPERATIVE_MAGIC_SQUARES_BOOK_UNDERSTANDING"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "xe_hedge_mage_magic_squares").value == true)) then
        H.set_var("actor", H.u(ctx), ctx, "deciphered_spellbook_hedge_abramelin_the_mage", 1)
        return true
    end
    return false
    end
    COND["EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "xedra_revenant_prof").value == true)) == true
    end
    EOC["EOC_SCENARIO_REVENANT_PERIODIC_FIX_NEEDS"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "xedra_revenant_prof").value == true)) then
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) < 118000) then
            do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(118000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 118000; local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        end
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) > 0) then
            H.set_char_val_extra(H.u(ctx), "sleepiness", 0, "=")
        end
        if (H.char_val_extra(H.u(ctx), "sleep_deprivation") > 0) then
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 0, "=")
        end
        return true
    end
    return false
    end
    COND["EOC_XE_SHAPESHIFTED_ANIMALS_CANT_DO_THAT"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "VAMPIRE_WOLF_FORM_TRAITS", "WEREWOLF_PRIMAL_FORM_TRAITS", "TURN_INTO_BEAR_TRAITS", "TURN_INTO_DEER_TRAITS", "TURN_INTO_COUGAR_TRAITS", "TURN_INTO_OWL_TRAITS", "TURN_INTO_RAVEN_TRAITS" }) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_XE_SHAPESHIFTED_ANIMALS_CANT_DO_THAT"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "VAMPIRE_WOLF_FORM_TRAITS", "WEREWOLF_PRIMAL_FORM_TRAITS", "TURN_INTO_BEAR_TRAITS", "TURN_INTO_DEER_TRAITS", "TURN_INTO_COUGAR_TRAITS", "TURN_INTO_OWL_TRAITS", "TURN_INTO_RAVEN_TRAITS" }) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        services.messages.add(ctx:expand_text(services.translate("You can't perform that activity while in the form of an animal.")), "bad")
        return true
    end
    return false
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_APPLY_FLAGS"] = function(ctx)
    if ((not (H.char_has_flag(H.npc(ctx), "SEMITANGIBLE"))) and (not (H.char_has_flag(H.npc(ctx), "UNRESTRICTED"))) and (not (H.char_has_flag(H.npc(ctx), "INTEGRATED")))) then
        do local _g = H.safe_id('json_flag', "SHAPESHIFTED_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "SEMITANGIBLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "UNRESTRICTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "INTANGIBLE_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "UNBREAKABLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    end
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_APPLY_FLAGS" }, {  })
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_REMOVE_FLAGS"] = function(ctx)
    do local _g = H.safe_id('json_flag', "SEMITANGIBLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "INTANGIBLE_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "UNRESTRICTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "SHAPESHIFTED_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "UNBREAKABLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_RETURN_ARMOR_TO_NORMAL"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_REMOVE_FLAGS" }, {  })
    return true
    end
    COND["EOC_XE_GOT_A_SPELL_LVL"] = function(ctx)
        return ((services.random.native_probability(1, (16)) and (services.time.calendar().now.turns_since_cataclysm > 2))) == true
    end
    EOC["EOC_XE_GOT_A_SPELL_LVL"] = function(ctx)
    if ((services.random.native_probability(1, (16)) and (services.time.calendar().now.turns_since_cataclysm > 2))) then
        if ((H.char_has_trait(H.u(ctx), "EATER") == 1) and ((("EATER") == (H.var_str("context", nil, ctx, "school", ""))))) then
            H.set_var("global", nil, ctx, "xe_eater_leveling", (H.global_var_num("xe_eater_leveling")) + (1))
            services.messages.add(ctx:expand_text(services.translate("Got a new level for eater, xe_eater_leveling: <global_val:xe_eater_leveling>")), "debug")
        end
        if ((H.char_has_trait(H.u(ctx), "DREAMER") == 1) and ((("DREAMER") == (H.var_str("context", nil, ctx, "school", ""))))) then
            H.set_var("global", nil, ctx, "xe_dreamer_leveling", (H.global_var_num("xe_dreamer_leveling")) + (1))
            services.messages.add(ctx:expand_text(services.translate("Got a new level for dreamer, xe_dreamer_leveling: <global_val:xe_dreamer_leveling>")), "debug")
        end
        return true
    end
    return false
    end
    COND["EOC_XE_QUEUE_LEVELING"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_BANNED_DREAM_MAGIC_TRAITS", ctx)) == true
    end
    EOC["EOC_XE_QUEUE_LEVELING"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_BANNED_DREAM_MAGIC_TRAITS", ctx)) then
        if (H.global_var_num("xe_eater_leveling") > 0) then
            for _i = 1, math.floor(H.global_var_num("xe_eater_leveling")) do
                H.run_eoc("EOC_PICK_SPELL_EATER", ctx, nil, nil, nil)
            end
        end
        if (H.global_var_num("xe_dreamer_leveling") > 0) then
            for _i = 1, math.floor(H.global_var_num("xe_dreamer_leveling")) do
                H.run_eoc("EOC_PICK_SPELL_DREAMER", ctx, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_PICK_SPELL_EATER"] = function(ctx)
    do
        local _arr = { "_xe_spell_1", "_xe_spell_2", "_xe_spell_3", "_xe_spell_4" }
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "random_eater_spell", _v)
            H.set_var("indirect", ctx, ctx, (H.resolve_var_get(ctx, "random_eater_spell", false) or (ctx and ctx:get("random_eater_spell"))), ((function() local _t = { "spring_heeled_leap", "blood_boil", "self_healing", "supercoffee", "spell_rage", "spell_stamina_wonder", "spell_night_vision", "spell_dodge", "spell_endurance", "spell_invisibility", "spell_clairvoyance", "spell_melee_damage", "spell_spear", "spell_speed_wonder", "spell_weak", "spell_unbreakable", "point_blank", "xedra_eater_stabilize_reality", "xedra_eater_erosion" }; return _t[services.random.native_int(1, #_t)] end)()))
        end
    end
    H.set_var("global", nil, ctx, "xe_eater_leveling", (H.global_var_num("xe_eater_leveling")) - (1))
    H.run_eoc("EOC_XE_GIVE_SPELL_SELECTOR", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_PICK_SPELL_DREAMER"] = function(ctx)
    do
        local _arr = { "_xe_spell_1", "_xe_spell_2", "_xe_spell_3", "_xe_spell_4" }
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "random_dreamer_spell", _v)
            H.set_var("indirect", ctx, ctx, (H.resolve_var_get(ctx, "random_dreamer_spell", false) or (ctx and ctx:get("random_dreamer_spell"))), ((function() local _t = { "banish_nether_monsters", "banish_dark_monsters", "dream_blade", "dream_dagger", "dream_armor", "banish_nether_monsters", "banish_dark_monsters", "spell_summon_twin", "spell_dreamer_clairvoyance", "spell_dreamer_clairvoyance_eff", "summon_shifter", "summon_sapient_light", "make_constructed_hammer", "summon_duplicator", "teleport_coin", "summon_ophanim", "summon_winch", "dreamer_lucid_dreams", "spell_ethereal_wings", "spell_karma_arms", "spell_stalker_eyes", "spell_devil_tail", "xedra_dreamer_time_bubble", "xedra_dreamer_generate_accelerated_time" }; return _t[services.random.native_int(1, #_t)] end)()))
        end
    end
    H.set_var("global", nil, ctx, "xe_dreamer_leveling", (H.global_var_num("xe_dreamer_leveling")) - (1))
    H.run_eoc("EOC_XE_GIVE_SPELL_SELECTOR", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_XE_GIVE_SPELL_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_XE_GIVE_SPELL_1"] == nil or E.cond["EOC_XE_GIVE_SPELL_1"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("<spell_name:<context_val:xe_spell_1>>")), description = ctx:expand_text(services.translate("<spell_description:<context_val:xe_spell_1>>")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_XE_GIVE_SPELL_1" end end
        do local _en = (E.cond["EOC_XE_GIVE_SPELL_2"] == nil or E.cond["EOC_XE_GIVE_SPELL_2"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("<spell_name:<context_val:xe_spell_2>>")), description = ctx:expand_text(services.translate("<spell_description:<context_val:xe_spell_2>>")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_XE_GIVE_SPELL_2" end end
        do local _en = (E.cond["EOC_XE_GIVE_SPELL_3"] == nil or E.cond["EOC_XE_GIVE_SPELL_3"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("<spell_name:<context_val:xe_spell_3>>")), description = ctx:expand_text(services.translate("<spell_description:<context_val:xe_spell_3>>")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_XE_GIVE_SPELL_3" end end
        do local _en = (E.cond["EOC_XE_GIVE_SPELL_4"] == nil or E.cond["EOC_XE_GIVE_SPELL_4"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("<spell_name:<context_val:xe_spell_4>>")), description = ctx:expand_text(services.translate("<spell_description:<context_val:xe_spell_4>>")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_XE_GIVE_SPELL_4" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Choose your Destiny")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_XE_GIVE_SPELL_1"] = function(ctx)
    local _a9 = H.u(ctx)
    local _sn10 = H.var_str("context", nil, ctx, "xe_spell_1", "")
    local _sg11 = (_sn10 ~= "") and H.safe_id("spell", _sn10) or nil
    if _a9 and _sg11 then services.spells.set_level(_a9, _sg11, math.floor((H.char_spell_level(_a9, _sn10)) + 1)) end
    return true
    end
    COND["EOC_XE_GIVE_SPELL_2"] = function(ctx)
        return ((H.char_skill(H.u(ctx), "deduction") >= 3)) == true
    end
    EOC["EOC_XE_GIVE_SPELL_2"] = function(ctx)
    if ((H.char_skill(H.u(ctx), "deduction") >= 3)) then
        local _a12 = H.u(ctx)
        local _sn13 = H.var_str("context", nil, ctx, "xe_spell_2", "")
        local _sg14 = (_sn13 ~= "") and H.safe_id("spell", _sn13) or nil
        if _a12 and _sg14 then services.spells.set_level(_a12, _sg14, math.floor((H.char_spell_level(_a12, _sn13)) + 1)) end
        return true
    end
    return false
    end
    COND["EOC_XE_GIVE_SPELL_3"] = function(ctx)
        return ((H.char_skill(H.u(ctx), "deduction") >= 6)) == true
    end
    EOC["EOC_XE_GIVE_SPELL_3"] = function(ctx)
    if ((H.char_skill(H.u(ctx), "deduction") >= 6)) then
        local _a15 = H.u(ctx)
        local _sn16 = H.var_str("context", nil, ctx, "xe_spell_3", "")
        local _sg17 = (_sn16 ~= "") and H.safe_id("spell", _sn16) or nil
        if _a15 and _sg17 then services.spells.set_level(_a15, _sg17, math.floor((H.char_spell_level(_a15, _sn16)) + 1)) end
        return true
    end
    return false
    end
    COND["EOC_XE_GIVE_SPELL_4"] = function(ctx)
        return ((H.char_skill(H.u(ctx), "deduction") >= 8)) == true
    end
    EOC["EOC_XE_GIVE_SPELL_4"] = function(ctx)
    if ((H.char_skill(H.u(ctx), "deduction") >= 8)) then
        local _a18 = H.u(ctx)
        local _sn19 = H.var_str("context", nil, ctx, "xe_spell_4", "")
        local _sg20 = (_sn19 ~= "") and H.safe_id("spell", _sn19) or nil
        if _a18 and _sg20 then services.spells.set_level(_a18, _sg20, math.floor((H.char_spell_level(_a18, _sn19)) + 1)) end
        return true
    end
    return false
    end
    EOC["EOC_XE_DEBUG_OUTPUT"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("magic_potential: <global_val:magic_potential>")), "info")
    services.messages.add(ctx:expand_text(services.translate("allow_sequence: <global_val:allow_sequence>")), "info")
    services.messages.add(ctx:expand_text(services.translate("eater_dreamer_sequence: <global_val:eater_dreamer_sequence>")), "info")
    services.messages.add(ctx:expand_text(services.translate("inventor_dreamsmith_sequence: <global_val:inventor_dreamsmith_sequence>")), "info")
    services.messages.add(ctx:expand_text(services.translate("xe_eater_leveling: <global_val:xe_eater_leveling>")), "info")
    services.messages.add(ctx:expand_text(services.translate("xe_dreamer_leveling: <global_val:xe_dreamer_leveling>")), "info")
    return true
    end
    EOC["EOC_VAMPIRE_HUNTERS_PERMA_HOSTILE"] = function(ctx)
    do local g = H.safe_id("faction", "vampire_hunters"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "vampire_hunters"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "vampire_hunters"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
    return true
    end
    EOC["EOC_HUNTER_DOCTOR_GIVE_CURE"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "blood_treatment", 3, false, false, "bottle_plastic")
    return true
    end
    COND["EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES"] = function(ctx)
        return ((not (H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "LILIN_TRAITS", "DHAMPIR_WEAKNESS_SUN_SENSITIVITY", "CHANGELING_COURT_WINTER" })))) == true
    end
    EOC["EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES"] = function(ctx)
    if ((not (H.char_has_any_trait(H.u(ctx), { "VAMPIRE", "LILIN_TRAITS", "DHAMPIR_WEAKNESS_SUN_SENSITIVITY", "CHANGELING_COURT_WINTER" })))) then
        services.messages.add(ctx:expand_text(services.translate("You are ineligible for sunrises.")), "debug")
        return true
    end
    return false
    end
end
