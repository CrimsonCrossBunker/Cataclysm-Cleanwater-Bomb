local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES_2"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES_2"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.npc_mood_write(H.npc(ctx), "fear", math.max((-10), (H.npc_mood_read(H.npc(ctx), "fear") - (H.var_num(H.u(ctx), "mood_stabilized_power_level") / 2))), "=")
        H.npc_mood_write(H.npc(ctx), "anger", math.max((-10), (H.npc_mood_read(H.npc(ctx), "anger") - (H.var_num(H.u(ctx), "mood_stabilized_power_level") / 2))), "=")
        H.npc_mood_write(H.npc(ctx), "trust", math.min(20, (H.npc_mood_read(H.npc(ctx), "trust") + (H.var_num(H.u(ctx), "mood_stabilized_power_level") / 4))), "=")
        services.messages.add(ctx:expand_text(services.translate("You reach in and, with a deft touch, sooth your target's negative emotions.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_telepath_mood_stabilization_attitude_modified", 43200, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You attempt to edit the target's mood, but your powers slam into a smooth, unyielding barrier and slide off.")), "bad")
        return false
    end
    end
    COND["EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepath_mood_stabilization_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepath_mood_stabilization_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't want to risk affecting the target's mind too quickly, and withdraw.")), "neutral")
        return false
    end
    end
    COND["EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES_2"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES_2"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.set_char_val_extra(H.u(ctx), "anger", (H.var_num(H.u(ctx), "mood_stabilized_power_level") * 5), "-=")
        services.messages.add(ctx:expand_text(services.translate("You reach in and, with a deft touch, sooth your target's negative emotions.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_telepath_mood_stabilization_attitude_modified", 300, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You attempt to edit the target's mood, but your powers slam into a smooth, unyielding barrier and slide off.")), "bad")
        return false
    end
    end
    COND["EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepath_mood_stabilization_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepath_mood_stabilization_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_OBSCURITY_REMOVAL_CHARACTER"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_TELEPATH_OBSCURITY_REMOVAL_CHARACTER"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if (((function() local eg = H.safe_id('effect', "telepathic_ignorance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())) then
            do local _eg = H.safe_id('effect', "telepathic_ignorance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_OBSCURITY_REMOVAL_MONSTER"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_TELEPATH_OBSCURITY_REMOVAL_MONSTER"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if (((function() local eg = H.safe_id('effect', "telepathic_ignorance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "telepathic_ignorance_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())) then
            do local _eg = H.safe_id('effect', "telepathic_ignorance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_PRIMAL_TERROR"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and ((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) >= H.char_spell_level(H.npc(ctx), "telepathic_fear"))))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))))) == true
    end
    EOC["EOC_TELEPATH_PRIMAL_TERROR"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and ((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) >= H.char_spell_level(H.npc(ctx), "telepathic_fear"))))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))))) then
        H.set_var("actor", H.u(ctx), ctx, "telepathy_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "telepathy_power_level", H.char_spell_level(H.npc(ctx), "telepathic_fear"))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telepathy_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.eoc_add_effect(H.u(ctx), "psi_stunned", services.random.native_float((((((H.var_num(H.u(ctx), "telepathy_power_level") * 0.25) * 6) / ((H.var_num(H.u(ctx), "telepathy_power_level") * 0.25) + 3)) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling")), (((((H.var_num(H.u(ctx), "telepathy_power_level") * 0.25) * 10) / ((H.var_num(H.u(ctx), "telepathy_power_level") * 0.25) + 3)) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling"))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telepathic_primal_terror", services.random.native_float(((((H.var_num(H.u(ctx), "telepathy_power_level") * 0.75) + 2) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling")), ((((H.var_num(H.u(ctx), "telepathy_power_level") * 1.75) + 5) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling"))), nil, nil, nil)
        H.run_eoc("EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE_2"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).npc == true)) == true
    end
    EOC["EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE_2"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).npc == true)) then
        H.npc_mood_write(H.npc(ctx), "fear", (H.var_num(H.u(ctx), "telepathy_power_level") / 2), "+=")
        H.eoc_add_effect(H.u(ctx), "effect_telepath_primal_terror_attitude_modified", 3600, nil, nil, nil)
        return true
    else
        H.set_char_val_extra(H.u(ctx), "morale", (H.var_num(H.u(ctx), "telepathy_power_level") * 5), "-=")
        H.eoc_add_effect(H.u(ctx), "effect_telepath_primal_terror_attitude_modified", 3600, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepath_primal_terror_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepath_primal_terror_attitude_modified"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_TELEPATH_PRIMAL_TERROR_ATTITUDE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_NETWORK_ALLY_CHECK"] = function(ctx)
        return ((services.npcs.count_allies(false) >= (1))) == true
    end
    EOC["EOC_TELEPATH_NETWORK_ALLY_CHECK"] = function(ctx)
    if ((services.npcs.count_allies(false) >= (1))) then
        H.eoc_cast_spell(H.u(ctx), "telepathic_network_real", false, { hit_self = true, message = ctx:expand_text(services.translate("You now have an instinctive awareness of your allies, and they of you.")) })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("With no nearby allies, there is no one to network with.")), "bad")
        return false
    end
    end
    COND["EOC_TELEPORT_STRIDE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_STRIDE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your steps are taking you further than your eyes tell you they should.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_teleport_stride", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_stride") * 3) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_stride") * 4) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_STRIDE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_STRIDE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_STRIDE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_STRIDE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_stride"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_STRIDE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_STRIDE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_stride"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_stride"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_stride") * 3) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_stride") * 4) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_STRIDE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPORT_WARPED_STRIKES_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_WARPED_STRIKES_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You are ready to momentarily warp space to coincide with your attacks.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_teleport_warped_strikes", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_warped_strikes") * 10) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_warped_strikes") * 30) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_WARPED_STRIKES_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_WARPED_STRIKES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_WARPED_STRIKES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_WARPED_STRIKES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_WARPED_STRIKES_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_WARPED_STRIKES_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_warped_strikes"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "teleport_warped_strikes", false))
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_warped_strikes"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_warped_strikes") * 10) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_warped_strikes") * 30) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_WARPED_STRIKES_DRAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_EPHEMERAL_WALK_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_EPHEMERAL_WALK_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a strange coolness as matter around you feels somehow less solid.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_teleport_ephemeral_walk", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_ephemeral_walk") * 10) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_ephemeral_walk") * 30) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_EPHEMERAL_WALK_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_EPHEMERAL_WALK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_EPHEMERAL_WALK"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_EPHEMERAL_WALK"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_EPHEMERAL_WALK_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_EPHEMERAL_WALK_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_ephemeral_walk"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_ephemeral_walk") * 10) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_ephemeral_walk") * 30) + 300) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_EPHEMERAL_WALK_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPORT_REACTIVE_DISPLACEMENT_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_REACTIVE_DISPLACEMENT_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You are prepared to displace your attackers.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_teleport_reactive_displacement", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_reactive_displacement") * 1) + 20) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_reactive_displacement") * 4) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_REACTIVE_DISPLACEMENT_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_REACTIVE_DISPLACEMENT_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REACTIVE_DISPLACEMENT_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_reactive_displacement"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_reactive_displacement") * 2) + 20) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_reactive_displacement") * 4) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_REACTIVE_DISPLACEMENT_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPORT_LOCI_ESTABLISHMENT_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_LOCI_ESTABLISHMENT_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You've established a locus to return to later.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "teleporter_loci_establishment_loc", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.eoc_add_effect(H.u(ctx), "effect_teleport_loci_establishment", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_loci_establishment") * 1) + 20) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_loci_establishment") * 4) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_LOCI_ESTABLISHMENT_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_LOCI_ESTABLISHMENT_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_LOCI_ESTABLISHMENT_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_loci_establishment"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_loci_establishment"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_loci_establishment") * 2) + 20) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_loci_establishment") * 4) + 200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_LOCI_ESTABLISHMENT_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPORT_WARPER_COMBAT_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPORT_WARPER_COMBAT_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The world jerks as you start continually blinking from place to place.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_teleport_warper_combat", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_warper_combat") * 3.5) + 23) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_warper_combat") * 8.5) + 97) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_WARPER_COMBAT_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPORT_REMOVE_WARPER_COMBAT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPORT_REMOVE_WARPER_COMBAT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_REMOVE_WARPER_COMBAT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_teleport_warper_combat"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_WARPER_COMBAT_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_WARPER_COMBAT_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_warper_combat"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 9)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "teleport_warper_combat"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "teleport_warper_combat") * 3.5) + 23) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "teleport_warper_combat") * 8.5) + 97) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_WARPER_COMBAT_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER_ADD_VOLUME_WORN"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "teleport_total_carried_volume", (H.var_num(H.u(ctx), "teleport_total_carried_volume")) + (H.creature_volume(H.npc(ctx))))
    return true
    end
    EOC["EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER_ADD_VOLUME_WIELDED"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "teleport_total_carried_volume", (H.var_num(H.u(ctx), "teleport_total_carried_volume")) + (H.creature_volume(H.npc(ctx))))
    return true
    end
    EOC["EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "teleport_total_carried_volume", 0)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true, _cond_fn = function(ctx) return ((H.creature_volume(H.npc(ctx)) > 0)) end } }, { "EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER_ADD_VOLUME_WORN" }, {  })
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return ((H.creature_volume(H.npc(ctx)) > 0)) end } }, { "EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER_ADD_VOLUME_WIELDED" }, {  })
    services.messages.add(ctx:expand_text(services.translate("Your carried volume is <u_val:teleport_total_carried_volume>.")), "debug")
    return true
    end
    COND["EOC_TELEPORT_BLINK_INITIATE"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) == true
    end
    EOC["EOC_TELEPORT_BLINK_INITIATE"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) then
        H.run_eoc("EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER", ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "teleport_blink_limit", (((H.char_spell_level(H.u(ctx), "teleport_blink") * 3500) + 5000) * H._jm_psionic_power_modifiers(ctx)))
        services.messages.add(ctx:expand_text(services.translate("Your Blink volume limit is <context_val:teleport_blink_limit>.")), "debug")
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") <= (ctx:get_number("teleport_blink_limit") or 0)) then
            H.eoc_cast_spell(H.u(ctx), "teleport_blink_real", false, { hit_self = true, min_level = math.floor(H.char_spell_level(H.u(ctx), "teleport_blink")) })
            services.messages.add(ctx:expand_text(services.translate("You vanish and reappear nearby.")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You attempt to teleport to somewhere nearby, but your skin merely tingles and nothing happens.  You're carrying too much.")), "bad")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a strange, inward force.")), "bad")
        return false
    end
    end
    COND["EOC_TELEPORT_PHASE_INITIATE"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) == true
    end
    EOC["EOC_TELEPORT_PHASE_INITIATE"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) then
        H.run_eoc("EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER", ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "teleport_phase_limit", (((H.char_spell_level(H.u(ctx), "teleport_phase") * 5000) + 10000) * H._jm_psionic_power_modifiers(ctx)))
        services.messages.add(ctx:expand_text(services.translate("Your Phase volume limit is <context_val:teleport_blink_limit>.")), "debug")
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") <= (ctx:get_number("teleport_phase_limit") or 0)) then
            H.eoc_cast_spell(H.u(ctx), "teleport_phase_real", false, { targeted = true, min_level = math.floor(H.char_spell_level(H.u(ctx), "teleport_phase")) })
            services.messages.add(ctx:expand_text(services.translate("There is a brief moment of darkness and terrible cold, and you are somewhere else.")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You attempt to phase through the barrier, but your skin merely tingles and nothing happens.  You're carrying too much.")), "bad")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a strange, inward force.")), "bad")
        return false
    end
    end
    EOC["EOC_TELEPORT_ITEM_APPORT_ITEM_QUALIFIES"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select apport location.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "teleporter_item_apport_location") and 1 or 0)) then
        if (((function() local p = H.get_tripoint_var("context", nil, ctx, "teleporter_item_apport_location"); local fg = H.safe_id('json_flag', "WALL"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "teleporter_item_apport_location"); local fg = H.safe_id('json_flag', "DOOR"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then
            services.messages.add(ctx:expand_text(services.translate("You cannot apport an item inside a solid object.")), "bad")
        else
            do local _t, _p = H.npc(ctx), H.get_tripoint_var("context", nil, ctx, "teleporter_item_apport_location"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
            services.messages.add(ctx:expand_text(services.translate("The item in your hands grows freezing cold for a moment before vanishing.")), "neutral")
        end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_TELEPORT_ITEM_APPORT_ITEM_DOES_NOT_QUALIFY"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The air around the item wavers, but nothing happens.  The item is too large.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_ITEM_APPORT_NEXT"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return (((H.creature_volume(H.npc(ctx)) <= (((H.char_spell_level(H.u(ctx), "teleport_item_apport") * 2500) + 2000) * H._jm_psionic_power_modifiers(ctx))) and (H.creature_volume(H.npc(ctx)) > 0))) end } }, { "EOC_TELEPORT_ITEM_APPORT_ITEM_QUALIFIES" }, { "EOC_TELEPORT_ITEM_APPORT_ITEM_DOES_NOT_QUALIFY" })
    return true
    end
    EOC["EOC_TELEPORT_ITEM_APPORT_FAIL"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You must be holding something to apport it.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORT_ITEM_APPORT"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true, _cond_fn = function(ctx) return ((H.creature_volume(H.npc(ctx)) > 0)) end } }, { "EOC_TELEPORT_ITEM_APPORT_NEXT" }, { "EOC_TELEPORT_ITEM_APPORT_FAIL" })
    return true
    end
    COND["EOC_TELEPORT_DISPLACEMENT_CHECK"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TELEPORT_IMMUNE"))) and (not (H.char_has_flag(H.u(ctx), "TELESTOP"))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) == true
    end
    EOC["EOC_TELEPORT_DISPLACEMENT_CHECK"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TELEPORT_IMMUNE"))) and (not (H.char_has_flag(H.u(ctx), "TELESTOP"))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) then
        H.set_var("actor", H.u(ctx), ctx, "teleportation_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "teleportation_intelligence_power_level", H.char_spell_level(H.npc(ctx), "teleport_displacement"))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_teleportation_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        if ((H.creature_volume(H.u(ctx)) <= ((((H.var_num(H.u(ctx), "teleportation_intelligence_power_level") * 12500) + 25000) * H.var_num(H.u(ctx), "teleportation_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_teleportation_scaling"))) and (H.creature_volume(H.u(ctx)) > 0)) then
            H.eoc_cast_spell(H.u(ctx), "teleport_blink_real", false, { hit_self = true, min_level = math.floor(10) })
            if ((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) then
                services.messages.add(ctx:expand_text(services.translate("As <u_name> strikes you, they are suddenly somewhere else")), "good")
            else
                services.messages.add(ctx:expand_text(services.translate("You touch <u_name> and they are suddenly somewhere else")), "good")
            end
        else
            if ((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) then
            else
                services.messages.add(ctx:expand_text(services.translate("You touch <u_name> but nothing happens.  They are too big to teleport.")), "bad")
            end
        end
        return true
    else
        if (not (((function() local eg = H.safe_id('effect', "effect_teleport_reactive_displacement"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) then
            services.messages.add(ctx:expand_text(services.translate("You touch <u_name> but nothing happens at all.")), "bad")
        end
        return false
    end
    end
    COND["EOC_TELEPORT_EPHEMERAL_WALK_ADDITIONAL_STAMINA_COST"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_EPHEMERAL_WALK_ADDITIONAL_STAMINA_COST"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleport_ephemeral_walk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_char_val_extra(H.u(ctx), "stamina", math.max((150 - (H.char_spell_level(H.u(ctx), "teleport_ephemeral_walk") * 4)), 50), "-=")
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_SPACIAL_VORTEX"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_four", false, { hit_self = true })
    do
        local _sw51 = H.char_spell_level(H.u(ctx), "teleport_collapse")
        if _sw51 == 0 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_01", false, { targeted = true })
        elseif _sw51 == 4 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_02", false, { targeted = true })
        elseif _sw51 == 8 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_03", false, { targeted = true })
        elseif _sw51 == 12 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_04", false, { targeted = true })
        elseif _sw51 == 16 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_05", false, { targeted = true })
        elseif _sw51 == 20 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_06", false, { targeted = true })
        elseif _sw51 == 24 then
            H.eoc_cast_spell(H.u(ctx), "teleport_collapse_07", false, { targeted = true })
        end
    end
    return true
    end
    COND["EOC_TELEPORT_FARSTEP_INITIATE"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) == true
    end
    EOC["EOC_TELEPORT_FARSTEP_INITIATE"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) then
        H.run_eoc("EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER", ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "teleport_farstep_limit", (((H.char_spell_level(H.u(ctx), "teleport_farstep") * 5000) + 8000) * H._jm_psionic_power_modifiers(ctx)))
        services.messages.add(ctx:expand_text(services.translate("Your Farstep volume limit is <context_val:teleport_farstep_limit>.")), "debug")
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") <= (ctx:get_number("teleport_farstep_limit") or 0)) then
            H.eoc_cast_spell(H.u(ctx), "teleport_farstep_real", false, { targeted = true })
            services.messages.add(ctx:expand_text(services.translate("There is a moment of darkness and terrible cold, and you are somewhere else.")), "neutral")
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a strange, inward force.")), "bad")
        return false
    end
    end
    COND["EOC_TELEPORTER_OUBLIETTE_HANDLING"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TELESTOP"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_IMMUNE"))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) == true
    end
    EOC["EOC_TELEPORTER_OUBLIETTE_HANDLING"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TELESTOP"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_IMMUNE"))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) then
        H.run_eoc("EOC_TELEPORTER_OUBLIETTE_HANDLING_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your target wavers for a moment, but nothing happens.")), "neutral")
        return false
    end
    end
    COND["EOC_TELEPORTER_OUBLIETTE_HANDLING_2"] = function(ctx)
        return ((not (((H.char_snap(H.u(ctx)) or {}).npc == true)))) == true
    end
    EOC["EOC_TELEPORTER_OUBLIETTE_HANDLING_2"] = function(ctx)
    if ((not (((H.char_snap(H.u(ctx)) or {}).npc == true)))) then
        H.set_var("actor", H.u(ctx), ctx, "psi_teleporter_damage", services.random.native_float((((15 + (H.char_spell_level(H.npc(ctx), "teleport_banish") * 15)) * (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * H.var_num(H.npc(ctx), "nether_attunement_power_scaling")), (((350 + (H.char_spell_level(H.npc(ctx), "teleport_banish") * 35)) * (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))))
        H.set_var("actor", H.u(ctx), ctx, "health_comparison", H.char_hp(H.u(ctx), "ALL", false))
        if (H.var_num(H.u(ctx), "psi_teleporter_damage") > H.var_num(H.u(ctx), "health_comparison")) then
            if H.u(ctx) then services.characters.die(H.u(ctx), { remove_corpse = true, suppress_message = true }) end
            services.messages.add(ctx:expand_text(services.translate("With a tremendous mental exertion, you hurl your target…elsewhere.")), "neutral")
        end
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "psi_teleporter_damage", services.random.native_float((((15 + (H.char_spell_level(H.npc(ctx), "teleport_banish") * 15)) * (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * H.var_num(H.npc(ctx), "nether_attunement_power_scaling")), (((350 + (H.char_spell_level(H.npc(ctx), "teleport_banish") * 35)) * (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))))
        H.set_var("actor", H.u(ctx), ctx, "health_comparison", ((((((H.char_hp(H.u(ctx), "arm_l", false) + H.char_hp(H.u(ctx), "arm_r", false)) + H.char_hp(H.u(ctx), "leg_l", false)) + H.char_hp(H.u(ctx), "leg_r", false)) + H.char_hp(H.u(ctx), "torso", false)) + H.char_hp(H.u(ctx), "head", false)) / 3))
        if (H.var_num(H.u(ctx), "psi_teleporter_damage") > H.var_num(H.u(ctx), "health_comparison")) then
            services.messages.add(ctx:expand_text(services.translate("With a tremendous mental exertion, you hurl your target…elsewhere.")), "neutral")
            if H.u(ctx) then services.characters.die(H.u(ctx), { remove_corpse = true, suppress_message = true }) end
        end
        return false
    end
    end
    EOC["EOC_TELEPORTER_GATEWAY_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("There is a long moment of darkness and terrible cold that seems like it will freeze your heart, and then you are somewhere else.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You attempt to teleport to your destination, but your skin merely tingles and nothing happens.  You're carrying too much.")), "bad")
    return true
    end
    EOC["EOC_TELEPORTER_ATTUNING_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You concentrate and begin memorizing every detail of the current area you are in.")), "neutral")
    return true
    end
    EOC["EOC_TELEPORTER_ATTUNED_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You have successfully memorized the local area, and may now return to it with your powers.")), "good")
    if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "DIMENSIONAL_ANCHOR"))) and (not (H.char_has_flag(H.u(ctx), "TELEPORT_LOCK"))))) then
        H.run_eoc("EOC_TELEPORT_SELF_CARRIED_VOLUME_CHECKER", ctx, nil, nil, nil)
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") <= (((H.char_spell_level(H.u(ctx), "teleport_gateway") * 7500) + 10000) * H._jm_psionic_power_modifiers(ctx))) then
            H.set_var("actor", H.u(ctx), ctx, "teleport_total_carried_volume", 1)
        else
            H.set_var("actor", H.u(ctx), ctx, "teleport_total_carried_volume", (-1))
        end
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_01"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_1>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_SELECTOR_01" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_02"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_2>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_SELECTOR_02" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_03"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_3>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_TELEPORT_GATEWAY_SELECTOR_03" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_04"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_04"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_4>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_TELEPORT_GATEWAY_SELECTOR_04" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_05"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_05"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_5>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_TELEPORT_GATEWAY_SELECTOR_05" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_06"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_06"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_6>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_TELEPORT_GATEWAY_SELECTOR_06" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_07"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_07"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_7>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_TELEPORT_GATEWAY_SELECTOR_07" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_08"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_08"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_8>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "EOC_TELEPORT_GATEWAY_SELECTOR_08" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_09"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_09"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_9>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "EOC_TELEPORT_GATEWAY_SELECTOR_09" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_10"] == nil or E.cond["EOC_TELEPORT_GATEWAY_SELECTOR_10"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Gateway: <u_val:gateway_destination_name_10>")), description = ctx:expand_text(services.translate("Teleport/Attune to a destination.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_TELEPORT_GATEWAY_SELECTOR_10" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a strange, inward force.")), "bad")
        return false
    end
    end
    COND["ECO_TELEPORTER_CANCELLING_ATTUNING_CANCELS_ATTUNE"] = function(ctx)
        return ((((("ACT_PSI_TELEPORTER_ATTUNING") == (H.var_str("context", nil, ctx, "activity", "")))) and ((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["ECO_TELEPORTER_CANCELLING_ATTUNING_CANCELS_ATTUNE"] = function(ctx)
    if ((((("ACT_PSI_TELEPORTER_ATTUNING") == (H.var_str("context", nil, ctx, "activity", "")))) and ((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_01"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_01"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_1>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_1>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_01" end end
        do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_01"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_01" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_01"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_01"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_1") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_1"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_01"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_01_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_01_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_01_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_1", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_1", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_02"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 1)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_02"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 1)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_02"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_2>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_2>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_02" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_02"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_02" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_02"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_02"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_2") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            services.messages.add(ctx:expand_text(services.translate("Destination coordinates are <u_val:gateway_destination_2>.")), "debug")
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_2"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_02"] = function(ctx)
    H.run_eoc("EOC_TELEPORTER_ATTUNING_MESSAGE", ctx, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_teleporter_attuning_to_area", 28800, nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_TELEPORTER_ATTUNING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(28800)))) end end
    do local _t = math.max(1, math.floor((28800 - H.clamp_num((H.char_spell_level(H.u(ctx), "teleport_gateway") * 1200), 0, 27000)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORT_GATEWAY_ATTUNE_02_SUCCESS"), nil) end end
    return true
    end
    COND["EOC_TELEPORT_GATEWAY_ATTUNE_02_SUCCESS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_ATTUNE_02_SUCCESS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_teleporter_attuning_to_area"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "gateway_destination_name_2", _ir.value) end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "gateway_destination_2", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_TELEPORTER_ATTUNED_MESSAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_SELECTOR_03"] = function(ctx)
        return (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 2)) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_SELECTOR_03"] = function(ctx)
    if (((((H.char_spell_level(H.u(ctx), "teleport_gateway") * (1 + (H.char_has_trait(H.u(ctx), "GOODMEMORY") * 0.2))) / (1 + (H.char_has_trait(H.u(ctx), "FORGETFUL") * 0.33))) / 3) >= 2)) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_03"] == nil or E.cond["EOC_TELEPORT_GATEWAY_TELEPORT_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Destination: <u_val:gateway_destination_name_3>")), description = ctx:expand_text(services.translate("Teleport to <u_val:gateway_destination_name_3>.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEPORT_GATEWAY_TELEPORT_03" end end
            do local _en = (E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_03"] == nil or E.cond["EOC_TELEPORT_GATEWAY_ATTUNE_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Attune to Area")), description = ctx:expand_text(services.translate("Attune to a new destination.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEPORT_GATEWAY_ATTUNE_03" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_GATEWAY_TELEPORT_03"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) == true
    end
    EOC["EOC_TELEPORT_GATEWAY_TELEPORT_03"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "gateway_destination_3") and 1 or 0))) then
        if (H.var_num(H.u(ctx), "teleport_total_carried_volume") >= 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "gateway_destination_3"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE", ctx, nil, nil, nil)
        else
            H.run_eoc("EOC_TELEPORTER_GATEWAY_MESSAGE_CARRYING_TOO_MUCH", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
end
