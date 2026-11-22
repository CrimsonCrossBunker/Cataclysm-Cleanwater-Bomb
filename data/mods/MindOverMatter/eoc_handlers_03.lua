local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEPATHY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) and ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEPATHY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) and ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEPATHY_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPORTATION"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPORTATION"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_VITAKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_VITAKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) and ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) and ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_3"] = function(ctx)
        return ((H.var_num(H.u(ctx), "using_appropriate_matrix_crystal_for_dissipation") ~= 1)) == true
    end
    EOC["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_3"] = function(ctx)
    if ((H.var_num(H.u(ctx), "using_appropriate_matrix_crystal_for_dissipation") ~= 1)) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(4)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(1)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_2"] = function(ctx)
        return (services.random.native_probability((((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2) + 250)), (1000))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_2"] = function(ctx)
    if (services.random.native_probability((((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2) + 250)), (1000))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_3", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_3"] = function(ctx)
        return ((H.var_num(H.u(ctx), "using_appropriate_matrix_crystal_for_dissipation") ~= 1)) == true
    end
    EOC["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_3"] = function(ctx)
    if ((H.var_num(H.u(ctx), "using_appropriate_matrix_crystal_for_dissipation") ~= 1)) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(7)) + 1); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(2)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_2"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)) == true
    end
    EOC["EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_2"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)) then
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_3", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_LOCATION_CHECKER"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx)) == true
    end
    EOC["EOC_POWERS_IN_NETHER_LOCATION_CHECKER"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx)) then
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER_NEAR_NETHER_2", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER_IN_NETHER_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_in_the_nether_warning_timer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_in_the_nether_warning_timer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_in_the_nether_warning_timer", 7200, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange fluctuation in the energies, but the matrix crystal you're holding seems to dissipate it.  Still, there's something odd about this place.")), "mixed")
        H.set_var("actor", H.u(ctx), ctx, "using_appropriate_matrix_crystal_for_dissipation", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "using_appropriate_matrix_crystal_for_dissipation", 1)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_in_the_nether_warning_timer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_in_the_nether_warning_timer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_in_the_nether_warning_timer", 7200, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a strange fluctuation in the energies.  There's something odd about this place.")), "mixed")
        H.set_var("actor", H.u(ctx), ctx, "using_appropriate_matrix_crystal_for_dissipation", 0)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "using_appropriate_matrix_crystal_for_dissipation", 0)
        return false
    end
    end
    COND["EOC_CONCENTRATION_IN_NETHER_AREAS_ATTUNEMENT"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx))) == true
    end
    EOC["EOC_CONCENTRATION_IN_NETHER_AREAS_ATTUNEMENT"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx))) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(2)) + 1); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_CHANNEL_TELEPORTER_POWERS_WHILE_THE_HOUNDS_ARE_WATCHING"] = function(ctx)
        return ((((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and ((function() local eg = H.safe_id('effect', "effect_teleport_mishap_tindrift_warning"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_CHANNEL_TELEPORTER_POWERS_WHILE_THE_HOUNDS_ARE_WATCHING"] = function(ctx)
    if ((((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and ((function() local eg = H.safe_id('effect', "effect_teleport_mishap_tindrift_warning"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_teleport_mishap_tindrift_warning"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("…but it's because the hunters have found you.")), "bad")
        H.eoc_add_effect(H.u(ctx), "tindrift", 86400, nil, nil, nil)
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_hound_tindalos") or H.safe_id('monster_group', "mon_hound_tindalos"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((services.random.native_int(0, H.round_half_away(3)) + 2)), min_radius = math.floor(2), max_radius = math.floor(8) }); 
        end end
        if (services.random.native_int(0, H.round_half_away(100)) >= 96) then
            do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_tindalos") or H.safe_id('monster_group', "mon_tindalos"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(1), max_radius = math.floor(4) }); 
            end end
        end
        return true
    end
    return false
    end
    EOC["EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN_ACTIVE"] = function(ctx)
    H.set_bionic_power(H.npc(ctx), (services.random.native_int(0, H.round_half_away(2)) + 1), "-=")
    return true
    end
    COND["EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_nether_attunement_electrokinetic_power_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_nether_attunement_electrokinetic_power_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(services.random.native_float(30, 120)), math.floor(services.random.native_float(90, 360)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN"), nil) end end
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN_ACTIVE" }, {  })
        return true
    end
    return false
    end
    COND["EOC_MOM_TELEPORTING_IN_PORTAL_STORM_DUNGEON"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (services.gameplay.environment.dimension() == "portal_storm_dungeon_dimension") and (not (((("teleport_slow") == (H.var_str("context", nil, ctx, "spell", "")))))) and (not (((("teleport_stride") == (H.var_str("context", nil, ctx, "spell", "")))))) and (not (((("teleport_collapse") == (H.var_str("context", nil, ctx, "spell", "")))))))) == true
    end
    EOC["EOC_MOM_TELEPORTING_IN_PORTAL_STORM_DUNGEON"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (services.gameplay.environment.dimension() == "portal_storm_dungeon_dimension") and (not (((("teleport_slow") == (H.var_str("context", nil, ctx, "spell", "")))))) and (not (((("teleport_stride") == (H.var_str("context", nil, ctx, "spell", "")))))) and (not (((("teleport_collapse") == (H.var_str("context", nil, ctx, "spell", "")))))))) then
        if ((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.eoc_add_effect(H.u(ctx), "tindrift", 600, nil, nil, nil)
        end
        if (not (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            if services.random.native_probability(((15 - H.char_skill(H.u(ctx), "metaphysics"))), (15)) then
                H.eoc_add_effect(H.u(ctx), "psi_nether_attention", (43200 + services.random.native_int(0, H.round_half_away(43200))), nil, nil, nil)
                services.messages.add(ctx:expand_text(services.translate("As you come out of a cold and the dark of the teleport the hair rises on the back of your neck.  You don't think that was such a good idea.")), "bad")
            end
        end
        return true
    end
    return false
    end
    COND["EOC_MOM_TELEPORTING_PHASING_IN_PORTAL_STORM_DUNGEON"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "portal_storm_dungeon_dimension")) == true
    end
    EOC["EOC_MOM_TELEPORTING_PHASING_IN_PORTAL_STORM_DUNGEON"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "portal_storm_dungeon_dimension")) then
        if ((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.eoc_add_effect(H.u(ctx), "tindrift", 600, nil, nil, nil)
        end
        if (not (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            if services.random.native_probability(((15 - H.char_skill(H.u(ctx), "metaphysics"))), (15)) then
                H.eoc_add_effect(H.u(ctx), "psi_nether_attention", (43200 + services.random.native_int(0, H.round_half_away(43200))), nil, nil, nil)
                services.messages.add(ctx:expand_text(services.translate("As you appear on the other side of the barrier the hair rises on the back of your neck.  You don't think that was such a good idea.")), "bad")
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_NETHER_AREA_ATTENTION_CHECK"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and services.random.native_probability((services.random.native_int(0, H.round_half_away((((1 + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) * 4) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") * 12))))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_NETHER_AREA_ATTENTION_CHECK"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and services.random.native_probability((services.random.native_int(0, H.round_half_away((((1 + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) * 4) + (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") * 12))))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("The hairs stand up on the back of your neck.  You have a strong feeling that you're being watched.")), "bad")
        H.eoc_add_effect(H.u(ctx), "psi_nether_attention", 604800, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_observed_rate_limiter", ((3600 - (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * services.random.native_float(10, 200))) - (H.creature_effect_intensity(H.u(ctx), "psi_nether_attention") * services.random.native_float(10, 200))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_NETHER_AREA_CHECK"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_observed_rate_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx) or H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_PSIONICS_NETHER_AREA_CHECK"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_observed_rate_limiter"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx) or H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_PSIONICS_NETHER_AREA_ATTENTION_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_OBSERVED_SIDE_EFFECTS"] = function(ctx)
    do
        local _sw17 = H.creature_effect_intensity(H.u(ctx), "psi_nether_attention")
        if _sw17 == 1 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_OBSERVED_EFFECT_HEARING_SOUNDS"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        end
    end
    return true
    end
    EOC["EOC_OBSERVED_EFFECT_HEARING_SOUNDS"] = function(ctx)
    services.messages.add((services.snippets.native_random("observed_effect_hearing_sounds") or ''), "neutral")
    return true
    end
    EOC["EOC_CHECK_NEAR_NETHER_CRYSTAL_FOLLOWUP"] = function(ctx)
    do local _t = math.max(1, math.floor(1800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHECK_NEAR_NETHER_CRYSTAL_FOLLOWUP_2"), nil) end end
    return true
    end
    EOC["EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "near_nether_crystal_coordinate_check", nil, nil, { kind = "furniture", id = H.safe_id("furniture", "f_nether_crystal_structure") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(6) }, nil, false, true, { "EOC_CHECK_NEAR_NETHER_CRYSTAL_FOLLOWUP" }, {  })
    return true
    end
    EOC["EOC_CHECK_NEAR_NETHER_CRYSTAL_FOLLOWUP_2"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "near_nether_crystal_coordinate_check", nil, nil, { kind = "furniture", id = H.safe_id("furniture", "f_nether_crystal_structure") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(6) }, nil, false, true, { "EOC_CHECK_NEAR_NETHER_CRYSTAL_EFFECTS" }, {  })
    return true
    end
    COND["EOC_CHECK_NEAR_NETHER_CRYSTAL_EFFECTS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CHECK_NEAR_NETHER_CRYSTAL_EFFECTS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_OBSERVED_SIDE_EFFECTS", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_AREA_ATTENTION_CHECK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_ATTENTION_NIGHTMARES"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_NETHER_ATTENTION_NIGHTMARES"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (3)))) then
        services.messages.add((services.snippets.native_random("psi_nether_attention_nightmares") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(7)) + 3); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    EOC["EOC_POWER_TOGGLE_REMOVE_EFFECTS"] = function(ctx)
    H.run_eoc("EOC_BIOKIN_REMOVE_METABOLISM_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SPEED_READ", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_SEE_AURAS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CLAIR_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_LOCAL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_HIDE_UGLY", ctx, nil, nil, nil)
    H.run_eoc("EOC_PHOTOKIN_REMOVE_RADIO", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_FIRE_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_PYRO_REMOVE_TORCH_WELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_JACKING_TOOL", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEKIN_REMOVE_LEVITATION", ctx, nil, nil, nil)
    H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION", ctx, nil, nil, nil)
    do local _eg = H.safe_id('effect', "telepathic_ignorance_self"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "effect_clair_perfect_shot"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK_2"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT", ctx)) == true
    end
    EOC["EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK_2"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT", ctx)) then
        H.run_eoc("EOC_POWER_TOGGLE_REMOVE_EFFECTS", ctx, nil, "npc", nil)
        return true
    end
    return false
    end
    COND["EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.run_eoc("EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK_2"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT", ctx)) == true
    end
    EOC["EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK_2"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_LIST_OF_POWERS_CANCELLED_BY_COMBAT", ctx)) then
        H.run_eoc("EOC_POWER_TOGGLE_REMOVE_EFFECTS", ctx, nil, "npc", nil)
        return true
    end
    return false
    end
    COND["EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.run_eoc("EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_BIOKIN_HURRICANE_BLOWS_MOVE_CANCEL"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_biokin_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_biokin_hurricane_blows_2"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_BIOKIN_HURRICANE_BLOWS_MOVE_CANCEL"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_biokin_hurricane_blows"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_biokin_hurricane_blows_2"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_biokin_hurricane_blows"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_biokin_hurricane_blows_2"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_INVISIBILITY_CANCEL_WALK"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))) and services.random.native_probability((math.max((20 - H.char_spell_level(H.u(ctx), "photokinetic_invisibility")), 4)), (1000)))) == true
    end
    EOC["EOC_PHOTOKIN_INVISIBILITY_CANCEL_WALK"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))) and services.random.native_probability((math.max((20 - H.char_spell_level(H.u(ctx), "photokinetic_invisibility")), 4)), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("As you move, light scatters around you in coruscating shards, revealing your position!")), "bad")
        do local _eg = H.safe_id('effect', "effect_photokin_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_INVISIBILITY_CANCEL_RUN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))) and services.random.native_probability((math.max((80 - (H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 3)), 30)), (1000)))) == true
    end
    EOC["EOC_PHOTOKIN_INVISIBILITY_CANCEL_RUN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))) and services.random.native_probability((math.max((80 - (H.char_spell_level(H.u(ctx), "photokinetic_invisibility") * 3)), 30)), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("As you run, a shower of light outlines your path, revealing your position!")), "bad")
        do local _eg = H.safe_id('effect', "effect_photokin_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_DODGE_CANCEL_ATTACKED"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_DODGE_CANCEL_ATTACKED"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_dodge"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_DODGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_BIOKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) and ((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_biokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_BIOKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) and ((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_biokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_biokin_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_CLAIRSENTIENT_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) and ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_clairsentience").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_CLAIRSENTIENT_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) and ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_clairsentience").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "blind_clair_overload", ((2 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "deaf_clair_overload", ((2 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_ELECTROKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) and ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_electrokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_ELECTROKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) and ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_electrokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_overload", ((5 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.run_eoc("EOC_ELECTRO_OVERLOAD_ZAP", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_PHOTOKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_photokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_PHOTOKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_photokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_photokin_myopia_overload", ((15 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_photokin_lumination_overload", ((15 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_PYROKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) and ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_pyrokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_PYROKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) and ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_pyrokinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokin_overload", ((5 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_TELEKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) and ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_telekinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_TELEKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) and ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_telekinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekin_overload", ((15 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_TELEPATH_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) and ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_telepathy").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_TELEPATH_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) and ((("TELEPATH") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_telepathy").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "nightmares", ((1800 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "disrupted_sleep", ((1800 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_TELEPORTER_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_teleportation").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_TELEPORTER_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEPORTER") == 1) and ((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_teleportation").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_portal_storm_teleport", ((1 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_VITAKINETIC_CHANNELING_FAILURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) and ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_vitakinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) == true
    end
    EOC["EOC_PSIONICS_VITAKINETIC_CHANNELING_FAILURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1) and ((("VITAKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_contemplation_vitakinesis").value == true)))) or ((ctx:get_number("success") or 0) == H.global_var_num("false")) or H.test_eoc("EOC_CONDITION_CAUGHT_IN_NETHER_WEATHER", ctx)) and services.random.native_probability((((10 * math.max(1, ((((ctx:get_number("difficulty") or 0) - 1) - (H.char_skill(H.u(ctx), "metaphysics") / 2)) * 15))) + H.char_vitamin(H.u(ctx), "vitamin_psionic_drain"))), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("Your powers rage out of control!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psionic_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_vitakin_overload", ((30 * (1 + (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2))) * services.random.native_float(1, (ctx:get_number("difficulty") or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTRO_OVERLOAD_ZAP"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_electrokin_overload"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ELECTRO_OVERLOAD_ZAP"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_electrokin_overload"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("Your muscles suddenly seize up!")), "bad")
        H.eoc_add_effect(H.u(ctx), "downed", (function() local a, b = math.floor(2), math.floor(8); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "stunned", (function() local a, b = math.floor(1), math.floor(4); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(2700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ELECTRO_OVERLOAD_ZAP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_INITIAL_KCAL_COST"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_PSIONICS_INITIAL_KCAL_COST"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", (ctx:get_number("difficulty") or 0))
        H.run_eoc("EOC_PSIONICS_KCAL_COST", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_POWER_MAINTENANCE_PLUS_ONE"] = function(ctx)
    do local _a, _v = H.u(ctx), "vitamin_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    H.run_eoc("EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_POWER_MAINTENANCE_MINUS_ONE"] = function(ctx)
    do local _a, _v = H.u(ctx), "vitamin_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    H.run_eoc("EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) == true
    end
    EOC["EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" }) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) then
        H.set_var("context", nil, ctx, "debug_maintained_powers", H.char_vitamin(H.u(ctx), "vitamin_maintained_powers"))
        H.set_var("context", nil, ctx, "debug_concentration_calculations", H._jm_concentration_calculations(ctx))
        services.messages.add(ctx:expand_text(services.translate("You are concentrating on <context_val:debug_maintained_powers> / <context_val:debug_concentration_calculations> powers (current/limit).")), "debug")
        H.run_eoc("EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > H._jm_concentration_calculations(ctx)) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) == true
    end
    EOC["EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > H._jm_concentration_calculations(ctx)) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1))) then
        if (not (((function() local eg = H.safe_id('effect', "effect_psi_intense_concentration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            services.messages.add(ctx:expand_text(services.translate("It's taking you a lot of concentration to maintain your powers.  You're not sure you'll be able to do it for very long.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_psi_intense_concentration", -1, nil, nil, nil)
        end
        return true
    else
        if ((function() local eg = H.safe_id('effect', "effect_psi_intense_concentration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            services.messages.add(ctx:expand_text(services.translate("The pressure on your mind lightens.  It's easier to concentrate now.")), "good")
            do local _eg = H.safe_id('effect', "effect_psi_intense_concentration"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return false
    end
    end
    COND["EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= H._jm_concentration_calculations(ctx)) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) and services.random.native_probability(((((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") / math.max(H._jm_concentration_calculations(ctx), 1)) * 5) + (H.clamp_num(H._jm_concentration_calculations(ctx), (-20), 0) * (-10)))), (100)))) == true
    end
    EOC["EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= H._jm_concentration_calculations(ctx)) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) and services.random.native_probability(((((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") / math.max(H._jm_concentration_calculations(ctx), 1)) * 5) + (H.clamp_num(H._jm_concentration_calculations(ctx), (-20), 0) * (-10)))), (100)))) then
        services.messages.add(ctx:expand_text(services.translate("Your concentration breaks!")), "bad")
        H.run_eoc("EOC_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONCENTRATION_FAILURE_REDUCE_FOCUS", ctx, nil, nil, nil)
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = ((services.random.native_float(3, 8) * H.char_vitamin(H.u(ctx), "vitamin_maintained_powers")) / H._jm_concentration_calculations(ctx)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        local _a18 = H.u(ctx)
        local _sg19 = H.safe_id("skill", "metaphysics")
        if _a18 and _sg19 then services.skills.set(_a18, _sg19, { exercise_raw = math.floor((H.char_skill_exp(_a18, "metaphysics", true)) + (((15 * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        H.run_eoc("EOC_CONCENTRATION_CHECK_FOR_NETHER_ATTUNEMENT_BACKLASH", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_CONCENTRATION_SUCCESS_PROFICIENCY", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONCENTRATION_IN_NETHER_AREAS_ATTUNEMENT", ctx, nil, nil, nil)
        H.run_eoc("EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK_CONCENTRATION", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONCENTRATION_SUCCESS_REDUCE_FOCUS", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONCENTRATION_CHECK_FOR_NETHER_ATTUNEMENT_BACKLASH", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
        local _a20 = H.u(ctx)
        local _sg21 = H.safe_id("skill", "metaphysics")
        if _a20 and _sg21 then services.skills.set(_a20, _sg21, { exercise_raw = math.floor((H.char_skill_exp(_a20, "metaphysics", true)) + (((75 * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return false
    end
    end
    COND["EOC_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) == true
    end
    EOC["EOC_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_master", ((services.random.native_int(0, H.round_half_away(4)) / 96) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    end
    return false
    end
    COND["EOC_CONCENTRATION_SUCCESS_PROFICIENCY_INT"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) == true
    end
    EOC["EOC_CONCENTRATION_SUCCESS_PROFICIENCY_INT"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_intermediate", ((services.random.native_int(0, H.round_half_away(4)) / 48) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    else
        H.run_eoc("EOC_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CONCENTRATION_SUCCESS_PROFICIENCY"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) == true
    end
    EOC["EOC_CONCENTRATION_SUCCESS_PROFICIENCY"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value == true))) and (not (H.test_eoc("EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION", ctx))) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_basic", ((services.random.native_int(0, H.round_half_away(4)) / 24) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    else
        H.run_eoc("EOC_CONCENTRATION_SUCCESS_PROFICIENCY_INT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_CONCENTRATION_SUCCESS_REDUCE_FOCUS"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) == true
    end
    EOC["EOC_CONCENTRATION_SUCCESS_REDUCE_FOCUS"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) then
        H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        return true
    end
    return false
    end
    COND["EOC_CONCENTRATION_FAILURE_REDUCE_FOCUS"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 20))) == true
    end
    EOC["EOC_CONCENTRATION_FAILURE_REDUCE_FOCUS"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 20))) then
        H.set_char_val_extra(H.u(ctx), "focus", 5, "-=")
        return true
    end
    return false
    end
    COND["EOC_CONCENTRATION_CHECK_FOR_NETHER_ATTUNEMENT_BACKLASH"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) and services.random.native_probability(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * H._jm_concentration_nether_attunement_influences(ctx))), (2500)))) == true
    end
    EOC["EOC_CONCENTRATION_CHECK_FOR_NETHER_ATTUNEMENT_BACKLASH"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) and services.random.native_probability(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * H._jm_concentration_nether_attunement_influences(ctx))), (2500)))) then
        services.messages.add(ctx:expand_text(services.translate("Your concentration wavers for just a moment.")), "bad")
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_CHANNEL_MAINTENANCE_CHECK"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= H._jm_concentration_calculations(ctx)))) == true
    end
    EOC["EOC_PSIONICS_CHANNEL_MAINTENANCE_CHECK"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= H._jm_concentration_calculations(ctx)))) then
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_CHANNEL_COSTS_FOCUS"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) == true
    end
    EOC["EOC_PSIONICS_CHANNEL_COSTS_FOCUS"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) then
        H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        return true
    end
    return false
    end
end
