local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_CLAIR_REMOVE_BETTER_SENSES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_BETTER_SENSES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("The world now seems separated from you by a thin veil.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_better_senses"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_BETTER_SENSES_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_BETTER_SENSES_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 1)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "clair_better_senses") >= 1) then
            do local _a, _sp = H.u(ctx), "clair_better_senses"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "clair_better_senses_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "clair_better_senses") + H.char_spell_level(H.u(ctx), "clair_better_senses_knack")) * 215) + 595) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "clair_better_senses") + H.char_spell_level(H.u(ctx), "clair_better_senses_knack")) * 482) + 1264) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_BETTER_SENSES_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_NIGHT_EYES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_NIGHT_EYES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You open your senses to the world.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_night_eyes", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_night_vision") * 150) + 290) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_night_vision") * 270) + 980) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_NIGHT_EYES_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_NIGHT_EYES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_NIGHT_EYES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_NIGHT_EYES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_1"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_3"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_4"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_5"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_6"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_7"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes_8"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_night_eyes"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CLAIR_NIGHT_EYES_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_NIGHT_EYES_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_night_eyes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 1)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_night_vision"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_night_vision") * 150) + 290) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_night_vision") * 270) + 980) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_NIGHT_EYES_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_SPEED_READING_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_SPEED_READING_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You feel like sitting down with a good book.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_clair_speed_reader", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_speed_reading") * 372) + 7200) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_speed_reading") * 810) + 1400) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SPEED_READING_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_SPEED_READ", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_SPEED_READ"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_SPEED_READ"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("Your eyes ache a bit.  Maybe it's time to put the book down.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_speed_reader"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_SPEED_READING_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_SPEED_READING_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_speed_reader"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_speed_reading"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_speed_reading") * 372) + 720) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_speed_reading") * 810) + 1400) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SPEED_READING_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_SEE_AURAS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_SEE_AURAS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Swirling colors coalesce around others' bodies")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_see_auras", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_see_auras") * 90) + 650) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_see_auras") * 190) + 1130) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SEE_AURAS_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_SEE_AURAS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_SEE_AURAS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_SEE_AURAS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_see_auras"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_SEE_AURAS_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_SEE_AURAS_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_see_auras"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_see_auras"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_see_auras") * 90) + 650) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_see_auras") * 190) + 1130) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SEE_AURAS_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_DANGER_SENSE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_DANGER_SENSE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You become preternaturally aware of possible dangers.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_premonition", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 303) + 1174) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 1002) + 2232) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_DANGER_SENSE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_DANGER_SENSE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_DANGER_SENSE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_DANGER_SENSE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_premonition"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_DANGER_SENSE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_DANGER_SENSE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1) then
            do local _a, _sp = H.u(ctx), "clair_danger_sense"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "clair_danger_sense_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 303) + 1174) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 1002) + 2232) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_DANGER_SENSE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_RANGED_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_RANGED_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Distances seem to narrow and your enemies' movements seem to slow as their vulnerabilities are laid bare.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_ranged_enhance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_ranged_enhance") * 8) + 210) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_ranged_enhance") * 25) + 640) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_RANGED_ENHANCE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_RANGED_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_RANGED_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_RANGED_ENHANCE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_RANGED_ENHANCE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_ranged_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_ranged_enhance") * 8) + 210) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_ranged_enhance") * 25) + 640) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_RANGED_ENHANCE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_SENSE_HOSTILE_CREATURES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_SENSE_HOSTILE_CREATURES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You open your senses to the dangers of the world.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_sense_hostile_creatures", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 45) + 120) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 75) + 490) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SENSE_HOSTILE_CREATURES_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_SENSE_HOSTILE_CREATURES_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_SENSE_HOSTILE_CREATURES_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_sense_hostile_creatures"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 45) + 120) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 75) + 490) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_SENSE_HOSTILE_CREATURES_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_DODGE_POWER_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_DODGE_POWER_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You can see a premonition of your enemies' attacks like a ghostly image.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_dodge", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_dodge_power") * 9) + 120) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_dodge_power") * 17) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_DODGE_POWER_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_DODGE_POWER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_DODGE_POWER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_DODGE_POWER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_dodge"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_DODGE_POWER_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_DODGE_POWER_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_dodge_power"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_dodge_power") * 9) + 120) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_dodge_power") * 17) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_DODGE_POWER_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_CRAFT_BONUS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_CRAFT_BONUS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You can see how it all fits together, and how it *should* fit together.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_CLAIR_CRAFT_BONUS_SWITCHER", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_craft_bonus", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_craft_bonus") * 250) + 1215) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_craft_bonus") * 600) + 2700) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_CRAFT_BONUS_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_CLAIR_CRAFT_BONUS_SWITCHER"] = function(ctx)
    do
        local _sw26 = H.char_spell_level(H.u(ctx), "clair_craft_bonus")
        if _sw26 == 0 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_01"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw26 == 4 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_02"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw26 == 8 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_03"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw26 == 12 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_04"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw26 == 16 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_05"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw26 == 20 then
            do local _g = H.safe_id('mutation', "CLAIR_CRAFT_BONUS_06"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        end
    end
    return true
    end
    COND["EOC_CLAIR_REMOVE_CRAFT_BONUS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_CRAFT_BONUS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_craft_bonus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_clair_craft_bonus_blindness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_01")
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_02")
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_03")
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_04")
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_05")
        H.lose_trait(H.u(ctx), "CLAIR_CRAFT_BONUS_06")
        return true
    end
    return false
    end
    COND["EOC_CLAIR_CRAFT_BONUS_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_CRAFT_BONUS_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_craft_bonus"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_craft_bonus") * 250) + 1215) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_craft_bonus") * 600) + 2700) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_CRAFT_BONUS_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_CLEAR_SIGHT_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_CLEAR_SIGHT_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your senses sharpen and all distractions vanish.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_clear_sight", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_clear_sight") * 12) + 150) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_clear_sight") * 25) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_CLEAR_SIGHT_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_CLEAR_SIGHT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_CLEAR_SIGHT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_CLEAR_SIGHT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_clear_sight"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_CLEAR_SIGHT_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_CLEAR_SIGHT_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_clear_sight"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 8)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_clear_sight"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_clear_sight") * 12) + 150) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_clear_sight") * 25) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_CLEAR_SIGHT_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_CLAIR_GROUP_TACTICS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_GROUP_TACTICS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("As the visions overtake you, you start involuntarily calling out warnings to your allies.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_clair_group_tactics_self", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_group_tactics") * 9) + 60) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_group_tactics") * 23) + 180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_GROUP_TACTICS_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_GROUP_TACTICS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_REMOVE_GROUP_TACTICS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_REMOVE_GROUP_TACTICS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_GROUP_TACTICS_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_GROUP_TACTICS_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_group_tactics_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 9)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "clair_group_tactics"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "clair_group_tactics") * 9) + 60) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "clair_group_tactics") * 23) + 180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_GROUP_TACTICS_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_CLAIR_DISCERN_WEAKNESS"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "discern_weakness_clear_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
    H.set_var("actor", H.u(ctx), ctx, "discern_weakness_clear_power_level", H.char_spell_level(H.npc(ctx), "clair_spot_weakness"))
    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_discern_weakness_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
    H.eoc_add_effect(H.u(ctx), "effect_clair_weak_point", services.random.native_float(((((H.var_num(H.u(ctx), "discern_weakness_clear_power_level") * 1.5) + 13.5) * H.var_num(H.u(ctx), "discern_weakness_clear_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_discern_weakness_scaling")), ((((H.var_num(H.u(ctx), "discern_weakness_clear_power_level") * 2.5) + 30) * H.var_num(H.u(ctx), "discern_weakness_clear_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_discern_weakness_scaling"))), nil, nil, nil)
    return true
    end
    EOC["EOC_CLAIR_RAD_SENSE"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_CLAIR_RAD_SENSE_SELF"] == nil or E.cond["EOC_CLAIR_RAD_SENSE_SELF"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Check yourself")), description = ctx:expand_text(services.translate("Cast your subtle senses over yourself, seeing if you are contaminated with radiation.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_CLAIR_RAD_SENSE_SELF" end end
        do local _en = (E.cond["EOC_CLAIR_RAD_SENSE_OUTSIDE"] == nil or E.cond["EOC_CLAIR_RAD_SENSE_OUTSIDE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Check your surroundings")), description = ctx:expand_text(services.translate("Open your inner eye, searching your environment for dangerous radiation.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_CLAIR_RAD_SENSE_OUTSIDE" end end
        do local _en = (E.cond["EOC_MOM_NO_EFFECT"] == nil or E.cond["EOC_MOM_NO_EFFECT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Do nothing for now.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_MOM_NO_EFFECT" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "clair_sense_rads_self", false, nil)
    return true
    end
    EOC["EOC_CLAIR_RAD_SENSE_OUTSIDE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "clair_sense_rads_outside", false, nil)
    H.eoc_cast_spell(H.u(ctx), "clair_sense_rads_outside_spawn_item", false, nil)
    return true
    end
    COND["EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_sense_rads_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_sense_rads_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local g = H.safe_id('item', "clair_sense_rad_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.eoc_cast_spell(H.u(ctx), "clair_sense_rads_outside_spawn_item", false, nil)
        return true
    end
    return false
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT_3"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 51) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 100))) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT_3"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 51) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 100))) then
        services.messages.add(ctx:expand_text(services.translate("Turning your senses on yourself, you see a dull glow along your core.  Your radiation is climbing, though it's still not in the danger zone.")), "bad")
        return true
    else
        H.run_eoc("EOC_CLAIR_RAD_SENSE_SELF_REPORT_4", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT_2"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) > 0) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 50))) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT_2"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) > 0) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 50))) then
        services.messages.add(ctx:expand_text(services.translate("Turning your senses on yourself, you see a few dull glimmers, hidden deep in your flesh.  The damage is minimal for now, but you had best not let it fester.")), "mixed")
        return true
    else
        H.run_eoc("EOC_CLAIR_RAD_SENSE_SELF_REPORT_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT"] = function(ctx)
        return (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 0)) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT"] = function(ctx)
    if (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 0)) then
        services.messages.add(ctx:expand_text(services.translate("Turning your senses on yourself, you see none of the insidious glow typical of radiation.  You are in the clear, for now.")), "good")
        return true
    else
        H.run_eoc("EOC_CLAIR_RAD_SENSE_SELF_REPORT_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT_6"] = function(ctx)
        return (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 501)) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT_6"] = function(ctx)
    if (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 501)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Turning your senses on yourself, you see a steady glow all along your muscles and bones.  You are in real trouble if you don't deal with your radiation immediately.")))
        return true
    end
    return false
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT_5"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 201) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 500))) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT_5"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 201) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 500))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Turning your senses on yourself, you see a glow along your bones.  You had best seek treatment, and soon.")))
        return true
    else
        H.run_eoc("EOC_CLAIR_RAD_SENSE_SELF_REPORT_6", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CLAIR_RAD_SENSE_SELF_REPORT_4"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 101) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 200))) == true
    end
    EOC["EOC_CLAIR_RAD_SENSE_SELF_REPORT_4"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 101) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 200))) then
        services.messages.add(ctx:expand_text(services.translate("Turning your senses on yourself, you see a faint glow spreading outward from your core to your limbs.  You're getting closer to dangerous levels--you should deal with it before it gets worse.")), "bad")
        return true
    else
        H.run_eoc("EOC_CLAIR_RAD_SENSE_SELF_REPORT_5", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_CLAIR_EXAMINE_ITEM_DETECTION"] = function(ctx)
    H.set_var("context", nil, ctx, "artifact_resonance", (((H.char_snap(H.npc(ctx)) or {}).combat or {}).artifact_resonance or 0))
    H.set_var("context", nil, ctx, "resonance_modifier", math.min((H.char_spell_level(H.u(ctx), "clair_examine_item") + H.char_spell_level(H.u(ctx), "clair_examine_item_knack")), 10))
    H.set_var("context", nil, ctx, "resonance_modifier", ((10 - (ctx:get_number("resonance_modifier") or 0)) / 50))
    H.set_var("context", nil, ctx, "artifact_resonance", ((ctx:get_number("artifact_resonance") or 0) * services.random.native_float((1 - (ctx:get_number("resonance_modifier") or 0)), (1 + (ctx:get_number("resonance_modifier") or 0)))))
    if ((ctx:get_number("artifact_resonance") or 0) > 0) then
        services.messages.add(ctx:expand_text(services.translate("The strange object has an otherworldly resonance about it (about <color_light_cyan><context_val:artifact_resonance></color> resonance ).")), "neutral")
    end
    if H.char_has_flag(H.npc(ctx), "FIFTH_SUN_TECHNOLOGY") then
        services.messages.add(ctx:expand_text(services.translate("You have a sense of vast distances from this object, as though it came from a place you would never find on any map.  For a moment, you see an eagle stooping over a snake, wings flashing in the sun, and a vast shape moving through the void between the stars.")), "neutral")
    end
    return true
    end
    EOC["EOC_CLAIR_EXAMINE_ITEM_INITIATE"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", nil, nil, { "EOC_CLAIR_EXAMINE_ITEM_DETECTION" }, {  })
    return true
    end
    COND["EOC_CLAIR_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_CLAIR_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_clair_craft_bonus_blindness", 43200, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You close your eyes as the visions overtake you.")), "mixed")
        return true
    end
    return false
    end
    COND["EOC_CLAIR_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus_blindness"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_CLAIR_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_craft_bonus_blindness"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        do local _eg = H.safe_id('effect', "effect_clair_craft_bonus_blindness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You open your eyes as the visions fade.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_CLAIR_ASTRAL_PROJECTION_INITIATE"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).controlling_vehicle == true)))) == true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_INITIATE"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).controlling_vehicle == true)))) then
        H.run_eoc("EOC_CLAIR_ASTRAL_PROJECTION_INITIATE_POST_VEHICLE_CHECK", ctx, nil, nil, nil)
        return true
    else
        H.eoc_add_effect(H.u(ctx), "effect_no_nether_attunement_from_channel", 0, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Trying to send your spirit out of your body while driving is dangerous at best and suicidal at worst.  You had better not do it.")), "mixed")
        return false
    end
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_INITIATE_POST_VEHICLE_CHECK"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "clair_astral_projection_original_location", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.eoc_add_effect(H.u(ctx), "effect_clair_astral_projection", -1, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "incorporeal", -1, nil, nil, nil)
    services.messages.add(ctx:expand_text(services.translate("As you meditate, you feel your spirit slipping free from your body.")), "good")
    do local _g = H.safe_id('mutation', "CLAIR_ASTRAL_PROJECTION_APPEARANCE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    H.eoc_spawn_item(H.u(ctx), "body_astral_projection", 1, false, false, nil)
    H.eoc_spawn_item(H.u(ctx), "item_clair_astral_projection_cord", 1, false, true, nil)
    local _a27 = H.u(ctx)
    local _sn28 = "clair_astral_projection_return"
    local _sg29 = (_sn28 ~= "") and H.safe_id("spell", _sn28) or nil
    if _a27 and _sg29 then services.spells.set_level(_a27, _sg29, math.floor(0)) end
    return true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_DEACTIVATE_REMOVE_BODY"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_DEACTIVATE"] = function(ctx)
    do local g = H.safe_id('item', "item_clair_astral_projection_cord"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local _eg = H.safe_id('effect', "effect_clair_astral_projection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "incorporeal"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    H.lose_trait(H.u(ctx), "CLAIR_ASTRAL_PROJECTION_APPEARANCE")
    local _a30 = H.u(ctx)
    local _sn31 = "clair_astral_projection_return"
    local _sg32 = (_sn31 ~= "") and H.safe_id("spell", _sn31) or nil
    if _a30 and _sg32 then services.spells.set_level(_a30, _sg32, math.floor((-1))) end
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "clair_astral_projection_original_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 0, nil, { { id = "body_astral_projection" } }, { "EOC_CLAIR_ASTRAL_PROJECTION_DEACTIVATE_REMOVE_BODY" })
    return true
    end
    COND["EOC_CLAIR_ASTRAL_PROJECTION_MOVEMENT_STAMINA"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_MOVEMENT_STAMINA"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_char_val_extra(H.u(ctx), "stamina", math.max((75 - (H.char_spell_level(H.u(ctx), "clair_astral_projection") * 3)), 25), "-=")
        return true
    end
    return false
    end
    COND["EOC_CLAIR_ASTRAL_PROJECTION_NO_STAMINA_RETURN"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "winded"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) == 0)))) == true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_NO_STAMINA_RETURN"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "winded"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) == 0)))) then
        H.run_eoc("EOC_CLAIR_ASTRAL_PROJECTION_DEACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CLAIR_ASTRAL_PROJECTION_CANT_DO_THAT"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_CLAIR_ASTRAL_PROJECTION_CANT_DO_THAT"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_clair_astral_projection"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_LOCKPICK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REPAIR_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MEND_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_REPAIR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_RELOAD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIRSTAID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MILK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HACKSAW") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BOLTCUTTING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAIRCUT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_EBOOKSAVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TIDY_UP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_DECONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_FOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_VEHICLE_UNFOLD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_UNRACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BIKERACK_RACKING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_DIS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CHOP_TREES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MINE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_CONSTRUCTION") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_MOP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_READ") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FISH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GENERIC_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_GAME") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISASSEMBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MULTIPLE_FARM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HARVEST") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FIELD_DRESS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SKIN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_QUARTER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DISSECT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_LONGSALVAGE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BUILD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKAXE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HAND_CRANK") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AUTODRIVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FERTILIZE_PLOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_MOVE_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_UNLOAD_LOOT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_INSERT_ITEM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_FIRE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OPEN_GATE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FILL_LIQUID") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SHEARING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_HOTWIRE_CAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_AIM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_ATM") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_START_ENGINES") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_OXYTORCH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TOOLMOD_ADD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CLEAR_RUBBLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WASH") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PRYING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_LOGS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHOP_PLANKS") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_JACKHAMMER") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CHURN") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PLANT_SEED") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WEAR") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_PICKUP") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_WIELD") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_BINDER_COPY_RECIPE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_DATA_HANDLING") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_FURNITURE_MOVE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_PLACE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_TENT_DECONSTRUCT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_REEL_CABLE") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_SALINE_INFUSE") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        services.messages.add(ctx:expand_text(services.translate("You can't perform that activity while astrally projecting.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_SEE_ELECTRICITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_SEE_ELECTRICITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You open your senses to the flow of current.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_see_electricity", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") + H.char_spell_level(H.u(ctx), "electrokinetic_see_electric_knack")) * 150) + 900) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") + H.char_spell_level(H.u(ctx), "electrokinetic_see_electric_knack")) * 300) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_SEE_ELECTRICITY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_ELECTROKIN_SEE_ELECTRICITY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_SEE_ELECTRICITY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "electrokinetic_see_electric", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "electrokinetic_see_electric_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") >= 1) then
            do local _a, _sp = H.u(ctx), "electrokinetic_see_electric"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "electrokinetic_see_electric_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") + H.char_spell_level(H.u(ctx), "electrokinetic_see_electric_knack")) * 150) + 900) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "electrokinetic_see_electric") + H.char_spell_level(H.u(ctx), "electrokinetic_see_electric_knack")) * 300) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_SEE_ELECTRICITY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_ELECTROKIN_ZAP_ENEMIES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTROKIN_ZAP_ENEMIES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your skin tingles.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_zap_enemies", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_zap_enemies") * 80) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "electrokinetic_zap_enemies") * 225) + 800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTROKIN_ZAP_ENEMIES_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_electrokin_zap_enemies"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
end
