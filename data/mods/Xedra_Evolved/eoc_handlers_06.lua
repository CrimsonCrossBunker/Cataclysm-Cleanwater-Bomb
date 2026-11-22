local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_GROWING_WOOD_WALLS_WALL"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "spell_location"), H.safe_id('terrain_furniture_transform', "ter_arvore_wood_wall"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    do local tp = H.get_tripoint_var("context", nil, ctx, "spell_location"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(1)); H.set_var("context", nil, ctx, "spell_location", nt) end end
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "spell_location"), H.safe_id('terrain_furniture_transform', "ter_arvore_wood_wall_top"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
    COND["EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER_2"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "FACTION_CAMP_ANY", math.floor(2)) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_loc"); return p ~= nil and services.overmap.is_in_city(p) == true end)()))) == true
    end
    EOC["EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER_2"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "FACTION_CAMP_ANY", math.floor(2)) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_loc"); return p ~= nil and services.overmap.is_in_city(p) == true end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "homullus_is_in_civilization", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "homullus_is_in_civilization", 0)
        return false
    end
    end
    COND["EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "check_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.run_eoc("EOC_CONDITION_CHECK_HOMULLUS_IN_CIVILIZATION_ON_OMT_ENTER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_HOMULLUS_NEAR_FACTION_ON_OMT_ENTER"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx))) == true
    end
    EOC["EOC_CONDITION_CHECK_HOMULLUS_NEAR_FACTION_ON_OMT_ENTER"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx))) then
        H.set_var("actor", H.u(ctx), ctx, "homullus_is_near_faction", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "homullus_is_near_faction", 0)
        return false
    end
    end
    COND["EOC_CONDITION_HOMULLUS_NEAR_FACTION"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(6)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "isolated_road_field_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_9", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "farm_isherwood_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dairy_farm_isherwood_SW", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ranch_camp_41", math.floor(6)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_5", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_entrance", math.floor(4)) end)()))) == true
    end
    EOC["EOC_CONDITION_HOMULLUS_NEAR_FACTION"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(6)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "isolated_road_field_0", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_9", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "farm_isherwood_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dairy_farm_isherwood_SW", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ranch_camp_41", math.floor(6)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_5", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_entrance", math.floor(4)) end)()))) then
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_IN_CIVILIZATION_CHECKER_CONDITION"] = function(ctx)
        return ((H.var_num(H.u(ctx), "homullus_is_in_civilization") == 1)) == true
    end
    EOC["EOC_HOMULLUS_IN_CIVILIZATION_CHECKER_CONDITION"] = function(ctx)
    if ((H.var_num(H.u(ctx), "homullus_is_in_civilization") == 1)) then
        return true
    end
    return false
    end
    EOC["EOC_HOMULLUS_SELF_DECEPTION"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_homullus_self_deception"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_homullus_self_deception"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(((5 + H.char_spell_level(H.u(ctx), "homullus_self_deception_spell")) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0)))), math.floor(40), { duration = services.time.duration_from_turns(math.floor(((3600 + (H.char_spell_level(H.u(ctx), "homullus_self_deception_spell") * 900)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))))), decay_start = services.time.duration_from_turns(math.floor((((3600 + (H.char_spell_level(H.u(ctx), "homullus_self_deception_spell") * 900)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))) / 2))) }) end end
    return true
    end
    COND["EOC_HOMULLUS_RUNNING_GIVE_STAMINA"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_THE_HUNTER2") == 1) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) == true
    end
    EOC["EOC_HOMULLUS_RUNNING_GIVE_STAMINA"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_THE_HUNTER2") == 1) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) then
        H.set_char_val_extra(H.u(ctx), "stamina", services.random.native_float(40, 65), "+=")
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_INVISIBLE_TO_HUMANS"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).npc == true) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (H.u(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HUMAN")).value == true))))))) == true
    end
    EOC["EOC_HOMULLUS_INVISIBLE_TO_HUMANS"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).npc == true) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (H.u(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HUMAN")).value == true))))))) then
        H.eoc_add_effect(H.u(ctx), "telepathic_ignorance", ((6000 + (H.char_spell_level(H.u(ctx), "homullus_invisible_to_humans_spell") * 3000)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DREAMWALKER_GAIN_DREAMDROSS"] = function(ctx)
        return ((((H.char_has_trait(H.u(ctx), "HOMULLUS_DREAMWALKER") == 1) or (H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_DREAMWALKER") == 1)) and services.random.native_probability((((1 + H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS")) + H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_NOBLE"))), (10)) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))) == true
    end
    EOC["EOC_HOMULLUS_DREAMWALKER_GAIN_DREAMDROSS"] = function(ctx)
    if ((((H.char_has_trait(H.u(ctx), "HOMULLUS_DREAMWALKER") == 1) or (H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_DREAMWALKER") == 1)) and services.random.native_probability((((1 + H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS")) + H.char_has_trait(H.u(ctx), "THRESH_FAIR_FOLK_NOBLE"))), (10)) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))) then
        services.messages.add(ctx:expand_text(services.translate("As you awaken from the remnants of another's dreams, you find scraps of dreamdross next to you.")), "neutral")
        H.eoc_spawn_item(H.u(ctx), "scrap_dreamdross", services.random.native_float(1, 4), false, false, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_GOBLIN_FRUIT"] = function(ctx)
        return (H.test_eoc("EOC_HOMULLUS_IN_CIVILIZATION_CHECKER_CONDITION", ctx)) == true
    end
    EOC["EOC_HOMULLUS_GOBLIN_FRUIT"] = function(ctx)
    if (H.test_eoc("EOC_HOMULLUS_IN_CIVILIZATION_CHECKER_CONDITION", ctx)) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_homullus", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be in the remnants of civilization to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "HOMULLUS_GAIN_BIONIC_POWER", "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA" }))) == true
    end
    EOC["EOC_HOMULLUS_GAIN_BIONIC_POWER_IN_CITIES"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "HOMULLUS_GAIN_BIONIC_POWER", "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA" }))) then
        H.set_bionic_power(H.u(ctx), (1000000 + (1000000 * H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS"))), "+=")
        return true
    end
    return false
    end
    COND["HOMULLUS_MIGRATE_TO_MIMIMIZED_MUTATIONS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS_MINIMIZED_MUTATIONS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS_EXPANDED_MUTATIONS") == 1))))) == true
    end
    EOC["HOMULLUS_MIGRATE_TO_MIMIMIZED_MUTATIONS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS") == 1) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS_MINIMIZED_MUTATIONS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HOMULLUS_EXPANDED_MUTATIONS") == 1))))) then
        do local _g = H.safe_id('mutation', "HOMULLUS_MINIMIZED_MUTATIONS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "HOMULLUS_NO_DOLL_MUTATIONS") == 1)) == true
    end
    EOC["EOC_HOMULLUS_CUT_OFF_FURTHER_HOMULLUS_MUTATIONS_2"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "HOMULLUS_NO_DOLL_MUTATIONS") == 1)) then
        do local _a, _v = H.u(ctx), "mutagen_dollkin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER_2"] = function(ctx)
        return (((H.var_num(H.u(ctx), "doll_form_movement") == 0) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") == 1))) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER_2"] = function(ctx)
    if (((H.var_num(H.u(ctx), "doll_form_movement") == 0) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") == 1))) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_REGAIN", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1)) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1)) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_COUNTER_ZERO_CHECKER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_SET_TO_ZERO"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1)) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_SET_TO_ZERO"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1)) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_MOVEMENT_RESETTER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_RESETTER"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 45, nil) == 0)) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_RESETTER"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 45, nil) == 0)) then
        H.set_var("actor", H.u(ctx), ctx, "doll_form_movement", 0)
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_REGAIN", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_INCREASING"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1) and (H.var_num(H.u(ctx), "doll_form_movement") <= 1000))) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_INCREASING"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1) and (H.var_num(H.u(ctx), "doll_form_movement") <= 1000))) then
        H.set_var("actor", H.u(ctx), ctx, "doll_form_movement", (H.var_num(H.u(ctx), "doll_form_movement")) + ((services.random.native_int(0, H.round_half_away(10)) + 2)))
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_BREAK_CHECKER"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1) and (H.var_num(H.u(ctx), "doll_form_movement") > 0) and services.random.native_probability((H.var_num(H.u(ctx), "doll_form_movement")), (1000)))) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_MOVEMENT_BREAK_CHECKER"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1) and (H.var_num(H.u(ctx), "doll_form_movement") > 0) and services.random.native_probability((H.var_num(H.u(ctx), "doll_form_movement")), (1000)))) then
        services.messages.add(ctx:expand_text(services.translate("As you take another step, you notice hostile eyes turn toward you.  They don't see you as just a doll now.")), "bad")
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MELEE_MONSTER_CANCEL_TOGGLES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) == true
    end
    EOC["EOC_MELEE_MONSTER_CANCEL_TOGGLES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_MELEE_CHARACTER_CANCEL_TOGGLES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) == true
    end
    EOC["EOC_MELEE_CHARACTER_CANCEL_TOGGLES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_RANGED_MONSTER_CANCEL_TOGGLES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) == true
    end
    EOC["EOC_RANGED_MONSTER_CANCEL_TOGGLES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_RANGED_CHARACTER_CANCEL_MIEN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) == true
    end
    EOC["EOC_HOMULLUS_RANGED_CHARACTER_CANCEL_MIEN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "THRESH_HOMULLUS") == 1))) then
        H.run_eoc("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1))) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_LOSE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS") == 1) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1))) then
        H.lose_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS")
        do local _g = H.safe_id('mutation', "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(180), math.floor(360); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_REGAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_REGAIN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") == 1) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1))) == true
    end
    EOC["EOC_HOMULLUS_DOLL_FORM_ANGER_RELATIONS_REGAIN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER") == 1) and (H.char_has_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_TRAITS") == 1))) then
        H.lose_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER")
        do local _g = H.safe_id('mutation', "HOMULLUS_DOLL_FORM_ANGER_RELATIONS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    else
        H.lose_trait(H.u(ctx), "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER")
        return false
    end
    end
    COND["EOC_HOMULLUS_ALL_ROADS_TRANSLOCATE_CHECK"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and H.char_at_om_location(H.u(ctx), "road") and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "ROAD"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) == true
    end
    EOC["EOC_HOMULLUS_ALL_ROADS_TRANSLOCATE_CHECK"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and H.char_at_om_location(H.u(ctx), "road") and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "ROAD"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) then
        H.eoc_cast_spell(H.u(ctx), "paraclesian_translocate", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing on a road to cast this spell.")), "mixed")
        return false
    end
    end
    COND["EOC_HOMULLUS_ALL_ROADS_ATTUNEMENT_CHECK"] = function(ctx)
        return (((H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx) or (H.chars_nearby(H.u(ctx), 50, "any") >= 15)))) == true
    end
    EOC["EOC_HOMULLUS_ALL_ROADS_ATTUNEMENT_CHECK"] = function(ctx)
    if (((H.test_eoc("EOC_CONDITION_HOMULLUS_NEAR_FACTION", ctx) or (H.chars_nearby(H.u(ctx), 50, "any") >= 15)))) then
        H.eoc_cast_spell(H.u(ctx), "homullus_civilization_translocate_attune_real", false, { targeted = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be within one of the remaining bastions of civilization to cast this spell.")), "mixed")
        return false
    end
    end
    EOC["EOC_HOMULLUS_DEATH_DOOR_KILL_TARGET"] = function(ctx)
    do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "xedra_self_banish", (cs and cs.kind == 'monster'), nil) end end
    return true
    end
    COND["EOC_HOMULLUS_DEATH_DOOR_REBIRTH"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "DEATH_IS_BUT_A_DOOR") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_homullus_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_HOMULLUS_DEATH_DOOR_REBIRTH"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "DEATH_IS_BUT_A_DOOR") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_homullus_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "homullus_death_door_target", nil, nil, { kind = "species", id = H.safe_id("species", "FERAL") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        if (not H.truthy((H.var_exists("context", nil, ctx, "homullus_death_door_target") and 1 or 0))) then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "homullus_death_door_target", nil, nil, { kind = "npc" }, { target_min_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        end
        if H.truthy((H.var_exists("context", nil, ctx, "homullus_death_door_target") and 1 or 0)) then
            H.run_eoc("EOC_HOMULLUS_DEATH_DOOR_KILL_TARGET", ctx, nil, nil, nil)
            do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
            H.set_char_hp(H.u(ctx), "ALL", 999, "=")
            do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            local _a31 = H.u(ctx)
            if _a31 then services.characters.adjust(_a31, { pain = math.floor((0) - (H.char_pain(_a31))) }) end
            H.set_char_val_extra(H.u(ctx), "rad", 0, "=")
            do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "onfire"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "venom_blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "formication"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "blisters"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "frostbite"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "frostbite_recovery"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "wet"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "slimed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "migo_atmosphere"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "fetid_goop"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "sap"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "nausea"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            H.eoc_add_effect(H.u(ctx), "effect_homullus_prevented_death", math.max(20160, (1209600 - (15120 * H.char_sum_traits_cat(H.u(ctx), "HOMULLUS", "ALL")))), nil, nil, nil)
            do local _p = H.get_tripoint_var("context", nil, ctx, "homullus_death_door_target"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force_safe = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force_safe = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force_safe = true }) end end end
        end
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_IERDE_ON_NATURAL_EARTH_OR_UNDERGROUND"] = function(ctx)
        return (((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)) or ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)())))))) == true
    end
    EOC["EOC_CONDITION_CHECK_IERDE_ON_NATURAL_EARTH_OR_UNDERGROUND"] = function(ctx)
    if (((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)) or ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)())))))) then
        return true
    end
    return false
    end
    COND["EOC_IERDE_DETECT_NEARBY_MONSTERS_CHECK"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_ierde_sense_nearby_monsters"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1) or (((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)())))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) == true
    end
    EOC["EOC_IERDE_DETECT_NEARBY_MONSTERS_CHECK"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_ierde_sense_nearby_monsters"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1) or (((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)())))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) then
        do local _g = H.safe_id('mutation', "IERDE_DETECT_NEARBY_MONSTERS_EARTH"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, false) end end
        return true
    end
    return false
    end
    COND["EOC_IERDE_GOBLIN_FRUIT"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) == true
    end
    EOC["EOC_IERDE_GOBLIN_FRUIT"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_ierde", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on living earth or stone to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_IERDE_IRON_ARMOR_SPELL"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) == true
    end
    EOC["EOC_IERDE_IRON_ARMOR_SPELL"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) then
        H.eoc_cast_spell(H.u(ctx), "ierde_iron_armor_spell_real", false, { hit_self = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on living earth or stone to infuse yourself with iron.")), "bad")
        return false
    end
    end
    COND["EOC_IERDE_REVEAL_MAP"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) == true
    end
    EOC["EOC_IERDE_REVEAL_MAP"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) then
        do
            local _sw32 = H.char_spell_level(H.u(ctx), "ierde_reveal_earth_map_spell")
            if _sw32 == 0 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_01", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_01", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_01"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw32 == 3 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_02", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_02", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_02"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw32 == 6 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_03", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_03", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_03"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw32 == 9 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_04", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_04", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_04"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw32 == 12 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_05", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_05", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_05"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw32 == 15 then
                H.eoc_spawn_item(H.u(ctx), "item_ierde_reveal_earth_map_06", 1, false, false, nil)
                H.run_eoc("EOC_IERDE_REVEAL_MAP_ITEM_06", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_ierde_reveal_earth_map_06"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without a direct connection to the living earth, the spell fails.")), "neutral")
        return false
    end
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_01_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_01"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_01" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_01_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_02_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_02"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_02" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_02_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_03_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_03"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_03" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_03_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_04_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_04"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_04" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_04_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_05_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_05"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_05" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_05_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_06_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_IERDE_REVEAL_MAP_ITEM_06"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_ierde_reveal_earth_map_06" } }, { "EOC_IERDE_REVEAL_MAP_ITEM_06_ACTIVATE" }, {  })
    return true
    end
    COND["EOC_IERDE_NO_SLEEP_MEDITATE"] = function(ctx)
        return (((((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.char_val_extra(H.u(ctx), "sleep_deprivation")) >= 0))) == true
    end
    EOC["EOC_IERDE_NO_SLEEP_MEDITATE"] = function(ctx)
    if (((((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.char_val_extra(H.u(ctx), "sleep_deprivation")) >= 0))) then
        do local _g = H.safe_id('activity', "ACT_IERDE_NO_SLEEP_MEDITATE"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(30600)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You're feeling refreshed and have no need to begin a vigil.")), "mixed")
        return false
    end
    end
    COND["EOC_IERDE_EARTHEN_SHIELD_SPELL"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) == true
    end
    EOC["EOC_IERDE_EARTHEN_SHIELD_SPELL"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_ierde_earthen_shield", (((H.char_spell_level(H.u(ctx), "ierde_earthen_shield_spell") * 15) + 300) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).strength or 0))), nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "earthen_shield_protection_level", (((H.char_spell_level(H.u(ctx), "ierde_earthen_shield_spell") * 1) * services.random.native_float(0.5, 1.5)) + 4))
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on living earth or stone to create the earthen shield.")), "bad")
        return false
    end
    end
    COND["EOC_IERDE_EARTHEN_SHIELD_REDUCER"] = function(ctx)
        return ((H.var_num(H.u(ctx), "earthen_shield_protection_level") >= 1)) == true
    end
    EOC["EOC_IERDE_EARTHEN_SHIELD_REDUCER"] = function(ctx)
    if ((H.var_num(H.u(ctx), "earthen_shield_protection_level") >= 1)) then
        H.set_var("actor", H.u(ctx), ctx, "earthen_shield_protection_level", (H.var_num(H.u(ctx), "earthen_shield_protection_level")) - (1))
        return true
    else
        do local _eg = H.safe_id('effect', "effect_ierde_earthen_shield"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_IERDE_SLEEP_IN_EARTH_REMOVER"] = function(ctx)
        return (((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9)))) and (H.char_has_trait(H.u(ctx), "IERDE_STONE_SLEEP") == 1))) == true
    end
    EOC["EOC_IERDE_SLEEP_IN_EARTH_REMOVER"] = function(ctx)
    if (((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9)))) and (H.char_has_trait(H.u(ctx), "IERDE_STONE_SLEEP") == 1))) then
        H.lose_trait(H.u(ctx), "IERDE_STONE_SLEEP")
        return true
    end
    return false
    end
    EOC["EOC_RESHAPE_THE_EARTH_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_RESHAPE_EARTH_MAKE_WALL"] == nil or E.cond["EOC_RESHAPE_EARTH_MAKE_WALL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Create or Destroy Wall")), description = ctx:expand_text(services.translate("Turn a dirt or stone floor into a wall or vice versa.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_RESHAPE_EARTH_MAKE_WALL" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_MAKE_PIT"] == nil or E.cond["EOC_RESHAPE_EARTH_MAKE_PIT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Create Pit")), description = ctx:expand_text(services.translate("Create a pit.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_RESHAPE_EARTH_MAKE_PIT" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_RAISE_EARTH"] == nil or E.cond["EOC_RESHAPE_EARTH_RAISE_EARTH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Earthen Stairs Up")), description = ctx:expand_text(services.translate("Reshape the dirt or stone into a set of stairs going up.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_RESHAPE_EARTH_RAISE_EARTH" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_LOWER_EARTH"] == nil or E.cond["EOC_RESHAPE_EARTH_LOWER_EARTH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Earthen Stairs Down")), description = ctx:expand_text(services.translate("Reshape the dirt or stone into a set of stairs going down.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_RESHAPE_EARTH_LOWER_EARTH" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_SMOOTH_STONE"] == nil or E.cond["EOC_RESHAPE_EARTH_SMOOTH_STONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Smooth Stone")), description = ctx:expand_text(services.translate("Polish and smooth a stone wall into a mirror-like finish.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_RESHAPE_EARTH_SMOOTH_STONE" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_CHURN_EARTH"] == nil or E.cond["EOC_RESHAPE_EARTH_CHURN_EARTH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Churn Earth for Planting")), description = ctx:expand_text(services.translate("Create furrows in the earth suitable for planting crops")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_RESHAPE_EARTH_CHURN_EARTH" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_DIRT_TO_STONE"] == nil or E.cond["EOC_RESHAPE_EARTH_DIRT_TO_STONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Turn Earth to Stone")), description = ctx:expand_text(services.translate("Turn dirt and earth into solid rock.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_RESHAPE_EARTH_DIRT_TO_STONE" end end
        do local _en = (E.cond["EOC_RESHAPE_EARTH_STONE_TO_DIRT"] == nil or E.cond["EOC_RESHAPE_EARTH_STONE_TO_DIRT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Turn Stone to Earth")), description = ctx:expand_text(services.translate("Turn solid rock into loose soil or dirt.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "EOC_RESHAPE_EARTH_STONE_TO_DIRT" end end
        do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("Do nothing")), description = ctx:expand_text(services.translate("Do nothing.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "EOC_NONE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_RESHAPE_EARTH_MAKE_WALL"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_walls", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_MAKE_PIT"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_pits", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_RAISE_EARTH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_raise", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_LOWER_EARTH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_lower", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_SMOOTH_STONE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_smooth_stone", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_CHURN_EARTH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_churn_earth", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_DIRT_TO_STONE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_earth_to_stone", false, { targeted = true })
    return true
    end
    EOC["EOC_RESHAPE_EARTH_STONE_TO_DIRT"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "ierde_reshape_the_stone_to_dirt", false, { targeted = true })
    return true
    end
end
