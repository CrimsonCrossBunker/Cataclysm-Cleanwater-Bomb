local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_ELECTROKIN_ZAP_ENEMIES_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_ZAP_ENEMIES_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_zap_enemies"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_zap_enemies") * 80) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_zap_enemies") * 225) + 800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_ZAP_ENEMIES_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_MELEE_ATTACKS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_MELEE_ATTACKS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Lightning crackles between your fingers!")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_melee_attacks", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_melee_attacks") * 55) + 240) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_melee_attacks") * 90) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_MELEE_ATTACKS_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_MELEE_ATTACKS_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_MELEE_ATTACKS_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_melee_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_melee_attacks"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_melee_attacks") * 55) + 240) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_melee_attacks") * 90) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_MELEE_ATTACKS_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_HACKING_INTERFACE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_HACKING_INTERFACE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You now have the ability to hack into nearby electronics.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_HACKING_INTERFACE_SWITCHER", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_hacking_interface", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") + H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface_knack")) * 45) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") + H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface_knack")) * 90) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_HACKING_INTERFACE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE_REMOVE_ITEM", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_ELECTROKIN_HACKING_INTERFACE_SWITCHER"] = function(ctx)
    do
        local _sw33 = ((H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") + H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface_knack")) * H._jm_psionic_power_modifiers(ctx))
        if _sw33 == 0 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_1", 1, false, true, nil)
        elseif _sw33 == 4 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_2", 1, false, true, nil)
        elseif _sw33 == 8 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_3", 1, false, true, nil)
        elseif _sw33 == 12 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_4", 1, false, true, nil)
        elseif _sw33 == 16 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_5", 1, false, true, nil)
        elseif _sw33 == 20 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_6", 1, false, true, nil)
        elseif _sw33 == 24 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_7", 1, false, true, nil)
        elseif _sw33 == 28 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_8", 1, false, true, nil)
        elseif _sw33 == 32 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_9", 1, false, true, nil)
        elseif _sw33 == 36 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_10", 1, false, true, nil)
        elseif _sw33 == 40 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_11", 1, false, true, nil)
        elseif _sw33 == 44 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_12", 1, false, true, nil)
        end
    end
    return true
    end
    COND["EOC_ELECTROKIN_HACKING_INTERFACE_UPDATER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_HACKING_INTERFACE_UPDATER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE_REMOVE_ITEM", ctx, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_HACKING_INTERFACE_SWITCHER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE_REMOVE_ITEM"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE_REMOVE_ITEM"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local g = H.safe_id('item', "electrokinetic_electrohack_1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_2"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_3"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_4"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_5"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_6"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_7"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_8"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_9"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_10"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_11"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_12"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_HACKING_INTERFACE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_HACKING_INTERFACE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "electrokinetic_hacking_interface", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "electrokinetic_hacking_interface_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") >= 1) then
            do local _a, _sp = H.u(ctx), "electrokinetic_hacking_interface"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "electrokinetic_hacking_interface_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") + H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface_knack")) * 45) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface") + H.char_spell_level(H.u(ctx), "electrokinetic_hacking_interface_knack")) * 90) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_HACKING_INTERFACE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_nether_attunement_electrokinetic_power_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_nether_attunement_electrokinetic_power_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_INITIATE_REAL", ctx, nil, nil, nil)
        return true
    else
        H.eoc_add_effect(H.u(ctx), "effect_no_nether_attunement_from_channel", 0, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("The power you channel vanishes into nothingness.")), "bad")
        return false
    end
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_INITIATE_REAL"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_INITIATE_REAL"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The hair on your body stands up on end.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_personal_battery", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_BEGIN", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 45) + 600) * H._jm_psionic_power_modifiers(ctx)), 14400)), math.floor(math.min((((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 90) + 1800) * H._jm_psionic_power_modifiers(ctx)), 14400)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_PERSONAL_BATTERY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_BEGIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_BEGIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((60 - ((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 2.5) * H._jm_psionic_power_modifiers(ctx))), 5)), math.floor(math.max((240 - ((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 5) * H._jm_psionic_power_modifiers(ctx))), 10)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_BEGIN"), nil) end end
        H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_power_count", (((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") / 5) + 1) * H._jm_psionic_power_modifiers(ctx)))
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT"] = function(ctx)
        return ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1)) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT"] = function(ctx)
    if ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1)) then
        H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_item_count", 0)
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_GET_ITEM_COUNT", ctx, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_AMMEND_ITEM_COUNT", ctx, nil, nil, nil)
        if (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_max_indv_power", math.floor((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") / H.var_num(H.u(ctx), "electrokin_personal_battery_item_count"))))
        else
            H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_max_indv_power", 0)
        end
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS_DISTRIBUTION"] = function(ctx)
        return ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1)) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS_DISTRIBUTION"] = function(ctx)
    if ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1)) then
        if (H.var_num(H.u(ctx), "electrokin_personal_battery_max_indv_power") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_power_count_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "electrokin_personal_battery_max_indv_power")))
        else
            H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_power_count_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "electrokin_personal_battery_power_count")))
        end
        H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_power_count_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "electrokin_personal_battery_max_indv_power")))
        H.set_bionic_power(H.npc(ctx), H.var_num(H.u(ctx), "electrokin_personal_battery_power_count_used"), "+=")
        H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_power_count", (H.var_num(H.u(ctx), "electrokin_personal_battery_power_count")) - (H.var_num(H.u(ctx), "electrokin_personal_battery_power_count_used")))
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS"] = function(ctx)
        return (((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1) and (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count") >= 1))) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS"] = function(ctx)
    if (((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1) and (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count") >= 1))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_POWER_ITEMS_DISTRIBUTION" }, {  })
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_GET_ITEM_COUNT_2"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_item_count", (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count")) + (1))
    return true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_GET_ITEM_COUNT"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_ELECTROKIN_PERSONAL_BATTERY_GET_ITEM_COUNT_2" }, {  })
    return true
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_AMMEND_ITEM_COUNT"] = function(ctx)
        return (((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1) and (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count") >= 1) and ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") / H.var_num(H.u(ctx), "electrokin_personal_battery_item_count")) < 1))) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_AMMEND_ITEM_COUNT"] = function(ctx)
    if (((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") >= 1) and (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count") >= 1) and ((H.var_num(H.u(ctx), "electrokin_personal_battery_power_count") / H.var_num(H.u(ctx), "electrokin_personal_battery_item_count")) < 1))) then
        H.set_var("actor", H.u(ctx), ctx, "electrokin_personal_battery_item_count", (H.var_num(H.u(ctx), "electrokin_personal_battery_item_count")) - (1))
        H.run_eoc("EOC_ELECTROKIN_PERSONAL_BATTERY_EFFECT_AMMEND_ITEM_COUNT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PERSONAL_BATTERY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_PERSONAL_BATTERY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_personal_battery"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 45) + 600) * H._jm_psionic_power_modifiers(ctx)), 14400)), math.floor(math.min((((H.char_spell_level(H.u(ctx), "electrokinetic_personal_battery") * 90) + 1800) * H._jm_psionic_power_modifiers(ctx)), 14400)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_PERSONAL_BATTERY_DRAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_REDUCE_PAIN_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_REDUCE_PAIN_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The aches and pains of post-Cataclysmic life fade, just a little.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_reduce_pain", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_reduce_pain") * 120) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_reduce_pain") * 280) + 1500) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_REDUCE_PAIN_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_REDUCE_PAIN", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_REDUCE_PAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_REDUCE_PAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_REDUCE_PAIN_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REDUCE_PAIN_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_reduce_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_reduce_pain"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_reduce_pain") * 120) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_reduce_pain") * 280) + 1500) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_REDUCE_PAIN_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_SPEED_BOOST_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_SPEED_BOOST_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You enhance the functioning of your neurons.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokinetic_speed_boost", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_speed_boost") * 18) + 81) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_speed_boost") * 57) + 286) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_SPEED_BOOST_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_SPEED_BOOST", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_SPEED_BOOST"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_SPEED_BOOST"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_SPEED_BOOST_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_SPEED_BOOST_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_speed_boost"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_speed_boost"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_speed_boost") * 18) + 81) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_speed_boost") * 57) + 286) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_SPEED_BOOST_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_LIGHTNING_AURA_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_LIGHTNING_AURA_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The air around you begins crackling with electricity!")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokinetic_lightning_aura", -1, nil, nil, nil)
        H.run_eoc("EOC_ELECTROKIN_LIGHTNING_AURA_EFFECTS", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_lightning_aura") * 15) + 60) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_lightning_aura") * 25) + 250) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_LIGHTNING_AURA_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_electrokinetic_lightning_aura_aftershock", 5, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_LIGHTNING_AURA_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_LIGHTNING_AURA_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 8)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "electrokinetic_lightning_aura"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_lightning_aura") * 15) + 60) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_lightning_aura") * 25) + 250) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_LIGHTNING_AURA_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_LIGHTNING_AURA_EFFECTS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_LIGHTNING_AURA_EFFECTS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_lightning_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "lightning_aura_nearby_target", nil, nil, { kind = "monster", id = H.safe_id("monster", "") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(math.min((((H.char_spell_level(H.u(ctx), "electrokinetic_lightning_aura") * 0.33) + 2) * H._jm_psionic_power_modifiers(ctx)), 10)) }, nil, false, true, {  }, {  })
        H.eoc_cast_spell(H.u(ctx), "electrokinetic_lightning_aura_attack_placeholder", false, { target = H.get_tripoint_var("global", nil, ctx, "lightning_aura_nearby_target") })
        H.eoc_cast_spell(H.u(ctx), "electrokinetic_lightning_aura_spark", false, nil)
        do local _t = math.max(1, math.floor(5)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_LIGHTNING_AURA_EFFECTS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PARALYSIS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_ELECTROKIN_PARALYSIS"] = function(ctx)
    if (ctx:has_speaker()) then
        if (not ((H.creature_has_effect(H.u(ctx), "effect_electrokinetic_speed_boost") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration")))) then
            H.set_var("actor", H.u(ctx), ctx, "paralysis_electrokin_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
            H.set_var("actor", H.u(ctx), ctx, "paralysis_electrokin_power_level", H.char_spell_level(H.npc(ctx), "electrokinetic_paralysis"))
            H.set_var("actor", H.u(ctx), ctx, "nether_attunement_paralysis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
            H.set_var("context", nil, ctx, "minimum_duration", math.min(((((H.var_num(H.u(ctx), "paralysis_electrokin_power_level") * 0.2) + 1) * H.var_num(H.u(ctx), "paralysis_electrokin_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_paralysis_scaling")), 5))
            H.set_var("context", nil, ctx, "maximum_duration", math.min(((((H.var_num(H.u(ctx), "paralysis_electrokin_power_level") * 0.35) + 3) * H.var_num(H.u(ctx), "paralysis_electrokin_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_paralysis_scaling")), 5))
            H.set_var("context", nil, ctx, "duration", services.random.native_float((ctx:get_number("minimum_duration") or 0), (ctx:get_number("maximum_duration") or 0)))
            H.eoc_add_effect(H.u(ctx), "downed", (ctx:get_number("duration") or 0), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "psi_dazed", (ctx:get_number("duration") or 0), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_electrokin_paralysis", (ctx:get_number("duration") or 0), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You overload the target's neurons!")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("You attempt to overload the target's neurons but nothing happens!")), "bad")
        end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_PAIN_IMMUNE_ON"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_pain_immune"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_PAIN_IMMUNE_ON"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokinetic_pain_immune"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.set_var("actor", H.u(ctx), ctx, "electrokin_pain_value", (((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0))
        local _a34 = H.u(ctx)
        if _a34 then services.characters.adjust(_a34, { pain = math.floor((0) - (H.char_pain(_a34))) }) end
        H.eoc_add_effect(H.u(ctx), "effect_electrokinetic_pain_immune", 3600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_pain_immune") + H.char_spell_level(H.u(ctx), "electrokinetic_pain_immune_knack")) * 8) + 60) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_pain_immune") + H.char_spell_level(H.u(ctx), "electrokinetic_pain_immune_knack")) * 13) + 150) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_PAIN_IMMUNE_OFF"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are already under the effects of Analgesic Block!")), "mixed")
        return false
    end
    end
    COND["EOC_ELECTROKIN_PAIN_IMMUNE_OFF"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokinetic_pain_immune"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_PAIN_IMMUNE_OFF"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokinetic_pain_immune"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_electrokinetic_pain_immune"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        local _a35 = H.u(ctx)
        if _a35 then services.characters.adjust(_a35, { pain = math.floor((H.var_num(H.u(ctx), "electrokin_pain_value") * 1.1)) }) end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_SPEED_BOOST_TARGET_CHECKER"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).avatar == true)) == true
    end
    EOC["EOC_ELECTROKIN_SPEED_BOOST_TARGET_CHECKER"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).avatar == true)) then
        H.run_eoc("EOC_ELECTROKIN_SPEED_BOOST_INITIATE", ctx, nil, nil, nil)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "speed_boost_electrokin_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "speed_boost_electrokin_power_level", H.char_spell_level(H.npc(ctx), "electrokinetic_speed_boost"))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_speed_boost_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.eoc_add_effect(H.u(ctx), "effect_electrokinetic_speed_boost_npc", services.random.native_float(((((H.var_num(H.u(ctx), "speed_boost_electrokin_power_level") * 9) + 40) * H.var_num(H.u(ctx), "speed_boost_electrokin_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_speed_boost_scaling")), ((((H.var_num(H.u(ctx), "speed_boost_electrokin_power_level") * 28) + 143) * H.var_num(H.u(ctx), "speed_boost_electrokin_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_speed_boost_scaling"))), nil, nil, nil)
        return false
    end
    end
    EOC["EOC_ELECTROKIN_ROBOT_INTERFACE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "electro_spawn_robot_interface", false, nil)
    H.run_eoc("EOC_ELECTROKIN_USE_ROBOT_INTERFACE", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_ELECTROKIN_USE_ROBOT_INTERFACE_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "ROBOTCONTROL", { target = _p }) end end
    return true
    end
    EOC["EOC_ELECTROKIN_USE_ROBOT_INTERFACE"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "electro_robot_interface" } }, { "EOC_ELECTROKIN_USE_ROBOT_INTERFACE_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_MOM_ABJURATION_STONE_SPELL_EFFECTS"] = function(ctx)
    if H.u(ctx) then services.characters.die(H.u(ctx), { remove_corpse = true, suppress_message = false }) end
    return true
    end
    COND["EOC_PHOTOKIN_LIGHT_LOCAL_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_LOCAL_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("A soft glow springs up around you.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_light_local", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_local") * 260) + 1560) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_local") * 870) + 3420) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_LOCAL_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_light_local"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_LIGHT_LOCAL_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_LOCAL_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_local"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 1)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_light_local"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_local") * 260) + 1560) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_local") * 870) + 3420) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_LOCAL_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_LIGHT_DODGE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_DODGE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You are surrounded by shifting illusions.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_dodge", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_dodge") * 13) + 28) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_dodge") * 27) + 125) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_DODGE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_DODGE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_LIGHT_DODGE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_LIGHT_DODGE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_dodge"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_LIGHT_DODGE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_DODGE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_light_dodge"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_dodge") * 13) + 28) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_dodge") * 27) + 125) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_DODGE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_RAD_IMMUNITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_RAD_IMMUNITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The air around you shimmers as an invisible barrier of light forms around you.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_photokin_light_barrier", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_rad_immunity") * 18) + 370) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_rad_immunity") * 182) + 810) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_RAD_IMMUNITY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_photokin_light_barrier"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_RAD_IMMUNITY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_RAD_IMMUNITY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_barrier"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_rad_immunity"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_rad_immunity") * 18) + 370) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_rad_immunity") * 182) + 810) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_RAD_IMMUNITY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_CAMOUFLAGE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_CAMOUFLAGE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You twist nearby light to help conceal you from distant observers.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_camouflage", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_camouflage") + H.char_spell_level(H.u(ctx), "photokinetic_camouflage_knack")) * 48) + 690) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_camouflage") + H.char_spell_level(H.u(ctx), "photokinetic_camouflage_knack")) * 113) + 1430) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_CAMOUFLAGE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_CAMOUFLAGE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_CAMOUFLAGE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_CAMOUFLAGE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_photokin_camouflage"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_1")
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_2")
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_3")
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_4")
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_5")
        H.lose_trait(H.u(ctx), "PHOTOKINETIC_CAMOUFLAGE_6")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_CAMOUFLAGE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_CAMOUFLAGE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_camouflage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "photokinetic_camouflage") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_camouflage", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_camouflage_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "photokinetic_camouflage") >= 1) then
            do local _a, _sp = H.u(ctx), "photokinetic_camouflage"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "photokinetic_camouflage_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_camouflage") + H.char_spell_level(H.u(ctx), "photokinetic_camouflage_knack")) * 48) + 690) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_camouflage") + H.char_spell_level(H.u(ctx), "photokinetic_camouflage_knack")) * 113) + 1430) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_CAMOUFLAGE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_HIDE_UGLY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_HIDE_UGLY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You shroud your true form behind unassuming illusions.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_PHOTOKIN_HIDE_UGLY_REMOVE_GODCO_VARS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_photokin_hide_ugly", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") + H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly_knack")) * 22) + 450) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") + H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly_knack")) * 55) + 890) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_HIDE_UGLY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_HIDE_UGLY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_HIDE_UGLY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_HIDE_UGLY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_01")
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_02")
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_03")
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_04")
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_05")
        H.lose_trait(H.u(ctx), "PHOTOKIN_HIDE_UGLY_06")
        H.run_eoc("EOC_PHOTOKIN_HIDE_UGLY_GRANT_GODCO_VARS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_HIDE_UGLY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_HIDE_UGLY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_hide_ugly"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_hide_ugly", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_hide_ugly_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") >= 1) then
            do local _a, _sp = H.u(ctx), "photokinetic_hide_ugly"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "photokinetic_hide_ugly_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") + H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly_knack")) * 22) + 450) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly") + H.char_spell_level(H.u(ctx), "photokinetic_hide_ugly_knack")) * 55) + 890) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_HIDE_UGLY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_RADIO_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_RADIO_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You attune your senses to passing radio waves.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokinetic_radio", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_spawn_item(H.u(ctx), "item_photokinetic_radio_on", 1, false, true, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_radio") + H.char_spell_level(H.u(ctx), "photokinetic_radio_knack")) * 126) + 1456) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_radio") + H.char_spell_level(H.u(ctx), "photokinetic_radio_knack")) * 772) + 5220) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_RADIO_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_RADIO", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_RADIO"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_RADIO"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local g = H.safe_id('item', "item_photokinetic_radio"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_photokinetic_radio_on"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_photokinetic_radio"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_RADIO_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_RADIO_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokinetic_radio"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "photokinetic_radio") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_radio", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "photokinetic_radio_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "photokinetic_radio") >= 1) then
            do local _a, _sp = H.u(ctx), "photokinetic_radio"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "photokinetic_radio_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_radio") + H.char_spell_level(H.u(ctx), "photokinetic_radio_knack")) * 126) + 1456) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "photokinetic_radio") + H.char_spell_level(H.u(ctx), "photokinetic_radio_knack")) * 772) + 5220) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_RADIO_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_INVISIBILITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_INVISIBILITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Suddenly, the world around you seems like it's on the other side of the surface of water.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_invisibility", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 6) + 16) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 23) + 42) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_INVISIBILITY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_INVISIBILITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_INVISIBILITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_INVISIBILITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_INVISIBILITY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_INVISIBILITY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_invisibility"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 6) + 16) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 23) + 42) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_INVISIBILITY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
end
