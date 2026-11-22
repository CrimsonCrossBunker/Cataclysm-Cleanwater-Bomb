local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_DUST_STORM_WARN_OR_CAUSE_RECURRING"] = function(ctx)
    H.run_eoc("EOC_CAUSE_EARLY_DUST_STORM", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_DUST_STORM_WARN_DAY_NIGHT"] = function(ctx)
        return ((not services.gameplay.environment.is_night())) == true
    end
    EOC["EOC_DUST_STORM_WARN_DAY_NIGHT"] = function(ctx)
    if ((not services.gameplay.environment.is_night())) then
        services.messages.add((services.snippets.native_random("DUST_STORM_DAY_MESSAGES_1") or ''), "neutral")
        return true
    else
        services.messages.add((services.snippets.native_random("DUST_STORM_NIGHT_MESSAGES_1") or ''), "neutral")
        return false
    end
    end
    COND["EOC_DUST_STORM_WARN_CAN_SEE_OUTDOORS"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_DUST_STORM_WARN_CAN_SEE_OUTDOORS"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_DUST_STORM_WARN_DAY_NIGHT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DUST_EARLY_MESSAGES"] = function(ctx)
        return (((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm")) == true
    end
    EOC["EOC_DUST_EARLY_MESSAGES"] = function(ctx)
    if (((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm")) then
        H.run_eoc("EOC_DUST_STORM_WARN_CAN_SEE_OUTDOORS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DUST_STORM_POPUP_DAY_NIGHT"] = function(ctx)
        return ((not services.gameplay.environment.is_night())) == true
    end
    EOC["EOC_DUST_STORM_POPUP_DAY_NIGHT"] = function(ctx)
    if ((not services.gameplay.environment.is_night())) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You suddenly notice a wall of dust and debris coming your way.  A dust storm is approaching.")))
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("NIGHT You suddenly notice a wall of dust and debris coming your way.  A dust storm is approaching.")))
        return false
    end
    end
    COND["EOC_EARLY_DUST_STORM_POPUP"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_EARLY_DUST_STORM_POPUP"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_DUST_STORM_POPUP_DAY_NIGHT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CAUSE_EARLY_DUST_STORM"] = function(ctx)
        return ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm") or (H.global_var_num("cause_dust_storm") == 1) or (H.global_var_num("cause_early_dust_storm") == 1) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or (H.global_var_num("cause_portal_storm") == 1) or (H.global_var_num("cause_early_portal_storm") == 1))))) == true
    end
    EOC["EOC_CAUSE_EARLY_DUST_STORM"] = function(ctx)
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm") or (H.global_var_num("cause_dust_storm") == 1) or (H.global_var_num("cause_early_dust_storm") == 1) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or (H.global_var_num("cause_portal_storm") == 1) or (H.global_var_num("cause_early_portal_storm") == 1))))) then
        H.set_var("global", nil, ctx, "cause_early_dust_storm", 1)
        services.weather.request_update()
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CAUSE_DUST_STORM"), nil) end end
        H.run_eoc("EOC_EARLY_DUST_STORM_POPUP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DUST_STORM_MESSAGE"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_DUST_STORM_MESSAGE"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("The dust storm has arrived!")), "bad")
        return true
    end
    return false
    end
    COND["EOC_CAUSE_DUST_STORM"] = function(ctx)
        return ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or (H.global_var_num("cause_dust_storm") == 1))))) == true
    end
    EOC["EOC_CAUSE_DUST_STORM"] = function(ctx)
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or (H.global_var_num("cause_dust_storm") == 1))))) then
        H.set_var("global", nil, ctx, "cause_early_dust_storm", 0)
        H.set_var("global", nil, ctx, "cause_dust_storm", 1)
        services.weather.request_update()
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.global_var_num("ds_min_length")) ~= 0) and (H.global_var_num("ds_min_length")) or 3600)), math.floor((((H.global_var_num("ds_max_length")) ~= 0) and (H.global_var_num("ds_max_length")) or 18000)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CANCEL_DUST_STORM"), nil) end end
        H.run_eoc("EOC_DUST_STORM_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_END_DUST_STORM_MESSAGE"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_END_DUST_STORM_MESSAGE"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("As suddenly as it began, the dust storm fades.")), "good")
        return true
    end
    return false
    end
    COND["EOC_CANCEL_DUST_STORM"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm") or (H.global_var_num("cause_dust_storm") == 1) or (H.global_var_num("cause_early_dust_storm") == 1))) == true
    end
    EOC["EOC_CANCEL_DUST_STORM"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm") or (H.global_var_num("cause_dust_storm") == 1) or (H.global_var_num("cause_early_dust_storm") == 1))) then
        H.set_var("global", nil, ctx, "cause_dust_storm", 0)
        H.set_var("global", nil, ctx, "cause_early_dust_storm", 0)
        services.weather.request_update()
        H.run_eoc("EOC_END_DUST_STORM_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DUST_WIND"] = function(ctx)
        return (((H.weather_val("windpower") <= 60) and ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm"))) == true
    end
    EOC["EOC_DUST_WIND"] = function(ctx)
    if (((H.weather_val("windpower") <= 60) and ((services.weather.current().weather and services.weather.current().weather.value) == "early_dust_storm"))) then
        do local _cur = H.weather_val('windpower'); local _nxt = 3; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_windpower(_val) end
        services.messages.add(ctx:expand_text(services.translate("WIND")), "bad")
        return true
    end
    return false
    end
    COND["EOC_DUST_SMOKE"] = function(ctx)
        return (((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm")) == true
    end
    EOC["EOC_DUST_SMOKE"] = function(ctx)
    if (((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm")) then
        services.messages.add(ctx:expand_text(services.translate("Dust")), "bad")
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('field', "fd_dust_storm"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(150), intensity = math.floor(3) }) end end
        return true
    end
    return false
    end
    COND["EOC_DUST_WIND_STRONG"] = function(ctx)
        return (((H.weather_val("windpower") <= 120) and ((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm"))) == true
    end
    EOC["EOC_DUST_WIND_STRONG"] = function(ctx)
    if (((H.weather_val("windpower") <= 120) and ((services.weather.current().weather and services.weather.current().weather.value) == "dust_storm"))) then
        do local _cur = H.weather_val('windpower'); local _nxt = 4; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_windpower(_val) end
        services.messages.add(ctx:expand_text(services.translate("WIND")), "bad")
        return true
    end
    return false
    end
end
