local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_02_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_02"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_bandages_02" } }, { "EOC_VITAKIN_STOP_BLEEDING_ITEM_02_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_03_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_03"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_bandages_03" } }, { "EOC_VITAKIN_STOP_BLEEDING_ITEM_03_ACTIVATE" }, {  })
    return true
    end
    COND["EOC_VITAKIN_SLEEP"] = function(ctx)
        return (((((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.char_val_extra(H.u(ctx), "sleep_deprivation")) >= 0))) == true
    end
    EOC["EOC_VITAKIN_SLEEP"] = function(ctx)
    if (((((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.char_val_extra(H.u(ctx), "sleep_deprivation")) >= 0))) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_WAKEFUL_REST_MEDITATE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(30600)))) end end
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_wakeful_resting", 30600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((1800 - (H.char_spell_level(H.u(ctx), "vita_sleeping_trance") * 25))), math.floor((3600 - (H.char_spell_level(H.u(ctx), "vita_sleeping_trance") * 50))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SLEEP_EXPERIENCE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You're feeling refreshed and have no need to meditate.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_SLEEP_EXPERIENCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_wakeful_resting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_SLEEP_EXPERIENCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_wakeful_resting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_val_extra(H.u(ctx), "focus") >= 25) then
            H.set_char_val_extra(H.u(ctx), "focus", (services.random.native_int(0, H.round_half_away(10)) + 5), "-=")
        end
        do local _a, _sp = H.u(ctx), "vita_sleeping_trance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((1800 - (H.char_spell_level(H.u(ctx), "vita_sleeping_trance") * 25))), math.floor((3600 - (H.char_spell_level(H.u(ctx), "vita_sleeping_trance") * 50))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SLEEP_EXPERIENCE"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_VITAKIN_HEALING_TRANCE"] = function(ctx)
    do local _g = H.safe_id('activity', "ACT_VITAKIN_HEALING_TRANCE_MEDITATE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(144000)))) end end
    H.eoc_add_effect(H.u(ctx), "effect_vitakin_healing_trance", 144000, nil, nil, nil)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor((180 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 12))), math.floor((900 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 48))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_ONGOING_KAL_COSTS"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor((120 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 2))), math.floor((300 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 5))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_ONGOING_NETHER_ATTUNEMENT"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor((900 - (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 12))), math.floor((1800 - (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 25))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_EXPERIENCE"), nil) end end
    return true
    end
    COND["EOC_VITAKIN_HEALING_TRANCE_ONGOING_KAL_COSTS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_HEALING_TRANCE_ONGOING_KAL_COSTS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((120 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 12))), math.floor((300 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 48))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_ONGOING_KAL_COSTS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALING_TRANCE_ONGOING_NETHER_ATTUNEMENT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_HEALING_TRANCE_ONGOING_NETHER_ATTUNEMENT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(4)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((120 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 2))), math.floor((300 + (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 5))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_ONGOING_NETHER_ATTUNEMENT"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALING_TRANCE_EXPERIENCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_HEALING_TRANCE_EXPERIENCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_healing_trance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_val_extra(H.u(ctx), "focus") >= 25) then
            H.set_char_val_extra(H.u(ctx), "focus", (services.random.native_int(0, H.round_half_away(10)) + 5), "-=")
        end
        do local _a, _sp = H.u(ctx), "vita_healing_trance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((900 - (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 12))), math.floor((1800 - (H.char_spell_level(H.u(ctx), "vita_healing_trance") * 25))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALING_TRANCE_EXPERIENCE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CURE_DISEASE_CHECKS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_CHECKS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_VITAKIN_CURE_DISEASE_VS_COMMON_COLD", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_CURE_DISEASE_VS_FLU", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_CURE_DISEASE_VS_HAY_FEVER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((600 - ((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 5)), 1)), math.floor(math.max((3600 - ((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 30)), 1)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CURE_DISEASE_CHECKS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CURE_DISEASE_VS_COMMON_COLD"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")))), (100)))) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_VS_COMMON_COLD"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_common_cold_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CURE_DISEASE_VS_FLU"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")))), (100)))) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_VS_FLU"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_flu_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CURE_DISEASE_VS_HAY_FEVER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_VS_HAY_FEVER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("Your eyes burn and your nose is clogged with mucus.")), "bad")
        H.eoc_add_effect(H.u(ctx), "severe_hay_fever", (services.random.native_int(0, H.round_half_away(28800)) + 600), nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_SWITCH"] = function(ctx)
    do
        local _sw53 = H.char_spell_level(H.u(ctx), "vita_stop_infection")
        if _sw53 == 0 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_infection_01", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_INFECTION_ITEM_01", ctx, nil, nil, nil)
        elseif _sw53 == 6 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_infection_02", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_INFECTION_ITEM_02", ctx, nil, nil, nil)
        elseif _sw53 == 12 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_infection_03", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_INFECTION_ITEM_03", ctx, nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_01_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_01"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_disinfectant_01" } }, { "EOC_VITAKIN_STOP_INFECTION_ITEM_01_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_02_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_02"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_disinfectant_02" } }, { "EOC_VITAKIN_STOP_INFECTION_ITEM_02_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_03_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_INFECTION_ITEM_03"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_disinfectant_03" } }, { "EOC_VITAKIN_STOP_INFECTION_ITEM_03_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_VITAKIN_BLOOD_PURGE"] = function(ctx)
    H.run_eoc("EOC_VITAKIN_MUTAGEN_PURGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_DRUG_PURGE", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_VITAKIN_DRUG_PURGE"] = function(ctx)
    do local _a, _v = H.u(ctx), "vit_betablocker"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "vit_bloodthinner"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "vit_ibuprofen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "vit_mme"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "ethanol"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "BAC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    EOC["EOC_VITAKIN_MUTAGEN_PURGE"] = function(ctx)
    do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_alpha"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_batrachian"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_beast"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_bird"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_cattle"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_cephalopod"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_chelator"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_chimera"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_crustacean"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_elfa"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_feline"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_fish"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_gastropod"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_insect"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_lizard"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_lupine"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_medical"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_mouse"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_plant"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_rabbit"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_raptor"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_rat"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_slime"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_spider"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_troglobite"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_ursine"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagenic_slurry"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutant_toxin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "mutagen_crustacean"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    COND["EOC_VITAKIN_RAD_PURGE_4"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 60) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 124))) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE_4"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 60) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 124))) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 1800, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 1800, nil, 3, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_four", false, { hit_self = true })
        return true
    else
        H.run_eoc("EOC_VITAKIN_RAD_PURGE_5", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_RAD_PURGE_3"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 125) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 249))) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE_3"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 125) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 249))) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 3900, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 3900, nil, 4, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_five", false, { hit_self = true })
        return true
    else
        H.run_eoc("EOC_VITAKIN_RAD_PURGE_4", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_RAD_PURGE_2"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) > 250) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 499))) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE_2"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) > 250) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 499))) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 7500, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 7500, nil, 5, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_six", false, { hit_self = true })
        return true
    else
        H.run_eoc("EOC_VITAKIN_RAD_PURGE_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_RAD_PURGE"] = function(ctx)
        return (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 500)) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE"] = function(ctx)
    if (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 500)) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 15000, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 15000, nil, 6, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_seven", false, { hit_self = true })
        return true
    else
        H.run_eoc("EOC_VITAKIN_RAD_PURGE_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_RAD_PURGE_6"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 1) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 29))) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE_6"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 1) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 29))) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 420, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 420, nil, 1, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_two", false, { hit_self = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have no radiation in your body, and so no need to do anything.")), "good")
        return false
    end
    end
    COND["EOC_VITAKIN_RAD_PURGE_5"] = function(ctx)
        return ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 30) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 59))) == true
    end
    EOC["EOC_VITAKIN_RAD_PURGE_5"] = function(ctx)
    if ((((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 30) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) <= 59))) then
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads", 900, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_purge_rads_sideeffects", 900, nil, 2, nil)
        H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_three", false, { hit_self = true })
        return true
    else
        H.run_eoc("EOC_VITAKIN_RAD_PURGE_6", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_MINOR"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_MINOR"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Purge Minor Ailments")), description = ctx:expand_text(services.translate("Attempt to cure your minor illnesses.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_VITAKIN_BANISH_ILLNESS_MINOR" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_ASTHMA"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_ASTHMA"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Purge Asthma")), description = ctx:expand_text(services.translate("Attempt to cure your asthma.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_VITAKIN_BANISH_ILLNESS_ASTHMA" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Purge Chemical Imbalance")), description = ctx:expand_text(services.translate("Attempt to cure your chemical imbalance.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Purge Kaluptic Psychosis")), description = ctx:expand_text(services.translate("Attempt to cure your kaluptic psychosis.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_JITTERY"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_JITTERY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Purge Jitters")), description = ctx:expand_text(services.translate("Attempt to cure your jitters.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_VITAKIN_BANISH_ILLNESS_JITTERY" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_MOODSWINGS"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_MOODSWINGS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Purge Mood Swings")), description = ctx:expand_text(services.translate("Attempt to cure your mood swings.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_VITAKIN_BANISH_ILLNESS_MOODSWINGS" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_WEAKENING"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_WEAKENING"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Purge Wasting Sickness")), description = ctx:expand_text(services.translate("Attempt to cure your weakening sickness.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_VITAKIN_BANISH_ILLNESS_WEAKENING" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Purge Narcolepsy")), description = ctx:expand_text(services.translate("Attempt to cure your narcolepsy.  This meditation is extremely intensive, and is correspondingly more draining.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "EOC_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Purge Seasonal Allergies")), description = ctx:expand_text(services.translate("Attempt to cure your seasonal allergies.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Purge Seasonal Affective Disorder")), description = ctx:expand_text(services.translate("Attempt to cure your seasonal affective disorder.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE" end end
        do local _en = (E.cond["EOC_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM"] == nil or E.cond["EOC_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(11), label = ctx:expand_text(services.translate("Purge Strange Blood Disorder")), description = ctx:expand_text(services.translate("Attempt to cure your strange blood disorder.")), enabled = _en, hotkey = "A" }); _targets[tostring(11)] = "EOC_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM" end end
        do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(12), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Do nothing for now.")), enabled = _en, hotkey = "B" }); _targets[tostring(12)] = "EOC_NONE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_MINOR"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_MINOR"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_MINOR_AILMENT"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(7200)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You're not sick.  There is nothing to cure.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_ASTHMA"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ASTHMA") == 1) or ((function() local eg = H.safe_id('effect', "effect_asthma_disease_absorbed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_ASTHMA"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ASTHMA") == 1) or ((function() local eg = H.safe_id('effect', "effect_asthma_disease_absorbed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_ASTHMA"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(21600)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have asthma.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "CHEMIMBALANCE") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "CHEMIMBALANCE") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have a chemical imbalance.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(36000)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have kaluptic psychosis.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_JITTERY"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "JITTERY") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_JITTERY"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "JITTERY") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_JITTERY"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(18000)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have muscle jitters.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_MOODSWINGS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MOODSWINGS") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_MOODSWINGS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MOODSWINGS") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_MOODSWINGS"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(25200)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have mood swings.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_WEAKENING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ROT1") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_WEAKENING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ROT1") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_WEAKENING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have a weakening sickness.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NARCOLEPTIC") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NARCOLEPTIC") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(7200)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have narcolepsy.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(24000)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have seasonal allergies.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1)) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(33000)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have seasonal affective disorder.  There is no need to attempt to cure it.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_SUPER_HEAL_RUN_HEALING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_SUPER_HEAL_RUN_HEALING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_VITAKIN_SUPER_HEAL_EFFECTS", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITA_SUPER_HEAL_DRAIN", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((20 - math.min(((H.char_spell_level(H.u(ctx), "vita_super_heal") * 0.5) * H._jm_psionic_power_modifiers(ctx)), 17))), math.floor((35 - math.min(((H.char_spell_level(H.u(ctx), "vita_super_heal") * 0.5) * H._jm_psionic_power_modifiers(ctx)), 28))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SUPER_HEAL_RUN_HEALING"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_VITAKIN_SUPER_HEAL_EFFECTS"] = function(ctx)
    if (H.char_vitamin(H.u(ctx), "redcells") < 0) then
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 150; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "redcells") < (-1000)) then
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "redcells") < (-10000)) then
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "blood") < 0) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 150; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "blood") < (-1000)) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "blood") < (-10000)) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if ((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) or (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) or (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) or (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) or (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) or (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true))) then
        do
            local _arr = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }
            for _, _v in ipairs(_arr) do
                H.set_var("context", nil, ctx, "id", _v)
                if (H.char_hp(H.u(ctx), H.var_str("context", nil, ctx, "id", ""), false) < H.char_hp(H.u(ctx), H.var_str("context", nil, ctx, "id", ""), true)) then
                    H.set_char_hp(H.u(ctx), H.var_str("context", nil, ctx, "id", ""), math.max((1 * H._jm_psionic_power_modifiers(ctx)), 1), "+=")
                end
            end
        end
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
    EOC["EOC_VITA_SUPER_HEAL_DRAIN"] = function(ctx)
    do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float(150, 650) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float(150, 650); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
    do local _a, _v = H.u(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(50, 200); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(100, 200); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(20, 60); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    H.set_char_val_extra(H.u(ctx), "sleepiness", services.random.native_float(2, 10), "+=")
    return true
    end
    COND["EOC_VITAKIN_DEGENERATING_TOUCH_2"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))))))) == true
    end
    EOC["EOC_VITAKIN_DEGENERATING_TOUCH_2"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))))))) then
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_power_level", H.char_spell_level(H.npc(ctx), "vita_degenerating_touch"))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_vitakinesis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_min_possible_damage", ((((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 17) + 25) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_damage", ((((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 32) + 55) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_monster_damage", services.random.native_float(H.var_num(H.u(ctx), "vitakinesis_degen_min_possible_damage"), H.var_num(H.u(ctx), "vitakinesis_degen_max_possible_damage")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_damage", ((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 25) + 30))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_min_possible_duration", math.max((30 - ((H.var_num(H.u(ctx), "vitakinesis_degen_power_level") * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling"))), 15))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_duration", math.max((75 - (((H.var_num(H.u(ctx), "vitakinesis_degen_power_level") * 2) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling"))), 15))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_duration", services.random.native_float(H.var_num(H.u(ctx), "vitakinesis_degen_min_possible_duration"), H.var_num(H.u(ctx), "vitakinesis_degen_max_possible_duration")))
        H.eoc_cast_spell(H.u(ctx), "vita_degenerating_touch_self_monster", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("Your target's flesh begins decaying before your eyes!")), "bad")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your target has no biology to affect!")), "bad")
        return false
    end
    end
    COND["EOC_VITAKIN_DEGENERATING_TOUCH"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_VITAKIN_DEGENERATING_TOUCH"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_power_level", H.char_spell_level(H.npc(ctx), "vita_degenerating_touch"))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_vitakinesis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_min_possible_damage", ((((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 17) + 25) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_damage", ((((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 32) + 55) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_limb_damage", services.random.native_float(H.var_num(H.u(ctx), "vitakinesis_degen_min_possible_damage"), H.var_num(H.u(ctx), "vitakinesis_degen_max_possible_damage")))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_limb_damage", ((H.char_spell_level(H.npc(ctx), "vita_degenerating_touch") * 25) + 30))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_min_possible_duration", math.max((30 - ((H.var_num(H.u(ctx), "vitakinesis_degen_power_level") * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling"))), 15))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_max_possible_duration", math.max((75 - (((H.var_num(H.u(ctx), "vitakinesis_degen_power_level") * 2) * H.var_num(H.u(ctx), "vitakinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_vitakinesis_scaling"))), 15))
        H.set_var("actor", H.u(ctx), ctx, "vitakinesis_degen_duration", services.random.native_float(H.var_num(H.u(ctx), "vitakinesis_degen_min_possible_duration"), H.var_num(H.u(ctx), "vitakinesis_degen_max_possible_duration")))
        H.eoc_cast_spell(H.u(ctx), "vita_degenerating_touch_self_character", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("Your target's flesh begins decaying before your eyes!")), "bad")
        return true
    else
        H.run_eoc("EOC_VITAKIN_DEGENERATING_TOUCH_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKINESIS_RETURN_FROM_DEATH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKINESIS_RETURN_FROM_DEATH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As the wounds overtake you, you feel your powers go into overdrive.")))
        H.run_eoc("EOC_VITAKINESIS_RETURN_FROM_DEATH_START", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_RETURN_FROM_DEATH_RUN_HEALING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_super_heal_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_RETURN_FROM_DEATH_RUN_HEALING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_super_heal_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_VITAKIN_SUPER_HEAL_EFFECTS", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITA_SUPER_HEAL_DRAIN", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITA_SUPER_HEAL_DRAIN", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITA_SUPER_HEAL_DRAIN", ctx, nil, nil, nil)
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(10)) + 2); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(1), math.floor((3 - math.min(((H.char_spell_level(H.u(ctx), "vita_return_from_death") / 25) * H._jm_psionic_power_modifiers(ctx)), 2))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_RETURN_FROM_DEATH_RUN_HEALING"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKINESIS_RETURN_FROM_DEATH_DAMAGE_TRACKER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKINESIS_RETURN_FROM_DEATH_DAMAGE_TRACKER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_hp(H.u(ctx), "torso", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_torso", H.char_hp(H.u(ctx), "torso", false))
        end
        if (H.char_hp(H.u(ctx), "head", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_head", H.char_hp(H.u(ctx), "head", false))
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_arm_l", H.char_hp(H.u(ctx), "arm_l", false))
        end
        if (H.char_hp(H.u(ctx), "arm_r", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_arm_r", H.char_hp(H.u(ctx), "arm_r", false))
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_leg_l", H.char_hp(H.u(ctx), "leg_l", false))
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "vitakinesis_return_from_death_hp_leg_r", H.char_hp(H.u(ctx), "leg_r", false))
        end
        return true
    end
    return false
    end
    COND["EOC_VITAKINESIS_RETURN_FROM_DEATH_START"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKINESIS_RETURN_FROM_DEATH_START"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor((H.var_num(H.u(ctx), "vitakin_return_from_death_kcal") * 0.8) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (H.var_num(H.u(ctx), "vitakin_return_from_death_kcal") * 0.8); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        H.set_char_hp(H.u(ctx), "ALL_MINOR", 999, "=")
        H.set_char_hp(H.u(ctx), "torso", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_torso"), 10), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_head"), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_arm_l"), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_arm_r"), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_leg_l"), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.var_num(H.u(ctx), "vitakinesis_return_from_death_hp_leg_r"), 10), "=")
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "bad_food"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "onfire"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "downed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "sap"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "staggered_character"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "nausea"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "deaf"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vita_return_from_death"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_vita_super_heal_return_from_death", 20, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((2 - math.min(((H.char_spell_level(H.u(ctx), "vita_return_from_death") / 25) * H._jm_psionic_power_modifiers(ctx)), 1))), math.floor((3 - math.min(((H.char_spell_level(H.u(ctx), "vita_return_from_death") / 25) * H._jm_psionic_power_modifiers(ctx)), 2))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_RETURN_FROM_DEATH_RUN_HEALING"), nil) end end
        H.eoc_add_effect(H.u(ctx), "effect_vita_super_heal_pain_allayed", 300, nil, nil, nil)
        return true
    end
    return false
    end
end
