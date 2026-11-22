local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_SLEEPING_SEIZED_BY_LILIT_WARNING"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (H.chars_nearby(H.u(ctx), 45, "any") == 0) and ((services.gameplay.environment.dimension() == "default") and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not ((H.u(ctx) ~= nil and services.characters.is_in_vehicle(H.u(ctx)).value == true))) and (not (H.char_on_furniture(H.u(ctx), "f_large_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_fema_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_center_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_groundsheet"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter_filled" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_arvore_living_tent" end)())))) and services.random.native_probability((1), (2)) and ((services.time.calendar().now.turns_since_cataclysm / 86400) <= 20) and (not (((function() local eg = H.safe_id('effect', "effect_lilin_attack_warning_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_SLEEPING_SEIZED_BY_LILIT_WARNING"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (H.chars_nearby(H.u(ctx), 45, "any") == 0) and ((services.gameplay.environment.dimension() == "default") and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not ((H.u(ctx) ~= nil and services.characters.is_in_vehicle(H.u(ctx)).value == true))) and (not (H.char_on_furniture(H.u(ctx), "f_large_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_fema_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_center_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_groundsheet"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter_filled" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_arvore_living_tent" end)())))) and services.random.native_probability((1), (2)) and ((services.time.calendar().now.turns_since_cataclysm / 86400) <= 20) and (not (((function() local eg = H.safe_id('effect', "effect_lilin_attack_warning_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("The night was a little rough.  You tossed and turned, aware of every single noise and creak of wood in a way you never were before all of this happened, before you finally fell asleep.  You weren't attacked and woke up without trouble, but you have to wonder if it's really safe, sleeping alone like this in an abandoned building?")))
        H.eoc_add_effect(H.u(ctx), "effect_lilin_attack_warning_cooldown", 1728000, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_SLEEPING_SEIZED_BY_LILIT"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (H.chars_nearby(H.u(ctx), 45, "any") == 0) and (not ((not services.gameplay.environment.is_night()))) and ((services.gameplay.environment.dimension() == "default") and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not ((H.u(ctx) ~= nil and services.characters.is_in_vehicle(H.u(ctx)).value == true))) and (not (H.char_on_furniture(H.u(ctx), "f_large_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_fema_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_center_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_groundsheet"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter_filled" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_arvore_living_tent" end)())))) and services.random.native_probability(((((((1 + math.min((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 90), 180)) + (((H.creature_effect_intensity(H.u(ctx), "common_cold") > (-1))) and (15) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "influenza") > (-1))) and (25) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "pre_common_cold") > (-1))) and (7) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "pre_flu") > (-1))) and (12) or (0)))), (365)) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "WARDING_SYMBOL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "WARDING_SYMBOL")).value == true))))) == true
    end
    EOC["EOC_SLEEPING_SEIZED_BY_LILIT"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1))) and (H.chars_nearby(H.u(ctx), 45, "any") == 0) and (not ((not services.gameplay.environment.is_night()))) and ((services.gameplay.environment.dimension() == "default") and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not ((H.u(ctx) ~= nil and services.characters.is_in_vehicle(H.u(ctx)).value == true))) and (not (H.char_on_furniture(H.u(ctx), "f_large_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_fema_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_center_groundsheet"))) and (not (H.char_on_furniture(H.u(ctx), "f_groundsheet"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter_filled" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_improvised_shelter" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_arvore_living_tent" end)())))) and services.random.native_probability(((((((1 + math.min((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 90), 180)) + (((H.creature_effect_intensity(H.u(ctx), "common_cold") > (-1))) and (15) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "influenza") > (-1))) and (25) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "pre_common_cold") > (-1))) and (7) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "pre_flu") > (-1))) and (12) or (0)))), (365)) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "WARDING_SYMBOL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "WARDING_SYMBOL")).value == true))))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(10800), math.floor(18000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SLEEPING_SEIZED_BY_LILIT_EFFECTS"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_SLEEPING_SEIZED_BY_LILIT_EFFECTS"] = function(ctx)
        return (((H.chars_nearby(H.u(ctx), 45, "any") == 0) and ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "effect_sleep_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_SLEEPING_SEIZED_BY_LILIT_EFFECTS"] = function(ctx)
    if (((H.chars_nearby(H.u(ctx), 45, "any") == 0) and ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "effect_sleep_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_lilin_ruach_drain_side_effects", 259200, nil, (services.random.native_int(0, H.round_half_away(2)) + 1), nil)
        services.messages.add((services.snippets.native_random("snippet_drained_by_lilit") or ''), "bad")
        H.set_var("actor", H.u(ctx), ctx, "lilin_ruach_drained_recently", 1)
        return true
    end
    return false
    end
    COND["EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE_SUCCESS"] = function(ctx)
        return ((not (((function() local p = H.get_tripoint_var("context", nil, ctx, "brownie_spawn_location"); return p ~= nil and services.gameplay.environment.is_outside(p) == true end)())))) == true
    end
    EOC["EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE_SUCCESS"] = function(ctx)
    if ((not (((function() local p = H.get_tripoint_var("context", nil, ctx, "brownie_spawn_location"); return p ~= nil and services.gameplay.environment.is_outside(p) == true end)())))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_xe_strange_event_brownie") or H.safe_id('monster_group', "mon_xe_strange_event_brownie"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), indoor_only = true, lifespan = services.time.duration_from_turns(math.floor(150)) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("A wizened, hairy creature suddenly appears out of thin air!")), 'warning') end
        end end
        return true
    end
    return false
    end
    COND["EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).avatar == true) and H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY") and services.random.native_probability((1), (25)) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "FAE_ENMITY") == 1))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "xe_brownie_in_faction_event_has_run", "")))))))) == true
    end
    EOC["EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).avatar == true) and H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY") and services.random.native_probability((1), (25)) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "FAE_ENMITY") == 1))) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "xe_brownie_in_faction_event_has_run", "")))))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "brownie_spawn_location", nil, nil, nil, { min_radius = math.floor(5), max_radius = math.floor(10), passable_only = true }, nil, false, true, { "EOC_XE_BROWNIE_IN_YOUR_FACTION_BASE_SUCCESS" }, {  })
        return true
    end
    return false
    end
    COND["EOC_XE_STRANGE_EVENT_BROWNIE_CONVERSATION"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE" })) == true
    end
    EOC["EOC_XE_STRANGE_EVENT_BROWNIE_CONVERSATION"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE" })) then
        if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The strange creature sees you and starts before spinning around and vanishing into thin air.")), "mixed")
        do local _g = H.safe_id('mutation', "XE_FACTION_CAMP_BROWNIE_BLESSING"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t, { remove_corpse = true, suppress_message = true }) else services.characters.die(t, { remove_corpse = true, suppress_message = true }) end end end
        return false
    end
    end
    COND["EOC_XE_MAGIC_BAD_DREAMS"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((H.global_var_num("eater_dreamer_sequence") > 0) or (H.global_var_num("inventor_dreamsmith_sequence") > 0)))) == true
    end
    EOC["EOC_XE_MAGIC_BAD_DREAMS"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((H.global_var_num("eater_dreamer_sequence") > 0) or (H.global_var_num("inventor_dreamsmith_sequence") > 0)))) then
        services.messages.add((services.snippets.native_random("XE_BAD_DREAMS") or ''), "bad")
        return true
    end
    return false
    end
    EOC["EOC_RUST_INVENTOR_ITEMS"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", 2, "-=")
    services.messages.add(ctx:expand_text(services.translate("You hear a sudden crack!")), "neutral")
    services.messages.add(ctx:expand_text(services.translate("Your lack of an inventor's aura makes items created by their fevered mind rapidly degrade!")), "neutral")
    services.messages.add(ctx:expand_text(services.translate("My items are falling apart!  It isn't me!")), "neutral")
    return true
    end
    COND["EOC_INVENTOR_CRAFTED_DEGRADATION"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1)))) == true
    end
    EOC["EOC_INVENTOR_CRAFTED_DEGRADATION"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1)))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_RUST_INVENTOR_ITEMS" }, {  })
        return true
    end
    return false
    end
    COND["EOC_INVENTOR_CBM_DEGRADATION"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1))) and (H.char_has_bionic(H.u(ctx), "bio_inventor_mana_kj_penalty_switch") or H.char_has_bionic(H.u(ctx), "bio_inventor_calorie_storage") or H.char_has_bionic(H.u(ctx), "bio_inventor_creative_fuel") or H.char_has_bionic(H.u(ctx), "bio_inventor_book_burn_boost")))) == true
    end
    EOC["EOC_INVENTOR_CBM_DEGRADATION"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1))) and (H.char_has_bionic(H.u(ctx), "bio_inventor_mana_kj_penalty_switch") or H.char_has_bionic(H.u(ctx), "bio_inventor_calorie_storage") or H.char_has_bionic(H.u(ctx), "bio_inventor_creative_fuel") or H.char_has_bionic(H.u(ctx), "bio_inventor_book_burn_boost")))) then
        H.run_eoc("EOC_INVENTOR_CBM_DEGRADATION_BREAKDOWN", ctx, nil, "u", nil)
        return true
    end
    return false
    end
    EOC["EOC_INVENTOR_CBM_DEGRADATION_BREAKDOWN"] = function(ctx)
    if H.char_has_bionic(H.u(ctx), "bio_inventor_mana_kj_penalty_switch") then
        H.lose_bionic(H.u(ctx), "bio_inventor_mana_kj_penalty_switch")
        H.add_bionic(H.u(ctx), "bio_power_weakness")
    end
    if H.char_has_bionic(H.u(ctx), "bio_inventor_calorie_storage") then
        H.lose_bionic(H.u(ctx), "bio_inventor_calorie_storage")
        H.add_bionic(H.u(ctx), "bio_drain")
    end
    if H.char_has_bionic(H.u(ctx), "bio_inventor_creative_fuel") then
        H.lose_bionic(H.u(ctx), "bio_inventor_creative_fuel")
        H.add_bionic(H.u(ctx), "bio_dis_shock")
    end
    if H.char_has_bionic(H.u(ctx), "bio_inventor_book_burn_boost") then
        H.lose_bionic(H.u(ctx), "bio_inventor_book_burn_boost")
        H.add_bionic(H.u(ctx), "bio_leaky")
    end
    services.messages.add(ctx:expand_text(services.translate("You hear a sudden crack!")), "neutral")
    if ((H.char_snap(H.u(ctx)) or {}).avatar == true) then
        services.messages.add(ctx:expand_text(services.translate("Your lack of an inventor's aura is breaking the bionics that depend on it!")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("My bionics are falling apart!  It isn't me!")), "neutral")
    end
    return true
    end
    COND["EOC_INVENTOR_SLEEP_GAMING"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "inventor_gaming_rig_on")) == true
    end
    EOC["EOC_INVENTOR_SLEEP_GAMING"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "inventor_gaming_rig_on")) then
        H.set_var("global", nil, ctx, "morale_game_inventor", ((3 * H.char_skill(H.u(ctx), "deduction")) + 3))
        do local _g = H.safe_id('morale', "morale_game_inventor"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(H.global_var_num("morale_game_inventor")), math.floor(H.global_var_num("morale_game_inventor")), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(900)) }) end end
        return true
    end
    return false
    end
    EOC["EOC_GEAR_INVENTOR_ITEMS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_weird_equipment", 300, nil, nil, nil)
    return true
    end
    COND["EOC_INVENTOR_CRAFTED_GEAR"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1)) == true
    end
    EOC["EOC_INVENTOR_CRAFTED_GEAR"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "INVENTOR") == 1)) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_GEAR_INVENTOR_ITEMS" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_bio_inventor_calorie_storage_activated"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_bio_inventor_calorie_storage", -1, nil, nil, nil)
    return true
    end
    COND["EOC_calorie_storage_check_size_tiny"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "TINY")) == true
    end
    EOC["EOC_calorie_storage_check_size_tiny"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "TINY")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) / (8))
        H.run_eoc("EOC_calorie_storage_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_calorie_storage_check_size_small", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_calorie_storage"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_calorie_storage"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", 95000)
        H.run_eoc("EOC_calorie_storage_check_size_tiny", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_calorie_storage_check_size_small"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "SMALL")) == true
    end
    EOC["EOC_calorie_storage_check_size_small"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "SMALL")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) / (3))
        H.run_eoc("EOC_calorie_storage_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_calorie_storage_check_size_large", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_calorie_storage_check_size_large"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "LARGE")) == true
    end
    EOC["EOC_calorie_storage_check_size_large"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "LARGE")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) * (1.5))
        H.run_eoc("EOC_calorie_storage_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_calorie_storage_check_size_huge", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_calorie_storage_check_size_huge"] = function(ctx)
        return (H.char_has_flag(H.u(ctx), "HUGE")) == true
    end
    EOC["EOC_calorie_storage_check_size_huge"] = function(ctx)
    if (H.char_has_flag(H.u(ctx), "HUGE")) then
        H.set_var("actor", H.u(ctx), ctx, "calories_needed", (H.var_num(H.u(ctx), "calories_needed")) * (2))
        H.run_eoc("EOC_calorie_storage_convert", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_calorie_storage_convert", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_calorie_storage_convert"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_calorie_storage_convert"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) <= H.var_num(H.u(ctx), "calories_needed")) then
            if (H.char_vitamin(H.u(ctx), "stored_calories") >= 100) then
                do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(100 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 100; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                do local _a, _v = H.u(ctx), "stored_calories"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 100; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            else
                if ((H.char_vitamin(H.u(ctx), "stored_calories") < 100) and (H.char_vitamin(H.u(ctx), "stored_calories") > 0)) then
                    do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(H.char_vitamin(H.u(ctx), "stored_calories") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.char_vitamin(H.u(ctx), "stored_calories"); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                    do local _a, _v = H.u(ctx), "stored_calories"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.char_vitamin(H.u(ctx), "stored_calories"); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                    services.messages.add(ctx:expand_text(services.translate("The last of your orbiting calories settle inside your body.")), "mixed")
                end
            end
        else
            if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) >= (H.var_num(H.u(ctx), "calories_needed") * 1.05)) then
                do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(100 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 100; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
                do local _a, _v = H.u(ctx), "stored_calories"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 75; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_bio_inventor_calorie_storage_deactivated"] = function(ctx)
    do local _a, _v = H.u(ctx), "stored_calories"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _eg = H.safe_id('effect', "effect_bio_inventor_calorie_storage"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_inventor_creative_fuel"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "creative_spark") > 0)) == true
    end
    EOC["EOC_inventor_creative_fuel"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "creative_spark") > 0)) then
        do local _a, _v = H.u(ctx), "creative_spark"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_bionic_power(H.u(ctx), services.random.native_float(900000000, 1100000000), "+=")
        services.messages.add(ctx:expand_text(services.translate("Some of your brillance is converted into electricity.")), "info")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your creativity isn't potent enough to be converted to electricity.")), "bad")
        return false
    end
    end
    EOC["EOC_bio_inventor_book_burn_boost_start"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "amount_of_burned_books", (H.var_num(H.u(ctx), "amount_of_burned_books")) + (1))
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_bio_inventor_book_burn_boost_fail"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The buddy needs books to burn!")), "bad")
    return true
    end
    EOC["EOC_bio_inventor_book_burn_boost_activated"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "amount_of_burned_books", 0)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", nil, { { category = "manuals" }, { category = "ma_manuals" }, { category = "books" } }, { "EOC_bio_inventor_book_burn_boost_start" }, { "EOC_bio_inventor_book_burn_boost_fail" })
    H.run_eoc("EOC_bio_inventor_book_burn_boost_vitamin_gain", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_bio_inventor_book_burn_boost_vitamin_gain"] = function(ctx)
        return ((H.var_num(H.u(ctx), "amount_of_burned_books") > 0)) == true
    end
    EOC["EOC_bio_inventor_book_burn_boost_vitamin_gain"] = function(ctx)
    if ((H.var_num(H.u(ctx), "amount_of_burned_books") > 0)) then
        do local _a, _v = H.u(ctx), "burned_books"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "amount_of_burned_books"); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("Your mind fills with information as the books burn!")), "good")
        return true
    end
    return false
    end
    EOC["EOC_bio_inventor_book_burn_boost_vitamin_drain"] = function(ctx)
    do local _a, _v = H.u(ctx), "burned_books"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    EOC["EOC_WINCH_INITIAL"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "winch_teleport", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("You draw coordinates in a constructed beam.")), "good")
    return true
    end
    EOC["EOC_WINCH_TELEPORT"] = function(ctx)
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "winch_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_SI_POST_TELEPORT_FOLLOWUP"), nil) end end
    return true
    end
    EOC["EOC_XE_MAGIC_POTENTIAL_CONDUCTS"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "ALL", false) / 6) == (H.char_hp(H.u(ctx), "torso", true) / 2)) then
        H.set_var("global", nil, ctx, "magic_potential", (H.global_var_num("magic_potential")) + (1))
        services.messages.add(ctx:expand_text(services.translate("Got magic potential from wounds, magic_potential: <global_val:magic_potential>")), "debug")
    end
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) > 250) then
        H.set_var("global", nil, ctx, "magic_potential", (H.global_var_num("magic_potential")) + (1))
        services.messages.add(ctx:expand_text(services.translate("Got magic potential from pain, magic_potential: <global_val:magic_potential>")), "debug")
    end
    if (H.char_val_extra(H.u(ctx), "morale") < (-100)) then
        H.set_var("global", nil, ctx, "magic_potential", (H.global_var_num("magic_potential")) + (1))
        services.messages.add(ctx:expand_text(services.translate("Got magic potential from depression, magic_potential: <global_val:magic_potential>")), "debug")
    end
    if ((H.var_num(H.u(ctx), "counter_portal_storm_counter") > 0) and (H.global_var_num("magic_potential_from_ps") == 0)) then
        H.set_var("global", nil, ctx, "magic_potential", (H.global_var_num("magic_potential")) + (1))
        H.set_var("global", nil, ctx, "magic_potential_from_ps", 1)
        services.messages.add(ctx:expand_text(services.translate("Got magic potential from witnessing the portal storm, magic_potential: <global_val:magic_potential>")), "debug")
    end
    if ((function() local eg = H.safe_id('effect', "taint"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
        H.set_var("global", nil, ctx, "magic_potential", (H.global_var_num("magic_potential")) + (1))
        services.messages.add(ctx:expand_text(services.translate("Got magic potential from tainted mind, magic_potential: <global_val:magic_potential>")), "debug")
    end
    return true
    end
    COND["EOC_WEATHER_CONTROL_INITIATE"] = function(ctx)
        return ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) == true
    end
    EOC["EOC_WEATHER_CONTROL_INITIATE"] = function(ctx)
    if ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) then
        H.run_eoc("EOC_WEATHER_CONTROL_ABOVE_FREEZING", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_WEATHER_CONTROL_BELOW_FREEZING", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_ABOVE_FREEZING_INITIATE"] = function(ctx)
        return (((not (((services.weather.current().weather and services.weather.current().weather.value) == "cloudy"))))) == true
    end
    EOC["EOC_WEATHER_CONTROL_ABOVE_FREEZING_INITIATE"] = function(ctx)
    if (((not (((services.weather.current().weather and services.weather.current().weather.value) == "cloudy"))))) then
        services.messages.add(ctx:expand_text(services.translate("As the clouds roll in, drops of rain begin to fall.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_light_drizzle", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_DRIZZLE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The clouds churn as drops of rain begin to fall.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_light_drizzle", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_DRIZZLE"), nil) end end
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_ABOVE_FREEZING"] = function(ctx)
        return (((not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning"))))) == true
    end
    EOC["EOC_WEATHER_CONTROL_ABOVE_FREEZING"] = function(ctx)
    if (((not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning"))))) then
        H.run_eoc("EOC_WEATHER_CONTROL_ABOVE_FREEZING_INITIATE", ctx, nil, nil, nil)
        return true
    else
        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle") then
            H.run_eoc("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_DRIZZLE", ctx, nil, nil, nil)
        else
            if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle") then
                H.run_eoc("EOC_WEATHER_CONTROL_DRIZZLE_TO_RAIN", ctx, nil, nil, nil)
            else
                if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain") then
                    H.run_eoc("EOC_WEATHER_CONTROL_RAIN_TO_RAINSTORM", ctx, nil, nil, nil)
                else
                    if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") then
                        H.run_eoc("EOC_WEATHER_CONTROL_RAINSTORM_TO_THUNDERSTORM", ctx, nil, nil, nil)
                    else
                        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") then
                            H.run_eoc("EOC_WEATHER_CONTROL_THUNDERSTORM_TO_LIGHTNINGSTORM", ctx, nil, nil, nil)
                        end
                    end
                end
            end
        end
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_DRIZZLE"] = function(ctx)
        return (((H.global_var_num("magic_weather_light_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 2))) == true
    end
    EOC["EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_DRIZZLE"] = function(ctx)
    if (((H.global_var_num("magic_weather_light_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 2))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The rain picks up.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_light_drizzle", 0)
        H.set_var("global", nil, ctx, "magic_weather_drizzle", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_DRIZZLE_TO_RAIN"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_DRIZZLE_TO_RAIN"] = function(ctx)
        return (((H.global_var_num("magic_weather_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 3))) == true
    end
    EOC["EOC_WEATHER_CONTROL_DRIZZLE_TO_RAIN"] = function(ctx)
    if (((H.global_var_num("magic_weather_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 3))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The rain falls steadily now.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_drizzle", 0)
        H.set_var("global", nil, ctx, "magic_weather_rain", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAIN_TO_RAINSTORM"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_RAIN_TO_RAINSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_rain") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 4))) == true
    end
    EOC["EOC_WEATHER_CONTROL_RAIN_TO_RAINSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_rain") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 4))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The rain falls in lashing sheet.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_rain", 0)
        H.set_var("global", nil, ctx, "magic_weather_rainstorm", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAINSTORM_TO_THUNDERSTORM"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_RAINSTORM_TO_THUNDERSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_rainstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 5))) == true
    end
    EOC["EOC_WEATHER_CONTROL_RAINSTORM_TO_THUNDERSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_rainstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 5))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("Thunder rumbles amid the driving rain.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_rainstorm", 0)
        H.set_var("global", nil, ctx, "magic_weather_thunder", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_THUNDERSTORM_TO_LIGHTNINGSTORM"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_THUNDERSTORM_TO_LIGHTNINGSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_thunder") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 6))) == true
    end
    EOC["EOC_WEATHER_CONTROL_THUNDERSTORM_TO_LIGHTNINGSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_thunder") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 6))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The sky is continually illuminated by flashing lightning.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_thunder", 0)
        H.set_var("global", nil, ctx, "magic_weather_lightning", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_LOSE_EFFECT_RESET_VARIABLES"] = function(ctx)
        return (((("effect_controlling_weather") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_WEATHER_CONTROL_LOSE_EFFECT_RESET_VARIABLES"] = function(ctx)
    if (((("effect_controlling_weather") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.set_var("actor", H.u(ctx), ctx, "weather_change_limit", 0)
        do local _t = math.max(1, math.floor(3)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_DOWNGRADE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_DOWNGRADE"] = function(ctx)
        return ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) == true
    end
    EOC["EOC_WEATHER_CONTROL_DOWNGRADE"] = function(ctx)
    if ((H.weather_val("temperature") > ((((31) - 32) * 5 / 9) + 273.15))) then
        H.run_eoc("EOC_WEATHER_CONTROL_ABOVE_FREEZING_DOWNGRADE", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_WEATHER_CONTROL_BELOW_FREEZING_DOWNGRADE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_ABOVE_FREEZING_DOWNGRADE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_WEATHER_CONTROL_ABOVE_FREEZING_DOWNGRADE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do local _eg = H.safe_id('effect', "effect_controlling_weather_rains"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_controlling_weather_rainstorm"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_light_drizzle") then
            H.run_eoc("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_NOTHING", ctx, nil, nil, nil)
        else
            if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_drizzle") then
                H.run_eoc("EOC_WEATHER_CONTROL_DRIZZLE_TO_LIGHT_DRIZZLE", ctx, nil, nil, nil)
            else
                if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rain") then
                    H.run_eoc("EOC_WEATHER_CONTROL_RAIN_TO_DRIZZLE", ctx, nil, nil, nil)
                else
                    if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_rainstorm") then
                        H.run_eoc("EOC_WEATHER_CONTROL_RAINSTORM_TO_RAIN", ctx, nil, nil, nil)
                    else
                        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") then
                            H.run_eoc("EOC_WEATHER_CONTROL_THUNDERSTORM_TO_RAINSTORM", ctx, nil, nil, nil)
                        else
                            if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning") then
                                H.run_eoc("EOC_WEATHER_CONTROL_LIGHTNINGSTORM_TO_THUNDERSTORM", ctx, nil, nil, nil)
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_LIGHTNINGSTORM_TO_THUNDERSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_lightning") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 5))) == true
    end
    EOC["EOC_WEATHER_CONTROL_LIGHTNINGSTORM_TO_THUNDERSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_lightning") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 5))) then
        H.set_var("global", nil, ctx, "magic_weather_lightning", 0)
        H.set_var("global", nil, ctx, "magic_weather_thunder", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_THUNDERSTORM_TO_RAINSTORM"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_THUNDERSTORM_TO_RAINSTORM"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_THUNDERSTORM_TO_RAINSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_thunder") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 4))) == true
    end
    EOC["EOC_WEATHER_CONTROL_THUNDERSTORM_TO_RAINSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_thunder") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 4))) then
        H.set_var("global", nil, ctx, "magic_weather_thunder", 0)
        H.set_var("global", nil, ctx, "magic_weather_rainstorm", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAINSTORM_TO_RAIN"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAINSTORM_TO_RAIN"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_RAINSTORM_TO_RAIN"] = function(ctx)
        return (((H.global_var_num("magic_weather_rainstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 3))) == true
    end
    EOC["EOC_WEATHER_CONTROL_RAINSTORM_TO_RAIN"] = function(ctx)
    if (((H.global_var_num("magic_weather_rainstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 3))) then
        H.set_var("global", nil, ctx, "magic_weather_rainstorm", 0)
        H.set_var("global", nil, ctx, "magic_weather_rain", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAIN_TO_DRIZZLE"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_RAIN_TO_DRIZZLE"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_RAIN_TO_DRIZZLE"] = function(ctx)
        return (((H.global_var_num("magic_weather_rain") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 2))) == true
    end
    EOC["EOC_WEATHER_CONTROL_RAIN_TO_DRIZZLE"] = function(ctx)
    if (((H.global_var_num("magic_weather_rain") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 2))) then
        H.set_var("global", nil, ctx, "magic_weather_rain", 0)
        H.set_var("global", nil, ctx, "magic_weather_drizzle", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_DRIZZLE_TO_LIGHT_DRIZZLE"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_DRIZZLE_TO_LIGHT_DRIZZLE"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_DRIZZLE_TO_LIGHT_DRIZZLE"] = function(ctx)
        return (((H.global_var_num("magic_weather_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 1))) == true
    end
    EOC["EOC_WEATHER_CONTROL_DRIZZLE_TO_LIGHT_DRIZZLE"] = function(ctx)
    if (((H.global_var_num("magic_weather_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 1))) then
        H.set_var("global", nil, ctx, "magic_weather_drizzle", 0)
        H.set_var("global", nil, ctx, "magic_weather_light_drizzle", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_NOTHING"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_NOTHING"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_NOTHING"] = function(ctx)
        return (((H.global_var_num("magic_weather_light_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 0))) == true
    end
    EOC["EOC_WEATHER_CONTROL_LIGHT_DRIZZLE_TO_NOTHING"] = function(ctx)
    if (((H.global_var_num("magic_weather_light_drizzle") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 0))) then
        H.set_var("global", nil, ctx, "magic_weather_light_drizzle", 0)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_BELOW_FREEZING_INITIATE"] = function(ctx)
        return (((not (((services.weather.current().weather and services.weather.current().weather.value) == "cloudy"))))) == true
    end
    EOC["EOC_WEATHER_CONTROL_BELOW_FREEZING_INITIATE"] = function(ctx)
    if (((not (((services.weather.current().weather and services.weather.current().weather.value) == "cloudy"))))) then
        services.messages.add(ctx:expand_text(services.translate("The sky clouds over as snow begins to drift down.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_flurries", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_FLURRIES_TO_SNOWING"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Snow slowly begins to drift down from the clouds above.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_flurries", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_FLURRIES_TO_SNOWING"), nil) end end
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_BELOW_FREEZING"] = function(ctx)
        return (((not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_flurries"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowing"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowstorm"))))) == true
    end
    EOC["EOC_WEATHER_CONTROL_BELOW_FREEZING"] = function(ctx)
    if (((not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_flurries"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowing"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowstorm"))))) then
        H.run_eoc("EOC_WEATHER_CONTROL_BELOW_FREEZING_INITIATE", ctx, nil, nil, nil)
        return true
    else
        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_flurries") then
            H.run_eoc("EOC_WEATHER_CONTROL_FLURRIES_TO_SNOWING", ctx, nil, nil, nil)
        else
            if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowing") then
                H.run_eoc("EOC_WEATHER_CONTROL_SNOWING_TO_SNOWSTORM", ctx, nil, nil, nil)
            end
        end
        return false
    end
    end
    COND["EOC_WEATHER_CONTROL_FLURRIES_TO_SNOWING"] = function(ctx)
        return (((H.global_var_num("magic_weather_flurries") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 3))) == true
    end
    EOC["EOC_WEATHER_CONTROL_FLURRIES_TO_SNOWING"] = function(ctx)
    if (((H.global_var_num("magic_weather_flurries") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 3))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("Snow falls steadily now.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_flurries", 0)
        H.set_var("global", nil, ctx, "magic_weather_snowing", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_SNOWING_TO_SNOWSTORM"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_SNOWING_TO_SNOWSTORM"] = function(ctx)
        return (((H.global_var_num("magic_weather_snowing") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 5))) == true
    end
    EOC["EOC_WEATHER_CONTROL_SNOWING_TO_SNOWSTORM"] = function(ctx)
    if (((H.global_var_num("magic_weather_snowing") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") >= 5))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("Snow falls thickly, obscuring your vision.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_snowing", 0)
        H.set_var("global", nil, ctx, "magic_weather_snowstorm", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_BELOW_FREEZING_DOWNGRADE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_WEATHER_CONTROL_BELOW_FREEZING_DOWNGRADE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_flurries") then
            H.run_eoc("EOC_WEATHER_CONTROL_FLURRIES_TO_NOTHING", ctx, nil, nil, nil)
        else
            if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowing") then
                H.run_eoc("EOC_WEATHER_CONTROL_SNOWING_TO_FLURRIES", ctx, nil, nil, nil)
            else
                if ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_snowstorm") then
                    H.run_eoc("EOC_WEATHER_CONTROL_SNOWSTORM_TO_SNOWING", ctx, nil, nil, nil)
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_SNOWSTORM_TO_SNOWING"] = function(ctx)
        return (((H.global_var_num("magic_weather_snowstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 4))) == true
    end
    EOC["EOC_WEATHER_CONTROL_SNOWSTORM_TO_SNOWING"] = function(ctx)
    if (((H.global_var_num("magic_weather_snowstorm") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 4))) then
        H.set_var("global", nil, ctx, "magic_weather_snowstorm", 0)
        H.set_var("global", nil, ctx, "magic_weather_snowing", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_SNOWING_TO_FLURRIES"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_SNOWING_TO_FLURRIES"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_SNOWING_TO_FLURRIES"] = function(ctx)
        return (((H.global_var_num("magic_weather_snowing") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 2))) == true
    end
    EOC["EOC_WEATHER_CONTROL_SNOWING_TO_FLURRIES"] = function(ctx)
    if (((H.global_var_num("magic_weather_snowing") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 2))) then
        H.set_var("global", nil, ctx, "magic_weather_snowing", 0)
        H.set_var("global", nil, ctx, "magic_weather_flurries", 1)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        if ((function() local eg = H.safe_id('effect', "effect_controlling_weather"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(H.var_num(H.u(ctx), "weather_stage_up_lower_bound")), math.floor(H.var_num(H.u(ctx), "weather_stage_up_upper_bound")); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_FLURRIES_TO_NOTHING"), nil) end end
        else
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_lower_bound") * services.random.native_float(2, 5)), 1800)), math.floor(math.min((H.var_num(H.u(ctx), "weather_stage_up_upper_bound") * services.random.native_float(2, 5)), 1800)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEATHER_CONTROL_FLURRIES_TO_NOTHING"), nil) end end
        end
        return true
    end
    return false
    end
    COND["EOC_WEATHER_CONTROL_FLURRIES_TO_NOTHING"] = function(ctx)
        return (((H.global_var_num("magic_weather_flurries") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 0))) == true
    end
    EOC["EOC_WEATHER_CONTROL_FLURRIES_TO_NOTHING"] = function(ctx)
    if (((H.global_var_num("magic_weather_flurries") == 1) and (H.var_num(H.u(ctx), "weather_change_limit") <= 0))) then
        H.set_var("global", nil, ctx, "magic_weather_flurries", 0)
        H.run_eoc("EOC_CALL_NEXT_WEATHER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_DREAMS_DEDUCTION_SKILL_EXP"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "EATER", "DREAMER", "DREAMSMITH", "INVENTOR", "IERDE", "HOMULLUS", "SALAMANDER", "UNDINE", "SYLPH" }) and (((("EATER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DREAMER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DREAMSMITH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("INVENTOR") == (H.var_str("context", nil, ctx, "school", "")))) or ((("IERDE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("HOMULLUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("UNDINE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SYLPH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VAMPIRE") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_DREAMS_DEDUCTION_SKILL_EXP"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "EATER", "DREAMER", "DREAMSMITH", "INVENTOR", "IERDE", "HOMULLUS", "SALAMANDER", "UNDINE", "SYLPH" }) and (((("EATER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DREAMER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DREAMSMITH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("INVENTOR") == (H.var_str("context", nil, ctx, "school", "")))) or ((("IERDE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("HOMULLUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("UNDINE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SYLPH") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VAMPIRE") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        local _a6 = H.u(ctx)
        local _sg7 = H.safe_id("skill", "deduction")
        if _a6 and _sg7 then services.skills.set(_a6, _sg7, { exercise_raw = math.floor((H.char_skill_exp(_a6, "deduction", true)) + ((250 * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return true
    end
    return false
    end
    COND["EOC_CALL_DAFFODIL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "called_daffodil"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CALL_DAFFODIL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "called_daffodil"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("You can't call more daffodil yet.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "called_daffodil", 86400, nil, nil, nil)
        H.eoc_cast_spell(H.u(ctx), "call_daffodil_real", false, nil)
        return false
    end
    end
    COND["EOC_caster_necklace_boost"] = function(ctx)
        return (H.char_is_wearing(H.u(ctx), "dream_attuning_necklace")) == true
    end
    EOC["EOC_caster_necklace_boost"] = function(ctx)
    if (H.char_is_wearing(H.u(ctx), "dream_attuning_necklace")) then
        H.set_spell_adj(H.u(ctx), "level", "DREAMER", "", "", 5, "+=")
        H.set_spell_adj(H.u(ctx), "level", "EATER", "", "", 5, "+=")
        H.set_spell_adj(H.u(ctx), "level", "DREAMSMITH", "", "", 5, "+=")
        H.set_spell_adj(H.u(ctx), "level", "INVENTOR", "", "", 5, "+=")
        return true
    end
    return false
    end
    COND["STORMWROUGHT_BLOOD_LOW_CHARGE"] = function(ctx)
        return ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 1)) == true
    end
    EOC["STORMWROUGHT_BLOOD_LOW_CHARGE"] = function(ctx)
    if ((H.var_num(H.u(ctx), "stormwrought_blood_charge") >= 1)) then
        services.messages.add(ctx:expand_text(services.translate("The stormwrought blood boils a little, then becomes inert again.")), "info")
        return true
    end
    return false
    end
end
