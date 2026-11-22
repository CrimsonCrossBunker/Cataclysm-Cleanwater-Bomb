local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_VITAKINETIC_CRYSTAL_SELECTED"] = function(ctx)
    do local _g = H.safe_id('json_flag', "MOM_SHADOW_URGE_CHOICE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_VITAKINETIC_CRYSTAL"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "activated_shadow_urge_machine", "no")
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", ctx:expand_text(services.translate("Which crystal do you enter?")), { {  } }, { "EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_VITAKINETIC_CRYSTAL_SELECTED" }, {  })
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_VITAKINETIC_CRYSTAL_CONSUME_RUN"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    H.set_var("actor", H.u(ctx), ctx, "activated_shadow_urge_machine", "yes")
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_VITAKINETIC_CRYSTAL_CONSUME"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { {  } }, { "EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_VITAKINETIC_CRYSTAL_CONSUME_RUN" }, {  })
    return true
    end
    EOC["EOC_BIOKIN_LEARNING_GUIDED_EVOLUTION"] = function(ctx)
    return true
    end
    EOC["EOC_MoM_AEA_INTENSIFY_NEARBY_FLAMES_ACTION"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "MoM_AEA_val"), H.safe_id('field', "fd_fire"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(0), intensity = math.floor(1) }) end end
    return true
    end
    EOC["EOC_MoM_AEA_INTENSIFY_NEARBY_FLAMES"] = function(ctx)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor((5 + services.random.native_int(0, H.round_half_away(10)))) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "MoM_AEA_val", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "MoM_AEA_val"); local fg = H.safe_id('field', "fd_fire"); return p ~= nil and fg ~= nil and services.gameplay.environment.field_exists(p, fg, true) end)())) then for _, _eid in ipairs({ "EOC_MoM_AEA_INTENSIFY_NEARBY_FLAMES_ACTION" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
    return true
    end
    COND["EOC_AEA_TELEKIN_WAVE_TARGETS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_AEA_TELEKIN_WAVE_TARGETS"] = function(ctx)
    if (ctx:has_speaker()) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("context", nil, ctx, "push_nearby_enemies_power_level", 8)
        H.set_var("context", nil, ctx, "telekinesis_weight_ratio", 55)
        H.set_var("context", nil, ctx, "weight_ratio", ((((ctx:get_number("push_nearby_enemies_power_level") or 0) * (ctx:get_number("telekinesis_weight_ratio") or 0)) + ((ctx:get_number("telekinesis_weight_ratio") or 0) / 2)) / (H.creature_weight(H.u(ctx)) / 1000000)))
        H.set_var("context", nil, ctx, "telekinesis_shove_spell_level", H.clamp_num((((ctx:get_number("weight_ratio") or 0) - 1) * 1.5), 0, 20))
        if services.random.native_probability((((ctx:get_number("weight_ratio") or 0) * 1000)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        end
        if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor((ctx:get_number("telekinesis_shove_spell_level") or 0)), stun = math.floor(2), dam_mult = math.floor((1 + ((ctx:get_number("telekinesis_shove_spell_level") or 0) * 0.4))), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
        return true
    end
    return false
    end
    COND["EOC_MoM_AEA_FEAR_AURA"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_MoM_AEA_FEAR_AURA"] = function(ctx)
    if (ctx:has_speaker()) then
        if ((not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not (H.char_has_flag(H.u(ctx), "TEEPSHIELD")))) then
            H.eoc_add_effect(H.u(ctx), "psi_stunned", (1 + services.random.native_int(0, H.round_half_away(4))), nil, nil, nil)
            H.set_char_val_extra(H.u(ctx), "morale", (20 + services.random.native_int(0, H.round_half_away(40))), "-=")
        end
        return true
    end
    return false
    end
    EOC["EOC_MoM_AEA_BLOOD_PURGE"] = function(ctx)
    if (H.char_vitamin(H.u(ctx), "iron") > 0) then
        do local _a, _v = H.u(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "vitC") > 0) then
        do local _a, _v = H.u(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "calcium") > 0) then
        do local _a, _v = H.u(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    H.run_eoc("EOC_VITAKIN_MUTAGEN_PURGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_DRUG_PURGE", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_BIOKIN_PAIN_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_PAIN_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You breathe deeply and your pain lessens.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_biokin_overcome_pain", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_BIOKIN_OVERCOME_PAIN_SWITCHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_overcome_pain") * 20) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_overcome_pain") * 75) + 2100) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_OVERCOME_PAIN_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_OVERCOME_PAIN", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_BIOKIN_OVERCOME_PAIN_SWITCHER"] = function(ctx)
    do
        local _sw25 = H.char_spell_level(H.u(ctx), "biokin_overcome_pain")
        if _sw25 == 0 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_1", -1, nil, nil, nil)
        elseif _sw25 == 4 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_2", -1, nil, nil, nil)
        elseif _sw25 == 8 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_3", -1, nil, nil, nil)
        elseif _sw25 == 12 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_4", -1, nil, nil, nil)
        elseif _sw25 == 16 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_5", -1, nil, nil, nil)
        elseif _sw25 == 20 then
            H.eoc_add_effect(H.u(ctx), "effect_biokin_pkill_6", -1, nil, nil, nil)
        end
    end
    return true
    end
    COND["EOC_BIOKIN_REMOVE_OVERCOME_PAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_OVERCOME_PAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_1"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_3"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_4"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_5"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_pkill_6"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_OVERCOME_PAIN_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_OVERCOME_PAIN_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_overcome_pain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 1)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_overcome_pain"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_overcome_pain") * 20) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "spell: biokin_overcome_pain") * 75) + 2100) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_OVERCOME_PAIN_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_PHYSICAL_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_PHYSICAL_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You enhance your physical prowess.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_physical", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_physical_enhance") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_physical_enhance") * 90) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_PHYSICAL_ENHANCE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_physical"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_PHYSICAL_ENHANCE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_PHYSICAL_ENHANCE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_physical"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_physical_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_physical_enhance") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_physical_enhance") * 90) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_PHYSICAL_ENHANCE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_BREATHE_SKIN_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_BREATHE_SKIN_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("As you seal your lips, your chest still rises and falls.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_breathe_skin", -1, nil, nil, nil)
        do local _eg = H.safe_id('effect', "biokin_sealed_system"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_breathe_skin") * 36) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_breathe_skin") * 72) + 540) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_BREATH_SKIN_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_BREATHE_SKIN", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_BREATHE_SKIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_BREATHE_SKIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_BREATH_SKIN_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_BREATH_SKIN_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_breathe_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 2)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_breathe_skin"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_breathe_skin") * 36) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_breathe_skin") * 72) + 540) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_BREATH_SKIN_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_HARDENED_SKIN_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_HARDENED_SKIN_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your skin itches slightly and takes on a waxy appearance.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_armor_skin", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_armor_skin") * 86) + 356) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_armor_skin") * 244) + 693) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_HARDENED_SKIN_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_HARDENED_SKIN", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_HARDENED_SKIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_HARDENED_SKIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_armor_skin"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_HARDENED_SKIN_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_HARDENED_SKIN_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_armor_skin"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_armor_skin"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_armor_skin") * 86) + 356) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_armor_skin") * 244) + 693) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_HARDENED_SKIN_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_CLIMATE_CONTROL_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_CLIMATE_CONTROL_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel much more comfortable.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_climate_control", -1, nil, nil, nil)
        do local _eg = H.safe_id('effect', "biokin_sealed_system"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_climate_control") * 180) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_climate_control") * 360) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_CLIMATE_CONTROL_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_CLIMATE_CONTROL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_CLIMATE_CONTROL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_CLIMATE_CONTROL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_biokin_climate_control"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_CLIMATE_CONTROL_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_CLIMATE_CONTROL_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_climate_control"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_climate_control"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_climate_control") * 180) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_climate_control") * 360) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_CLIMATE_CONTROL_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_ENHANCE_MOBILITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_ENHANCE_MOBILITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your gear doesn't seem to encumber you as much.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_enhance_mobility", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_enhance_mobility") * 45) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_enhance_mobility") * 120) + 900) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_ENHANCE_MOBILITY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_2"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_3"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_4"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_5"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "biokin_enhance_mobility_item_6"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_ENHANCE_MOBILITY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_ENHANCE_MOBILITY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_enhance_mobility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_enhance_mobility"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_enhance_mobility") * 45) + 300) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_enhance_mobility") * 120) + 900) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_ENHANCE_MOBILITY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_HAMMERHAND_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_HAMMERHAND_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You flex your fingers.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_hammerhand", -1, nil, nil, nil)
        H.eoc_spawn_item(H.u(ctx), "biokin_hammerhand_item", 1, false, true, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_hammerhand") * 450) + 1800) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_hammerhand") * 750) + 5400) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_HAMMERHAND_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_HAMMERHAND", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_HAMMERHAND"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_HAMMERHAND"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local g = H.safe_id('item', "biokin_hammerhand_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_biokin_hammerhand"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_HAMMERHAND_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_HAMMERHAND_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "biokin_hammerhand"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_hammerhand"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_hammerhand") * 450) + 1800) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_hammerhand") * 750) + 5400) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_HAMMERHAND_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_REFLEX_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_REFLEX_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You enhance your speed and sensory prowess.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_reflex", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_reflex_enhance") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_reflex_enhance") * 90) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_REFLEX_ENHANCE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_REFLEX_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_REFLEX_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_REFLEX_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_reflex"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_REFLEX_ENHANCE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REFLEX_ENHANCE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_reflex"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_reflex_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_reflex_enhance") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_reflex_enhance") * 90) + 450) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_REFLEX_ENHANCE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_METABOLISM_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_METABOLISM_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You supercharge your metabolism.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_metabolism_enhance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_metabolism_enhance") * 250) + 2700) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_metabolism_enhance") * 500) + 6750) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_METABOLISM_ENHANCE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_METABOLISM_ENHANCE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_METABOLISM_ENHANCE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_metabolism_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 7)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_metabolism_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 10, "-=")
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_metabolism_enhance") * 250) + 2700) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_metabolism_enhance") * 500) + 6750) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_METABOLISM_ENHANCE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_GUIDED_EVOLUTION_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_GUIDED_EVOLUTION_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin targeting your future mutations.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_guided_evolution", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_guided_evolution") * 250) + 2700) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_guided_evolution") * 500) + 6750) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_GUIDED_EVOLUTION_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_GUIDED_EVOLUTION_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_GUIDED_EVOLUTION_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "biokin_guided_evolution", false))
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_guided_evolution"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_guided_evolution") * 250) + 2700) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_guided_evolution") * 500) + 6750) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_GUIDED_EVOLUTION_DRAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_COMBAT_DANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_COMBAT_DANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("A surge of power fills your body and you begin moving with terrible purpose!")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_combat_dance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_combat_dance") * 12) + 40) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_combat_dance") * 59) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_COMBAT_DANCE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_COMBAT_DANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_COMBAT_DANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_COMBAT_DANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_combat_dance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_COMBAT_DANCE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_COMBAT_DANCE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_combat_dance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 8)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_combat_dance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_combat_dance") * 12) + 40) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_combat_dance") * 59) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_COMBAT_DANCE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_BIOKIN_PERFECTED_MOTION_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_PERFECTED_MOTION_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The world around you slows down to a crawl")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_perfected_motion", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_perfected_motion") * 0.5) + 5) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_perfected_motion") * 1.1) + 30) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_PERFECTED_MOTION_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_BIOKIN_REMOVE_PERFECTED_MOTION", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BIOKIN_REMOVE_PERFECTED_MOTION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_REMOVE_PERFECTED_MOTION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_PERFECTED_MOTION_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_PERFECTED_MOTION_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 9)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "biokin_perfected_motion"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "biokin_perfected_motion") * 0.5) + 5) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "biokin_perfected_motion") * 1.1) + 30) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_PERFECTED_MOTION_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_BIOKIN_CHANGE_APPEARANCE"] = function(ctx)
    if H.npc(ctx) then services.npcs.grooming.open_style(H.npc(ctx), 'hair') end
    if H.npc(ctx) then services.npcs.grooming.open_style(H.npc(ctx), 'beard') end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "change_appearance", { target = _p }) end end
    return true
    end
    COND["EOC_BIOKIN_ADRENALINE_TRIGGER"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "adrenaline"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BIOKIN_ADRENALINE_TRIGGER"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "adrenaline"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "adrenaline", 450, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You already have a surge of adrenaline in your system!")), "mixed")
        return false
    end
    end
    COND["EOC_PERFECTED_MOTION_WATER_RUN_CONTINUANCE"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) == true
    end
    EOC["EOC_PERFECTED_MOTION_WATER_RUN_CONTINUANCE"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) then
        services.messages.add(ctx:expand_text(services.translate("You are moving too slowly and fall into the water.")), "bad")
        H.run_eoc("EOC_BIOKIN_REMOVE_PERFECTED_MOTION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERFECTED_MOTION_WATER_RUN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PERFECTED_MOTION_WATER_RUN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_perfected_motion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_PERFECTED_MOTION_WATER_RUN_CONTINUANCE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_BIOKIN_VITAMINOSIS"] = function(ctx)
    do local _g = H.safe_id('activity', "ACT_BIOKIN_VITAMINOSIS_MEDITATE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(144000)))) end end
    H.eoc_add_effect(H.u(ctx), "effect_biokin_vitaminosis", 144000, nil, nil, nil)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_CALCIUM"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_IRON"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_VITC"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor((120 + (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2))), math.floor((300 + (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 5))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_ONGOING_NETHER_ATTUNEMENT"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor((900 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 12))), math.floor((1800 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 25))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_EXPERIENCE"), nil) end end
    return true
    end
    COND["EOC_BIOKIN_VITAMINOSIS_CALCIUM"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "calcium") <= (-100)))) == true
    end
    EOC["EOC_BIOKIN_VITAMINOSIS_CALCIUM"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "calcium") <= (-100)))) then
        do local _a, _v = H.u(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(200 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 200; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_CALCIUM"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_VITAMINOSIS_IRON"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "iron") <= (-100)))) == true
    end
    EOC["EOC_BIOKIN_VITAMINOSIS_IRON"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "iron") <= (-100)))) then
        do local _a, _v = H.u(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(200 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 200; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_IRON"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_VITAMINOSIS_VITC"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "vitC") <= (-100)))) == true
    end
    EOC["EOC_BIOKIN_VITAMINOSIS_VITC"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_vitamin(H.u(ctx), "vitC") <= (-100)))) then
        do local _a, _v = H.u(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(200 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 200; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max(0, (120 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))), math.floor(math.max(0, (240 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_VITC"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_VITAMINOSIS_ONGOING_NETHER_ATTUNEMENT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_BIOKIN_VITAMINOSIS_ONGOING_NETHER_ATTUNEMENT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(4)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((120 + (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 2))), math.floor((300 + (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 5))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_ONGOING_NETHER_ATTUNEMENT"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_VITAMINOSIS_EXPERIENCE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((H.char_vitamin(H.u(ctx), "calcium") <= (-100)) or (H.char_vitamin(H.u(ctx), "iron") <= (-100)) or (H.char_vitamin(H.u(ctx), "vitC") <= (-100))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) > 50000))) == true
    end
    EOC["EOC_BIOKIN_VITAMINOSIS_EXPERIENCE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_vitaminosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((H.char_vitamin(H.u(ctx), "calcium") <= (-100)) or (H.char_vitamin(H.u(ctx), "iron") <= (-100)) or (H.char_vitamin(H.u(ctx), "vitC") <= (-100))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) > 50000))) then
        if (H.char_val_extra(H.u(ctx), "focus") >= 25) then
            H.set_char_val_extra(H.u(ctx), "focus", (services.random.native_int(0, H.round_half_away(10)) + 5), "-=")
        end
        do local _a, _sp = H.u(ctx), "biokin_vitaminosis"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((900 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 12))), math.floor((1800 - (H.char_spell_level(H.u(ctx), "biokin_vitaminosis") * 25))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BIOKIN_VITAMINOSIS_EXPERIENCE"), nil) end end
        return true
    else
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        return false
    end
    end
    COND["EOC_BIOKIN_GUIDED_EVOLUTION_NETHER_ATTUNEMENT_BACKFIRE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((100 * (math.max((H.var_num(H.u(ctx), "nether_attunement_power_scaling") - 1.05), 0) / 2.95)) > services.random.native_int(0, H.round_half_away(100))))) == true
    end
    EOC["EOC_BIOKIN_GUIDED_EVOLUTION_NETHER_ATTUNEMENT_BACKFIRE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_guided_evolution"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((100 * (math.max((H.var_num(H.u(ctx), "nether_attunement_power_scaling") - 1.05), 0) / 2.95)) > services.random.native_int(0, H.round_half_away(100))))) then
        H.eoc_add_effect(H.u(ctx), "effect_biokin_guided_evolution_backfire", 1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_LOSES_GUIDED_EVOLUTION_BACKFIRE"] = function(ctx)
        return (((("effect_biokin_guided_evolution_backfire") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_BIOKIN_LOSES_GUIDED_EVOLUTION_BACKFIRE"] = function(ctx)
    if (((("effect_biokin_guided_evolution_backfire") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(1), false) end
        return true
    end
    return false
    end
    COND["EOC_CLAIR_BETTER_SENSES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLAIR_BETTER_SENSES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_better_senses"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("All of your senses are enhanced.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_clair_better_senses", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "clair_better_senses") + H.char_spell_level(H.u(ctx), "clair_better_senses_knack")) * 215) + 595) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "clair_better_senses") + H.char_spell_level(H.u(ctx), "clair_better_senses_knack")) * 482) + 1264) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLAIR_BETTER_SENSES_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_CLAIR_REMOVE_BETTER_SENSES", ctx, nil, nil, nil)
        return false
    end
    end
end
