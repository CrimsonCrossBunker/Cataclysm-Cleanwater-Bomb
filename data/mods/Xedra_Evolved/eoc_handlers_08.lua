local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_SELKIE_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") == 1)) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") == 1)) then
        services.messages.add(ctx:expand_text(services.translate("The thick fog begins to disperse.")), "neutral")
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        return true
    end
    return false
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINS"] = function(ctx)
        return ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINS"] = function(ctx)
    if ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) then
        H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINS_NOT_WINTER", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The weather is too cold for you to control it.")), "bad")
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 3)
        H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_lower_bound", 60)
        H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_upper_bound", 180)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_rains", 21600, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", services.random.native_float(((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 17.15) + (H.char_skill(H.u(ctx), "gramarye") * 60.43)) + 355.43) * H._jm_selkie_has_weather_mastery(ctx)), ((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 42.26) + (((H.char_skill(H.u(ctx), "gramarye") * 179.81) + 1233.79) * H._jm_selkie_has_weather_mastery(ctx)))), nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_INITIATE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINS_NOT_WINTER"] = function(ctx)
        return (((H.var_num(H.u(ctx), "weather_change_limit") <= 2) and (not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_rains"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINS_NOT_WINTER"] = function(ctx)
    if (((H.var_num(H.u(ctx), "weather_change_limit") <= 2) and (not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_rains"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINS_INITIATE", ctx, nil, nil, nil)
        return true
    else
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather_rains"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
            do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        else
            H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINS_INITIATE", ctx, nil, nil, nil)
        end
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM"] = function(ctx)
        return ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM"] = function(ctx)
    if ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) then
        H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_NOT_WINTER", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The weather is too cold for you to control it.")), "bad")
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 4)
        H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_lower_bound", 60)
        H.set_var("actor", H.u(ctx), ctx, "weather_stage_up_upper_bound", 180)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_rainstorm", 21600, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", services.random.native_float(((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 17.15) + (H.char_skill(H.u(ctx), "gramarye") * 60.43)) + 355.43) * H._jm_selkie_has_weather_mastery(ctx)), ((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 42.26) + (((H.char_skill(H.u(ctx), "gramarye") * 179.81) + 1233.79) * H._jm_selkie_has_weather_mastery(ctx)))), nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_INITIATE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_NOT_WINTER"] = function(ctx)
        return (((H.var_num(H.u(ctx), "weather_change_limit") <= 3) and (not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_rainstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_NOT_WINTER"] = function(ctx)
    if (((H.var_num(H.u(ctx), "weather_change_limit") <= 3) and (not (((function() local eg = H.safe_id('effect', "effect_controlling_weather_rainstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_INITIATE", ctx, nil, nil, nil)
        return true
    else
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather_rainstorm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
            do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        else
            H.run_eoc("EOC_SELKIE_CHANGE_WEATHER_RAINSTORM_INITIATE", ctx, nil, nil, nil)
        end
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "rainstorm"))) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "rainstorm"))) then
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 6)
        H.set_var("global", nil, ctx, "magic_weather_rainstorm", 0)
        H.set_var("global", nil, ctx, "magic_weather_lightning", 1)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_lightningstorm", 21600, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather", 1800, nil, nil, nil)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("The sky explodes in a frenzy of lightning!")), "mixed")
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM_END"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You need a heavy rainstorm to agitate it into lightning.")), "bad")
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM_END"] = function(ctx)
        return ((H.global_var_num("magic_weather_lightning") == 1)) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM_END"] = function(ctx)
    if ((H.global_var_num("magic_weather_lightning") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_controlling_weather_lightningstorm"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TROW_START_MINING"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TROW_WHILE_MINING_NO_EATING_OR_SLEEP") == 1) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_TROW_START_MINING"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TROW_WHILE_MINING_NO_EATING_OR_SLEEP") == 1) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        H.set_var("actor", H.u(ctx), ctx, "calories_pre_mining", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0))
        H.eoc_add_effect(H.u(ctx), "effect_trow_no_eating_or_sleep", -1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TROW_WHILE_MINING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_trow_no_eating_or_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TROW_WHILE_MINING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_trow_no_eating_or_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "calories_pre_mining") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "calories_pre_mining"); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    end
    return false
    end
    COND["EOC_TROW_END_MINING"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TROW_WHILE_MINING_NO_EATING_OR_SLEEP") == 1) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_TROW_END_MINING"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TROW_WHILE_MINING_NO_EATING_OR_SLEEP") == 1) and (((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        do local _eg = H.safe_id('effect', "effect_trow_no_eating_or_sleep"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_SELKIE_GOBLIN_FRUIT"] = function(ctx)
        return ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_light_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_rain") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_lightning"))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pond_field", math.floor(1)) end)()) or H.char_at_om_location(H.u(ctx), "fishing_pond_0_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_0_1") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_1") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SE"))) == true
    end
    EOC["EOC_SELKIE_GOBLIN_FRUIT"] = function(ctx)
    if ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_light_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_drizzle") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_rain") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_rainstorm") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "weather_lightning"))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pond_field", math.floor(1)) end)()) or H.char_at_om_location(H.u(ctx), "fishing_pond_0_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_0_1") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_1") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SE"))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_selkie", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be near water or under the rain to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_BROWNIE_GOBLIN_FRUIT"] = function(ctx)
        return (((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (H.mons_nearby(H.u(ctx), {  }, 8, nil) == 0) and (H.chars_nearby(H.u(ctx), 8, "any") == 0))) == true
    end
    EOC["EOC_BROWNIE_GOBLIN_FRUIT"] = function(ctx)
    if (((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (H.mons_nearby(H.u(ctx), {  }, 8, nil) == 0) and (H.chars_nearby(H.u(ctx), 8, "any") == 0))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_brownie", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be inside and unobserved to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_POOKA_GOBLIN_FRUIT"] = function(ctx)
        return (((H.species_nearby(H.u(ctx), { "MAMMAL" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "AMPHIBIAN" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "BIRD" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "REPTILE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "FISH" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "KRAKEN" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "INSECT" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "CENTIPEDE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "INSECT_FLYING" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SPIDER" }, 30, nil) >= 1))) == true
    end
    EOC["EOC_POOKA_GOBLIN_FRUIT"] = function(ctx)
    if (((H.species_nearby(H.u(ctx), { "MAMMAL" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "AMPHIBIAN" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "BIRD" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "REPTILE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "FISH" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "KRAKEN" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "INSECT" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "CENTIPEDE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "INSECT_FLYING" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SPIDER" }, 30, nil) >= 1))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_pooka", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be near an animal to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_TROW_GOBLIN_FRUIT"] = function(ctx)
        return (((not ((not services.gameplay.environment.is_night()))) or (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) == true
    end
    EOC["EOC_TROW_GOBLIN_FRUIT"] = function(ctx)
    if (((not ((not services.gameplay.environment.is_night()))) or (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_trow", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be under the ground or at night to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_NOBLE_GOBLIN_FRUIT"] = function(ctx)
        return (((H.species_nearby(H.u(ctx), { "CHANGELING" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "ARVORE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "IERDE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "HOMULLUS" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SALAMANDER" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SYLPH" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "UNDINE" }, 30, nil) >= 1) or (H.chars_nearby(H.u(ctx), 30, "any") >= 1))) == true
    end
    EOC["EOC_NOBLE_GOBLIN_FRUIT"] = function(ctx)
    if (((H.species_nearby(H.u(ctx), { "CHANGELING" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "ARVORE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "IERDE" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "HOMULLUS" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SALAMANDER" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "SYLPH" }, 30, nil) >= 1) or (H.species_nearby(H.u(ctx), { "UNDINE" }, 30, nil) >= 1) or (H.chars_nearby(H.u(ctx), 30, "any") >= 1))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_noble", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be near humans or Fae to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_WAR_FORM_BANNED_ACTIVITY_PHYSICAL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_WAR_FORM_BANNED_ACTIVITY_PHYSICAL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        services.messages.add(ctx:expand_text(services.translate("Your war form lacks the fine dexterity for that.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_WAR_FORM_BANNED_ACTIVITY_MENTAL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1) and (((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SOCIALIZE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VIBE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_WAR_FORM_BANNED_ACTIVITY_MENTAL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1) and (((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SOCIALIZE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VIBE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        services.messages.add(ctx:expand_text(services.translate("Your mind is filled with the urge to sink your fangs into your enemies' throats, leaving no room for these passive activities.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_WAR_FORM_SHIFT_BACK_ON_SLEEP"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1)) == true
    end
    EOC["EOC_WAR_FORM_SHIFT_BACK_ON_SLEEP"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "WEREWOLF_HYBRID_FORM_TRAITS") == 1)) then
        do local _g = H.safe_id('mutation', "WEREWOLF_HYBRID_FORM"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, false) end end
        return true
    end
    return false
    end
    COND["EOC_SET_VAMPIRE_TRAIT_NUMBERS_FOR_NPC_USE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) or (H.char_has_trait(H.u(ctx), "VAMPIRE2") == 1) or (H.char_has_trait(H.u(ctx), "VAMPIRE3") == 1))) == true
    end
    EOC["EOC_SET_VAMPIRE_TRAIT_NUMBERS_FOR_NPC_USE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) or (H.char_has_trait(H.u(ctx), "VAMPIRE2") == 1) or (H.char_has_trait(H.u(ctx), "VAMPIRE3") == 1))) then
        H.set_var("actor", H.u(ctx), ctx, "vampire_total_tier_one_traits", H._jm_vampire_total_tier_one_traits_plus_potency(ctx))
        H.set_var("actor", H.u(ctx), ctx, "vampire_total_tier_two_traits", H._jm_vampire_total_tier_two_traits(ctx))
        H.set_var("actor", H.u(ctx), ctx, "vampire_total_tier_three_traits", H._jm_vampire_total_tier_three_traits(ctx))
        H.set_var("actor", H.u(ctx), ctx, "vampire_total_tier_four_traits", H._jm_vampire_total_tier_four_traits_plus_potence(ctx))
        H.set_var("actor", H.u(ctx), ctx, "vampire_total_tier_five_traits", H._jm_vampire_total_tier_five_traits_plus_cauldron(ctx))
        return true
    end
    return false
    end
    COND["EOC_VAMPIRIC_RESILIENCE_FLESH_OF_MARBLE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vampire_resilience_flesh_of_marble"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VAMPIRIC_RESILIENCE_FLESH_OF_MARBLE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vampire_resilience_flesh_of_marble"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_vampire_resilience_flesh_of_marble"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_SCENT_BLOOD_activated"] = function(ctx)
        return (((H.chars_nearby(H.u(ctx), 30, "any") + H.species_nearby(H.u(ctx), { "FERAL", "RENFIELD" }, 30, nil)) >= 1)) == true
    end
    EOC["EOC_VAMPIRE_SCENT_BLOOD_activated"] = function(ctx)
    if (((H.chars_nearby(H.u(ctx), 30, "any") + H.species_nearby(H.u(ctx), { "FERAL", "RENFIELD" }, 30, nil)) >= 1)) then
        services.messages.add(ctx:expand_text(services.translate("The scent of fresh blood fills your nostrils.  There is a human nearby.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You do not smell any nearby human blood.")), "neutral")
        return false
    end
    end
    EOC["EOC_COMMUNE_NIGHT_MAP"] = function(ctx)
    if ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_cast_spell(H.u(ctx), "vampire_map_real", false, nil)
        services.messages.add(ctx:expand_text(services.translate("The children of the night tell you what features of the map are nearby.")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Without the ability to howl into the wilds of the night, there is no response.")), "neutral")
    end
    return true
    end
    EOC["EOC_BLOODHEAL_activated"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("But your left arm is too damaged.  Only time can heal it.")), "bad")
    else
        H.set_char_hp(H.u(ctx), "arm_l", math.min((((((5 + (H._jm_vampire_total_tier_one_traits(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits(ctx) * 3.5)), 25), "+=")
    end
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("But your right arm is too damaged.  Only time can heal it.")), "bad")
    else
        H.set_char_hp(H.u(ctx), "arm_r", math.min((((((5 + (H._jm_vampire_total_tier_one_traits(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits(ctx) * 3.5)), 25), "+=")
    end
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("But your left leg is too damaged.  Only time can heal it.")), "bad")
    else
        H.set_char_hp(H.u(ctx), "leg_l", math.min((((((5 + (H._jm_vampire_total_tier_one_traits(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits(ctx) * 3.5)), 25), "+=")
    end
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((function() local eg = H.safe_id('effect', "disabled"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("But your right leg is too damaged.  Only time can heal it.")), "bad")
    else
        H.set_char_hp(H.u(ctx), "leg_r", math.min((((((5 + (H._jm_vampire_total_tier_one_traits(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits(ctx) * 3.5)), 25), "+=")
    end
    H.set_char_hp(H.u(ctx), "torso", math.min((((((5 + (H._jm_vampire_total_tier_one_traits_plus_potency(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits_plus_cauldron(ctx) * 3.5)), 25), "+=")
    H.set_char_hp(H.u(ctx), "head", math.min((((((5 + (H._jm_vampire_total_tier_one_traits_plus_potency(ctx) * 0.75)) + (H._jm_vampire_total_tier_two_traits(ctx) * 1)) + (H._jm_vampire_total_tier_three_traits(ctx) * 1.25)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 2.5)) + (H._jm_vampire_total_tier_five_traits_plus_cauldron(ctx) * 3.5)), 25), "+=")
    services.messages.add(ctx:expand_text(services.translate("You don't have enough blood to heal your wounds.")), "bad")
    return true
    end
    COND["EOC_VAMPIRE_FEAR_GAZE_activated_3"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).npc == true)) == true
    end
    EOC["EOC_VAMPIRE_FEAR_GAZE_activated_3"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).npc == true)) then
        H.npc_mood_write(H.npc(ctx), "fear", (H.var_num(H.u(ctx), "vampire_fear_gaze_power_level") / 2), "+=")
        services.messages.add(ctx:expand_text(services.translate("You bare your fangs and hiss at your target.")), "neutral")
        H.eoc_add_effect(H.u(ctx), "effect_vampire_fear_gazed", 300, nil, nil, nil)
        return true
    else
        H.set_char_val_extra(H.u(ctx), "morale", (H.var_num(H.u(ctx), "vampire_fear_gaze_power_level") * 5), "-=")
        services.messages.add(ctx:expand_text(services.translate("You bare your fangs and hiss at your target.")), "neutral")
        H.eoc_add_effect(H.u(ctx), "effect_vampire_fear_gazed", 300, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VAMPIRE_FEAR_GAZE_activated_2"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_vampire_fear_gazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))))) == true
    end
    EOC["EOC_VAMPIRE_FEAR_GAZE_activated_2"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_vampire_fear_gazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))))) then
        H.run_eoc("EOC_VAMPIRE_FEAR_GAZE_activated_3", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_VAMPIRE_FEAR_GAZE_activated"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "vampire_fear_gaze_power_level", (((((H.var_num(H.npc(ctx), "vampire_total_tier_one_traits_plus_potency") * 0.5) + (H.var_num(H.npc(ctx), "vampire_total_tier_two_traits") * 0.75)) + (H.var_num(H.npc(ctx), "vampire_total_tier_three_traits") * 1)) + (H.var_num(H.npc(ctx), "vampire_total_tier_four_traits") * 2)) + (H.var_num(H.npc(ctx), "vampire_total_tier_five_traits_plus_cauldron") * 3)))
    H.run_eoc("EOC_VAMPIRE_FEAR_GAZE_activated_2", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_HYPNOTIC_GAZE_activated_2"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1))) and (not (((function() local eg = H.safe_id('effect', "blind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "BLIND")))) then
        H.eoc_add_effect(H.u(ctx), "effect_vampire_hypnotism", H.var_num(H.u(ctx), "vampire_hypnotic_gaze_power_level"), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "dazed", H.var_num(H.u(ctx), "vampire_hypnotic_gaze_power_level"), nil, nil, nil)
    else
        services.messages.add(ctx:expand_text(services.translate("Your target is unaffected by your gaze!")), "bad")
    end
    return true
    end
    EOC["EOC_HYPNOTIC_GAZE_activated"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "vampire_hypnotic_gaze_power_level", (((((2 + (H.var_num(H.npc(ctx), "vampire_total_tier_one_traits_plus_potency") * 0.5)) + (H.var_num(H.npc(ctx), "vampire_total_tier_two_traits") * 0.75)) + (H.var_num(H.npc(ctx), "vampire_total_tier_three_traits") * 1.2)) + (H.var_num(H.npc(ctx), "vampire_total_tier_four_traits") * 2.5)) + (H.var_num(H.npc(ctx), "vampire_total_tier_five_traits_plus_cauldron") * 3.5)))
    H.run_eoc("EOC_HYPNOTIC_GAZE_activated_2", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_VAMPIRE_EARTH_SLUMBER_activated"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()))) == true
    end
    EOC["EOC_VAMPIRE_EARTH_SLUMBER_activated"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()))) then
        H.run_eoc("EOC_VAMPIRE_EARTH_SLUMBER_activated_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on diggable soil to sink into it.")), "bad")
        return false
    end
    end
    EOC["EOC_VAMPIRE_EARTH_SLUMBER_activated_3"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "VAMPIRE_sleep_in_earth_starting_point", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "VAMPIRE_sleep_in_earth_destination", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, { dz = math.floor(-9) }, true, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("The earth parts beneath you and you sink down into the soil.")), "good")
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "VAMPIRE_sleep_in_earth_destination"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    COND["EOC_VAMPIRE_EARTH_SLUMBER_activated_2"] = function(ctx)
        return ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9))))) == true
    end
    EOC["EOC_VAMPIRE_EARTH_SLUMBER_activated_2"] = function(ctx)
    if ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9))))) then
        H.run_eoc("EOC_VAMPIRE_EARTH_SLUMBER_activated_3", ctx, nil, nil, nil)
        return true
    else
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "VAMPIRE_sleep_in_earth_starting_point"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        services.messages.add(ctx:expand_text(services.translate("You feel yourself rising until you stand in the clear air once again.")), "good")
        return false
    end
    end
    COND["EOC_VAMPIRE_TORPOR_activated"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))) == true
    end
    EOC["EOC_VAMPIRE_TORPOR_activated"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))) then
        if (services.interaction.confirm(ctx:expand_text(services.translate("Enter torpor?"))) == true) then
            H.set_char_val_extra(H.u(ctx), "sleepiness", 0, "=")
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 0, "=")
            services.messages.add(ctx:expand_text(services.translate("You enter torpor.")), "info")
            do local _g = H.safe_id('activity', "ACT_VAMPIRE_TORPOR"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
            H.eoc_add_effect(H.u(ctx), "effect_vampire_torpor", 28800, nil, nil, nil)
        else
            services.messages.add(ctx:expand_text(services.translate("You decide to not enter torpor.")), "info")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Entering torpor outdoors would only result in you dying from the sun's rays.")), "bad")
        return false
    end
    end
    EOC["EOC_VAMPIRE_MIST_FORM_SEEP_THROUGH_DOOR_WINDOW"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select door or window.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "vampire_mist_door_or_window_seep") and 1 or 0)) then
        services.messages.add(ctx:expand_text(services.translate("Select where to appear.")), "neutral")
        do local _p = H.get_tripoint_var("context", nil, ctx, "place_to_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    else
        services.messages.add(ctx:expand_text(services.translate("You must be near a door or window to seep through.")), "neutral")
    end
    return true
    end
    COND["eoc_vampire_blood_to_kcal_check_size_tiny"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "TINY")) == true
    end
    EOC["eoc_vampire_blood_to_kcal_check_size_tiny"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "TINY")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) / (8))
        H.run_eoc("eoc_vampire_blood_to_kcal_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("eoc_vampire_blood_to_kcal_check_size_small", ctx, nil, nil, nil)
        return false
    end
    end
    COND["eoc_vampire_blood_to_kcal"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "BLOOD_DRINKER") == 1)) == true
    end
    EOC["eoc_vampire_blood_to_kcal"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "BLOOD_DRINKER") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", 95000)
        H.run_eoc("eoc_vampire_blood_to_kcal_check_size_tiny", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["eoc_vampire_blood_to_kcal_check_size_small"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "SMALL")) == true
    end
    EOC["eoc_vampire_blood_to_kcal_check_size_small"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "SMALL")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) / (3))
        H.run_eoc("eoc_vampire_blood_to_kcal_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("eoc_vampire_blood_to_kcal_check_size_large", ctx, nil, nil, nil)
        return false
    end
    end
    COND["eoc_vampire_blood_to_kcal_check_size_large"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "LARGE")) == true
    end
    EOC["eoc_vampire_blood_to_kcal_check_size_large"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "LARGE")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) * (1.5))
        H.run_eoc("eoc_vampire_blood_to_kcal_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("eoc_vampire_blood_to_kcal_check_size_huge", ctx, nil, nil, nil)
        return false
    end
    end
    COND["eoc_vampire_blood_to_kcal_check_size_huge"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "HUGE")) == true
    end
    EOC["eoc_vampire_blood_to_kcal_check_size_huge"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "HUGE")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) * (2))
        H.run_eoc("eoc_vampire_blood_to_kcal_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("eoc_vampire_blood_to_kcal_convert", ctx, nil, nil, nil)
        return false
    end
    end
    COND["eoc_vampire_blood_to_kcal_convert"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "human_blood_vitamin") > 500) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) < H.var_num(H.u(ctx), "calories_needed")))) == true
    end
    EOC["eoc_vampire_blood_to_kcal_convert"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "human_blood_vitamin") > 500) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) < H.var_num(H.u(ctx), "calories_needed")))) then
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(500 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 500; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        services.messages.add(ctx:expand_text(services.translate("Some of your stolen blood is consumed by your body, making it a little less gaunt.")), "good")
        return true
    end
    return false
    end
    COND["EOC_last_breath_mist"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST") == 1) and (not (((function() local eg = H.safe_id('effect', "last_breath_mist_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 1800))) == true
    end
    EOC["EOC_last_breath_mist"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST") == 1) and (not (((function() local eg = H.safe_id('effect', "last_breath_mist_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 1800))) then
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        H.run_eoc("EOC_VAMPIRE_MIST_FORM_TRAIT_activated", ctx, nil, nil, nil)
        H.set_char_hp(H.u(ctx), "torso", math.max(H.char_hp(H.u(ctx), "torso", false), 30), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.char_hp(H.u(ctx), "head", false), 30), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.char_hp(H.u(ctx), "arm_l", false), 30), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.char_hp(H.u(ctx), "arm_r", false), 30), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.char_hp(H.u(ctx), "leg_l", false), 30), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.char_hp(H.u(ctx), "leg_r", false), 30), "=")
        do local _eg = H.safe_id('effect', "downed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "onfire"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "formication"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "blisters"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "frostbite"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "frostbite_recovery"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "wet"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "slimed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "migo_atmosphere"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "fetid_goop"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "sap"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "nausea"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        local _a38 = H.u(ctx)
        if _a38 then services.characters.adjust(_a38, { pain = math.floor((0) - (H.char_pain(_a38))) }) end
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        local _a39 = H.u(ctx)
        if _a39 then services.characters.adjust(_a39, { pain = math.floor((0) - (H.char_pain(_a39))) }) end
        H.set_char_val_extra(H.u(ctx), "rad", 0, "=")
        H.eoc_loc_var(H.u(ctx), ctx, "global", "last_breath_new_pos", nil, nil, nil, { min_radius = math.floor(25), max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2400; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if (H.char_has_trait(H.u(ctx), "VAMPIRE_LAST_BREATH_MIST_UPGRADE") == 1) then
            H.eoc_add_effect(H.u(ctx), "last_breath_mist_cooldown", 302400, nil, nil, nil)
        else
            H.eoc_add_effect(H.u(ctx), "last_breath_mist_cooldown", 604800, nil, nil, nil)
        end
        do local _p = H.get_tripoint_var("global", nil, ctx, "last_breath_new_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        ccb.presentation.notice(ctx:expand_text(services.translate("As you are about to die, your body instinctively turns to mist before reappearing nearby with some of its wounds closed.")))
        return true
    end
    return false
    end
    EOC["EOC_VAMPIRE_MIST_FORM_TRAIT_activated"] = function(ctx)
    do local _g = H.safe_id('mutation', "VAMPIRE_MIST_FORM"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, true) end end
    return true
    end
    COND["EOC_NEED_LIVING_BLOOD_GIVE_EFFECT"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD") == 1)) == true
    end
    EOC["EOC_NEED_LIVING_BLOOD_GIVE_EFFECT"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD") == 1)) then
        H.eoc_add_effect(H.u(ctx), "vampire_need_living_blood", -1, nil, (H.creature_effect_intensity(H.u(ctx), "vampire_need_living_blood") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_HOLY_BURN_CHECK_REMOVE"] = function(ctx)
        return (((H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "head") >= 1))) == true
    end
    EOC["EOC_HOLY_BURN_CHECK_REMOVE"] = function(ctx)
    if (((H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_holy_place_burn", "head") >= 1))) then
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_holy_place_burn"); local _bp = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You are now far enough from the holy place.  You no longer feel like you're burning up.")), "good")
        return true
    end
    return false
    end
    COND["EOC_HOLY_BURN_CHECK_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_2ndfloor_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_3rdfloor_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_roof_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_parking", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_basement", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple_roof", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_roof", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_upper_roof", math.floor(1)) end)()))) == true
    end
    EOC["EOC_HOLY_BURN_CHECK_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_2ndfloor_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_3rdfloor_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "church_roof_1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_parking", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_basement", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "rural_church_steeple_roof", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_7_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_6_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_5_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_4_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_3_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_2_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_1_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_NE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SW", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cathedral_b_SE", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_roof", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "synagogue_upper_roof", math.floor(1)) end)()))) then
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "leg_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_holy_place_burn", 100, "head", nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You are too close to a holy place!  You must flee its proximity immediately or you will die!")), "bad")
        return true
    else
        H.run_eoc("EOC_HOLY_BURN_CHECK_REMOVE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_HOLY_BURN_CHECK"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_HOLY_BURN") == 1)) == true
    end
    EOC["EOC_HOLY_BURN_CHECK"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_HOLY_BURN") == 1)) then
        H.run_eoc("EOC_HOLY_BURN_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VAST_WATER_CHECK_REMOVE"] = function(ctx)
        return (((H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "head") >= 1))) == true
    end
    EOC["EOC_VAST_WATER_CHECK_REMOVE"] = function(ctx)
    if (((H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "effect_vast_water_burn", "head") >= 1))) then
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vast_water_burn"); local _bp = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You are now far enough from the vast water.  You no longer feel like you're melting.")), "good")
        return true
    end
    return false
    end
    COND["EOC_VAST_WATER_BURN_CHECK_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()))) == true
    end
    EOC["EOC_VAST_WATER_BURN_CHECK_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()))) then
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "leg_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vast_water_burn", 100, "head", nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You are too close to a vast body of water!  You must flee its proximity immediately or you will die!")), "bad")
        return true
    else
        H.run_eoc("EOC_VAST_WATER_CHECK_REMOVE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VAST_WATER_BURN_CHECK"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_VAST_WATER_BURN") == 1)) == true
    end
    EOC["EOC_VAST_WATER_BURN_CHECK"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_VAST_WATER_BURN") == 1)) then
        H.run_eoc("EOC_VAST_WATER_BURN_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BLOOD_CRAVING_START"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_BLOOD_CRAVING_START"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(180), math.floor(360); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOOD_CRAVING_CAUSE"), nil) end end
        services.messages.add(ctx:expand_text(services.translate("You feel a growing craving for blood.  If you do not drink blood soon, the craving will grow unbearable for a short time.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_BLOOD_CRAVING_CAUSE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_BLOOD_CRAVING_CAUSE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_BLOOD_CRAVING") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "blood_craving", (400 + services.random.native_int(0, H.round_half_away(600))), nil, 1, nil)
        return true
    end
    return false
    end
    COND["EOC_NO_FUN_CHECK"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NO_FUN") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_NO_FUN_CHECK"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_NO_FUN") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_drank_blood_recently"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _g = H.safe_id('morale', "morale_vw_no_fun"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "morale_vw_no_fun", (15 + H.char_val_extra(H.u(ctx), "morale")))
        do local _g = H.safe_id('morale', "morale_vw_no_fun"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((H.var_num(H.u(ctx), "morale_vw_no_fun") * (-1))), math.floor((H.var_num(H.u(ctx), "morale_vw_no_fun") * (-1))), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_INVISIBLE_IN_DARK"] = function(ctx)
        return ((not (((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "vampire_blind_the_sun"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))))) == true
    end
    EOC["EOC_VAMPIRE_INVISIBLE_IN_DARK"] = function(ctx)
    if ((not (((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "vampire_blind_the_sun"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))))) then
        do local _g = H.safe_id('activity', "ACT_GENERIC_EOC"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(0.25)))) end end
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 300; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.eoc_add_effect(H.u(ctx), "effect_vampire_invisible_in_dark", (services.random.native_float(0.75, 1.25) * (((((200 + (H._jm_vampire_total_tier_one_traits_plus_potency(ctx) * 20)) + (H._jm_vampire_total_tier_two_traits(ctx) * 45)) + (H._jm_vampire_total_tier_three_traits(ctx) * 70)) + (H._jm_vampire_total_tier_four_traits_plus_potence(ctx) * 100)) + (H._jm_vampire_total_tier_five_traits_plus_cauldron(ctx) * 150))), nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You cannot use this power under the sun's rays.")), "bad")
        return false
    end
    end
    COND["EOC_VAMPIRE_HEAL_IN_DARK"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VAMPIRE_HEAL_IN_DARK") == 1) and (not (((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))))) == true
    end
    EOC["EOC_VAMPIRE_HEAL_IN_DARK"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VAMPIRE_HEAL_IN_DARK") == 1) and (not (((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))))) then
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) >= 1) then
            local _a40 = H.u(ctx)
            if _a40 then services.characters.adjust(_a40, { pain = math.floor(-(3)) }) end
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) then
            H.set_char_hp(H.u(ctx), "arm_l", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) then
            H.set_char_hp(H.u(ctx), "arm_r", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) then
            H.set_char_hp(H.u(ctx), "leg_l", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) then
            H.set_char_hp(H.u(ctx), "leg_r", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) then
            H.set_char_hp(H.u(ctx), "torso", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)) then
            H.set_char_hp(H.u(ctx), "head", 1, "+=")
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "arm_l", -1, nil)
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "arm_r", -1, nil)
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_l") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "leg_l", -1, nil)
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "leg_r", -1, nil)
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "torso") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "torso", -1, nil)
        end
        if (H.creature_effect_intensity(H.u(ctx), "bleed", "head") >= 1) then
            H.eoc_add_effect(H.u(ctx), "bleed", 0, "head", -1, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_recent_vampire_drink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_recent_vampire_drink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_anathema_need_vampire_blood", -1, nil, (H.creature_effect_intensity(H.u(ctx), "effect_anathema_need_vampire_blood") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_recent_vampire_drink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD_DRAIN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_recent_vampire_drink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.set_var("actor", H.u(ctx), ctx, "counter_anathema_need_vampire_blood", (H.var_num(H.u(ctx), "counter_anathema_need_vampire_blood")) + (H.creature_effect_intensity(H.u(ctx), "effect_anathema_need_vampire_blood")))
        if services.random.native_probability((H.var_num(H.u(ctx), "counter_anathema_need_vampire_blood")), (100)) then
            do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1 + services.random.native_int(0, H.round_half_away(1))); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            H.set_var("actor", H.u(ctx), ctx, "counter_anathema_need_vampire_blood", 0)
        end
        return true
    end
    return false
    end
    COND["EOC_MENTOR_VANISH"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MENTOR_PEACE") == 1)) == true
    end
    EOC["EOC_MENTOR_VANISH"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MENTOR_PEACE") == 1)) then
        if H.u(ctx) then services.characters.die(H.u(ctx), { remove_corpse = true, suppress_message = true }) end
        services.messages.add(ctx:expand_text(services.translate("%1$s vanishes in a fine mist.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You're not a mentor, so you're not supposed to see this.  Please open a GitHub bug report.")), "popup")
        return false
    end
    end
    COND["EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_vampiric_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH_REFINEMENT_SMASHING_TILES") == 1))) == true
    end
    EOC["EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_vampiric_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "VAMPIRIC_STRENGTH_REFINEMENT_SMASHING_TILES") == 1))) then
        H.eoc_add_effect(H.u(ctx), "effect_vampire_unholy_devastation", 2, nil, (H.creature_effect_intensity(H.u(ctx), "effect_vampire_unholy_devastation") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES_REMOVE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vampire_unholy_devastation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VAMPIRE_UNHOLY_DEVASTATION_BONUSES_REMOVE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vampire_unholy_devastation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_vampire_unholy_devastation"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
end
