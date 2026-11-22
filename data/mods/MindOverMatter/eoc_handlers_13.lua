local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_TELEPORT_RELOCATION_SELECT_05"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_05"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_5") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_05" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_05" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_06"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_6"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_06"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_06"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_06"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_6") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_06" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_06" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_07"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_7"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_07"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_07"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_07"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_7") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_07" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_07" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_08"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_8"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_08"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_08"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_08"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_8") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_08" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_08" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_09"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_9"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_09"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_09"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_09"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_9") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_09" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_09" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_10"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_10"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    services.messages.add(ctx:expand_text(services.translate("The items in your hands vanish with a faint pop sound.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_10"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The items in your hands flicker and appear to shrink before returning to normal.  Nothing else happens.")), "neutral")
    return true
    end
    COND["EOC_TELEPORT_RELOCATION_SELECT_10"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_RELOCATION_SELECT_10"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_10") and 1 or 0))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_relocation") * 10000) + 10000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_RELOCATION_TELEPORT_10" }, { "EOC_TELEPORT_RELOCATION_TELEPORT_FAIL_10" })
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_SUMMON"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_NETHER_BREACH"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(1, 3)), min_radius = math.floor(2), max_radius = math.floor(6) }); 
    end end
    return true
    end
    EOC["EOC_REALITY_TEAR_CHECKER"] = function(ctx)
    H.set_var("context", nil, ctx, "reality_tear_adjustment", 0)
    if H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx) then
        H.set_var("context", nil, ctx, "reality_tear_adjustment", ((ctx:get_number("reality_tear_adjustment") or 0)) + (20))
    end
    if H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx) then
        H.set_var("context", nil, ctx, "reality_tear_adjustment", ((ctx:get_number("reality_tear_adjustment") or 0)) + (10))
    end
    if H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) then
        H.set_var("context", nil, ctx, "reality_tear_adjustment", ((ctx:get_number("reality_tear_adjustment") or 0)) + (5))
    end
    services.messages.add(ctx:expand_text(services.translate("Your adjusted chance is <context_val:reality_tear_adjustment>.")), "debug")
    if services.random.native_probability((((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 25) + (ctx:get_number("reality_tear_adjustment") or 0))), (100)) then
        H.eoc_cast_spell(H.u(ctx), "teleport_reality_tear_permanent", false, { targeted = true, min_level = math.floor(H.char_spell_level(H.u(ctx), "teleport_reality_tear")) })
    else
        H.eoc_cast_spell(H.u(ctx), "teleport_reality_tear_temporary", false, { targeted = true, min_level = math.floor(H.char_spell_level(H.u(ctx), "teleport_reality_tear")) })
    end
    return true
    end
    COND["EOC_TELEPORT_LOCI_TECHNIQUE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_LOCI_TECHNIQUE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK")))) then
            H.run_eoc("EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER", ctx, nil, nil, nil)
            H.set_var("context", nil, ctx, "teleport_loci_technique_limit", (((H.char_spell_level(H.u(ctx), "teleport_loci_technique") * 5000) + 8000) * H._jm_psionic_power_modifiers(ctx)))
            services.messages.add(ctx:expand_text(services.translate("Your Loci Technique volume limit is <context_val:teleport_loci_technique_limit>.")), "debug")
            if (H.var_num(H.u(ctx), "teleport_total_carried_volume") <= (ctx:get_number("teleport_loci_technique_limit") or 0)) then
                do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "teleporter_loci_establishment_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            else
                H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
            end
        else
            services.messages.add(ctx:expand_text(services.translate("You feel a strange, inward force.")), "bad")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are currently not concentrating on [Ψ]Loci Establishment!")), "neutral")
        return false
    end
    end
    COND["EOC_VITAKIN_SLOW_BLEEDING_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_SLOW_BLEEDING_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a warmth throughout your entire body.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_slow_bleeding", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_slow_bleeding") * 18) + 290) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_slow_bleeding") * 163) + 1174) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SLOW_BLEEDING_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_SLOW_BLEEDING", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_SLOW_BLEEDING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_SLOW_BLEEDING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vitakin_slow_bleeding_01"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vitakin_slow_bleeding_02"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vitakin_slow_bleeding_03"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_SLOW_BLEEDING_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_SLOW_BLEEDING_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_slow_bleeding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 1)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "vita_slow_bleeding"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_slow_bleeding") * 18) + 290) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_slow_bleeding") * 163) + 1174) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SLOW_BLEEDING_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_HEALTH_POWER_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your skin prickles and you feel like you're bursting with energy.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_health", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_health_power") + H.char_spell_level(H.u(ctx), "vita_health_power_knack")) * 21) + 354) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_health_power") + H.char_spell_level(H.u(ctx), "vita_health_power_knack")) * 298) + 1550) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALTH_POWER_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_HEALTH_POWER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_HEALTH_POWER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_HEALTH_POWER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_vita_health"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "vita_health_power") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "vita_health_power", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "vita_health_power_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "vita_health_power") >= 1) then
            do local _a, _sp = H.u(ctx), "vita_health_power"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "vita_health_power_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_health_power") + H.char_spell_level(H.u(ctx), "vita_health_power_knack")) * 21) + 354) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_health_power") + H.char_spell_level(H.u(ctx), "vita_health_power_knack")) * 298) + 1550) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_HEALTH_POWER_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your injuries itch.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_CONCENTRATED_HEALING_SELECTOR", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_REMOVE_HEALTH_POWER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 73) + 463) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 284) + 1034) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CONCENTRATED_HEALING_DRAIN"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((3600 - (((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 60) * H._jm_psionic_power_modifiers(ctx)))), math.floor((3600 - (((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 60) * H._jm_psionic_power_modifiers(ctx)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_ARM"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Left Arm")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the left arm.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_ARM" end end
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_ARM"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Right Arm")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the right arm.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_ARM" end end
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_HEAD"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_HEAD"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Head")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the head.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_VITAKIN_CONCENTRATED_HEALING_HEAD" end end
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_LEG"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Left Leg")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the left leg.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_LEG" end end
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_LEG"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Right Leg")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the right leg.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_LEG" end end
        do local _en = (E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_TORSO"] == nil or E.cond["EOC_VITAKIN_CONCENTRATED_HEALING_TORSO"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Torso")), description = ctx:expand_text(services.translate("Concentrate healing wounds on the torso.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_VITAKIN_CONCENTRATED_HEALING_TORSO" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Choose body part.")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_ARM"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_ARM"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "head", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_l", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "arm_l")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "arm_l", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_ARM"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_ARM"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "head", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_l", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "arm_r")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "arm_r", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_TORSO"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_TORSO"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "head", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_l", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "torso")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "torso", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_LEG"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_RIGHT_LEG"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "head", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_l", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "leg_r")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "leg_r", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_LEG"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_LEFT_LEG"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "head", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_r", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "leg_l")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "leg_l", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_HEAD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_HEAD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "torso", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "arm_l", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_r", nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_penalty", -1, "leg_l", nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "head")
        H.eoc_add_effect(H.u(ctx), "effect_vita_concentrated_healing_bonus", -1, "head", ((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 1.5) + 2) * H._jm_psionic_power_modifiers(ctx)), nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vita_concentrated_healing_bonus"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_vita_concentrated_healing_penalty"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "vita_slow_bleeding"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 73) + 463) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") + H.char_spell_level(H.u(ctx), "vita_concentrated_healing_knack")) * 284) + 1034) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CONCENTRATED_HEALING_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_CURE_DISEASE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("No disease is going to keep you down.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_cure_disease", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 48) + 1148) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 311) + 2834) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CURE_DISEASE_DRAIN"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((600 - ((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 5)), 1)), math.floor(math.max((3600 - ((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 30)), 1)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CURE_DISEASE_CHECKS"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_CURE_DISEASE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_CURE_DISEASE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_CURE_DISEASE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_vita_cure_disease"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_CURE_DISEASE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_CURE_DISEASE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_cure_disease"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "vita_cure_disease") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "vita_cure_disease", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "vita_cure_disease_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "vita_cure_disease") >= 1) then
            do local _a, _sp = H.u(ctx), "vita_cure_disease"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "vita_cure_disease_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 48) + 1148) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_cure_disease") + H.char_spell_level(H.u(ctx), "vita_cure_disease_knack")) * 311) + 2834) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CURE_DISEASE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_INCREASED_HP_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_INCREASED_HP_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel more resilient.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_vita_increase_hp", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_increased_hp") * 281.65) + 1084.5) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_increased_hp") * 681.96) + 2908.42) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_INCREASED_HP_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_INCREASED_HP", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_INCREASED_HP"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_INCREASED_HP"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_vita_increase_hp"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_INCREASED_HP_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_INCREASED_HP_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_increase_hp"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "vita_increased_hp", false))
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "vita_increased_hp"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_increased_hp") * 281.65) + 1084.5) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_increased_hp") * 681.96) + 2908.42) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_INCREASED_HP_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_NO_NEED_FOR_SLEEP_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_NO_NEED_FOR_SLEEP_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You blink suddenly.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_no_need_for_sleep", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_no_need_for_sleep") * 210) + 1950) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_no_need_for_sleep") * 590) + 4180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_NO_NEED_FOR_SLEEP_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_NO_NEED_FOR_SLEEP_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_NO_NEED_FOR_SLEEP_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vitakin_no_need_for_sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 7)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "vita_no_need_for_sleep"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        if (H.char_val_extra(H.u(ctx), "sleep_deprivation") >= 250) then
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 250, "-=")
        end
        if (H.char_val_extra(H.u(ctx), "sleep_deprivation") >= 100) then
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 100, "-=")
        end
        if (H.char_val_extra(H.u(ctx), "sleep_deprivation") >= 50) then
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 50, "-=")
        end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_no_need_for_sleep") * 210) + 1950) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_no_need_for_sleep") * 590) + 4180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_NO_NEED_FOR_SLEEP_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_SUPER_HEAL_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_SUPER_HEAL_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a sudden sensation of fatigue and your wounds itch.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vita_super_heal", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((20 - math.min(((H.char_spell_level(H.u(ctx), "vita_super_heal") * 0.5) * H._jm_psionic_power_modifiers(ctx)), 17))), math.floor((35 - math.min(((H.char_spell_level(H.u(ctx), "vita_super_heal") * 0.5) * H._jm_psionic_power_modifiers(ctx)), 28))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SUPER_HEAL_RUN_HEALING"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_super_heal") * 29) + 146) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_super_heal") * 110) + 372) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SUPER_HEAL_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_SUPER_HEAL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_SUPER_HEAL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_SUPER_HEAL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_vita_super_heal"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_SUPER_HEAL_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_SUPER_HEAL_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_super_heal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 9)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "vita_super_heal"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_super_heal") * 29) + 146) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_super_heal") * 110) + 372) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_SUPER_HEAL_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_RETURN_FROM_DEATH_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_RETURN_FROM_DEATH_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You prepare yourself to return from near-death.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "vitakin_return_from_death_kcal", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0))
        H.eoc_add_effect(H.u(ctx), "effect_vita_return_from_death", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_return_from_death") * 962) + 3978) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_return_from_death") * 2819) + 12360) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_RETURN_FROM_DEATH_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(2), math.floor(2); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH_2"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH_2"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH_2"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_vita_return_from_death"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_RETURN_FROM_DEATH_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_VITAKIN_RETURN_FROM_DEATH_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_vita_return_from_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 10)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "vitakin_return_from_death_kcal", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0))
        do local _a, _sp = H.u(ctx), "vita_return_from_death"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "vita_return_from_death") * 962) + 3978) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "vita_return_from_death") * 2819) + 12360) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_RETURN_FROM_DEATH_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK_2"] = function(ctx)
        return ((services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_concentrated_healing") * 3))), (100)) and (H.char_vitamin(H.u(ctx), "dermatik_larva_size") <= 720) and (((H.var_str("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "")) == (H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", "")))))) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK_2"] = function(ctx)
    if ((services.random.native_probability(((10 + (H.char_spell_level(H.u(ctx), "vita_concentrated_healing") * 3))), (100)) and (H.char_vitamin(H.u(ctx), "dermatik_larva_size") <= 720) and (((H.var_str("actor", H.u(ctx), ctx, "latest_concentrated_body_part", "")) == (H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", "")))))) then
        do local _a, _v = H.u(ctx), "mutant_toxin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.char_vitamin(H.u(ctx), "dermatik_larva_size"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _eg = H.safe_id('effect', "dermatik"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dermatik_visible"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _a, _v = H.u(ctx), "dermatik_larva_size"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("You feel a severe itching sensation.")), "mixed")
        return true
    else
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((3600 - ((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") * 60) * H._jm_psionic_power_modifiers(ctx)))), math.floor((3600 - ((H.char_spell_level(H.u(ctx), "vita_concentrated_healing") * 60) * H._jm_psionic_power_modifiers(ctx)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "dermatik"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik_visible"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_vita_concentrated_healing"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "dermatik"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik_visible"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "dermatik"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_VITAKIN_CONCENTRATED_HEALING_DERMATIK_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_DEXTOXIFICATION_CHECK_1"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "poison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_dmg"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_weaken"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_blind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "paralyzepoison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_VITAKIN_DEXTOXIFICATION_CHECK_1"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "poison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "poison"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "badpoison"); local bpg = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_dmg"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_weaken"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_blind"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "venom_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "paralyzepoison"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        services.messages.add(ctx:expand_text(services.translate("Your skin tingles as the poison begins to work its way out of your body.")), "mixed")
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((15 - ((H.char_spell_level(H.u(ctx), "vita_remove_poison") + H.char_spell_level(H.u(ctx), "vita_remove_poison_knack")) * H._jm_psionic_power_modifiers(ctx))), 1)), math.floor(math.max((120 - (((H.char_spell_level(H.u(ctx), "vita_remove_poison") + H.char_spell_level(H.u(ctx), "vita_remove_poison_knack")) * H._jm_psionic_power_modifiers(ctx)) * 2)), 1)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_DEXTOXIFICATION_CHECK_2"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You're not suffering from poisoning and have nothing to detoxify.")), "good")
        return false
    end
    end
    EOC["EOC_VITAKIN_DEXTOXIFICATION_CHECK_2"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You begin to sweat.")), "mixed")
    if H.u(ctx) then services.characters.add_wet(H.u(ctx), math.floor(8)) end
    H.run_eoc("EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH", ctx, nil, nil, nil)
    do local _eg = H.safe_id('effect', "poison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "badpoison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_dmg"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_weaken"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_blind"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_pain"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "paralyzepoison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "TOXICFLESH") == 1)))) == true
    end
    EOC["EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "TOXICFLESH") == 1)))) then
        do local _g = H.safe_id('mutation', "TOXICFLESH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "vita_remove_poison") + H.char_spell_level(H.u(ctx), "vita_remove_poison_knack")) * 4) + 156) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "vita_remove_poison") + H.char_spell_level(H.u(ctx), "vita_remove_poison_knack")) * 32) + 418) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH_REMOVE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH_REMOVE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "TOXICFLESH") == 1)) == true
    end
    EOC["EOC_VITAKIN_DEXTOXIFICATION_TOXICFLESH_REMOVE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "TOXICFLESH") == 1)) then
        H.lose_trait(H.u(ctx), "TOXICFLESH")
        return true
    end
    return false
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_EOC"] = function(ctx)
    do
        local _sw52 = H.char_spell_level(H.u(ctx), "vita_stop_bleeding")
        if _sw52 == 0 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_bleeding_01", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_BLEEDING_ITEM_01", ctx, nil, nil, nil)
        elseif _sw52 == 6 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_bleeding_02", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_BLEEDING_ITEM_02", ctx, nil, nil, nil)
        elseif _sw52 == 12 then
            H.eoc_cast_spell(H.u(ctx), "vita_stop_bleeding_03", false, nil)
            H.run_eoc("EOC_VITAKIN_STOP_BLEEDING_ITEM_03", ctx, nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_01_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_VITAKIN_STOP_BLEEDING_ITEM_01"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "vita_bandage_01" } }, { "EOC_VITAKIN_STOP_BLEEDING_ITEM_01_ACTIVATE" }, {  })
    return true
    end
end
