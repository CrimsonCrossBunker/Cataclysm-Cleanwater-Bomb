local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_CHANGELING_SPRING_REMOVE_FATIGUE_AND_SLEEP_DEPRIVATION_INITIATE_REMOVAL"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) >= 1) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", ((50 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 12)) * services.random.native_float(0.5, 1.5)), "-=")
        services.messages.add(ctx:expand_text(services.translate("Your tiredness just seems to fall away.")), "good")
    end
    if (H.char_val_extra(H.u(ctx), "sleep_deprivation") >= 1) then
        H.set_char_val_extra(H.u(ctx), "sleep_deprivation", ((100 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 24)) * services.random.native_float(0.5, 1.5)), "-=")
    end
    if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) < 0) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", 0, "=")
    end
    if (H.char_val_extra(H.u(ctx), "sleep_deprivation") < 0) then
        H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 0, "=")
    end
    return true
    end
    COND["EOC_CHANGELING_SPRING_REMOVE_FATIGUE_AND_SLEEP_DEPRIVATION_INITIATE"] = function(ctx)
        return ((not ((services.time_snapshot().season_id == string.lower("autumn"))))) == true
    end
    EOC["EOC_CHANGELING_SPRING_REMOVE_FATIGUE_AND_SLEEP_DEPRIVATION_INITIATE"] = function(ctx)
    if ((not ((services.time_snapshot().season_id == string.lower("autumn"))))) then
        H.run_eoc("EOC_CHANGELING_SPRING_REMOVE_FATIGUE_AND_SLEEP_DEPRIVATION_INITIATE_REMOVAL", ctx, nil, nil, nil)
        return true
    else
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not services.gameplay.environment.is_night())) then
            H.run_eoc("EOC_CHANGELING_SPRING_REMOVE_FATIGUE_AND_SLEEP_DEPRIVATION_INITIATE_REMOVAL", ctx, nil, nil, nil)
        else
            services.messages.add(ctx:expand_text(services.translate("During the autumn, you must be outdoors and in sunlight to shed your tiredness")), "bad")
        end
        return false
    end
    end
    COND["EOC_CHANGELING_SPRING_SUMMON_RAIN_SHOWER"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15)))) == true
    end
    EOC["EOC_CHANGELING_SPRING_SUMMON_RAIN_SHOWER"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15)))) then
        if (H.var_num(H.u(ctx), "weather_change_limit") == 3) then
            services.messages.add(ctx:expand_text(services.translate("You unweave the glamour controlling the weather.")), "good")
            H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
            do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        else
            do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("You spin some glamour into the skies.")), "good")
            H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 3)
            H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_lower_bound", (45 / H._jm_selkie_has_weather_mastery(ctx)))
            H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_upper_bound", (150 / H._jm_selkie_has_weather_mastery(ctx)))
            H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_rains", 21600, nil, nil, nil)
            H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((556.53 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 146.77)) + (H.char_skill(H.u(ctx), "gramarye") * 267.49)) * H._jm_selkie_has_weather_mastery(ctx)))
            H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((1256.5 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 205.48)) + (H.char_skill(H.u(ctx), "gramarye") * 687.4)) * H._jm_selkie_has_weather_mastery(ctx)))
            H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_INITIATE"), nil) end end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outside and the temperature must be above freezing to call the rains.")), "bad")
        return false
    end
    end
    COND["EOC_CHANGELING_SUMMER_LIGHT_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_light_spell"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_LIGHT_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_light_spell"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((256.97 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 67.91)) + (H.char_skill(H.u(ctx), "gramarye") * 162.5)) * (((H.global_var_num("global_what_is_the_season") == 4)) and (0.6) or (1))))
        H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((615.27 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 165.31)) + (H.char_skill(H.u(ctx), "gramarye") * 486.15)) * (((H.global_var_num("global_what_is_the_season") == 4)) and (0.4) or (1))))
        H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_light", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("A flickering red-orange wisp of light kindles near your shoulder.")), "neutral")
        return true
    else
        do local _eg = H.safe_id('effect', "effect_changeling_summer_light"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_CHANGELING_SUMMER_LIGHT_FIRE_INITIATE"] = function(ctx)
        return ((not ((services.time_snapshot().season_id == string.lower("winter"))))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_LIGHT_FIRE_INITIATE"] = function(ctx)
    if ((not ((services.time_snapshot().season_id == string.lower("winter"))))) then
        H.run_eoc("EOC_HEDGE_LIGHT_FIRE", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You gesture and summon up a burst of fiery heat.")), "neutral")
        return true
    else
        if services.random.native_probability(((50 + H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER"))), (100)) then
            H.run_eoc("EOC_HEDGE_LIGHT_FIRE", ctx, nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You gesture and summon up a burst of fiery heat.")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You gesture but nothing happens.")), "bad")
        end
        return false
    end
    end
    EOC["EOC_CHANGELING_SUMMER_SUN_GLASSES_INITIATE"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((580.52 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 109.82)) + (H.char_skill(H.u(ctx), "gramarye") * 223.65)))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((1185.21 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 318.25)) + (H.char_skill(H.u(ctx), "gramarye") * 816.82)))
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_sun_glasses", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    H.eoc_spawn_item(H.u(ctx), "changeling_summer_sunglasses", 1, false, true, nil)
    services.messages.add(ctx:expand_text(services.translate("The intensity of nearby light grows muted.")), "neutral")
    return true
    end
    EOC["EOC_CHANGELING_SUMMER_PROTECT_FROM_HOT_WEATHER"] = function(ctx)
    H.set_var("context", nil, ctx, "spell_low_duration", ((766.28 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 144.96)) + (H.char_skill(H.npc(ctx), "gramarye") * 295.21)))
    H.set_var("context", nil, ctx, "spell_high_duration", ((1694.85 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 455.08)) + (H.char_skill(H.npc(ctx), "gramarye") * 1168.05)))
    H.set_var("actor", H.u(ctx), ctx, "summer_spell_count", H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER"))
    H.set_var("actor", H.u(ctx), ctx, "gramarye_for_spells", H.char_skill(H.npc(ctx), "gramarye"))
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_protect_from_hot_weather", services.random.native_float((ctx:get_number("spell_low_duration") or 0), (ctx:get_number("spell_high_duration") or 0)), nil, nil, nil)
    return true
    end
    COND["EOC_CHANGELING_SUMMER_SUN_GLASSES_REMOVER"] = function(ctx)
        return (((("effect_changeling_summer_sun_glasses") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_SUN_GLASSES_REMOVER"] = function(ctx)
    if (((("effect_changeling_summer_sun_glasses") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        do local g = H.safe_id('item', "changeling_summer_sunglasses"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_SUMMER_RUN_FOR_LONG_PERIODS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_run_for_long_periods", 2, nil, nil, nil)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_NO_CASTING_OTHER_GLAMOURS_CHECKER"), nil) end end
    return true
    end
    COND["EOC_CHANGELING_SUMMER_ABSORB_STRENGTH_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_absorb_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_ABSORB_STRENGTH_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_absorb_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        if ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true)))))) then
            H.set_var("actor", H.u(ctx), ctx, "changeling_gramarye_tracker", H.char_skill(H.npc(ctx), "gramarye"))
            H.set_var("actor", H.u(ctx), ctx, "changeling_summer_glamour_tracker", H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER"))
            H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((80.64 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 13.51)) + (H.char_skill(H.npc(ctx), "gramarye") * 45.08)))
            H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((140.85 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 30.12)) + (H.char_skill(H.npc(ctx), "gramarye") * 99.81)))
            H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_absorb_strength", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
            H.eoc_add_effect(H.npc(ctx), "effect_changeling_summer_absorb_strength_self", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
        else
            services.messages.add(ctx:expand_text(services.translate("You touch the machine but nothing happens.  What strength it possesses is not amenable to removal.")), "bad")
        end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_RUN_FOR_LONG_PERIODS_CONTINUANCE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_changeling_summer_run_for_long_periods"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RUN_FOR_LONG_PERIODS_CONTINUANCE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_changeling_summer_run_for_long_periods"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) then
        if (H.char_effect_dur(H.u(ctx), "effect_changeling_summer_run_for_long_periods", "") < 2) then
            H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_run_for_long_periods", 2, nil, nil, nil)
        else
            H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_run_for_long_periods", 1, nil, nil, nil)
        end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_changeling_summer_run_for_long_periods"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_CHANGELING_SUMMER_CREATE_THUNDERSTORM_INITIATE"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15)))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_CREATE_THUNDERSTORM_INITIATE"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15)))) then
        if (H.var_num(H.u(ctx), "weather_change_limit") == 6) then
            services.messages.add(ctx:expand_text(services.translate("You have already enchanted the weather.  Now you must wait until it runs its course.")), "mixed")
        else
            do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 6)
            H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_lower_bound", (60 / H._jm_selkie_has_weather_mastery(ctx)))
            H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_upper_bound", (180 / H._jm_selkie_has_weather_mastery(ctx)))
            H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_lightningstorm", 21600, nil, nil, nil)
            H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((428.1 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 112.9)) + (H.char_skill(H.u(ctx), "gramarye") * 205.76)) * H._jm_selkie_has_weather_mastery(ctx)))
            H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((897.5 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 249.16)) + (H.char_skill(H.u(ctx), "gramarye") * 491.07)) * H._jm_selkie_has_weather_mastery(ctx)))
            H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_INITIATE"), nil) end end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outside and the temperature must be above freezing to summon a thunderstorm.")), "bad")
        return false
    end
    end
    COND["EOC_CHANGELING_SUMMER_CREATE_THUNDERSTORM_END"] = function(ctx)
        return ((H.global_var_num("magic_weather_lightning") == 1)) == true
    end
    EOC["EOC_CHANGELING_SUMMER_CREATE_THUNDERSTORM_END"] = function(ctx)
    if ((H.global_var_num("magic_weather_lightning") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_GAIN_STAY_AWAKE_IN_SUNLIGHT_EFFECT"] = function(ctx)
        return (((("effect_changeling_summer_stay_awake_in_sunlight") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_GAIN_STAY_AWAKE_IN_SUNLIGHT_EFFECT"] = function(ctx)
    if (((("effect_changeling_summer_stay_awake_in_sunlight") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.set_char_val_extra(H.u(ctx), "sleep_deprivation", ((H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * (-20)) + (H.char_skill(H.u(ctx), "gramarye") * (-45))), "+=")
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.npc(ctx), "effect_changeling_summer_ring_of_flames_limiter", 1, nil, nil, nil)
        H.eoc_add_effect(H.npc(ctx), "effect_changeling_summer_ring_of_flames", 11, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_ring_of_flames_enemy", 600, nil, nil, nil)
        if (H.global_var_num("global_what_is_the_season") == 2) then
            if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true)) then
                do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "changeling_summer_ring_of_flames_actual_flames_summer_spell", (cs and cs.kind == 'monster'), { hit_self = true }) end end
                do local _p, _g = (H.creature_snap(H.npc(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(5), _g, nil) end end
            end
        else
            if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true)) then
                do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "changeling_summer_ring_of_flames_actual_flames_non_summer_spell", (cs and cs.kind == 'monster'), { hit_self = true }) end end
                do local _p, _g = (H.creature_snap(H.npc(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(5), _g, nil) end end
            end
        end
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true)) then
            services.messages.add(ctx:expand_text(services.translate("A ring of flames springs up around you!")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You must be outside to call up the ring of champions.")), "bad")
        end
        do local _t = math.max(1, math.floor(10)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CONTINUOUS"), nil) end end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.npc(ctx) and _eg then services.effects.remove(H.npc(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames_enemy"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _p, _g = (H.creature_snap(H.npc(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(12), _g, nil) end end
        return false
    end
    end
    COND["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CONTINUOUS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CONTINUOUS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "changeling_near_fire", nil, nil, { kind = "field", id = H.safe_id("field", "fd_fire") }, { target_max_radius = math.floor(5) }, nil, false, true, {  }, {  })
        if ((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_near_fire"); local fg = H.safe_id('field', "fd_fire"); return p ~= nil and fg ~= nil and services.gameplay.environment.field_exists(p, fg, true) end)()) then
            H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_ring_of_flames", 11, nil, nil, nil)
        else
            do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(10), _g, nil) end end
        end
        do local _t = math.max(1, math.floor(10)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CONTINUOUS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CHECK_MOVEMENT"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_CHECK_MOVEMENT"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) then
        do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_NPC"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_NPC"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames_enemy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())) then
            do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(12), _g, nil) end end
            do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("As your enemy collapses, the ring of flames gutters and dies.")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_MONSTER"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_CHANGELING_SUMMER_RING_OF_FLAMES_KILL_TARGET_MONSTER"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if (((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames_enemy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())) then
            do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_summer_remove_ring_fire"); if _p and _g then services.world.transform_radius(_p, math.floor(12), _g, nil) end end
            do local _eg = H.safe_id('effect', "effect_changeling_summer_ring_of_flames"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("As your enemy collapses, the ring of flames gutters and dies.")), "mixed")
        end
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_SUMMER_POWERFUL_SUNLIGHT_INITIATE"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((5.95 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 1.52)) + (H.char_skill(H.u(ctx), "gramarye") * 2.51)))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((15.2 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 3.82)) + (H.char_skill(H.u(ctx), "gramarye") * 6.01)))
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_powerful_sunlight", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    services.messages.add(ctx:expand_text(services.translate("You blaze with brilliant light.")), "good")
    H.eoc_cast_spell(H.u(ctx), "changeling_summer_powerful_sunlight_spell_aura_effects", false, nil)
    return true
    end
    EOC["EOC_CHANGELING_SUMMER_POWERFUL_SUNLIGHT_AURA_EFFECTS"] = function(ctx)
    if (not (((function() local eg = H.safe_id('effect', "blind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        H.eoc_add_effect(H.u(ctx), "blind", 60, nil, nil, nil)
    end
    if H.char_has_flag(H.u(ctx), "SUNDEATH") then
        H.set_char_val_extra(H.u(ctx), "morale", 200, "-=")
        H.eoc_cast_spell(H.u(ctx), "changeling_summer_powerful_sunlight_spell_sundeath_self_damage", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("The <u_name> is seared by the brilliant light!")), "neutral")
    end
    return true
    end
    EOC["EOC_CHANGELING_SUMMER_COMBAT_PROWESS_POWERFUL_BUFF_INITIATE"] = function(ctx)
    H.set_var("context", nil, ctx, "spell_low_duration", ((38.45 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 6.05)) + (H.char_skill(H.u(ctx), "gramarye") * 12.85)))
    H.set_var("context", nil, ctx, "spell_high_duration", ((153.15 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SUMMER") * 14.05)) + (H.char_skill(H.u(ctx), "gramarye") * 23.54)))
    H.set_var("context", nil, ctx, "buff_duration", services.random.native_float((ctx:get_number("spell_low_duration") or 0), (ctx:get_number("spell_high_duration") or 0)))
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_combat_prowess_powerful_buff", (ctx:get_number("buff_duration") or 0), nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_summer_combat_prowess_powerful_buff", (ctx:get_number("buff_duration") or 0), nil, nil, nil)
    H.eoc_spawn_item(H.u(ctx), "integrated_riastrad_item", 1, false, true, nil)
    do local _t = math.max(1, math.floor((ctx:get_number("buff_duration") or 0))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_SUMMER_COMBAT_PROWESS_POWERFUL_BUFF_END"), nil) end end
    return true
    end
    EOC["EOC_CHANGELING_SUMMER_COMBAT_PROWESS_POWERFUL_BUFF_END"] = function(ctx)
    do local g = H.safe_id('item', "integrated_riastrad_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(((((500 * H.global_var_num("global_what_is_the_season")) == 4)) and (2) or (1)) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = ((((500 * H.global_var_num("global_what_is_the_season")) == 4)) and (2) or (1)); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(((((500 * H.global_var_num("global_what_is_the_season")) == 4)) and (2) or (1)) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = ((((500 * H.global_var_num("global_what_is_the_season")) == 4)) and (2) or (1)); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
    return true
    end
    EOC["EOC_CHANGELING_WINTER_FREEZE_TARGET_IN_PLACE"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((2.51 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 2.45)) + (H.char_skill(H.npc(ctx), "gramarye") * 3.5)))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((6.52 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 5.55)) + (H.char_skill(H.npc(ctx), "gramarye") * 7.91)))
    if ((H.u(ctx) ~= nil) or (H.creature_volume(H.u(ctx)) >= (60 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 5000)))) then
        if (services.time_snapshot().season_id == string.lower("winter")) then
            if (services.time_snapshot().season_id == string.lower("summer")) then
                do local _eg = H.safe_id('effect', "effect_changeling_winter_freeze_target_in_place_during_winter"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_freeze_target_in_place_during_winter", services.random.native_float(((((H.var_num(H.u(ctx), "spell_low_duration") * H.global_var_num("global_what_is_the_season")) == 2)) and (0.6) or (1)), ((((H.var_num(H.u(ctx), "spell_high_duration") * H.global_var_num("global_what_is_the_season")) == 2)) and (0.4) or (1))), nil, nil, nil)
            else
                do local _eg = H.safe_id('effect', "effect_changeling_winter_freeze_target_in_place_during_winter"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_freeze_target_in_place_during_winter", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
            end
        else
            if (services.time_snapshot().season_id == string.lower("summer")) then
                do local _eg = H.safe_id('effect', "effect_changeling_winter_freeze_target_in_place_not_winter"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_freeze_target_in_place_not_winter", services.random.native_float(((((H.var_num(H.u(ctx), "spell_low_duration") * H.global_var_num("global_what_is_the_season")) == 2)) and (0.6) or (1)), ((((H.var_num(H.u(ctx), "spell_high_duration") * H.global_var_num("global_what_is_the_season")) == 2)) and (0.4) or (1))), nil, nil, nil)
            else
                do local _eg = H.safe_id('effect', "effect_changeling_winter_freeze_target_in_place_not_winter"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_freeze_target_in_place_not_winter", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
            end
        end
    else
        services.messages.add(ctx:expand_text(services.translate("The target easily shatters the ice!")), "bad")
    end
    return true
    end
    EOC["EOC_CHANGELING_WINTER_FEIGN_DEATH"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_feign_death", -1, nil, nil, nil)
    if (not (((function() local eg = H.safe_id('effect', "effect_changeling_winter_feign_death_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        services.messages.add(ctx:expand_text(services.translate("You collapse to the ground as your chest ceases its movements.")), "neutral")
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_NO_CASTING_OTHER_GLAMOURS_CHECKER"), nil) end end
    else
        services.messages.add(ctx:expand_text(services.translate("You collapse to the ground, but nothing seems fooled!")), "bad")
        do local _eg = H.safe_id('effect', "effect_changeling_using_glamour_removes_checker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    end
    return true
    end
    COND["EOC_CHANGELING_WINTER_FEIGN_DEATH_LIMITER_ON_LOSS"] = function(ctx)
        return (((("effect_changeling_winter_feign_death") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_CHANGELING_WINTER_FEIGN_DEATH_LIMITER_ON_LOSS"] = function(ctx)
    if (((("effect_changeling_winter_feign_death") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_feign_death_limiter", 60, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_changeling_using_glamour_removes_checker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_WINTER_FEIGN_DEATH_LOST_ON_ACTIVITY"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_changeling_winter_feign_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_CHANGELING_WINTER_FEIGN_DEATH_LOST_ON_ACTIVITY"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_changeling_winter_feign_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        do local _eg = H.safe_id('effect', "effect_changeling_winter_feign_death."); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_WINTER_STOP_BLEEDING"] = function(ctx)
    do
        local _arr = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            if (H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")) >= 1) then
                H.set_var("context", nil, ctx, "bleed_intensity", H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")))
                do local _g, _a = H.safe_id('damage_type', "cold"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(1, ((ctx:get_number("bleed_intensity") or 0) / 10)), { body_part = H.safe_id('body_part', H.var_str("context", nil, ctx, "id", "")) }) end end
                do local _eg = H.safe_id('effect', "bleed"); local _bp = (H.var_str("context", nil, ctx, "id", "") ~= nil) and H.safe_id('body_part', H.var_str("context", nil, ctx, "id", "")) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            end
        end
    end
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((18.12 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 5.82)) + (H.char_skill(H.u(ctx), "gramarye") * 15.46)) * (((H.global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1))))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((35.21 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 13.46)) + (H.char_skill(H.u(ctx), "gramarye") * 36.46)) * (((H.global_var_num("global_what_is_the_season") == 2)) and (0.4) or (1))))
    H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_stop_bleeding", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    return true
    end
    EOC["EOC_CHANGELING_WINTER_NEUTRALIZE_MORALE"] = function(ctx)
    H.run_eoc("EOC_FULL_MORALE_NEUTRALIZATION", ctx, nil, nil, nil)
    if (not ((services.time_snapshot().season_id == string.lower("summer")))) then
        H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((29.12 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 15.82)) + (H.char_skill(H.u(ctx), "gramarye") * 31.84)))
        H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((69.52 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 41.85)) + (H.char_skill(H.u(ctx), "gramarye") * 90.52)))
        H.eoc_add_effect(H.u(ctx), "effect_changeling_winter_neutralize_morale", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_WINTER_NEUTRALIZE_MORALE_CONTINUANCE"), nil) end end
    end
    return true
    end
    COND["EOC_CHANGELING_WINTER_NEUTRALIZE_MORALE_CONTINUANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_changeling_winter_neutralize_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CHANGELING_WINTER_NEUTRALIZE_MORALE_CONTINUANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_changeling_winter_neutralize_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_FULL_MORALE_NEUTRALIZATION", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_WINTER_NEUTRALIZE_MORALE_CONTINUANCE"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_WINTER_HAIL_ATTACK"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select target.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "changeling_winter_hail_attack_location") and 1 or 0)) then
        if ((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_winter_hail_attack_location"); return p ~= nil and services.gameplay.environment.is_outside(p) == true end)()) then
            H.eoc_cast_spell(H.u(ctx), "changeling_winter_hail_attack_spell_bash_damage", false, { target = H.get_tripoint_var("context", nil, ctx, "changeling_winter_hail_attack_location") })
            H.eoc_cast_spell(H.u(ctx), "changeling_winter_hail_attack_spell_cold_damage", false, { target = H.get_tripoint_var("context", nil, ctx, "changeling_winter_hail_attack_location") })
            if (not ((services.time_snapshot().season_id == string.lower("summer")))) then
                H.eoc_cast_spell(H.u(ctx), "changeling_winter_hail_attack_spell_ice_fields", false, { target = H.get_tripoint_var("context", nil, ctx, "changeling_winter_hail_attack_location") })
            end
            services.messages.add(ctx:expand_text(services.translate("Ice and hail fall from the sky!")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("The Tears of the Cailleach must fall outdoors.")), "bad")
        end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_CHANGELING_WINTER_PURE_AREA_DARKNESS"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("All light dies away.")), "neutral")
    services.weather.override_light(math.floor(0), services.time.duration_from_turns(math.floor((function() local a, b = math.floor((((39.85 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 16.78)) + (H.char_skill(H.u(ctx), "gramarye") * 49.85)) * (((H.global_var_num("global_what_is_the_season") == 2)) and (0.3) or (1)))), math.floor((((133.47 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_WINTER") * 68.15)) + (H.char_skill(H.u(ctx), "gramarye") * 120.85)) * (((H.global_var_num("global_what_is_the_season") == 2)) and (0.2) or (1)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())), "")
    return true
    end
    EOC["EOC_BOANN_RETALIATION_NON_PLAYER"] = function(ctx)
    H.run_eoc("EOC_BOANN_RETALIATION_NON_PLAYER_REAL", ctx, nil, "u", services.characters.avatar())
    return true
    end
    COND["EOC_BOANN_RETALIATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "hit_by_player"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BOANN_RETALIATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "hit_by_player"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_BOANN_RETALIATION_REAL", ctx, nil, "u", services.characters.avatar())
        return true
    else
        H.run_eoc("EOC_BOANN_RETALIATION_NON_PLAYER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BOANN_RETALIATION_REAL"] = function(ctx)
        return (((H.u(ctx) ~= nil and services.characters.is_alive(H.u(ctx)).value == true) and ((H.char_snap(H.npc(ctx)) or {}).avatar == true))) == true
    end
    EOC["EOC_BOANN_RETALIATION_REAL"] = function(ctx)
    if (((H.u(ctx) ~= nil and services.characters.is_alive(H.u(ctx)).value == true) and ((H.char_snap(H.npc(ctx)) or {}).avatar == true))) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "Boann_teleport", { terrain = "forest", match = "CONTAINS" }, { z = math.floor(0), search_range = math.floor(1200), min_distance = math.floor(250), random = true }, nil, nil, nil, false, true, {  }, {  })
        ccb.presentation.notice(ctx:expand_text(services.translate("Boann waves her hands as you strike her, and you are enveloped by a swirl of multicolored lights.")))
        H.eoc_cast_spell(H.u(ctx), "boann_heal", false, nil)
        do local _eg = H.safe_id('effect', "hit_by_player"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_goblin_fruit_nobleed", 2, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "panacea", 2, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "cureall", 2, nil, nil, nil)
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_wild_huntsman") or H.safe_id('monster_group', "mon_wild_huntsman"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((4 + services.random.native_int(0, H.round_half_away(2)))), min_radius = math.floor(2), max_radius = math.floor(7) }); 
        end end
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_wild_hunt_hound") or H.safe_id('monster_group', "mon_wild_hunt_hound"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((8 + services.random.native_int(0, H.round_half_away(4)))), min_radius = math.floor(4), max_radius = math.floor(10) }); 
        end end
        do local _t, _p = H.npc(ctx), H.get_tripoint_var("context", nil, ctx, "Boann_teleport"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, { force = true }) else services.relocation.teleport_item(_t, _p) end end end
        return true
    end
    return false
    end
    COND["EOC_BOANN_RETALIATION_NON_PLAYER_REAL"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.characters.is_alive(H.u(ctx)).value == true)) == true
    end
    EOC["EOC_BOANN_RETALIATION_NON_PLAYER_REAL"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.characters.is_alive(H.u(ctx)).value == true)) then
        H.eoc_cast_spell(H.u(ctx), "boann_banish_monsters_check", false, nil)
        H.eoc_cast_spell(H.u(ctx), "boann_heal", false, nil)
        H.eoc_add_effect(H.u(ctx), "effect_goblin_fruit_nobleed", 2, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "panacea", 2, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "cureall", 2, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Boann waves her hands as her opponent strikes her, and they vanish in a swirl of multicolored lights.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_BOANN_RETALIATION_NON_PLAYER_TARGETING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "boann_retaliation_mark"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BOANN_RETALIATION_NON_PLAYER_TARGETING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "boann_retaliation_mark"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_cast_spell(H.u(ctx), "boann_banish_monsters", false, nil)
        return true
    end
    return false
    end
    COND["EOC_XE_GETTING_HIT_WHILE_USING_ETHEREAL_WINGS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1)) == true
    end
    EOC["EOC_XE_GETTING_HIT_WHILE_USING_ETHEREAL_WINGS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1)) then
        if (not (services.random.native_probability((math.min(H.char_spell_level(H.u(ctx), "spell_ethereal_wings"), 40)), (50)))) then
            H.lose_trait(H.u(ctx), "ethereal_wings")
            services.messages.add(ctx:expand_text(services.translate("The wings behind you fade out of existence!")), "bad")
        else
            services.messages.add(ctx:expand_text(services.translate("Your ethereal wings flicker out of existence for just a moment.")), "mixed")
        end
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_MAGIC_REMOVE_MOVEMENT_EFFECTS"] = function(ctx)
    H.lose_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE")
    do local _eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_HEDGE_MAGIC_REMOVE_ATTACK_EFFECTS"] = function(ctx)
    do local g = H.safe_id('item', "hedge_witchlight"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.lose_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE")
    do local _eg = H.safe_id('effect', "effect_invisibility_magic_square"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_HEDGE_MAGIC_MOVEMENT_CANCEL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_HEDGE_MAGIC_MOVEMENT_CANCEL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or ((function() local eg = H.safe_id('effect', "effect_hedge_no_nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        H.run_eoc("EOC_HEDGE_MAGIC_REMOVE_MOVEMENT_EFFECTS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or H.char_has_item(H.u(ctx), "hedge_witchlight") or ((function() local eg = H.safe_id('effect', "effect_invisibility_magic_square"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or H.char_has_item(H.u(ctx), "hedge_witchlight") or ((function() local eg = H.safe_id('effect', "effect_invisibility_magic_square"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or H.char_has_item(H.u(ctx), "hedge_witchlight") or ((function() local eg = H.safe_id('effect', "effect_invisibility_magic_square"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HEDGE_FOREST_BUSH_SHAPE") == 1) or H.char_has_item(H.u(ctx), "hedge_witchlight") or ((function() local eg = H.safe_id('effect', "effect_invisibility_magic_square"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_MELEE_MONSTER_CANCEL"] = function(ctx)
        return (H.test_eoc("EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS", ctx)) == true
    end
    EOC["EOC_HEDGE_MAGIC_MELEE_MONSTER_CANCEL"] = function(ctx)
    if (H.test_eoc("EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS", ctx)) then
        H.run_eoc("EOC_HEDGE_MAGIC_REMOVE_ATTACK_EFFECTS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_MELEE_CHARACTER_CANCEL"] = function(ctx)
        return (H.test_eoc("EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS", ctx)) == true
    end
    EOC["EOC_HEDGE_MAGIC_MELEE_CHARACTER_CANCEL"] = function(ctx)
    if (H.test_eoc("EOC_HEDGE_MAGIC_MELEE_EOC_CONDITIONS", ctx)) then
        H.run_eoc("EOC_HEDGE_MAGIC_REMOVE_ATTACK_EFFECTS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_RANGED_MONSTER_CANCEL"] = function(ctx)
        return (H.test_eoc("EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS", ctx)) == true
    end
    EOC["EOC_HEDGE_MAGIC_RANGED_MONSTER_CANCEL"] = function(ctx)
    if (H.test_eoc("EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS", ctx)) then
        H.run_eoc("EOC_HEDGE_MAGIC_REMOVE_ATTACK_EFFECTS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HEDGE_MAGIC_RANGED_CHARACTER_CANCEL"] = function(ctx)
        return (H.test_eoc("EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS", ctx)) == true
    end
    EOC["EOC_HEDGE_MAGIC_RANGED_CHARACTER_CANCEL"] = function(ctx)
    if (H.test_eoc("EOC_HEDGE_MAGIC_RANGED_EOC_CONDITIONS", ctx)) then
        H.run_eoc("EOC_HEDGE_MAGIC_REMOVE_ATTACK_EFFECTS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_HEDGE_MAGIC_LOSE_EFFECTS_ON_SLEEP"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_hedge_protect_the_mind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS_ACTUAL"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The witchlight vanishes without a sound.")), "neutral")
    do local g = H.safe_id('item', "item_hedge_witchlight"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    EOC["EOC_HEDGE_LIGHT_FIRE_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "firestarter", { target = _p }) end end
    return true
    end
    EOC["EOC_HEDGE_LIGHT_FIRE"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "hedge_fire_starter", 1, false, false, nil)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "hedge_fire_starter" } }, { "EOC_HEDGE_LIGHT_FIRE_ACTIVATE" }, {  })
    do local g = H.safe_id('item', "hedge_fire_starter"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    COND["EOC_HEDGE_MAKE_PLANTS_GROW_2"] = function(ctx)
        return (((((services.turn() % 86400) / 3600) > 11) and (((services.turn() % 86400) / 3600) < 13))) == true
    end
    EOC["EOC_HEDGE_MAKE_PLANTS_GROW_2"] = function(ctx)
    if (((((services.turn() % 86400) / 3600) > 11) and (((services.turn() % 86400) / 3600) < 13))) then
        H.eoc_cast_spell(H.u(ctx), "hedge_make_plants_grow_real", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must complete the charm within one hour of noon for it to be effective.")), "bad")
        return false
    end
    end
    EOC["EOC_HEDGE_MAKE_PLANTS_GROW"] = function(ctx)
    H.run_eoc("EOC_HEDGE_MAKE_PLANTS_GROW_2", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_HEDGE_STUNNING_SPELL"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_HEDGE_STUNNING_SPELL"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_cast_spell(H.u(ctx), "hedge_stunning_spell_real", false, { targeted = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outside to use the charm.")), "bad")
        return false
    end
    end
    EOC["EOC_HEDGE_CLAIRVOYANCE_CONE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "bleed", 300, "head", 1, nil)
    H.set_char_hp(H.u(ctx), "head", 1, "-=")
    H.eoc_cast_spell(H.u(ctx), "hedge_clairvoyance_cone_real", false, { targeted = true })
    return true
    end
    COND["EOC_HEDGE_ACTIVITY_TYPE_BREAKS_INCREASE_HEALING_RATE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PULP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_TREE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_HARD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_ACTIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_MODERATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_BUTCHER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUTCHER") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_HEDGE_ACTIVITY_TYPE_BREAKS_INCREASE_HEALING_RATE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PULP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_TREE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_HARD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_ACTIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WORKOUT_MODERATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_BUTCHER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUTCHER") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        do local _eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_val_extra(H.u(ctx), "activity_level") >= 3))) == true
    end
    EOC["EOC_HEDGE_ACTIVITY_LEVEL_BREAKS_INCREASE_HEALING_RATE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_val_extra(H.u(ctx), "activity_level") >= 3))) then
        do local _eg = H.safe_id('effect', "effect_hedge_increase_healing_rate"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_HEDGE_HIDE_IN_FOREST"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest")))) == true
    end
    EOC["EOC_HEDGE_HIDE_IN_FOREST"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest")))) then
        do local _g = H.safe_id('mutation', "HEDGE_FOREST_BUSH_SHAPE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without being in a forest, the charm has no effect.")), "neutral")
        return false
    end
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_SPAWN_ITEM"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "item_hedge_turn_into_bear", 1, false, false, nil)
    return true
    end
    EOC["EOC_HEDGE_TURN_INTO_BEAR_WEAR_ITEM_INTANGIBLE"] = function(ctx)
    do local _g = H.safe_id('json_flag', "SEMITANGIBLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
end
