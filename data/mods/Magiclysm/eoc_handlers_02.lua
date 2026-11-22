local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_CALL_FORAGING_BEETLES"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "mag_summon_mushrooms", false, { min_level = math.floor(5) })
    services.messages.add(ctx:expand_text(services.translate("The beetles come swiftly, bearing some mushrooms.")), "good")
    return true
    end
    EOC["EOC_LOSE_STAG_BEETLE_BOND"] = function(ctx)
    H.lose_trait(H.u(ctx), "MAG_STAG_BEETLE_BOND")
    services.messages.add(ctx:expand_text(services.translate("Your bond with the stag beetle fades.  Another can answer the call now.")), "good")
    return true
    end
    EOC["EOC_KELVINIST_HEAT_FOOD_SPELL_ITEM"] = function(ctx)
    do local _g = H.safe_id('json_flag', "HOT"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    do local _g = H.safe_id('json_flag', "FROZEN"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_KELVINIST_HEAT_FOOD_SPELL"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", nil, { { category = "food" }, { category = "drink" } }, { "EOC_KELVINIST_HEAT_FOOD_SPELL_ITEM" }, {  })
    return true
    end
    COND["EOC_KELVINIST_SET_EVERYONE_ON_FIRE"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_KELVINIST_SET_EVERYONE_ON_FIRE"] = function(ctx)
    if (ctx:has_speaker()) then
        H.set_var("actor", H.u(ctx), ctx, "kelvinist_explosion_level", H.char_spell_level(H.npc(ctx), "kelvinist_set_everyone_on_fire"))
        H.eoc_cast_spell(H.u(ctx), "kelvinist_set_everyone_on_fire_secondary", false, { hit_self = true, min_level = math.floor(H.var_num(H.u(ctx), "kelvinist_explosion_level")) })
        return true
    end
    return false
    end
    EOC["EOC_MAGUS_MARK"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "magus_teleport_mark", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("As you make the gestures and recite the incantation, a brief glow fills your surroundings.")), "good")
    return true
    end
    EOC["EOC_MAGUS_RECALL"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You shout out the word of recall and suddenly you are somewhere else.")), "good")
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "magus_teleport_mark"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    COND["EOC_MAGUS_STOP_ATTACK_SHIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_magus_mageshield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MAGUS_STOP_ATTACK_SHIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_magus_mageshield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_magus_mageshield"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_MAGUS_FAR_HAND_PULL"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_MAGUS_FAR_HAND_PULL_ITEM"] == nil or E.cond["EOC_MAGUS_FAR_HAND_PULL_ITEM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Grab Item")), description = ctx:expand_text(services.translate("Pick up an item and pull it to you")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_MAGUS_FAR_HAND_PULL_ITEM" end end
        do local _en = (E.cond["EOC_MAGUS_FAR_HAND_PULL_CREATURE"] == nil or E.cond["EOC_MAGUS_FAR_HAND_PULL_CREATURE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Pull Creature")), description = ctx:expand_text(services.translate("Target a creature and pull it toward you")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_MAGUS_FAR_HAND_PULL_CREATURE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_MAGUS_FAR_HAND_PULL_ITEM"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "magus_far_hand_pull_items", false, { targeted = true })
    return true
    end
    EOC["EOC_MAGUS_FAR_HAND_PULL_CREATURE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "magus_far_hand_pull_creatures", false, { targeted = true })
    return true
    end
    EOC["EOC_MAGUS_DIAMOND_IMBUEMENT_ITEM"] = function(ctx)
    do local _g = H.safe_id('json_flag', "DIAMOND"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    do local _g = H.safe_id('json_flag', "DURABLE_MELEE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    do local _g = H.safe_id('json_flag', "NO_REPAIR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_MAGUS_DIAMOND_IMBUEMENT"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", nil, { { category = "weapons" } }, { "EOC_MAGUS_DIAMOND_IMBUEMENT_ITEM" }, {  })
    return true
    end
    COND["EOC_MAGUS_PUSH_NEARBY_ENEMIES_BACK"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_MAGUS_PUSH_NEARBY_ENEMIES_BACK"] = function(ctx)
    if (ctx:has_speaker()) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("context", nil, ctx, "push_nearby_enemies_power_level", H.char_spell_level(H.npc(ctx), "magus_push_nearby_enemies_back"))
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
    COND["EOC_SPELL_GRANT_MANA_ADD1_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_efficiency_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_ADD1_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_efficiency_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_ADD1", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_ADD1"] = function(ctx)
        return (((not services.gameplay.environment.is_night()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_ADD1"] = function(ctx)
    if (((not services.gameplay.environment.is_night()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_ADD1_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_ADD2_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_efficiency_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_ADD2_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_efficiency_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_ADD2", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_ADD2"] = function(ctx)
        return (((((services.turn() % 86400) / 3600) >= 11) and (((services.turn() % 86400) / 3600) <= 13) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 4))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_ADD2"] = function(ctx)
    if (((((services.turn() % 86400) / 3600) >= 11) and (((services.turn() % 86400) / 3600) <= 13) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 4))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_ADD2_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_REGEN1_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_regeneration_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_REGEN1_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_regeneration_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_REGEN1", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_REGEN1"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHALLOW_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DEEP_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "CURRENT"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sewage" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_pool_shallow_outdoors" end)())))))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_REGEN1"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHALLOW_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DEEP_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "CURRENT"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sewage" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_pool_shallow_outdoors" end)())))))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_REGEN1_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_REGEN2_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_regeneration_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_REGEN2_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_regeneration_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_REGEN2", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_REGEN2"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHALLOW_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DEEP_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) and (H.char_at_om_location(H.u(ctx), "generic_river_bank") or H.char_at_om_location(H.u(ctx), "generic_river") or H.char_at_om_location(H.u(ctx), "river_center") or H.char_at_om_location(H.u(ctx), "river") or H.char_at_om_location(H.u(ctx), "river_c_not_ne") or H.char_at_om_location(H.u(ctx), "river_c_not_nw") or H.char_at_om_location(H.u(ctx), "river_c_not_se") or H.char_at_om_location(H.u(ctx), "river_c_not_sw")) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "CURRENT"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sewage" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_pool_shallow_outdoors" end)())))))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_REGEN2"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHALLOW_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DEEP_WATER"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) and (H.char_at_om_location(H.u(ctx), "generic_river_bank") or H.char_at_om_location(H.u(ctx), "generic_river") or H.char_at_om_location(H.u(ctx), "river_center") or H.char_at_om_location(H.u(ctx), "river") or H.char_at_om_location(H.u(ctx), "river_c_not_ne") or H.char_at_om_location(H.u(ctx), "river_c_not_nw") or H.char_at_om_location(H.u(ctx), "river_c_not_se") or H.char_at_om_location(H.u(ctx), "river_c_not_sw")) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "CURRENT"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sewage" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_pool_shallow_outdoors" end)())))))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_REGEN2_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_MULT1_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_sensitivity_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_MULT1_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_sensitivity_01") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_MULT1", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_MULT1"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "magic_cabin", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dirt_road", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dumpsite", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_MULT1"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "magic_cabin", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dirt_road", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dumpsite", math.floor(4)) end)()))))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_MULT1_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_MULT2_PART2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_sensitivity_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_MULT2_PART2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "mana_upgrade_sensitivity_02") + (H.char_skill(H.u(ctx), "spellcraft") / 2)))) > (15))) then
        H.mutate_towards(H.u(ctx), "MANA_MULT2", "MANATOUCHED", false)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("As you intone the final words of the spell, you wait for the change, but nothing happens.  You must need more practice.")), "neutral")
        return false
    end
    end
    COND["EOC_SPELL_GRANT_MANA_MULT2"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "magic_cabin", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dirt_road", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dumpsite", math.floor(15)) end)()))))) == true
    end
    EOC["EOC_SPELL_GRANT_MANA_MULT2"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not (H.char_at_om_location(H.u(ctx), "FACTION_CAMP_ANY"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "magic_cabin", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dirt_road", math.floor(15)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "dumpsite", math.floor(15)) end)()))))) then
        H.run_eoc("EOC_SPELL_GRANT_MANA_MULT2_PART2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You intone the final words of the spell, but without the proper conditions being fulfilled it has no effect.")), "neutral")
        return false
    end
    end
    COND["EOC_CATOBLEPAS_GAZE_2"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_CATOBLEPAS_GAZE_2"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "head", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "head") + 1), nil)
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "torso", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "torso") + 1), nil)
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "arm_l", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "arm_l") + 1), nil)
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "arm_r", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "arm_r") + 1), nil)
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "leg_l", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "leg_l") + 1), nil)
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze", (services.random.native_int(0, H.round_half_away(10)) + 5), "leg_r", (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze", "leg_r") + 1), nil)
        return true
    else
        H.eoc_add_effect(H.u(ctx), "effect_catoblepas_gaze_monster", (services.random.native_int(0, H.round_half_away(10)) + 5), nil, (H.creature_effect_intensity(H.u(ctx), "effect_catoblepas_gaze_monster") + 1), nil)
        return false
    end
    end
    COND["EOC_CATOBLEPAS_GAZE"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "BLIND"))) and (not (((function() local eg = H.safe_id('effect', "BLIND"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true))))) == true
    end
    EOC["EOC_CATOBLEPAS_GAZE"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "BLIND"))) and (not (((function() local eg = H.safe_id('effect', "BLIND"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "BLIND") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "BLIND")).value == true))))) then
        H.run_eoc("EOC_CATOBLEPAS_GAZE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_FERAL_DABBLE_SPELLS_SELECTOR_SPELL"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "feral_dabbler_chosen_spell_number", (services.random.native_int(0, H.round_half_away(99)) + 1))
    return true
    end
    COND["EOC_MAGICLYSM_WILL_O_THE_WISP_DRAINING_ATTACK"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_MAGICLYSM_WILL_O_THE_WISP_DRAINING_ATTACK"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.set_var("context", nil, ctx, "attack_value", (100 + services.random.native_int(0, H.round_half_away(100))))
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("attack_value") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("attack_value") or 0); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("attack_value") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("attack_value") or 0); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    else
        H.eoc_add_effect(H.u(ctx), "effect_will_o_wisp_draining_monsters", (function() local a, b = math.floor(7200), math.floor(360000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return false
    end
    end
    EOC["EOC_RUST_MONSTER_DETECT_METAL_TRUE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "rust_monster_polymorph_to_hostile", false, { target = H.get_tripoint_var("context", nil, ctx, "loc") })
    H.eoc_cast_spell(H.u(ctx), "rust_monster_increase_aggression", false, { target = H.get_tripoint_var("context", nil, ctx, "loc") })
    return true
    end
    COND["EOC_RUST_MONSTER_DETECT_METAL"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_RUST_MONSTER_DETECT_METAL"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true } }, { "EOC_RUST_MONSTER_DETECT_METAL_TRUE" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_RUST_MONSTER_INCREASE_AGGRESSION"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "anger", 50, "=")
    return true
    end
    COND["EOC_GAIN_CLOAK_OF_FROG_MUTATIONS"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "THRESH_BATRACHIAN") == 1)))) == true
    end
    EOC["EOC_GAIN_CLOAK_OF_FROG_MUTATIONS"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "THRESH_BATRACHIAN") == 1)))) then
        do local _g = H.safe_id('mutation', "FRESHWATEROSMOSIS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "PHEROMONE_AMPHIBIAN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "AMPHIBIAN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "stormshaper_cloak_of_frog") * 3750) + 15000) * H._jm_transformation_proficiency_modifier(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "stormshaper_cloak_of_frog") * 3750) + 15000) * H._jm_transformation_proficiency_modifier(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LOSE_CLOAK_OF_FROG_MUTATIONS"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_LOSE_CLOAK_OF_FROG_MUTATIONS"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("It wasn't easy being green.")), "mixed")
    H.lose_trait(H.u(ctx), "FRESHWATEROSMOSIS")
    H.lose_trait(H.u(ctx), "PHEROMONE_AMPHIBIAN")
    H.lose_trait(H.u(ctx), "AMPHIBIAN")
    return true
    end
    EOC["EOC_CONJURE_UPS_INITIATE"] = function(ctx)
    do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "technomancer_conjure_ups") * 100) + 1000) * H._jm_summoning_proficiency_modifier(ctx)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CONJURE_UPS_REMOVER"), nil) end end
    H.eoc_spawn_item(H.u(ctx), "technomancer_summoned_ups", 1, false, false, nil)
    H.run_eoc("EOC_CONJURE_UPS_EFFECT_BEGIN", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CONJURE_UPS_EFFECT_BEGIN"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "technomancer_summoned_ups")) == true
    end
    EOC["EOC_CONJURE_UPS_EFFECT_BEGIN"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "technomancer_summoned_ups")) then
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CONJURE_UPS_EFFECT_BEGIN"), nil) end end
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_powering", ((H.char_spell_level(H.u(ctx), "technomancer_conjure_ups") / 3) + 1))
        H.run_eoc("EOC_CONJURE_UPS_EFFECT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONJURE_UPS_EFFECT"] = function(ctx)
        return ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1)) == true
    end
    EOC["EOC_CONJURE_UPS_EFFECT"] = function(ctx)
    if ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1)) then
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_item_count", 0)
        H.run_eoc("EOC_CONJURE_UPS_EFFECT_GET_ITEM_COUNT", ctx, nil, nil, nil)
        H.run_eoc("EOC_CONJURE_UPS_EFFECT_AMMEND_ITEM_COUNT", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_max_indv_power", math.floor((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") / H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count"))))
        H.run_eoc("EOC_CONJURE_UPS_EFFECT_POWER_ITEMS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONJURE_UPS_EFFECT_POWER_ITEMS_DISTRIBUTION"] = function(ctx)
        return ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1)) == true
    end
    EOC["EOC_CONJURE_UPS_EFFECT_POWER_ITEMS_DISTRIBUTION"] = function(ctx)
    if ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1)) then
        if (H.var_num(H.u(ctx), "technomancer_conjure_ups_max_indv_power") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_powering_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "technomancer_conjure_ups_max_indv_power")))
        else
            H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_powering_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "technomancer_conjure_ups_powering")))
        end
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_powering_used", math.min((H.char_bionic_power(H.npc(ctx), "power_max") - H.char_bionic_power(H.npc(ctx), "power")), H.var_num(H.u(ctx), "technomancer_conjure_ups_max_indv_power")))
        H.set_bionic_power(H.npc(ctx), H.var_num(H.u(ctx), "technomancer_conjure_ups_powering_used"), "+=")
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_powering", (H.var_num(H.u(ctx), "technomancer_conjure_ups_powering")) - (H.var_num(H.u(ctx), "technomancer_conjure_ups_powering_used")))
        return true
    end
    return false
    end
    COND["EOC_CONJURE_UPS_EFFECT_POWER_ITEMS"] = function(ctx)
        return (((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1) and (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count") >= 1))) == true
    end
    EOC["EOC_CONJURE_UPS_EFFECT_POWER_ITEMS"] = function(ctx)
    if (((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1) and (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count") >= 1))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_CONJURE_UPS_EFFECT_POWER_ITEMS_DISTRIBUTION" }, {  })
        H.run_eoc("EOC_CONJURE_UPS_EFFECT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_CONJURE_UPS_EFFECT_GET_ITEM_COUNT_2"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_item_count", (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count")) + (1))
    return true
    end
    EOC["EOC_CONJURE_UPS_EFFECT_GET_ITEM_COUNT"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_CONJURE_UPS_EFFECT_GET_ITEM_COUNT_2" }, {  })
    return true
    end
    COND["EOC_CONJURE_UPS_EFFECT_AMMEND_ITEM_COUNT"] = function(ctx)
        return (((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1) and (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count") >= 1) and ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") / H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count")) < 1))) == true
    end
    EOC["EOC_CONJURE_UPS_EFFECT_AMMEND_ITEM_COUNT"] = function(ctx)
    if (((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") >= 1) and (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count") >= 1) and ((H.var_num(H.u(ctx), "technomancer_conjure_ups_powering") / H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count")) < 1))) then
        H.set_var("actor", H.u(ctx), ctx, "technomancer_conjure_ups_item_count", (H.var_num(H.u(ctx), "technomancer_conjure_ups_item_count")) - (1))
        H.run_eoc("EOC_CONJURE_UPS_EFFECT_AMMEND_ITEM_COUNT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_CONJURE_UPS_REMOVER"] = function(ctx)
    do local g = H.safe_id('item', "technomancer_summoned_ups"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "technomancer_summoned_ups_2"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "technomancer_summoned_ups_3"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "technomancer_summoned_ups_4"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "technomancer_summoned_ups_5"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "technomancer_summoned_ups_6"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    EOC["EOC_TECHNOMANCER_POWER_LINKAGE_ITEM"] = function(ctx)
    do local _g = H.safe_id('json_flag', "USE_UPS"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_TECHNOMANCER_POWER_LINKAGE"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", nil, { {  } }, { "EOC_TECHNOMANCER_POWER_LINKAGE_ITEM" }, {  })
    return true
    end
    COND["EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING_CHARGER"] = function(ctx)
        return ((H.char_bionic_power(H.npc(ctx), "power") < H.char_bionic_power(H.npc(ctx), "power_max"))) == true
    end
    EOC["EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING_CHARGER"] = function(ctx)
    if ((H.char_bionic_power(H.npc(ctx), "power") < H.char_bionic_power(H.npc(ctx), "power_max"))) then
        H.set_bionic_power(H.npc(ctx), (H.char_spell_level(H.u(ctx), "spy_wasp") + H.char_spell_level(H.u(ctx), "artificer_toolkit")), "+=")
        return true
    end
    return false
    end
    COND["EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARTIFICER") == 1)) == true
    end
    EOC["EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARTIFICER") == 1)) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  }, {  }, {  }, {  } }, { "EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING_CHARGER" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_DUST_REBORN_INITIAL"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "dust_reborn_teleport", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.eoc_add_effect(H.u(ctx), "effect_dust_reborn", 2592000, nil, nil, nil)
    do local _g = H.safe_id('mutation', "DUST_REBORN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    services.messages.add(ctx:expand_text(services.translate("Part of your body and soul were divorced.")), "neutral")
    return true
    end
    COND["EOC_DUST_REBORN"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DUST_REBORN") == 1)) == true
    end
    EOC["EOC_DUST_REBORN"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DUST_REBORN") == 1)) then
        H.eoc_add_effect(H.u(ctx), "incorporeal", 1, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, nil)
        H.set_char_hp(H.u(ctx), "ALL", 999, "=")
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(70000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 70000; local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        H.eoc_spawn_item(H.u(ctx), "corpse_painful", 1, false, false, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DUST_REBORN_2"), nil) end end
        services.messages.add(ctx:expand_text(services.translate("You feel an insane pain, as your soul is pulled off, out of your body.  Second later, your mind were pulled somewhere else, in the place you visit before.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_DUST_REBORN_2"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DUST_REBORN") == 1)) == true
    end
    EOC["EOC_DUST_REBORN_2"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DUST_REBORN") == 1)) then
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "dust_reborn_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.lose_trait(H.u(ctx), "DUST_REBORN")
        local _a11 = H.u(ctx)
        if _a11 then services.characters.adjust(_a11, { pain = math.floor((0) - (H.char_pain(_a11))) }) end
        H.set_char_val_extra(H.u(ctx), "thirst", 0, "=")
        H.set_char_val_extra(H.u(ctx), "rad", 0, "=")
        do local _a, _v = H.u(ctx), "bad_food"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "calcium"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "instability"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "iron"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_alpha"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_batrachian"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_beast"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_bird"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_cattle"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_cephalopod"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_chelator"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen_chimera"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
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
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "vitC"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_GIVE_FROZEN_PRESSURE_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "GLACIER_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_glacier_mage_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_FROZEN_PRESSURE_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "GLACIER_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_glacier_mage_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "FROZEN_PRESSURE_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_glacier_mage_attunement", "yes")
        return true
    end
    return false
    end
    COND["EOC_GIVE_CLAIRVOYANCE_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "RADIATION_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_radiation_mage_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_CLAIRVOYANCE_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "RADIATION_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_radiation_mage_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "CLAIRVOYANCE_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_radiation_mage_attunement", "yes")
        return true
    end
    return false
    end
    COND["EOC_GIVE_MIND_READ"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SHAMAN") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_shaman_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_MIND_READ"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SHAMAN") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_shaman_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "MIND_READ_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_shaman_attunement", "yes")
        return true
    end
    return false
    end
    COND["EOC_GIVE_SOUL_PRESSURE_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SOULFIRE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_soulfire_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_SOUL_PRESSURE_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SOULFIRE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_soulfire_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "SOUL_PRESSURE_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_soulfire_attunement", "yes")
        return true
    end
    return false
    end
    COND["SUN_MAGE_BUFF"] = function(ctx)
        return ((((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_has_trait(H.u(ctx), "SUN_MAGE") == 1)) or H.char_has_items(H.u(ctx), "pocket_sun", math.floor(1), math.floor(0)))) == true
    end
    EOC["SUN_MAGE_BUFF"] = function(ctx)
    if ((((not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_has_trait(H.u(ctx), "SUN_MAGE") == 1)) or H.char_has_items(H.u(ctx), "pocket_sun", math.floor(1), math.floor(0)))) then
        H.eoc_add_effect(H.u(ctx), "sun_mage_buff", 600, nil, 1, nil)
        return true
    end
    return false
    end
    COND["EOC_GIVE_FREEZING_AURA_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TUNDRA_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_tundra_mage_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_FREEZING_AURA_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TUNDRA_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_tundra_mage_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "FREEZING_AURA_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_tundra_mage_attunement", "yes")
        return true
    end
    return false
    end
    COND["EOC_GIVE_TOXIC_AURA_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "WITHER_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_wither_mage_attunement", "")))))))) == true
    end
    EOC["EOC_GIVE_TOXIC_AURA_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "WITHER_MAGE") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "attunement_attunement_u_got_wither_mage_attunement", "")))))))) then
        do local _g = H.safe_id('mutation', "TOXIC_AURA_OFF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "attunement_attunement_u_got_wither_mage_attunement", "yes")
        return true
    end
    return false
    end
    COND["EOC_CONDITION_MAGICLYSM_ELF_WILDERNESS_EQUIVALENTS"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor_noroof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_heartwood_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_floor_primitive" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_thatchroof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()) or H.char_on_furniture(H.u(ctx), "f_large_groundsheet") or H.char_on_furniture(H.u(ctx), "f_fema_groundsheet") or H.char_on_furniture(H.u(ctx), "f_center_groundsheet") or H.char_at_om_location(H.u(ctx), "park") or H.char_at_om_location(H.u(ctx), "park_5") or H.char_at_om_location(H.u(ctx), "park_7"))) == true
    end
    EOC["EOC_CONDITION_MAGICLYSM_ELF_WILDERNESS_EQUIVALENTS"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor_noroof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_heartwood_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_floor_primitive" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_thatchroof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()) or H.char_on_furniture(H.u(ctx), "f_large_groundsheet") or H.char_on_furniture(H.u(ctx), "f_fema_groundsheet") or H.char_on_furniture(H.u(ctx), "f_center_groundsheet") or H.char_at_om_location(H.u(ctx), "park") or H.char_at_om_location(H.u(ctx), "park_5") or H.char_at_om_location(H.u(ctx), "park_7"))) then
        return true
    end
    return false
    end
    EOC["EOC_ROCK_TROLL_TURN_TO_STONE"] = function(ctx)
    do local _p, _g = (H.creature_snap(H.npc(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_rock_troll_death"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
end
