local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_TELEPORTER_THE_HOUNDS_FOLLOW"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and (((("teleport_blink") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_phase") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_transpose") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.mons_nearby(H.u(ctx), { "mon_hound_tindalos" }, 50, nil) > 0) and (not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))))) == true
    end
    EOC["EOC_TELEPORTER_THE_HOUNDS_FOLLOW"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and (((("teleport_blink") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_phase") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_transpose") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.mons_nearby(H.u(ctx), { "mon_hound_tindalos" }, 50, nil) > 0) and (not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))))) then
        services.messages.add(ctx:expand_text(services.translate("As you come out of the darkness and the cold of the teleport, you feel the prickling sensation of watching eyes and see wisps of swirling fog in the corners of your vision.  They're still on your trail.")), "bad")
        H.eoc_add_effect(H.u(ctx), "tindrift", 86400, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and (((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.mons_nearby(H.u(ctx), { "mon_hound_tindalos" }, 50, nil) > 0) and (not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))))) == true
    end
    EOC["EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and (((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.mons_nearby(H.u(ctx), { "mon_hound_tindalos" }, 50, nil) > 0) and (not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))))) then
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY_2"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY_2"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("As you come out of the darkness and the cold of the teleport, you feel the prickling sensation of watching eyes and see wisps of swirling fog in the corners of your vision.  They're still on your trail.")), "bad")
    H.eoc_add_effect(H.u(ctx), "tindrift", 86400, nil, nil, nil)
    do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY_3" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    return true
    end
    EOC["EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY_3"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "tindrift", 86400, nil, nil, nil)
    return true
    end
    EOC["EOC_PSIONICS_KCAL_COST"] = function(ctx)
    do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(H._jm_psionics_kcal_cost(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H._jm_psionics_kcal_cost(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty")); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    return true
    end
    COND["EOC_BIOKIN_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_BIOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_BIOKIN_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_BIOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "BIOKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "biokin_flexibility_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "biokin_adrenaline_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_CLAIR_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_CLAIRSENTIENCE"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_CLAIR_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_CLAIRSENTIENCE"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "CLAIRSENTIENT", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "clair_better_senses_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "clair_danger_sense_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "clair_examine_item_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "clair_astral_projection_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_ELECTRO_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_ELECTROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_ELECTRO_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_ELECTROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "ELECTROKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "electrokinetic_see_electric_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "electrokinetic_pain_immune_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "electrokinetic_hacking_interface_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_PHOTO_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PHOTOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_PHOTO_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PHOTOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "PHOTOKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "photokinetic_camouflage_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "photokinetic_hide_ugly_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "photokinetic_radio_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_PYRO_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PYROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_PYRO_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PYROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "PYROKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_flash_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_intensify_flames_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_eruption_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_call_flames_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_cloak_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_flamethrower_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_aura_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "pyrokinetic_blast_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_TELEKIN_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telekinetic_pull_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telekinetic_push_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telekinetic_slam_down_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telekinetic_wave_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_TEEP_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPATHY"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_TEEP_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPATHY"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPATH", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_shield_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_mind_sense_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_morale_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_mesmerize_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_blast_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_animal_mind_control_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_invisibility_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "telepathic_blast_radius_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_TELEPORT_MATRIX_BOOST"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPORTATION"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_TELEPORT_MATRIX_BOOST"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPORTATION"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPORTER", "", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_MATRIX_BOOST"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_VITAKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) == true
    end
    EOC["EOC_VITAKIN_MATRIX_BOOST"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) or (H.char_has_trait(H.u(ctx), "PSYCHIC_KNACK") == 1)) and ((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_VITAKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)()))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "VITAKINETIC", "", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "vita_health_power_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "vita_concentrated_healing_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "vita_remove_poison_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "vita_cure_disease_knack", "", 6, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "", "vita_banish_illness_knack", "", 6, "=")
        return true
    end
    return false
    end
    COND["EOC_YOU_ARE_NEAR_NETHER_POWER_BOOST"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx))) == true
    end
    EOC["EOC_YOU_ARE_NEAR_NETHER_POWER_BOOST"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "BIOKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "CLAIRSENTIENT", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "ELECTROKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PHOTOKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PYROKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPATH", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPORTER", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "VITAKINETIC", "", "", 2, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PSYCHIC_KNACK", "", "", 2, "=")
        return true
    end
    return false
    end
    COND["EOC_YOU_ARE_IN_NETHER_POWER_BOOST"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx))) == true
    end
    EOC["EOC_YOU_ARE_IN_NETHER_POWER_BOOST"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx))) then
        H.set_spell_adj(H.u(ctx), "caster_level", "BIOKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "CLAIRSENTIENT", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "ELECTROKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PHOTOKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PYROKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPATH", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPORTER", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "VITAKINETIC", "", "", 4, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PSYCHIC_KNACK", "", "", 4, "=")
        return true
    end
    return false
    end
    COND["EOC_INTERSTICE_MOM_PHYSIOLOGY_REDUCES_POWER_COST"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "INTERSTICE_PHYSIOLOGY") == 1)) == true
    end
    EOC["EOC_INTERSTICE_MOM_PHYSIOLOGY_REDUCES_POWER_COST"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "INTERSTICE_PHYSIOLOGY") == 1)) then
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", (-0.9), "=")
        return true
    end
    return false
    end
    COND["EOC_MOM_CASCADE_STONE_POWER_BOOST"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_mom_cascade_stone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MOM_CASCADE_STONE_POWER_BOOST"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_mom_cascade_stone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", (-0.9), "=")
        return true
    end
    return false
    end
    COND["EOC_MOM_CASCADE_STONE_CONSEQUENCES"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((function() local eg = H.safe_id('effect', "effect_mom_cascade_stone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_MOM_CASCADE_STONE_CONSEQUENCES"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((function() local eg = H.safe_id('effect', "effect_mom_cascade_stone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        if (services.random.native_int(0, H.round_half_away(1)) >= 1) then
            H.set_char_health(H.u(ctx), 1, "-=")
        end
        if (services.random.native_int(0, H.round_half_away(8)) >= 7) then
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, 1, { armor_penetration = 999 }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_MOM_PSYCHIC_VAMPIRE_TELEPATHY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "MOM_PSYCHIC_VAMPIRE") == 1) and ((ctx:get_number("success") or 0) == H.global_var_num("true")) and (((("telepathic_blast") == (H.var_str("context", nil, ctx, "spell", ""))))))) == true
    end
    EOC["EOC_MOM_PSYCHIC_VAMPIRE_TELEPATHY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "MOM_PSYCHIC_VAMPIRE") == 1) and ((ctx:get_number("success") or 0) == H.global_var_num("true")) and (((("telepathic_blast") == (H.var_str("context", nil, ctx, "spell", ""))))))) then
        H.set_char_val_extra(H.u(ctx), "focus", (services.random.native_int(0, H.round_half_away(2)) + 1), "+=")
        return true
    end
    return false
    end
    COND["EOC_MOM_PSYCHIC_VAMPIRE_VITAKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "MOM_PSYCHIC_VAMPIRE") == 1) and ((ctx:get_number("success") or 0) == H.global_var_num("true")) and (((("vita_hurt_touch") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("vita_attack_touch") == (H.var_str("context", nil, ctx, "spell", ""))))))) == true
    end
    EOC["EOC_MOM_PSYCHIC_VAMPIRE_VITAKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "MOM_PSYCHIC_VAMPIRE") == 1) and ((ctx:get_number("success") or 0) == H.global_var_num("true")) and (((("vita_hurt_touch") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("vita_attack_touch") == (H.var_str("context", nil, ctx, "spell", ""))))))) then
        H.run_eoc("EOC_MOM_PSYCHIC_VAMPIRE_HEAL_HP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSI_EXTENDED_CHANNELING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1)) == true
    end
    EOC["EOC_PSI_EXTENDED_CHANNELING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1)) then
        H.set_spell_adj(H.u(ctx), "casting_time", "", "", "", 4, "=")
        return true
    end
    return false
    end
    COND["EOC_NETHER_ATTUNEMENT_BOOST"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_nether_attunement_power_surge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_NETHER_ATTUNEMENT_BOOST"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_nether_attunement_power_surge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "caster_level", "BIOKINETIC", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "CLAIRSENTIENT", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "ELECTROKINETIC", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PHOTOKINETIC", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "PYROKINETIC", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEKINETIC", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPATH", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "TELEPORTER", "", "", 3, "=")
        H.set_spell_adj(H.u(ctx), "caster_level", "VITAKINETIC", "", "", 3, "=")
        return true
    end
    return false
    end
    EOC["EOC_END_PSI_POWERS"] = function(ctx)
    H.run_eoc("EOC_BIOKIN_REMOVE_OVERCOME_PAIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_BREATHE_SKIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_HARDENED_SKIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_CLIMATE_CONTROL", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_HAMMERHAND", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_REFLEX_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_COMBAT_DANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_PERFECTED_MOTION", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_BETTER_SENSES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_NIGHT_EYES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SPEED_READ", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_DANGER_SENSE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SEE_AURAS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_DODGE_POWER", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_CLEAR_SIGHT", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_GROUP_TACTICS", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_REDUCE_PAIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_SPEED_BOOST", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_DODGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_CAMOUFLAGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_HIDE_UGLY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_RADIO", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_INVISIBILITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_BLINDING_GLARE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_FIRE_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_WARMTH_CLOAK", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYROKIN_REMOVE_BLAZING_AURA", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_TORCH_WELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYROKIN_REMOVE_FLAME_IMMUNITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_MOMENTUM", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_WATER_WALKING", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_LIFTING_FIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_JACKING_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_LEVITATION", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_SENSE_MINDS", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_EPHEMERAL_WALK", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_STRIDE", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_WARPED_STRIKES", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_WARPER_COMBAT", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_SLOW_BLEEDING", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_HEALTH_POWER", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_CURE_DISEASE", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_INCREASED_HP", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_SUPER_HEAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH", ctx, nil, nil, nil)
    do local _eg = H.safe_id('effect', "effect_biokin_sealed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_clair_sense_rads_self"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_clair_perfect_shot"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_clair_omniscence"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_photokin_arms"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_telekinetic_slowfall"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_telekinetic_aegis"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_telepath_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_telepath_network_effect"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_vitakin_purge_rads"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_psi_intense_concentration"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local g = H.safe_id('item', "clair_sense_rad_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local _a, _v = H.u(ctx), "vitamin_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    EOC["EOC_END_PSI_POWERS_SPECIFIC"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_OVERCOME_PAIN"] == nil or E.cond["EOC_BIOKIN_REMOVE_OVERCOME_PAIN"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Overcome Pain")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(1)] = "EOC_BIOKIN_REMOVE_OVERCOME_PAIN" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE"] == nil or E.cond["EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Physical Enhancement")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(2)] = "EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_BREATHE_SKIN"] == nil or E.cond["EOC_BIOKIN_REMOVE_BREATHE_SKIN"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Oxygen Absorption")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(3)] = "EOC_BIOKIN_REMOVE_BREATHE_SKIN" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_HARDENED_SKIN"] == nil or E.cond["EOC_BIOKIN_REMOVE_HARDENED_SKIN"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Hardened Skin")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(4)] = "EOC_BIOKIN_REMOVE_HARDENED_SKIN" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_CLIMATE_CONTROL"] == nil or E.cond["EOC_BIOKIN_REMOVE_CLIMATE_CONTROL"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Temperature Adaptability")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(5)] = "EOC_BIOKIN_REMOVE_CLIMATE_CONTROL" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY"] == nil or E.cond["EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Enhance Mobility")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(6)] = "EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION"] == nil or E.cond["EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Guided Evolution")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(7)] = "EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_HAMMERHAND"] == nil or E.cond["EOC_BIOKIN_REMOVE_HAMMERHAND"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Hammerhand")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(8)] = "EOC_BIOKIN_REMOVE_HAMMERHAND" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_REFLEX_ENHANCE"] == nil or E.cond["EOC_BIOKIN_REMOVE_REFLEX_ENHANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Heightened Reflexes")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(9)] = "EOC_BIOKIN_REMOVE_REFLEX_ENHANCE" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE"] == nil or E.cond["EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Metabolic Hyperefficiency")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(10)] = "EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_COMBAT_DANCE"] == nil or E.cond["EOC_BIOKIN_REMOVE_COMBAT_DANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(11), label = ctx:expand_text(services.translate("Combat Dance")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(11)] = "EOC_BIOKIN_REMOVE_COMBAT_DANCE" end end
        do local _en = (E.cond["EOC_BIOKIN_REMOVE_PERFECTED_MOTION"] == nil or E.cond["EOC_BIOKIN_REMOVE_PERFECTED_MOTION"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(12), label = ctx:expand_text(services.translate("Perfected Motion")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(12)] = "EOC_BIOKIN_REMOVE_PERFECTED_MOTION" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_BETTER_SENSES"] == nil or E.cond["EOC_CLAIR_REMOVE_BETTER_SENSES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(13), label = ctx:expand_text(services.translate("Heightened Senses")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(13)] = "EOC_CLAIR_REMOVE_BETTER_SENSES" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_NIGHT_EYES"] == nil or E.cond["EOC_CLAIR_REMOVE_NIGHT_EYES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(14), label = ctx:expand_text(services.translate("Night Eyes")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(14)] = "EOC_CLAIR_REMOVE_NIGHT_EYES" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_SPEED_READ"] == nil or E.cond["EOC_CLAIR_REMOVE_SPEED_READ"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(15), label = ctx:expand_text(services.translate("Speed Reader")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(15)] = "EOC_CLAIR_REMOVE_SPEED_READ" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_DANGER_SENSE"] == nil or E.cond["EOC_CLAIR_REMOVE_DANGER_SENSE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(16), label = ctx:expand_text(services.translate("Premonition")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(16)] = "EOC_CLAIR_REMOVE_DANGER_SENSE" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_SEE_AURAS"] == nil or E.cond["EOC_CLAIR_REMOVE_SEE_AURAS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(17), label = ctx:expand_text(services.translate("Aura Sight")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(17)] = "EOC_CLAIR_REMOVE_SEE_AURAS" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_RANGED_ENHANCE"] == nil or E.cond["EOC_CLAIR_REMOVE_RANGED_ENHANCE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(18), label = ctx:expand_text(services.translate("Marksman's Eye")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(18)] = "EOC_CLAIR_REMOVE_RANGED_ENHANCE" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES"] == nil or E.cond["EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(19), label = ctx:expand_text(services.translate("Sense Hostility")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(19)] = "EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_DODGE_POWER"] == nil or E.cond["EOC_CLAIR_REMOVE_DODGE_POWER"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(20), label = ctx:expand_text(services.translate("Combat Sense")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(20)] = "EOC_CLAIR_REMOVE_DODGE_POWER" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_CRAFT_BONUS"] == nil or E.cond["EOC_CLAIR_REMOVE_CRAFT_BONUS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(21), label = ctx:expand_text(services.translate("Intuitive Artisan")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(21)] = "EOC_CLAIR_REMOVE_CRAFT_BONUS" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_CLEAR_SIGHT"] == nil or E.cond["EOC_CLAIR_REMOVE_CLEAR_SIGHT"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(22), label = ctx:expand_text(services.translate("Clarity")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(22)] = "EOC_CLAIR_REMOVE_CLEAR_SIGHT" end end
        do local _en = (E.cond["EOC_CLAIR_REMOVE_GROUP_TACTICS"] == nil or E.cond["EOC_CLAIR_REMOVE_GROUP_TACTICS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(23), label = ctx:expand_text(services.translate("Prescient Tactician")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(23)] = "EOC_CLAIR_REMOVE_GROUP_TACTICS" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(24), label = ctx:expand_text(services.translate("Spark Sight")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(24)] = "EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(25), label = ctx:expand_text(services.translate("Electrical Discharge")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(25)] = "EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(26), label = ctx:expand_text(services.translate("Voltaic Strikes")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(26)] = "EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(27), label = ctx:expand_text(services.translate("Hacking Interface")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(27)] = "EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(28), label = ctx:expand_text(services.translate("Electron Overflow")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(28)] = "EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_REDUCE_PAIN"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_REDUCE_PAIN"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(29), label = ctx:expand_text(services.translate("Pain Suppression")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(29)] = "EOC_ELECTROKIN_REMOVE_REDUCE_PAIN" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_SPEED_BOOST"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_SPEED_BOOST"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(30), label = ctx:expand_text(services.translate("Neuro-acceleration")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(30)] = "EOC_ELECTROKIN_REMOVE_SPEED_BOOST" end end
        do local _en = (E.cond["EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA"] == nil or E.cond["EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(31), label = ctx:expand_text(services.translate("Galvanic Aura")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(31)] = "EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(32), label = ctx:expand_text(services.translate("Candle's Glow")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(32)] = "EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_LIGHT_DODGE"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_LIGHT_DODGE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(33), label = ctx:expand_text(services.translate("Trick of the Light")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(33)] = "EOC_PHOTOKIN_REMOVE_LIGHT_DODGE" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(34), label = ctx:expand_text(services.translate("Lucent Barrier")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(34)] = "EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_CAMOUFLAGE"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_CAMOUFLAGE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(35), label = ctx:expand_text(services.translate("Chameleoflage")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(35)] = "EOC_PHOTOKIN_REMOVE_CAMOUFLAGE" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_HIDE_UGLY"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_HIDE_UGLY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(36), label = ctx:expand_text(services.translate("Mirror-Mask")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(36)] = "EOC_PHOTOKIN_REMOVE_HIDE_UGLY" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_RADIO"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_RADIO"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(37), label = ctx:expand_text(services.translate("Radio Transception")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(37)] = "EOC_PHOTOKIN_REMOVE_RADIO" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_INVISIBILITY"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_INVISIBILITY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(38), label = ctx:expand_text(services.translate("Veil of Light")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(38)] = "EOC_PHOTOKIN_REMOVE_INVISIBILITY" end end
        do local _en = (E.cond["EOC_PHOTOKIN_REMOVE_BLINDING_GLARE"] == nil or E.cond["EOC_PHOTOKIN_REMOVE_BLINDING_GLARE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(39), label = ctx:expand_text(services.translate("Blinding Radiance")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(39)] = "EOC_PHOTOKIN_REMOVE_BLINDING_GLARE" end end
        do local _en = (E.cond["EOC_PYRO_REMOVE_FIRE_TOOL"] == nil or E.cond["EOC_PYRO_REMOVE_FIRE_TOOL"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(40), label = ctx:expand_text(services.translate("Banked Flames")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(40)] = "EOC_PYRO_REMOVE_FIRE_TOOL" end end
        do local _en = (E.cond["EOC_PYRO_REMOVE_WARMTH_CLOAK"] == nil or E.cond["EOC_PYRO_REMOVE_WARMTH_CLOAK"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(41), label = ctx:expand_text(services.translate("Cloak of Warmth")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(41)] = "EOC_PYRO_REMOVE_WARMTH_CLOAK" end end
        do local _en = (E.cond["EOC_PYROKIN_REMOVE_BLAZING_AURA"] == nil or E.cond["EOC_PYROKIN_REMOVE_BLAZING_AURA"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(42), label = ctx:expand_text(services.translate("Blazing Aura")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(42)] = "EOC_PYROKIN_REMOVE_BLAZING_AURA" end end
        do local _en = (E.cond["EOC_PYRO_REMOVE_TORCH_WELD"] == nil or E.cond["EOC_PYRO_REMOVE_TORCH_WELD"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(43), label = ctx:expand_text(services.translate("Incandescent Lance")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(43)] = "EOC_PYRO_REMOVE_TORCH_WELD" end end
        do local _en = (E.cond["EOC_PYROKIN_REMOVE_FLAME_IMMUNITY"] == nil or E.cond["EOC_PYROKIN_REMOVE_FLAME_IMMUNITY"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(44), label = ctx:expand_text(services.translate("Flameshield")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(44)] = "EOC_PYROKIN_REMOVE_FLAME_IMMUNITY" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_MOMENTUM"] == nil or E.cond["EOC_TELEKIN_REMOVE_MOMENTUM"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(45), label = ctx:expand_text(services.translate("Momentum Alteration")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(45)] = "EOC_TELEKIN_REMOVE_MOMENTUM" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_WATER_WALKING"] == nil or E.cond["EOC_TELEKIN_REMOVE_WATER_WALKING"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(46), label = ctx:expand_text(services.translate("Water Walking")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(46)] = "EOC_TELEKIN_REMOVE_WATER_WALKING" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_LIFTING_FIELD"] == nil or E.cond["EOC_TELEKIN_REMOVE_LIFTING_FIELD"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(47), label = ctx:expand_text(services.translate("Lifting Field")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(47)] = "EOC_TELEKIN_REMOVE_LIFTING_FIELD" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH"] == nil or E.cond["EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(48), label = ctx:expand_text(services.translate("Enhance Strength")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(48)] = "EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_SHIELD"] == nil or E.cond["EOC_TELEKIN_REMOVE_SHIELD"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(49), label = ctx:expand_text(services.translate("Inertial Barrier")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(49)] = "EOC_TELEKIN_REMOVE_SHIELD" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_JACKING_TOOL"] == nil or E.cond["EOC_TELEKIN_REMOVE_JACKING_TOOL"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(50), label = ctx:expand_text(services.translate("Lift Vehicle")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(50)] = "EOC_TELEKIN_REMOVE_JACKING_TOOL" end end
        do local _en = (E.cond["EOC_TELEKIN_REMOVE_LEVITATION"] == nil or E.cond["EOC_TELEKIN_REMOVE_LEVITATION"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(51), label = ctx:expand_text(services.translate("Levitation")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(51)] = "EOC_TELEKIN_REMOVE_LEVITATION" end end
        do local _en = (E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION"] == nil or E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(52), label = ctx:expand_text(services.translate("Concentration Trance")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(52)] = "EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION" end end
        do local _en = (E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD"] == nil or E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(53), label = ctx:expand_text(services.translate("Telepathic Shield")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(53)] = "EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD" end end
        do local _en = (E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE"] == nil or E.cond["EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(54), label = ctx:expand_text(services.translate("Mood Stabilization")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(54)] = "EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE" end end
        do local _en = (E.cond["EOC_TELEPATH_REMOVE_SENSE_MINDS"] == nil or E.cond["EOC_TELEPATH_REMOVE_SENSE_MINDS"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(55), label = ctx:expand_text(services.translate("Sense Minds")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(55)] = "EOC_TELEPATH_REMOVE_SENSE_MINDS" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_EPHEMERAL_WALK"] == nil or E.cond["EOC_TELEPORT_REMOVE_EPHEMERAL_WALK"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(56), label = ctx:expand_text(services.translate("Ephemeral Walk")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(56)] = "EOC_TELEPORT_REMOVE_EPHEMERAL_WALK" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_STRIDE"] == nil or E.cond["EOC_TELEPORT_REMOVE_STRIDE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(57), label = ctx:expand_text(services.translate("Extended Stride")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(57)] = "EOC_TELEPORT_REMOVE_STRIDE" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT"] == nil or E.cond["EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(58), label = ctx:expand_text(services.translate("Reactive Displacement")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(58)] = "EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT"] == nil or E.cond["EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(59), label = ctx:expand_text(services.translate("Loci Establishment")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(59)] = "EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_WARPED_STRIKES"] == nil or E.cond["EOC_TELEPORT_REMOVE_WARPED_STRIKES"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(60), label = ctx:expand_text(services.translate("Warped Strikes")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(60)] = "EOC_TELEPORT_REMOVE_WARPED_STRIKES" end end
        do local _en = (E.cond["EOC_TELEPORT_REMOVE_WARPER_COMBAT"] == nil or E.cond["EOC_TELEPORT_REMOVE_WARPER_COMBAT"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(61), label = ctx:expand_text(services.translate("Flickerflash Stance")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(61)] = "EOC_TELEPORT_REMOVE_WARPER_COMBAT" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_SLOW_BLEEDING"] == nil or E.cond["EOC_VITAKIN_REMOVE_SLOW_BLEEDING"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(62), label = ctx:expand_text(services.translate("Coagulation")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(62)] = "EOC_VITAKIN_REMOVE_SLOW_BLEEDING" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING"] == nil or E.cond["EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(63), label = ctx:expand_text(services.translate("Leukocyte Accumulation")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(63)] = "EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_HEALTH_POWER"] == nil or E.cond["EOC_VITAKIN_REMOVE_HEALTH_POWER"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(64), label = ctx:expand_text(services.translate("Healthy Glow")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(64)] = "EOC_VITAKIN_REMOVE_HEALTH_POWER" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_CURE_DISEASE"] == nil or E.cond["EOC_VITAKIN_REMOVE_CURE_DISEASE"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(65), label = ctx:expand_text(services.translate("Immunostimulus")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(65)] = "EOC_VITAKIN_REMOVE_CURE_DISEASE" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_INCREASED_HP"] == nil or E.cond["EOC_VITAKIN_REMOVE_INCREASED_HP"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(66), label = ctx:expand_text(services.translate("Augment Durability")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(66)] = "EOC_VITAKIN_REMOVE_INCREASED_HP" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP"] == nil or E.cond["EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(67), label = ctx:expand_text(services.translate("Selective Autosomnia")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(67)] = "EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_SUPER_HEAL"] == nil or E.cond["EOC_VITAKIN_REMOVE_SUPER_HEAL"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(68), label = ctx:expand_text(services.translate("Anabolic Rejuvenation")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(68)] = "EOC_VITAKIN_REMOVE_SUPER_HEAL" end end
        do local _en = (E.cond["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH"] == nil or E.cond["EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(69), label = ctx:expand_text(services.translate("Accelerated Resuscitation")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(69)] = "EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH" end end
        do local _en = (E.cond["EOC_MOM_NO_EFFECT"] == nil or E.cond["EOC_MOM_NO_EFFECT"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(70), label = ctx:expand_text(services.translate("cancel")), description = nil, enabled = _en, hotkey = nil }); _targets[tostring(70)] = "EOC_MOM_NO_EFFECT" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Stop concentrating on which power?")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_MOM_PSYCHIC_VAMPIRE_HEAL_HP"] = function(ctx)
    H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_MOM_NO_EFFECT"] = function(ctx)
    return true
    end
    EOC["EOC_END_PSI_POWERS_MAINTAINED"] = function(ctx)
    H.run_eoc("EOC_BIOKIN_REMOVE_OVERCOME_PAIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_PHYSICAL_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_BREATHE_SKIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_HARDENED_SKIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_CLIMATE_CONTROL", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_ENHANCE_MOBILITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_GUIDED_EVOLUTION", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_HAMMERHAND", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_REFLEX_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_COMBAT_DANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_BIOKIN_REMOVE_PERFECTED_MOTION", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_BETTER_SENSES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_NIGHT_EYES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SPEED_READ", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_DANGER_SENSE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SEE_AURAS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_DODGE_POWER", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SENSE_HOSTILE_CREATURES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_CLEAR_SIGHT", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_GROUP_TACTICS", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_SEE_ELECTRICITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_ZAP_ENEMIES", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_MELEE_ATTACKS", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_HACKING_INTERFACE", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_PERSONAL_BATTERY", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_REDUCE_PAIN", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_SPEED_BOOST", ctx, nil, nil, nil)
    H.run_eoc("EOC_ELECTROKIN_REMOVE_LIGHTNING_AURA", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_DODGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_RAD_IMMUNITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_CAMOUFLAGE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_HIDE_UGLY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_RADIO", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_INVISIBILITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_BLINDING_GLARE", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_FIRE_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_WARMTH_CLOAK", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYROKIN_REMOVE_BLAZING_AURA", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_TORCH_WELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYROKIN_REMOVE_FLAME_IMMUNITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_MOMENTUM", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_WATER_WALKING", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_LIFTING_FIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_JACKING_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_LEVITATION", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_SENSE_MINDS", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_EPHEMERAL_WALK", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_STRIDE", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_REACTIVE_DISPLACEMENT", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_LOCI_ESTABLISHMENT", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_WARPED_STRIKES", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPORT_REMOVE_WARPER_COMBAT", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_SLOW_BLEEDING", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_CONCENTRATED_HEALING", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_HEALTH_POWER", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_CURE_DISEASE", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_INCREASED_HP", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_SUPER_HEAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_VITAKIN_REMOVE_RETURN_FROM_DEATH", ctx, nil, nil, nil)
    do local _a, _v = H.u(ctx), "vitamin_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _eg = H.safe_id('effect', "effect_psi_intense_concentration"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR"] = function(ctx)
    H.run_eoc("EOC_PSIONICS_KCAL_COST", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC" }) and (not (((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC" }) and (not (((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.run_eoc("EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_vita_health"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_VITAKIN_HEALTH_POWER_VS_PRE_COMMON_COLD", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_HEALTH_POWER_VS_PRE_FLU", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_VIRAL", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_BACTERIA", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_VS_PRE_COMMON_COLD"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_VS_PRE_COMMON_COLD"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_common_cold_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_VS_PRE_FLU"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_VS_PRE_FLU"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_flu_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_VIRAL"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_VIRAL"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "pre_conjunctivitis_viral"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_conjunctivitis_viral_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_BACTERIA"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) == true
    end
    EOC["EOC_VITAKIN_HEALTH_POWER_VS_PRE_CONJUNCTIVITIS_BACTERIA"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "pre_conjunctivitis_bacterial"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability(((10 + H.char_spell_level(H.u(ctx), "vita_health_power"))), (100)))) then
        H.eoc_add_effect(H.u(ctx), "effect_vita_health_conjunctivitis_bacterial_protection", 864000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SPAWN_SHADOW_PREMONITION"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) == true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_PREMONITION"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("The darkness takes on a palpable sense of menace.  Something terrible is coming.")))
        if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _t = math.max(1, math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 5) + (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 10)) + 10))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LIEUTENANT_SPAWN_SHADOW_NOW"), nil) end end
        end
        if ((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 5) + 10))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LIEUTENANT_SPAWN_SHADOW_NOW"), nil) end end
        else
            do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 10) + 10))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LIEUTENANT_SPAWN_SHADOW_NOW"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW_NOW", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_PREP"] = function(ctx)
    H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW_PREMONITION", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_BANDIT_ASSASSIN_1_PREMONITION"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_1_PREMONITION"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel hostile eyes watching you and rapidly getting closer.  Someone has it in for you.")))
        if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _t = math.max(1, math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8)) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_1_ACTUAL_FAR"), nil) end end
        end
        if ((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_1_ACTUAL_FAR"), nil) end end
        else
            do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_1_ACTUAL_FAR"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_BANDIT_ASSASSIN_1_ACTUAL_NEAR", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BANDIT_ASSASSIN"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-40)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-60)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-40)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-60)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.run_eoc("EOC_BANDIT_ASSASSIN_1_PREMONITION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_BANDIT_ASSASSIN_1_ACTUAL_NEAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    EOC["EOC_BANDIT_ASSASSIN_1_ACTUAL_FAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    COND["EOC_BANDIT_ASSASSIN_2_PREMONITION"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_2_PREMONITION"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel hostile eyes watching you and rapidly getting closer.  Someone has it in for you.")))
        if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _t = math.max(1, math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8)) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_2_ACTUAL_FAR"), nil) end end
        end
        if ((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_2_ACTUAL_FAR"), nil) end end
        else
            do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_2_ACTUAL_FAR"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_BANDIT_ASSASSIN_2_ACTUAL_NEAR", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BANDIT_ASSASSIN_2"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-60)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 15) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_2"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-60)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 15) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.run_eoc("EOC_BANDIT_ASSASSIN_2_PREMONITION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_BANDIT_ASSASSIN_2_ACTUAL_NEAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    EOC["EOC_BANDIT_ASSASSIN_2_ACTUAL_FAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    COND["EOC_BANDIT_ASSASSIN_3_PREMONITION"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_3_PREMONITION"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel several sets of hostile eyes watching you and rapidly getting closer.  Someone has it in for you.")))
        if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _t = math.max(1, math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8)) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_3_ACTUAL_FAR"), nil) end end
        end
        if ((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_3_ACTUAL_FAR"), nil) end end
        else
            do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BANDIT_ASSASSIN_3_ACTUAL_FAR"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_BANDIT_ASSASSIN_3_ACTUAL_NEAR", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BANDIT_ASSASSIN_3"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 21) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_3"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 21) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.run_eoc("EOC_BANDIT_ASSASSIN_3_PREMONITION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_BANDIT_ASSASSIN_3_ACTUAL_NEAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    EOC["EOC_BANDIT_ASSASSIN_3_ACTUAL_FAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A rough-looking person steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
    return true
    end
    COND["EOC_OLD_GUARD_ASSASSIN_PREMONITION"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) == true
    end
    EOC["EOC_OLD_GUARD_ASSASSIN_PREMONITION"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_clair_premonition") or H.creature_has_effect(H.u(ctx), "effect_clair_sense_hostile_creatures"))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel several sets of hostile eyes watching you and rapidly getting closer.  Someone has it in for you.")))
        if (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_clair_sense_hostile_creatures"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
            do local _t = math.max(1, math.floor(((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8)) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_OLD_GUARD_ASSASSIN_ACTUAL_FAR"), nil) end end
        end
        if ((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "clair_danger_sense") + H.char_spell_level(H.u(ctx), "clair_danger_sense_knack")) * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_OLD_GUARD_ASSASSIN_ACTUAL_FAR"), nil) end end
        else
            do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") * 8) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_OLD_GUARD_ASSASSIN_ACTUAL_FAR"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_OLD_GUARD_ASSASSIN_ACTUAL_NEAR", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_OLD_GUARD_ASSASSIN"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "old_guard"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-45)) and (H.var_num(H.u(ctx), "government_assassins_sent") <= 6) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_OLD_GUARD_ASSASSIN"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "old_guard"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-45)) and (H.var_num(H.u(ctx), "government_assassins_sent") <= 6) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.run_eoc("EOC_OLD_GUARD_ASSASSIN_PREMONITION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_OLD_GUARD_ASSASSIN_ACTUAL_NEAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A professional-looking individual steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = false }, "A professional-looking individual steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "government_assassins_sent", (H.var_num(H.u(ctx), "government_assassins_sent")) + (2))
    return true
    end
    EOC["EOC_OLD_GUARD_ASSASSIN_ACTUAL_FAR"] = function(ctx)
    H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A professional-looking individual steps out of hiding and begins rapidly approaching you.")
    H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(25), max_radius = math.floor(40), outdoor_only = false }, "A professional-looking individual steps out of hiding and begins rapidly approaching you.")
    H.set_var("actor", H.u(ctx), ctx, "government_assassins_sent", (H.var_num(H.u(ctx), "government_assassins_sent")) + (2))
    return true
    end
    COND["EOC_MOM_PREMONITION_QUIET_FARMSTEAD_WARNING"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "effect_premonition_quiet_farm_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "NOT_GLASS") == 1))) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(2)) end)())))) == true
    end
    EOC["EOC_MOM_PREMONITION_QUIET_FARMSTEAD_WARNING"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "effect_premonition_quiet_farm_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "NOT_GLASS") == 1))) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_1", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(2)) end)())))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As you approach the farmhouse the hair rises on the back of your neck.  Despite the calm appearance you have a distinct sense of danger here.  Things are not as they seem.")))
        H.eoc_add_effect(H.u(ctx), "effect_premonition_quiet_farm_limiter", 86400, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_quietfarm_nearby_popup_welcome_message"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_quietfarm_nearby_popup_welcome_message"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_clair_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You arrive at the farmhouse, after what feels like an eternity.  It's not quite what you were expecting, but it's very peaceful.")))
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("You arrive at the farmhouse, after what feels like an eternity.  Despite the peaceful surroundings, your sense of danger only grows.  Something is very wrong here.")))
        return false
    end
    end
    COND["EOC_PERK_BURNING_BRIGHT_CHANNELING_FINISH_RAISE_ATTUNEMENT"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1)) == true
    end
    EOC["EOC_PERK_BURNING_BRIGHT_CHANNELING_FINISH_RAISE_ATTUNEMENT"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1)) then
        H.run_eoc("EOC_PERK_BURNING_BRIGHT_RAISE_ATTUNEMENT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") == 0))) == true
    end
    EOC["EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") == 0))) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_IN_THE_ZONE_ADD_EFFECT_TRIGGER"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (not (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_has_trait(H.u(ctx), "perk_in_the_zone") == 1))) == true
    end
    EOC["EOC_PERK_IN_THE_ZONE_ADD_EFFECT_TRIGGER"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (not (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_has_trait(H.u(ctx), "perk_in_the_zone") == 1))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_in_the_zone", 5, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_perk_in_the_zone_rate_limiter", 0, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_IN_THE_ZONE_REMOVE_EFFECT_TRIGGER"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_has_trait(H.u(ctx), "perk_in_the_zone") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone_rate_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_PERK_IN_THE_ZONE_REMOVE_EFFECT_TRIGGER"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_has_trait(H.u(ctx), "perk_in_the_zone") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone_rate_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_perk_in_the_zone"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_IN_THE_ZONE_ACTUAL_COST_ADJUSTMENT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PERK_IN_THE_ZONE_ACTUAL_COST_ADJUSTMENT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_perk_in_the_zone"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", (-0.25), "=")
        return true
    end
    return false
    end
end
