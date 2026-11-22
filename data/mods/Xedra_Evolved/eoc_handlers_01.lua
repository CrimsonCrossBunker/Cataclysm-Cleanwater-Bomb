local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_BLOOD_ADDICTION_SNIPPET_TYPE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BLOOD_ADDICTION_SNIPPET_TYPE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add((services.snippets.native_random("blood_addiction") or ''), "warning")
        do local _g = H.safe_id('morale', "morale_craving_blood"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        return true
    else
        services.messages.add((services.snippets.native_random("blood_addiction_dream") or ''), "warning")
        do local _g = H.safe_id('morale', "morale_craving_blood"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        return false
    end
    end
    COND["EOC_BLOOD_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(2000)) <= H._jm_addiction_rational(ctx, 2000, 20, H.char_addiction(H.u(ctx), "blood", "intensity")))) == true
    end
    EOC["EOC_BLOOD_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(2000)) <= H._jm_addiction_rational(ctx, 2000, 20, H.char_addiction(H.u(ctx), "blood", "intensity")))) then
        H.run_eoc("EOC_BLOOD_ADDICTION_SNIPPET_TYPE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FAEWILD_ADDICTION_SNIPPET_TYPE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_FAEWILD_ADDICTION_SNIPPET_TYPE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add((services.snippets.native_random("faewild_addiction") or ''), "warning")
        return true
    else
        services.messages.add((services.snippets.native_random("faewild_addiction_dream") or ''), "warning")
        return false
    end
    end
    COND["EOC_FAEWILD_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "faewild", "intensity")))) == true
    end
    EOC["EOC_FAEWILD_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "faewild", "intensity")))) then
        H.run_eoc("EOC_FAEWILD_ADDICTION_SNIPPET_TYPE", ctx, nil, nil, nil)
        H.run_eoc("EOC_FAEWILD_ENNUI", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_FAEWILD_ENNUI"] = function(ctx)
    do
        local _sw1 = H.char_val_extra(H.u(ctx), "morale")
        if _sw1 == 15 then
            do local _g = H.safe_id('morale', "morale_craving_faewild"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-15), math.floor(25), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        elseif _sw1 == 25 then
            do local _g = H.safe_id('morale', "morale_craving_faewild"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-25), math.floor(-25), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        elseif _sw1 == 50 then
            do local _g = H.safe_id('morale', "morale_craving_faewild"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-50), math.floor(-50), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        elseif _sw1 == 75 then
            do local _g = H.safe_id('morale', "morale_craving_faewild"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-75), math.floor(-75), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        elseif _sw1 == 100 then
            do local _g = H.safe_id('morale', "morale_craving_faewild"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-100), math.floor(-100), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        end
    end
    H.eoc_add_effect(H.u(ctx), "faewild", 5400, nil, nil, nil)
    return true
    end
    COND["blood_spiders_itch"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "blood_spiders"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["blood_spiders_itch"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "blood_spiders"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("The spiders in your veins itch!")), "bad")
        H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        return true
    end
    return false
    end
    COND["xe_night_messages"] = function(ctx)
        return ((services.random.native_probability(1, (6)) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["xe_night_messages"] = function(ctx)
    if ((services.random.native_probability(1, (6)) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        if (((services.weather.current().weather and services.weather.current().weather.value) == "clear") or ((services.weather.current().weather and services.weather.current().weather.value) == "sunny")) then
            services.messages.add((services.snippets.native_random("XE_NIGHT_MESSAGES_CLEAR_1") or ''), "neutral")
        else
            services.messages.add((services.snippets.native_random("XE_NIGHT_MESSAGES_CLOUDY_1") or ''), "neutral")
        end
        return true
    end
    return false
    end
    COND["xe_day_messages"] = function(ctx)
        return ((services.random.native_probability(1, (6)) and (not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["xe_day_messages"] = function(ctx)
    if ((services.random.native_probability(1, (6)) and (not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        services.messages.add((services.snippets.native_random("XE_DAY_MESSAGES_1") or ''), "neutral")
        return true
    end
    return false
    end
    COND["xe_scraggy-boo_messages"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "book_teens_deduction", math.floor(1), math.floor(0))) == true
    end
    EOC["xe_scraggy-boo_messages"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "book_teens_deduction", math.floor(1), math.floor(0))) then
        services.messages.add((services.snippets.native_random("XE_SCRAGGY-BOO_MESSAGES_1") or ''), "neutral")
        return true
    end
    return false
    end
    COND["xe_book_lies_carried"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "book_deduction_lies", math.floor(1), math.floor(0))) == true
    end
    EOC["xe_book_lies_carried"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "book_deduction_lies", math.floor(1), math.floor(0))) then
        H.set_var("global", nil, ctx, "morale_book_lies", ((-3) * H.char_skill(H.u(ctx), "deduction")))
        do local _g = H.safe_id('morale', "morale_book_lies"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(H.global_var_num("morale_book_lies")), math.floor(H.global_var_num("morale_book_lies")), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(900)) }) end end
        services.messages.add((services.snippets.native_random("XE_BOOK_LIES_CARRIED") or ''), "neutral")
        return true
    end
    return false
    end
    COND["xe_book_lies_carried_no_tick_down"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "book_deduction_lies", math.floor(1), math.floor(0))) == true
    end
    EOC["xe_book_lies_carried_no_tick_down"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "book_deduction_lies", math.floor(1), math.floor(0))) then
        do local _a, _v = H.u(ctx), "xedra_knowing_lies"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_BOOK_LIES_NIGHTMARES"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "xedra_knowing_lies") >= 500)) == true
    end
    EOC["EOC_BOOK_LIES_NIGHTMARES"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "xedra_knowing_lies") >= 500)) then
        services.messages.add((services.snippets.native_random("nightmares_book_lies") or ''), "bad")
        H.set_var("global", nil, ctx, "morale_book_lies", ((-3) * H.char_skill(H.u(ctx), "deduction")))
        do local _g = H.safe_id('morale', "morale_book_lies"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(H.global_var_num("morale_book_lies")), math.floor(H.global_var_num("morale_book_lies")), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(900)) }) end end
        return true
    end
    return false
    end
    COND["faeblood_hallu_light"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "drank_fae_blood_hallucination"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 3).value == true end)())) == true
    end
    EOC["faeblood_hallu_light"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "drank_fae_blood_hallucination"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 3).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "hallu", 1800, nil, 1, nil)
        return true
    end
    return false
    end
    COND["faeblood_hallu_hard"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "drank_fae_blood_hallucination"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 4).value == true end)())) == true
    end
    EOC["faeblood_hallu_hard"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "drank_fae_blood_hallucination"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 4).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "hallu", 1800, nil, 1, nil)
        H.eoc_add_effect(H.u(ctx), "visuals", 1800, nil, 1, nil)
        return true
    end
    return false
    end
    COND["EOC_EATER_CHECK"] = function(ctx)
        return (((H.char_spell_count(H.u(ctx), "EATER") >= 6) and (not ((H.char_has_trait(H.u(ctx), "EATER_SIXTH_SENSE") == 1))))) == true
    end
    EOC["EOC_EATER_CHECK"] = function(ctx)
    if (((H.char_spell_count(H.u(ctx), "EATER") >= 6) and (not ((H.char_has_trait(H.u(ctx), "EATER_SIXTH_SENSE") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("You suddenly realize that your ability to sense the unnatural has expanded to a level beyond those of the normal five senses.")), "good")
        do local _g = H.safe_id('mutation', "EATER_SIXTH_SENSE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    EOC["xe_test_remove_category"] = function(ctx)
    do local _g = H.safe_id('mutation_category', "URSINE"); if H.u(ctx) and _g then services.mutations.remove_category(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_discover_jotunn"] = function(ctx)
        return (((H.mons_nearby(H.u(ctx), { "mon_exodii_quad_jotunn" }, 60, nil) >= 1) and (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_exodii_seen_jotunn") and 1 or 0)))))) == true
    end
    EOC["EOC_discover_jotunn"] = function(ctx)
    if (((H.mons_nearby(H.u(ctx), { "mon_exodii_quad_jotunn" }, 60, nil) >= 1) and (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "dialogue_exodii_seen_jotunn") and 1 or 0)))))) then
        H.set_var("actor", H.u(ctx), ctx, "dialogue_exodii_seen_jotunn", "yes")
        return true
    end
    return false
    end
    COND["eoc_poppy_intensity_changed"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "opiate_eff"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "consumed_minoan_orchid"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["eoc_poppy_intensity_changed"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "opiate_eff"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "consumed_minoan_orchid"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        H.eoc_add_effect(H.u(ctx), "minoan_orchid_effect", -1, nil, H.creature_effect_intensity(H.u(ctx), "opiate_eff"), nil)
        return true
    end
    return false
    end
    COND["INCREASE_BERSERKER"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "dreamforged_knuckle_berserk", math.floor(1), math.floor(0))) == true
    end
    EOC["INCREASE_BERSERKER"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "dreamforged_knuckle_berserk", math.floor(1), math.floor(0))) then
        services.messages.add(ctx:expand_text(services.translate("BERSERK +1.")), "debug")
        H.set_var("global", nil, ctx, "BERSERKER", (H.global_var_num("BERSERKER")) + (1))
        return true
    end
    return false
    end
    EOC["DECREASE_BERSERKER"] = function(ctx)
    H.set_var("global", nil, ctx, "BERSERKER", math.max(0, (H.global_var_num("BERSERKER") - 1)))
    return true
    end
    COND["EOC_XE_RandEnc"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_xe_RandEnc"), 1) >= 86400) and (ctx:evaluate_conditional("random_enc_condition") == true))) == true
    end
    EOC["EOC_XE_RandEnc"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_xe_RandEnc"), 1) >= 86400) and (ctx:evaluate_conditional("random_enc_condition") == true))) then
        services.messages.add(ctx:expand_text(services.translate("Xedra Evolved random encounter has met its conditions.")), "debug")
        H.eoc_loc_var(H.u(ctx), ctx, "global", "XE_randenc_loc", { terrain = H.var_str("context", nil, ctx, "omt", "") }, { z = math.floor(0), search_range = math.floor(30), min_distance = math.floor(3), random = true }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "XE_randenc_loc"); if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("context", nil, ctx, "omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("context", nil, ctx, "map_update", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_xe_RandEnc", services.turn())
        H.set_var("global", nil, ctx, "XE_RandEnc", 1)
        H.copy_var("context", nil, "omt", "global", nil, "XE_random_encounter_omt", ctx)
        H.copy_var("context", nil, "map_removal", "global", nil, "XE_random_encounter_map_remove", ctx)
        if (ctx:evaluate_conditional("XE_random_enc_trigger_message_condition") == true) then
            services.messages.add(ctx:expand_text(services.translate("<global_val:XE_RandEnc_Trigger_Message>")), "info")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Xedra Evolved random encounter has not met its conditions.")), "debug")
        return false
    end
    end
    COND["EOC_Xedra_Evolved_RandEnc_remove"] = function(ctx)
        return (((H.time_since(H.var_num_opt(H.u(ctx), "timer_xe_RandEnc"), 1) > 7200) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "XE_random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("XE_RandEnc") == 1))) == true
    end
    EOC["EOC_Xedra_Evolved_RandEnc_remove"] = function(ctx)
    if (((H.time_since(H.var_num_opt(H.u(ctx), "timer_xe_RandEnc"), 1) > 7200) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "XE_random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("XE_RandEnc") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("Current random encounter is being removed.")), "debug")
        do local _p = H.get_tripoint_var("global", nil, ctx, "XE_randenc_loc"); if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("global", nil, ctx, "XE_random_encounter_omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("global", nil, ctx, "XE_random_encounter_map_remove", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "XE_RandEnc", 0)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_Roadstop_Jotunn"] = function(ctx)
        return ((H.global_var_num("XE_RandEnc") == 0)) == true
    end
    EOC["EOC_RandEnc_Roadstop_Jotunn"] = function(ctx)
    if ((H.global_var_num("XE_RandEnc") == 0)) then
        ctx:set_conditional("random_enc_condition", ((services.gameplay.environment.dimension() == "default") and (not ((services.time_snapshot().season_id == string.lower("winter"))))))
        services.messages.add(ctx:expand_text(services.translate("Xedra Evolved Jotunn/Zebra encounter has triggered!")), "debug")
        H.set_var("global", nil, ctx, "XE_RandEnc_Trigger_Message", services.translate("You hear a sustained burst of gunfire somewhere in the distance."))
        ctx:set_conditional("XE_random_enc_trigger_message_condition", (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))
        H.run_eoc("EOC_XE_RandEnc", ctx, { ["omt"] = "s_gas_rural", ["map_update"] = "nest_RandEnc_ruralgas_jotunn", ["map_removal"] = "nest_RandEnc_jotunn_remove", ["chance"] = 10, ["days_till_spawn"] = 7 }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_March_Lord_Hunting_Party"] = function(ctx)
        return ((H.global_var_num("XE_RandEnc") == 0)) == true
    end
    EOC["EOC_RandEnc_March_Lord_Hunting_Party"] = function(ctx)
    if ((H.global_var_num("XE_RandEnc") == 0)) then
        ctx:set_conditional("random_enc_condition", ((not services.gameplay.environment.is_night()) and (services.gameplay.environment.dimension() == "default") and ((services.weather.current().weather and services.weather.current().weather.value) == "fog") and (0 == 1)))
        services.messages.add(ctx:expand_text(services.translate("Xedra Evolved March Lord hunt encounter has triggered!")), "debug")
        H.set_var("global", nil, ctx, "XE_RandEnc_Trigger_Message", services.translate("You hear a low horn-call somewhere out in the fog."))
        ctx:set_conditional("XE_random_enc_trigger_message_condition", (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))
        H.run_eoc("EOC_XE_RandEnc", ctx, { ["omt"] = "field", ["map_update"] = "nest_RandEnc_March_Lord_Hunting_Party", ["map_removal"] = "nest_RandEnc_March_Lord_Hunting_Party_remove", ["chance"] = 15, ["days_till_spawn"] = 0 }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_XE_Wraiths_On_Dark_Nights"] = function(ctx)
        return ((H.global_var_num("XE_RandEnc") == 0)) == true
    end
    EOC["EOC_RandEnc_XE_Wraiths_On_Dark_Nights"] = function(ctx)
    if ((H.global_var_num("XE_RandEnc") == 0)) then
        ctx:set_conditional("random_enc_condition", ((not ((not services.gameplay.environment.is_night()))) and ((H.moon_phase() == 0) or (H.moon_phase() == 1) or (H.moon_phase() == 7)) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_light_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_rain"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_rainstorm"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_thunder"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "weather_lightning"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning")))))
        services.messages.add(ctx:expand_text(services.translate("Xedra Evolved wraiths encounter has triggered!")), "debug")
        H.set_var("global", nil, ctx, "XE_RandEnc_Trigger_Message", services.translate("A shadow seems to pass over the remnants of the moon."))
        ctx:set_conditional("XE_random_enc_trigger_message_condition", ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((H.moon_phase() == 1) or (H.moon_phase() == 7)) and (((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear"))))
        do
            local _sw2 = services.random.native_int(0, H.round_half_away(2))
            if _sw2 == 0 then
                H.run_eoc("EOC_XE_RandEnc", ctx, { ["omt"] = "field", ["map_update"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights", ["map_removal"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights_remove", ["chance"] = 15, ["days_till_spawn"] = 0 }, nil, nil)
            elseif _sw2 == 1 then
                H.run_eoc("EOC_XE_RandEnc", ctx, { ["omt"] = "forest", ["map_update"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights", ["map_removal"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights_remove", ["chance"] = 20, ["days_till_spawn"] = 0 }, nil, nil)
            elseif _sw2 == 2 then
                H.run_eoc("EOC_XE_RandEnc", ctx, { ["omt"] = "forest_water", ["map_update"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights", ["map_removal"] = "nest_RandEnc_XE_Wraiths_On_Dark_Nights_remove", ["chance"] = 20, ["days_till_spawn"] = 0 }, nil, nil)
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_XEDRA_TRACK_LAST_HIT"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "xedra_last_damage_taken", (ctx:get_number("damage") or 0))
    H.set_var("actor", H.u(ctx), ctx, "xedra_last_pain_taken", (ctx:get_number("pain") or 0))
    H.copy_var("context", nil, "bodypart", "actor", H.u(ctx), "xedra_last_damage_taken_bodypart", ctx)
    return true
    end
    COND["eoc_xedra_time_freeze_character_start_activity"] = function(ctx)
        return (((("effect_xedra_time_freeze") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["eoc_xedra_time_freeze_character_start_activity"] = function(ctx)
    if (((("effect_xedra_time_freeze") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        do local _g = H.safe_id('activity', "act_xedra_time_freeze"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(17280000)))) end end
        H.run_eoc("EOC_XEDRA_TIME_SAVE_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "time_freeze" }, nil, nil)
        return true
    end
    return false
    end
    COND["eoc_xedra_time_freeze_character_end_activity"] = function(ctx)
        return (((("effect_xedra_time_freeze") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["eoc_xedra_time_freeze_character_end_activity"] = function(ctx)
    if (((("effect_xedra_time_freeze") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        H.run_eoc("EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "time_freeze" }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XEDRA_DAMAGE_REVERSAL"] = function(ctx)
        return ((H.var_num(H.u(ctx), "xedra_last_damage_taken") > 0)) == true
    end
    EOC["EOC_XEDRA_DAMAGE_REVERSAL"] = function(ctx)
    if ((H.var_num(H.u(ctx), "xedra_last_damage_taken") > 0)) then
        if ((("bp_null") == ("u_xedra_last_damage_taken_bodypart"))) then
            H.set_char_hp(H.u(ctx), "ALL", H.var_num(H.u(ctx), "xedra_last_damage_taken"), "+=")
            H.set_var("actor", H.u(ctx), ctx, "xedra_last_damage_taken", 0)
            do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        else
            H.set_char_hp(H.u(ctx), H.var_str("actor", H.u(ctx), ctx, "xedra_last_damage_taken_bodypart", ""), H.var_num(H.u(ctx), "xedra_last_damage_taken"), "+=")
            local _a3 = H.u(ctx)
            if _a3 then services.characters.adjust(_a3, { pain = math.floor(-(H.var_num(H.u(ctx), "xedra_last_pain_taken"))) }) end
            H.set_var("actor", H.u(ctx), ctx, "xedra_last_damage_taken", 0)
            do local _eg = H.safe_id('effect', "bleed"); local _bp = (H.var_str("actor", H.u(ctx), ctx, "xedra_last_damage_taken_bodypart", "") ~= nil) and H.safe_id('body_part', H.var_str("actor", H.u(ctx), ctx, "xedra_last_damage_taken_bodypart", "")) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        services.messages.add(ctx:expand_text(services.translate("Your wound heals!")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have a previous wound to heal.")), "neutral")
        return false
    end
    end
    COND["EOC_CHECK_GAMESTART_CHRONOMANCER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER") == 1)) == true
    end
    EOC["EOC_CHECK_GAMESTART_CHRONOMANCER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER") == 1)) then
        H.run_eoc("EOC_XEDRA_LOOPING_WOUND_BEGIN", ctx, nil, nil, nil)
        H.run_eoc("EOC_XEDRA_CHRONOMANCER_UNSTABLE_POWERS", ctx, nil, nil, nil)
        do local _a, _v = H.u(ctx), "xedra_chronomancer_insight"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 51; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_LOOPING_WOUND_BEGIN"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_LOOPING_WOUND") == 1)) == true
    end
    EOC["EOC_XEDRA_LOOPING_WOUND_BEGIN"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_LOOPING_WOUND") == 1)) then
        H.run_eoc("EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE", ctx, nil, nil, nil)
        H.eoc_spawn_item(H.u(ctx), "xedra_chrono_knife", 1, false, false, nil)
        return true
    end
    return false
    end
    COND["EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_LOOPING_WOUND") == 1)) == true
    end
    EOC["EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_LOOPING_WOUND") == 1)) then
        services.messages.add(ctx:expand_text(services.translate("You feel a sharp jolt of pain as a stab wound suddenly opens in your belly!")), "bad")
        H.set_char_hp(H.u(ctx), "torso", 10, "-=")
        H.set_var("actor", H.u(ctx), ctx, "xedra_last_damage_taken", 10)
        H.set_var("actor", H.u(ctx), ctx, "xedra_last_damage_taken_bodypart", "torso")
        local _a4 = H.u(ctx)
        if _a4 then services.characters.adjust(_a4, { pain = math.floor(30) }) end
        H.set_var("actor", H.u(ctx), ctx, "xedra_last_pain_taken", 30)
        H.eoc_add_effect(H.u(ctx), "bleed", 600, "torso", nil, nil)
        do local _t = math.max(1, math.floor(86400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_CHRONOMANCER_UNSTABLE_POWERS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_UNSTABLE_POWERS") == 1)) == true
    end
    EOC["EOC_XEDRA_CHRONOMANCER_UNSTABLE_POWERS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "XEDRA_CHRONOMANCER_UNSTABLE_POWERS") == 1)) then
        if ((H._jm_xedra_chron_toggled_spell_count(ctx) > 0) and (services.random.native_float(0, 5) > H._jm_xedra_chron_toggled_spell_count(ctx))) then
            services.messages.add(ctx:expand_text(services.translate("Your chronomantic powers destabilize and you lose their effects!")), "neutral")
            do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_chronal_accel"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_destabilizing_strikes"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_stabilize_timeline"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_reverse_entropy"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_stable_timeloop"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(1800), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XEDRA_CHRONOMANCER_UNSTABLE_POWERS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_TIME_LOOP_START_LOOP"] = function(ctx)
        return (((("effect_xedra_time_loop") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_XEDRA_TIME_LOOP_START_LOOP"] = function(ctx)
    if (((("effect_xedra_time_loop") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.run_eoc("EOC_XEDRA_TIME_SAVE_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "time_loop" }, nil, nil)
        do local _t = math.max(1, math.floor(5)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XEDRA_TIME_LOOP_LOOP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_TIME_LOOP_LOOP"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_xedra_time_loop"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_XEDRA_TIME_LOOP_LOOP"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_xedra_time_loop"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "time_loop" }, nil, nil)
        do local _t = math.max(1, math.floor(5)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XEDRA_TIME_LOOP_LOOP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_TIME_LOOP_ENDED_LOOP"] = function(ctx)
        return (((("effect_xedra_time_loop") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_XEDRA_TIME_LOOP_ENDED_LOOP"] = function(ctx)
    if (((("effect_xedra_time_loop") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Your time loop ends!")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Your time loop ends!")))
        H.run_eoc("EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "time_loop" }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_GAIN_EFFECT"] = function(ctx)
        return (((("effect_xedra_chronomancer_stable_timeloop") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_GAIN_EFFECT"] = function(ctx)
    if (((("effect_xedra_chronomancer_stable_timeloop") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.run_eoc("EOC_XEDRA_TIME_SAVE_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "stable_timeloop" }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_LOSE_EFFECT"] = function(ctx)
        return (((("effect_xedra_chronomancer_stable_timeloop") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_LOSE_EFFECT"] = function(ctx)
    if (((("effect_xedra_chronomancer_stable_timeloop") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Time rewinds!")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Time rewinds!")))
        H.run_eoc("EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC", ctx, { ["xedra_chronomancer_prefix"] = "stable_timeloop" }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_PREVENT_DEATH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_xedra_chronomancer_stable_timeloop"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_XEDRA_CHRONOMANCER_STABLE_TIMELOOP_PREVENT_DEATH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_xedra_chronomancer_stable_timeloop"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        H.set_char_hp(H.u(ctx), "ALL", 1000, "=")
        do local _eg = H.safe_id('effect', "effect_xedra_chronomancer_stable_timeloop"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_TIME_SAVE_VARIABLES_DYNAMIC"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "xedra_chronomancer_prefix"))) == true
    end
    EOC["EOC_XEDRA_TIME_SAVE_VARIABLES_DYNAMIC"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "xedra_chronomancer_prefix"))) then
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_location_before_<context_val:xedra_chronomancer_prefix>"))
        H.eoc_loc_var(H.u(ctx), ctx, "indirect", (H.resolve_var_get(ctx, "target_var", false) or (ctx and ctx:get("target_var"))), nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_pain_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", (((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_kcal_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_thirst_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_blood_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "blood"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_redcells_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "redcells"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_rad_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "rad"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_calcium_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "calcium"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_iron_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "iron"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_vitC_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_vitamin(H.u(ctx), "vitC"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_sleepiness_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", (((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_sleep_deprivation_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_val_extra(H.u(ctx), "sleep_deprivation"))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_stamina_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_all_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "ALL", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_torso_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "torso", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_head_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "head", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_eyes_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "eyes", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_mouth_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "mouth", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_arm_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "arm_l", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_hand_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "hand_l", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_arm_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "arm_r", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_hand_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "hand_r", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_leg_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "leg_l", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_foot_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "foot_l", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_leg_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "leg_r", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_hp_foot_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_var("global", nil, ctx, "v_target_var", H.char_hp(H.u(ctx), "foot_r", false))
        H.set_var("context", nil, ctx, "target_var", ctx:expand_text("u_xedra_bleed_before_<context_val:xedra_chronomancer_prefix>"))
        if ((function() local eg = H.safe_id('effect', "bleed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.set_var("global", nil, ctx, "v_target_var", 1)
        else
            H.set_var("global", nil, ctx, "v_target_var", 0)
        end
        return true
    end
    return false
    end
    COND["EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "xedra_chronomancer_prefix"))) == true
    end
    EOC["EOC_XEDRA_TIME_LOAD_VARIABLES_DYNAMIC"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "xedra_chronomancer_prefix"))) then
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_location_before_<context_val:xedra_chronomancer_prefix>"))
        do local _p = H.resolve_var_get(ctx, (H.resolve_var_get(ctx, "temp_var", false) or (ctx and ctx:get("temp_var"))), true); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_pain_before_<context_val:xedra_chronomancer_prefix>"))
        local _a5 = H.u(ctx)
        if _a5 then services.characters.adjust(_a5, { pain = math.floor((H.global_var_num("v_temp_var")) - (H.char_pain(_a5))) }) end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_kcal_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(H.global_var_num("v_temp_var") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.global_var_num("v_temp_var"); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_thirst_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_val_extra(H.u(ctx), "thirst", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_blood_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.global_var_num("v_temp_var"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_redcells_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.global_var_num("v_temp_var"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_calcium_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a, _v = H.u(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.global_var_num("v_temp_var"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_iron_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a, _v = H.u(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.global_var_num("v_temp_var"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_vitC_before_<context_val:xedra_chronomancer_prefix>"))
        do local _a, _v = H.u(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.global_var_num("v_temp_var"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_rad_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_val_extra(H.u(ctx), "rad", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_sleepiness_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_val_extra(H.u(ctx), "sleepiness", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_sleep_deprivation_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_val_extra(H.u(ctx), "sleep_deprivation", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_stamina_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_val_extra(H.u(ctx), "stamina", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_all_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "ALL", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_torso_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "torso", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_head_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "head", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_eyes_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "eyes", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_mouth_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "mouth", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_arm_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "arm_l", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_hand_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "hand_l", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_arm_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "arm_r", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_hand_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "hand_r", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_leg_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "leg_r", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_foot_r_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "foot_r", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_leg_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "leg_l", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_hp_foot_l_before_<context_val:xedra_chronomancer_prefix>"))
        H.set_char_hp(H.u(ctx), "foot_l", H.global_var_num("v_temp_var"), "=")
        H.set_var("context", nil, ctx, "temp_var", ctx:expand_text("u_xedra_bleed_before_<context_val:xedra_chronomancer_prefix>"))
        if (H.global_var_num("v_temp_var") == 0) then
            do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return true
    end
    return false
    end
    COND["EOC_FEEDING_THE_BLACK_HORSE"] = function(ctx)
        return (((H.mons_nearby(H.u(ctx), { "mon_beneficial_polymorph_arion" }, 1000, nil) > 0) and (H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION") == 1))) == true
    end
    EOC["EOC_FEEDING_THE_BLACK_HORSE"] = function(ctx)
    if (((H.mons_nearby(H.u(ctx), { "mon_beneficial_polymorph_arion" }, 1000, nil) > 0) and (H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION") == 1))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("It's time to feed the beast that was your horse before it goes feral with hunger.")))
        H.eoc_add_effect(H.u(ctx), "effect_feed_the_black_horse", 259200, nil, nil, nil)
        do local _t = math.max(1, math.floor(345600)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHECKING_THE_BLACK_HORSE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_CHECKING_THE_BLACK_HORSE"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_fed_the_black_horse"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION") == 1))) == true
    end
    EOC["EOC_CHECKING_THE_BLACK_HORSE"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_fed_the_black_horse"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_has_trait(H.u(ctx), "DHAMPIR_BLACKEN_SOUL_ARION") == 1))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You didn't feed your horse and now the world with pay the price.  And maybe you will as well.")))
        H.eoc_cast_spell(H.u(ctx), "dhampir_horse_blood_hungry_polymorph_spell", false, nil)
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SPAWN_SHADOW_MESSAGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "EATER") == 1)) == true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_MESSAGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "EATER") == 1)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("The night closes in… but you were born to destroy what's coming")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("The night closes in… but you were born to destroy what's coming")))
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("You shiver as the night closes in…")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("You shiver as the night closes in…")))
        return false
    end
    end
    COND["EOC_UNDINE_WARP_POOL_BOTTOM_FLOOR"] = function(ctx)
        return (H.char_at_om_location(H.u(ctx), "undine_warp_pool_warper")) == true
    end
    EOC["EOC_UNDINE_WARP_POOL_BOTTOM_FLOOR"] = function(ctx)
    if (H.char_at_om_location(H.u(ctx), "undine_warp_pool_warper")) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "undine_pool_lake_port", { terrain = "lake", match = "PREFIX" }, { z = math.floor(0), search_range = math.floor(400), random = true }, nil, nil, nil, false, true, {  }, {  })
        ccb.presentation.notice(ctx:expand_text(services.translate("You swim down and down, further and further, until you're no longer sure which way is up.  You're in total darkness, still swimming, when you see a light up ahead.  With a goal at last in reach, you swim toward it as the light broadens and expands and, finally, you breach the water's surface.")))
        do local _p = H.get_tripoint_var("global", nil, ctx, "undine_pool_lake_port"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    end
    return false
    end
    EOC["EOC_OFFWORLD_ACQUISITIONS_ASSETS"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "OFFWORLD_ACQUISITIONS_ASSETS_COMPUTER_MAIN") end
    return true
    end
    EOC["EOC_OFFWORLD_ACQUISITIONS_RAW_MATERIALS"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "OFFWORLD_ACQUISITIONS_RAW_MATERIALS_COMPUTER_MAIN") end
    return true
    end
    COND["EOC_CONDITION_BANNED_DREAM_MAGIC_TRAITS"] = function(ctx)
        return ((not (H.char_has_any_trait(H.u(ctx), { "CHANGELING_MAGIC", "NATIVE_SHAPESHIFTER", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT", "LILIN_TRAITS", "GRACKEN", "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "VAMPIRE" })))) == true
    end
    EOC["EOC_CONDITION_BANNED_DREAM_MAGIC_TRAITS"] = function(ctx)
    if ((not (H.char_has_any_trait(H.u(ctx), { "CHANGELING_MAGIC", "NATIVE_SHAPESHIFTER", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT", "LILIN_TRAITS", "GRACKEN", "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "VAMPIRE" })))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "CHANGELING_MAGIC" })) == true
    end
    EOC["EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "CHANGELING_MAGIC" })) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_XE_VAMPIRE_AVOID_BURNING_IN_SUNLIGHT"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "vampire_blind_the_sun"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "mut_skyisland_sunblock_real") == 1))))) == true
    end
    EOC["EOC_CONDITION_XE_VAMPIRE_AVOID_BURNING_IN_SUNLIGHT"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "vampire_blind_the_sun"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "mut_skyisland_sunblock_real") == 1))))) then
        return true
    end
    return false
    end
    COND["EOC_DREAMS_AND_NIGHTMARES"] = function(ctx)
        return (((H.global_var_num("dream_counter") == 0) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1))) and (not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "IERDE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "ARVORE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1))) and (not ((H.char_has_trait(H.u(ctx), "UNDINE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SYLPH") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_POOKA") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_BROWNIE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_TROW") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_SELKIE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_NOBLE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "GRACKEN") == 1))))) == true
    end
    EOC["EOC_DREAMS_AND_NIGHTMARES"] = function(ctx)
    if (((H.global_var_num("dream_counter") == 0) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1))) and (not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "IERDE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "ARVORE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1))) and (not ((H.char_has_trait(H.u(ctx), "UNDINE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SYLPH") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_POOKA") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_BROWNIE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_TROW") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_COMMONER_SELKIE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_NOBLE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "GRACKEN") == 1))))) then
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_EDGE_CASES", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_MANA?", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_EDGE_CASES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1) or (H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_EDGE_CASES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1) or (H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) then
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_VAMPS_AND_LILIN", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_GRACKEN_AND_FAE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_VAMPS_AND_LILIN"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1)) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_VAMPS_AND_LILIN"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE4") == 1)) then
        services.messages.add((services.snippets.native_random("undead_wake_up") or ''), "neutral")
        return true
    else
        services.messages.add((services.snippets.native_random("lilin_wake_up") or ''), "neutral")
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_GRACKEN_AND_FAE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "GRACKEN") == 1)) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_GRACKEN_AND_FAE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "GRACKEN") == 1)) then
        services.messages.add((services.snippets.native_random("gracken_wake_up") or ''), "neutral")
        return true
    else
        if ((H.var_num(H.u(ctx), "changeling_advancement_dreams_counter") >= 1) and (H.char_has_trait(H.u(ctx), "VAMPIRE") == 1)) then
            services.messages.add((services.snippets.native_random("vampire_infected_fae_wake_up") or ''), "bad")
        else
            services.messages.add((services.snippets.native_random("fae_wake_up") or ''), "neutral")
        end
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_MANA?"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "DREAMER") == 1) or (H.char_has_trait(H.u(ctx), "EATER") == 1))) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_MANA?"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "DREAMER") == 1) or (H.char_has_trait(H.u(ctx), "EATER") == 1))) then
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_MANA", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_DREAMS_OR_NIGHTMARES_NO_MANA", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_MANA"] = function(ctx)
        return ((services.random.native_probability(1, (2)) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_MANA"] = function(ctx)
    if ((services.random.native_probability(1, (2)) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        services.messages.add(ctx:expand_text(services.translate("You have a good dream.")), "neutral")
        services.messages.add((services.snippets.native_random("XE_SWEET_DREAMS") or ''), "good")
        do local _g = H.safe_id('morale', "morale_sweet_dreams"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(15, 40)), math.floor(40), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        H.eoc_cast_spell(H.u(ctx), "dream_mana_gain", false, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a bad dream.")), "neutral")
        services.messages.add((services.snippets.native_random("XE_BAD_DREAMS") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-40, -15)), math.floor(-40), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        H.eoc_cast_spell(H.u(ctx), "nightmare_mana_gain", false, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return false
    end
    end
    COND["EOC_DREAMS_OR_NIGHTMARES_NO_MANA"] = function(ctx)
        return ((services.random.native_probability(1, (2)) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_DREAMS_OR_NIGHTMARES_NO_MANA"] = function(ctx)
    if ((services.random.native_probability(1, (2)) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        services.messages.add(ctx:expand_text(services.translate("You have a good dream.")), "neutral")
        services.messages.add((services.snippets.native_random("XE_SWEET_DREAMS") or ''), "good")
        do local _g = H.safe_id('morale', "morale_sweet_dreams"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(15, 40)), math.floor(40), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a bad dream.")), "neutral")
        services.messages.add((services.snippets.native_random("XE_BAD_DREAMS") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-40, -15)), math.floor(-40), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return false
    end
    end
    COND["EOC_CONDITIONS_LILIN_DINOMOD_RUACH_DRAIN"] = function(ctx)
        return (((H.u(ctx) ~= nil and ((H.safe_id('species', "DINOSAUR") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "DINOSAUR")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))))) == true
    end
    EOC["EOC_CONDITIONS_LILIN_DINOMOD_RUACH_DRAIN"] = function(ctx)
    if (((H.u(ctx) ~= nil and ((H.safe_id('species', "DINOSAUR") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "DINOSAUR")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITIONS_LILIN_FANTASY_SPECIES_RUACH_DRAIN"] = function(ctx)
        return (((H.u(ctx) ~= nil and ((H.safe_id('species', "LIZARDFOLK") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "LIZARDFOLK")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "GOBLIN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "GOBLIN")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "GOBLIN_FORGE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "GOBLIN_FORGE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ORC") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ORC")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "OGRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "OGRE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RAVENFOLK") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RAVENFOLK")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "DWARF") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "DWARF")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ELF") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ELF")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "FEY") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FEY")).value == true))))) == true
    end
    EOC["EOC_CONDITIONS_LILIN_FANTASY_SPECIES_RUACH_DRAIN"] = function(ctx)
    if (((H.u(ctx) ~= nil and ((H.safe_id('species', "LIZARDFOLK") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "LIZARDFOLK")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "GOBLIN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "GOBLIN")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "GOBLIN_FORGE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "GOBLIN_FORGE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ORC") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ORC")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "OGRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "OGRE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "RAVENFOLK") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RAVENFOLK")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "DWARF") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "DWARF")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ELF") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ELF")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "FEY") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FEY")).value == true))))) then
        return true
    end
    return false
    end
    COND["target_valid_drink"] = function(ctx)
        return (((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))))) == true
    end
    EOC["target_valid_drink"] = function(ctx)
    if (((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true))))) and (not ((H.char_has_trait(H.npc(ctx), "VAMPIRE") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "BLOOD_OF_SAINTS") == 1))))) then
        return true
    end
    return false
    end
end
