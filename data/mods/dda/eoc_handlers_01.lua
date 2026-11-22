local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_AO_SPATIAL_ANCHOR_SLOW"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "AO_ANCHOR", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(28800), math.floor(129600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AO_SPATIAL_ANCHOR_TP"), nil) end end
    return true
    end
    EOC["EOC_AO_SPATIAL_ANCHOR"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "AO_ANCHOR", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(20), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AO_SPATIAL_ANCHOR_TP"), nil) end end
    return true
    end
    COND["EOC_AO_SPATIAL_ANCHOR_TP"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true)))) == true
    end
    EOC["EOC_AO_SPATIAL_ANCHOR_TP"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true)))) then
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "AO_ANCHOR"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    end
    return false
    end
    EOC["EOC_AO_SURFACE"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "surface", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "surface"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["EOC_BOOK_FAR_TP"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "tp_loc", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    do local tp = H.get_tripoint_var("context", nil, ctx, "tp_loc"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(services.random.native_int(-40, 40)) * 24, (tp.y or 0) + math.floor(services.random.native_int(-40, 40)) * 24, (tp.z or 0) + math.floor(0)); H.set_var("context", nil, ctx, "tp_loc", nt) end end
    do local _p = H.get_tripoint_var("context", nil, ctx, "tp_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["_BOOK_COMBUSTION_EXPLODE"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "explode_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.run_eoc("EOC_BOOK_COMBUSTION_EXPLODE", ctx, { ["explode_loc"] = H.var_str("context", nil, ctx, "explode_loc", "") }, services.characters.avatar(), nil)
    return true
    end
    EOC["_MANUALS_COMBUSTION_EXPLODE"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "explode_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.run_eoc("EOC_BOOK_COMBUSTION_EXPLODE", ctx, { ["explode_loc"] = H.var_str("context", nil, ctx, "explode_loc", "") }, services.characters.avatar(), nil)
    return true
    end
    EOC["EOC_BOOK_COMBUSTION"] = function(ctx)
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 24, nil, { { category = "books" } }, { "_BOOK_COMBUSTION_EXPLODE" })
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 24, nil, { { category = "manuals" } }, { "_MANUALS_COMBUSTION_EXPLODE" })
    return true
    end
    COND["EOC_BOOK_COMBUSTION_EXPLODE"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "explode_loc"))) == true
    end
    EOC["EOC_BOOK_COMBUSTION_EXPLODE"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "explode_loc"))) then
        if H.u(ctx) then services.characters.explosion(H.u(ctx), { power = 50000, distance_factor = 0.1, max_noise = 35, target = H.get_tripoint_var("context", nil, ctx, "explode_loc") }) end
        return true
    end
    return false
    end
    EOC["EOC_MAGIC_CASCADE"] = function(ctx)
    if services.random.native_probability(1, (4)) then
        H.eoc_cast_spell(H.u(ctx), "MAGIC_CASCADE", false, nil)
    else
        H.eoc_cast_spell(H.u(ctx), "MAGIC_CASCADE", false, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGIC_CASCADE"), nil) end end
    end
    return true
    end
    EOC["EOC_DEBUG_QUICK_SETUP"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("EOC_DEBUG_QUICK_SETUP is automatically executed when using quick setup.  Override it for custom functionality during quick setup.")), "neutral")
    return true
    end
    COND["EOC_CAFFEINE_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(2000)) <= H._jm_addiction_rational(ctx, 2000, 20, H.char_addiction(H.u(ctx), "caffeine", "intensity")))) == true
    end
    EOC["EOC_CAFFEINE_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(2000)) <= H._jm_addiction_rational(ctx, 2000, 20, H.char_addiction(H.u(ctx), "caffeine", "intensity")))) then
        services.messages.add(ctx:expand_text(services.translate("You want some caffeine.")), "warning")
        do local _g = H.safe_id('morale', "morale_craving_caffeine"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        if ((H.char_val_extra(H.u(ctx), "stim") > (H.char_addiction(H.u(ctx), "caffeine", "intensity") * (-10))) and (services.random.native_int(0, H.round_half_away(10)) < H.char_addiction(H.u(ctx), "caffeine", "intensity"))) then
            H.set_char_val_extra(H.u(ctx), "stim", 1, "-=")
        end
        if ((H.char_addiction(H.u(ctx), "caffeine", "intensity") >= 8) and (services.random.native_int(0, H.round_half_away(392)) < H.char_addiction(H.u(ctx), "caffeine", "intensity"))) then
            services.messages.add(ctx:expand_text(services.translate("Your hands start shaking… you need it bad!")), "bad")
            H.eoc_add_effect(H.u(ctx), "shakes", 120, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_SLEEP_ADDICTION"] = function(ctx)
        return ((services.random.native_probability(1, (2)) and (H.char_addiction(H.u(ctx), "sleeping pill", "turns") < 0))) == true
    end
    EOC["EOC_SLEEP_ADDICTION"] = function(ctx)
    if ((services.random.native_probability(1, (2)) and (H.char_addiction(H.u(ctx), "sleeping pill", "turns") < 0))) then
        H.set_char_addiction(H.u(ctx), "sleeping pill", "turns", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_MARLOSS_R_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_r", "intensity")))) == true
    end
    EOC["EOC_MARLOSS_R_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_r", "intensity")))) then
        do local _g = H.safe_id('morale', "morale_craving_marloss"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        services.messages.add(ctx:expand_text(services.translate("You daydream about luscious pink berries as big as your fist.")), "info")
        if (H.char_val_extra(H.u(ctx), "focus") > 40) then
            H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        end
        return true
    end
    return false
    end
    COND["EOC_MARLOSS_B_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_b", "intensity")))) == true
    end
    EOC["EOC_MARLOSS_B_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_b", "intensity")))) then
        do local _g = H.safe_id('morale', "morale_craving_marloss"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        services.messages.add(ctx:expand_text(services.translate("You daydream about nutty cyan seeds as big as your hand.")), "info")
        if (H.char_val_extra(H.u(ctx), "focus") > 40) then
            H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        end
        return true
    end
    return false
    end
    COND["EOC_MARLOSS_Y_ADDICTION"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_y", "intensity")))) == true
    end
    EOC["EOC_MARLOSS_Y_ADDICTION"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(800)) <= H._jm_addiction_rational(ctx, 800, 20, H.char_addiction(H.u(ctx), "marloss_y", "intensity")))) then
        do local _g = H.safe_id('morale', "morale_craving_marloss"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        services.messages.add(ctx:expand_text(services.translate("You daydream about succulent, pale golden gel, sweet but light.")), "info")
        if (H.char_val_extra(H.u(ctx), "focus") > 40) then
            H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        end
        return true
    end
    return false
    end
    EOC["refund_power"] = function(ctx)
    H.set_bionic_power(H.u(ctx), (ctx:get_number("act_cost") or 0), "+=")
    return true
    end
    COND["EOC_bio_adrenaline"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "adrenaline"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_bio_adrenaline"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "adrenaline"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("Safeguards kicks in, and the bionic refuses to activate!")), "bad")
        H.run_eoc("refund_power", ctx, nil, nil, nil)
        return true
    else
        H.eoc_add_effect(H.u(ctx), "adrenaline", 1200, nil, nil, nil)
        return false
    end
    end
    COND["EOC_time_freeze"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "riding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_time_freeze"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "riding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("You cannot activate Time Dilation while mounted.")), "info")
        H.run_eoc("refund_power", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You activate your Time Dilation.")), "info")
        local _u1 = H.u(ctx)
        if _u1 then services.characters.adjust(_u1, { moves = -math.floor(((H.char_bionic_power(H.u(ctx), "power") / (-100000000))) * 100) }) end
        H.set_bionic_power(H.u(ctx), 0, "=")
        services.messages.add(ctx:expand_text(services.translate("Your speed suddenly increases!")), "good")
        if services.random.native_probability(1, (3)) then
            services.messages.add(ctx:expand_text(services.translate("Your muscles tear with the strain!")), "good")
            H.set_char_hp(H.u(ctx), "arm_l", services.random.native_float(5, 10), "-=")
            H.set_char_hp(H.u(ctx), "arm_r", services.random.native_float(5, 10), "-=")
            H.set_char_hp(H.u(ctx), "leg_l", services.random.native_float(7, 12), "-=")
            H.set_char_hp(H.u(ctx), "leg_r", services.random.native_float(7, 12), "-=")
            H.set_char_hp(H.u(ctx), "torso", services.random.native_float(5, 15), "-=")
        end
        if services.random.native_probability(1, (5)) then
            H.eoc_add_effect(H.u(ctx), "teleglow", (function() local a, b = math.floor(300), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        end
        return false
    end
    end
    EOC["EOC_bio_hydraulics"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your muscles hiss as hydraulic strength fills them!")), "good")
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(19), "activity", ctx:expand_text(services.translate("HISISSS!")), false) end end
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_bio_hydraulics_act"), nil) end end
    return true
    end
    COND["EOC_bio_hydraulics_act"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "bio_hydraulics_eff"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_bio_hydraulics_act"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "bio_hydraulics_eff"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(19), "activity", ctx:expand_text(services.translate("HISISSS!")), false) end end
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_bio_hydraulics_act"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_bio_hydraulics_activated"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "bio_hydraulics_strength_adjustment", (((H.char_snap(H.u(ctx)) or {}).stats or {}).strength or 0))
    H.eoc_add_effect(H.u(ctx), "effect_bio_hydraulics_active", -1, nil, nil, nil)
    return true
    end
    EOC["EOC_bio_hydraulics_deactivated"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_bio_hydraulics_active"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_bio_blood_filter"] = function(ctx)
    if ((function() local eg = H.safe_id('effect', "adrenaline"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
        do local _eg = H.safe_id('effect', "adrenaline"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "adrenaline", 150, nil, nil, nil)
    end
    if ((function() local eg = H.safe_id('effect', "meth"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
        do local _eg = H.safe_id('effect', "meth"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "meth", 200, nil, nil, nil)
    end
    do local _eg = H.safe_id('effect', "fungus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "dermatik"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "bloodworms"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "tetanus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "poison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "badpoison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill1_generic"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill1_acetaminophen"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill1_nsaid"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill3"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pkill_l"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "drunk"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "cig"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "high"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "hallu"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "visuals"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pblue"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "iodine"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "datura"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "took_xanax"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "took_prozac"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "took_prozac_bad"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "took_flumed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "antifungal"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_weaken"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_dmg"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "paralyzepoison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    H.set_char_val_extra(H.u(ctx), "pkill", 0, "=")
    H.set_char_val_extra(H.u(ctx), "stim", 0, "=")
    local _u2 = H.u(ctx)
    if _u2 then services.characters.adjust(_u2, { moves = -math.floor((1) * 100) }) end
    return true
    end
    EOC["EOC_bio_nl_blood_factory"] = function(ctx)
    if (H.char_vitamin(H.u(ctx), "redcells") < (-1)) then
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    end
    if (H.char_vitamin(H.u(ctx), "blood") < (-1)) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    end
    return true
    end
    COND["bio_drain"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_drain") and (H.char_bionic_power(H.u(ctx), "power") >= 25000000))) == true
    end
    EOC["bio_drain"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_drain") and (H.char_bionic_power(H.u(ctx), "power") >= 25000000))) then
        services.messages.add(ctx:expand_text(services.translate("Your batteries discharge slightly.")), "bad")
        services.sound.play_if_audible("elec_crackle_low", "bionics", math.floor(100))
        H.set_bionic_power(H.u(ctx), 25000000, "-=")
        return true
    end
    return false
    end
    COND["bio_trip"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_trip") and (not ((((function() local eg = H.safe_id('effect', "visuals"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) == true
    end
    EOC["bio_trip"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_trip") and (not ((((function() local eg = H.safe_id('effect', "visuals"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) then
        services.messages.add(ctx:expand_text(services.translate("Your vision pixelates!")), "bad")
        services.sound.play_if_audible("pixelated", "bionics", math.floor(100))
        H.eoc_add_effect(H.u(ctx), "visuals", 600, nil, nil, nil)
        return true
    end
    return false
    end
    COND["bio_spasm"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_spasm") and (not ((((function() local eg = H.safe_id('effect', "downed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) == true
    end
    EOC["bio_spasm"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_spasm") and (not ((((function() local eg = H.safe_id('effect', "downed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) then
        services.messages.add(ctx:expand_text(services.translate("Your malfunctioning bionic causes you to spasm and fall to the floor!")), "bad")
        services.sound.play_if_audible("elec_crackle_high", "bionics", math.floor(100))
        local _a3 = H.u(ctx)
        if _a3 then services.characters.adjust(_a3, { pain = math.floor(1) }) end
        H.eoc_add_effect(H.u(ctx), "stunned", 1, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, true)
        return true
    end
    return false
    end
    COND["bio_shakes"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_shakes") and (H.char_bionic_power(H.u(ctx), "power") >= 25000000))) == true
    end
    EOC["bio_shakes"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_shakes") and (H.char_bionic_power(H.u(ctx), "power") >= 25000000))) then
        services.messages.add(ctx:expand_text(services.translate("Your bionics short-circuit, causing you to tremble and shiver.")), "bad")
        services.sound.play_if_audible("elec_crackle_med", "bionics", math.floor(100))
        H.eoc_add_effect(H.u(ctx), "shakes", 300, nil, nil, nil)
        H.set_bionic_power(H.u(ctx), 25000000, "-=")
        return true
    end
    return false
    end
    COND["bio_glowy"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_glowy") and (not (((function() local eg = H.safe_id('effect', "glowy_led"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_bionic_power(H.u(ctx), "power") >= 1000000))) == true
    end
    EOC["bio_glowy"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_glowy") and (not (((function() local eg = H.safe_id('effect', "glowy_led"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_bionic_power(H.u(ctx), "power") >= 1000000))) then
        services.messages.add(ctx:expand_text(services.translate("Your malfunctioning bionic starts to glow!")), "bad")
        H.eoc_add_effect(H.u(ctx), "glowy_led", 300, nil, nil, nil)
        H.set_bionic_power(H.u(ctx), 1000000, "-=")
        return true
    end
    return false
    end
    COND["bio_sleepy"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_sleepy") and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["bio_sleepy"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_sleepy") and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", 1, "+=")
        return true
    end
    return false
    end
    COND["bio_itchy"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_itchy") and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and H.char_has_bionic(H.u(ctx), "bio_sleep_shutdown")))))) == true
    end
    EOC["bio_itchy"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_itchy") and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and H.char_has_bionic(H.u(ctx), "bio_sleep_shutdown")))))) then
        services.messages.add(ctx:expand_text(services.translate("Your malfunctioning bionic itches!")), "bad")
        H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        return true
    end
    return false
    end
    COND["bio_noise_quiet_burn_hearing"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) == true
    end
    EOC["bio_noise_quiet_burn_hearing"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) then
        services.messages.add(ctx:expand_text(services.translate("You hear and feel a bubbling inside your body.")), "bad")
        return true
    end
    return false
    end
    COND["bio_noise_quiet_burn_deaf"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) == true
    end
    EOC["bio_noise_quiet_burn_deaf"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) then
        services.messages.add(ctx:expand_text(services.translate("You feel a bubbling inside your body.")), "bad")
        return true
    end
    return false
    end
    COND["bio_noise_quiet_burn"] = function(ctx)
        return (((H.char_has_bionic(H.u(ctx), "bio_ethanol") or H.char_has_bionic(H.u(ctx), "bio_lampoil")) and services.random.native_probability(1, (480)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_quiet_burn_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["bio_noise_quiet_burn"] = function(ctx)
    if (((H.char_has_bionic(H.u(ctx), "bio_ethanol") or H.char_has_bionic(H.u(ctx), "bio_lampoil")) and services.random.native_probability(1, (480)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_quiet_burn_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(6), "movement", ctx:expand_text(services.translate("Hiss!!!")), false) end end
        H.eoc_add_effect(H.u(ctx), "effect_bio_noise_quiet_burn_cooldown", 600, nil, nil, nil)
        H.run_eoc("bio_noise_quiet_burn_hearing", ctx, nil, nil, nil)
        H.run_eoc("bio_noise_quiet_burn_deaf", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["bio_noise_quiet_digestive_hearing"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) == true
    end
    EOC["bio_noise_quiet_digestive_hearing"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) then
        services.messages.add(ctx:expand_text(services.translate("Your stomach gurgles and churns loudly.")), "bad")
        return true
    end
    return false
    end
    COND["bio_noise_quiet_digestive_deaf"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) == true
    end
    EOC["bio_noise_quiet_digestive_deaf"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) then
        services.messages.add(ctx:expand_text(services.translate("Your stomach gurgles and churns.")), "bad")
        return true
    end
    return false
    end
    COND["bio_noise_digestive"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_metabolics") and services.random.native_probability(1, (1800)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_digestive_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["bio_noise_digestive"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_metabolics") and services.random.native_probability(1, (1800)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_digestive_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(14), "movement", ctx:expand_text(services.translate("*STOMACH GURGLING NOISES*")), false) end end
        H.eoc_add_effect(H.u(ctx), "effect_bio_noise_digestive_cooldown", 600, nil, nil, nil)
        H.run_eoc("bio_noise_quiet_digestive_hearing", ctx, nil, nil, nil)
        H.run_eoc("bio_noise_quiet_digestive_deaf", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["bio_noise_gasoline"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_fuel_cell_gasoline") and services.random.native_probability(1, (900)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_gasoline_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["bio_noise_gasoline"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_fuel_cell_gasoline") and services.random.native_probability(1, (900)) and (not (((function() local eg = H.safe_id('effect', "effect_bio_noise_gasoline_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_bio_noise_gasoline_cooldown", 600, nil, nil, nil)
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(15), "movement", ctx:expand_text(services.translate("*ENGINE IDLES*")), false) end end
        return true
    end
    return false
    end
    COND["bio_noise_hearing"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) == true
    end
    EOC["bio_noise_hearing"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)))) then
        services.messages.add(ctx:expand_text(services.translate("Your faulty bionic emits a crackle of noise!")), "bad")
        services.sound.play_if_audible("elec_blast", "bionics", math.floor(100))
        return true
    end
    return false
    end
    COND["bio_noise_deaf"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) == true
    end
    EOC["bio_noise_deaf"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).deaf == true)) then
        services.messages.add(ctx:expand_text(services.translate("You feel your faulty bionic shuddering.")), "bad")
        services.sound.play_if_audible("elec_blast_muffled", "bionics", math.floor(100))
        return true
    end
    return false
    end
    COND["bio_noise"] = function(ctx)
        return ((H.char_has_bionic(H.u(ctx), "bio_noise") and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["bio_noise"] = function(ctx)
    if ((H.char_has_bionic(H.u(ctx), "bio_noise") and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(60), "movement", ctx:expand_text(services.translate("Crackle!")), false) end end
        H.run_eoc("bio_noise_hearing", ctx, nil, nil, nil)
        H.run_eoc("bio_noise_deaf", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["bio_leaky"] = function(ctx)
        return (H.char_has_bionic(H.u(ctx), "bio_leaky")) == true
    end
    EOC["bio_leaky"] = function(ctx)
    if (H.char_has_bionic(H.u(ctx), "bio_leaky")) then
        H.set_char_health(H.u(ctx), 1, "-=")
        return true
    end
    return false
    end
    COND["EOC_BIO_SONAR_activated"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "subaquatic_sonar"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.char_has_bionic(H.u(ctx), "bio_sonar"))) == true
    end
    EOC["EOC_BIO_SONAR_activated"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "subaquatic_sonar"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.char_has_bionic(H.u(ctx), "bio_sonar"))) then
        H.eoc_add_effect(H.u(ctx), "subaquatic_sonar", -1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIO_SONAR_deactivated"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "subaquatic_sonar"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIO_SONAR_deactivated"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "subaquatic_sonar"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "subaquatic_sonar"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_BIONIC_WEARMAN_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_BIONIC_WEARMAN_ACTIVATE_MUSIC"] == nil or E.cond["EOC_BIONIC_WEARMAN_ACTIVATE_MUSIC"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Music")), description = ctx:expand_text(services.translate("Activate the WearMan in music mode.")), enabled = _en, hotkey = nil }); _targets[tostring(1)] = "EOC_BIONIC_WEARMAN_ACTIVATE_MUSIC" end end
        do local _en = (E.cond["EOC_BIONIC_WEARMAN_ACTIVATE_RADIO"] == nil or E.cond["EOC_BIONIC_WEARMAN_ACTIVATE_RADIO"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Radio")), description = ctx:expand_text(services.translate("Activate the WearMan in radio mode.")), enabled = _en, hotkey = nil }); _targets[tostring(2)] = "EOC_BIONIC_WEARMAN_ACTIVATE_RADIO" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Pick the action")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_BIONIC_WEARMAN_ACTIVATE_MUSIC"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "internal_mp3_music_group", 1, true, true, nil)
    return true
    end
    EOC["EOC_BIONIC_WEARMAN_ACTIVATE_RADIO"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "internal_mp3_radio_group", 1, true, true, nil)
    return true
    end
    EOC["EOC_BIONIC_WEARMAN_REMOVAL"] = function(ctx)
    do local g = H.safe_id('item', "internal_mp3_music"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "internal_mp3_radio"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    EOC["EOC_bio_nl_dimensional_anchor"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "integrated_nl_dimensional_anchor", 1, false, true, nil)
    return true
    end
    EOC["EOC_bio_nl_dimensional_anchor_removal"] = function(ctx)
    do local g = H.safe_id('item', "integrated_nl_dimensional_anchor"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    EOC["EOC_bio_nl_hair"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["bio_barber_hair"] == nil or E.cond["bio_barber_hair"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Hairstyle")), description = ctx:expand_text(services.translate("Change the length and style of your hair.")), enabled = _en, hotkey = nil }); _targets[tostring(1)] = "bio_barber_hair" end end
        do local _en = (E.cond["bio_barber_beard"] == nil or E.cond["bio_barber_beard"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Facial Hair")), description = ctx:expand_text(services.translate("Change the length and style of your facial hair")), enabled = _en, hotkey = nil }); _targets[tostring(2)] = "bio_barber_beard" end end
        do local _en = (E.cond["bio_use_hair_dye_kit"] == nil or E.cond["bio_use_hair_dye_kit"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Hair Color")), description = ctx:expand_text(services.translate("Change the color of your hair.")), enabled = _en, hotkey = nil }); _targets[tostring(3)] = "bio_use_hair_dye_kit" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Pick an action")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["bio_barber_hair"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_BIO_ADJUST_YOUR_HAIR") end
    return true
    end
    EOC["reset_all_artificial_hair_types"] = function(ctx)
    H.lose_trait(H.u(ctx), "artificial_hair_buzzcut")
    H.lose_trait(H.u(ctx), "artificial_hair_crewcut")
    H.lose_trait(H.u(ctx), "artificial_hair_short")
    H.lose_trait(H.u(ctx), "artificial_hair_short_no_fringe")
    H.lose_trait(H.u(ctx), "artificial_hair_short_over_eye")
    H.lose_trait(H.u(ctx), "artificial_hair_medium")
    H.lose_trait(H.u(ctx), "artificial_hair_mohawk")
    H.lose_trait(H.u(ctx), "artificial_hair_long")
    H.lose_trait(H.u(ctx), "artificial_hair_long_mohawk")
    H.lose_trait(H.u(ctx), "artificial_hair_mullet")
    H.lose_trait(H.u(ctx), "artificial_hair_long_over_eye")
    H.lose_trait(H.u(ctx), "artificial_hair_messy")
    H.lose_trait(H.u(ctx), "artificial_hair_very_long")
    H.lose_trait(H.u(ctx), "artificial_hair_extremely_long")
    H.lose_trait(H.u(ctx), "artificial_hair_body_length")
    H.lose_trait(H.u(ctx), "artificial_hair_modern")
    H.lose_trait(H.u(ctx), "artificial_hair_puff")
    H.lose_trait(H.u(ctx), "artificial_hair_beaded")
    H.lose_trait(H.u(ctx), "artificial_hair_curls")
    H.lose_trait(H.u(ctx), "artificial_hair_bun")
    H.lose_trait(H.u(ctx), "artificial_hair_punk_long")
    H.lose_trait(H.u(ctx), "artificial_hair_braid")
    H.lose_trait(H.u(ctx), "artificial_hair_detective")
    H.lose_trait(H.u(ctx), "artificial_hair_super_princess")
    H.lose_trait(H.u(ctx), "artificial_hair_twintails")
    H.lose_trait(H.u(ctx), "artificial_hair_bald")
    H.lose_trait(H.u(ctx), "artificial_hair_fro")
    H.lose_trait(H.u(ctx), "artificial_hair_ponytail")
    return true
    end
    EOC["bio_use_hair_dye_kit"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["bio_black_hair_dye"] == nil or E.cond["bio_black_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Black")), description = ctx:expand_text(services.translate("Make your artificial hair black.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "bio_black_hair_dye" end end
        do local _en = (E.cond["bio_blond_hair_dye"] == nil or E.cond["bio_blond_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Blond")), description = ctx:expand_text(services.translate("Make your artificial hair blond.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "bio_blond_hair_dye" end end
        do local _en = (E.cond["bio_blue_hair_dye"] == nil or E.cond["bio_blue_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Blue")), description = ctx:expand_text(services.translate("Make your artificial hair blue.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "bio_blue_hair_dye" end end
        do local _en = (E.cond["bio_brown_hair_dye"] == nil or E.cond["bio_brown_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Brown")), description = ctx:expand_text(services.translate("Make your artificial hair brown.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "bio_brown_hair_dye" end end
        do local _en = (E.cond["bio_gray_hair_dye"] == nil or E.cond["bio_gray_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Gray")), description = ctx:expand_text(services.translate("Make your artificial hair gray.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "bio_gray_hair_dye" end end
        do local _en = (E.cond["bio_green_hair_dye"] == nil or E.cond["bio_green_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Green")), description = ctx:expand_text(services.translate("Make your artificial hair green.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "bio_green_hair_dye" end end
        do local _en = (E.cond["bio_red_hair_dye"] == nil or E.cond["bio_red_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Red")), description = ctx:expand_text(services.translate("Make your artificial hair red.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "bio_red_hair_dye" end end
        do local _en = (E.cond["bio_pink_hair_dye"] == nil or E.cond["bio_pink_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Pink")), description = ctx:expand_text(services.translate("Make your artificial hair pink.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "bio_pink_hair_dye" end end
        do local _en = (E.cond["bio_white_hair_dye"] == nil or E.cond["bio_white_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("White")), description = ctx:expand_text(services.translate("Make your artificial hair white.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "bio_white_hair_dye" end end
        do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Don't change anything.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_NONE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["bio_black_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "black" }, nil, nil)
    return true
    end
    EOC["bio_blond_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "blond" }, nil, nil)
    return true
    end
    EOC["bio_blue_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "blue" }, nil, nil)
    return true
    end
    EOC["bio_brown_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "brown" }, nil, nil)
    return true
    end
    EOC["bio_gray_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "gray" }, nil, nil)
    return true
    end
end
