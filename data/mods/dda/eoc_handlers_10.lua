local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_NL_PHASE_GOO"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (H.u(ctx) ~= nil))) == true
    end
    EOC["EOC_NL_PHASE_GOO"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (H.u(ctx) ~= nil))) then
        H.eoc_add_effect(H.u(ctx), "nl_phase_goo", 30, nil, nil, nil)
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "EOC_NL_PHASE_GOO_PHASED_FAULT" }, {  })
        return true
    end
    return false
    end
    COND["EOC_cellar_spider_leg"] = function(ctx)
        return (services.random.native_probability(1, (2))) == true
    end
    EOC["EOC_cellar_spider_leg"] = function(ctx)
    if (services.random.native_probability(1, (2))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_spider_cellar_leg") or H.safe_id('monster_group', "mon_spider_cellar_leg"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(1, 4)), min_radius = math.floor(1), max_radius = math.floor(3) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("The maimed leg wriggles loose!")), 'warning') end
        end end
        do local _eg = H.safe_id('effect', "maimed_leg"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_shifting_mass_attack"] = function(ctx)
        return ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))) == true
    end
    EOC["EOC_shifting_mass_attack"] = function(ctx)
    if ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", math.min((((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.global_var_num("ps_str")) + 20), 1200), "=")
        H.set_char_val_extra(H.u(ctx), "stamina", (H.global_var_num("ps_str") + 50), "*=")
        H.set_var("actor", H.u(ctx), ctx, "sleep_deprivation", (H.var_num(H.u(ctx), "sleep_deprivation")) + (60))
        return true
    end
    return false
    end
    COND["EOC_impossible_shape_attack"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not ((H.char_has_trait(H.u(ctx), "anti_shape") == 1))))) == true
    end
    EOC["EOC_impossible_shape_attack"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (not ((H.char_has_trait(H.u(ctx), "anti_shape") == 1))))) then
        if (H.var_num(H.u(ctx), "madness") >= 10) then
            H.eoc_add_effect(H.u(ctx), "nightmares", 64800, nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "disrupted_sleep", 64800, nil, nil, nil)
            do local _g = H.safe_id('morale', "morale_impossible_shape"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
            local _a26 = H.u(ctx)
            if _a26 then services.characters.adjust(_a26, { pain = math.floor(3) }) end
            H.set_var("actor", H.u(ctx), ctx, "madness", 0)
            services.messages.add(ctx:expand_text(services.translate("Your mind lurches, the shapes and figures dance across your vision, you feel like your head is going to explode.")), "neutral")
        else
            local _a27 = H.u(ctx)
            if _a27 then services.characters.adjust(_a27, { pain = math.floor(3) }) end
            H.set_var("actor", H.u(ctx), ctx, "madness", (H.var_num(H.u(ctx), "madness")) + (1))
            services.messages.add(ctx:expand_text(services.translate("You can't look away from the impossible shape, staring at it is making you feel sick, you have to get away!")), "neutral")
        end
        return true
    else
        if (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) then
            services.messages.add(ctx:expand_text(services.translate("You could never describe its appearance, but you perceive the impossible shape as you would any other.")), "neutral")
        end
        return false
    end
    end
    COND["EOC_absence_capture_attack"] = function(ctx)
        return ((((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 3)) == true
    end
    EOC["EOC_absence_capture_attack"] = function(ctx)
    if ((((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 3)) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "portal_cage", nil, nil, nil, nil, nil, false, true, {  }, {  })
        do local _p, _g = H.get_tripoint_var("global", nil, ctx, "portal_cage"), H.safe_id('terrain_furniture_transform', "portal_cage_transform"); if _p and _g then services.world.transform_radius(_p, math.floor(2), _g, nil) end end
        do local _p, _g = H.get_tripoint_var("global", nil, ctx, "portal_cage"), H.safe_id('terrain_furniture_transform', "portal_cage_revert_transform"); if _p and _g then services.world.transform_radius(_p, math.floor(2), _g, { delay = services.time.duration_from_turns(math.floor((function() local a, b = math.floor(3), math.floor(5); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())) }) end end
        services.messages.add(ctx:expand_text(services.translate("All the empty space around you is suddenly even emptier than should be possible.")), "neutral")
        return true
    else
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_shifting_mass_attack"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_PORTAL_TELEPORT_STUCK_START"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_PORTAL_INCORPOREAL"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        services.messages.add(ctx:expand_text(services.translate("For an instant you feel the absence's hunger upon you.")), "neutral")
        return false
    end
    end
    COND["EOC_mon_twisting_blade_attack"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false)) == true
    end
    EOC["EOC_mon_twisting_blade_attack"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false)) then
        H.eoc_add_effect(H.u(ctx), "nightmares", 64800, nil, nil, nil)
        local _a28 = H.u(ctx)
        if _a28 then services.characters.adjust(_a28, { pain = math.floor(3) }) end
        H.set_char_val_extra(H.u(ctx), "stamina", 20, "-=")
        return true
    end
    return false
    end
    COND["EOC_mon_swarm_structure_attack"] = function(ctx)
        return ((((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 4)) == true
    end
    EOC["EOC_mon_swarm_structure_attack"] = function(ctx)
    if ((((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) > 4)) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "swarm_target", nil, nil, nil, { min_radius = math.floor(1), max_radius = math.floor(2) }, nil, false, true, {  }, {  })
        do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.npc(ctx), ctx, "swarm_target"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
        return true
    else
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_twisting_blade") or H.safe_id('monster_group', "mon_twisting_blade"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(3, 5)), hallucinations = math.floor(services.random.native_int(5, 10)), min_radius = math.floor(3), max_radius = math.floor(5), lifespan = { minimum = services.time.duration_from_turns(math.floor(5)), maximum = services.time.duration_from_turns(math.floor(10)) } }); 
        end end
        return false
    end
    end
    EOC["EOC_mon_reflection_attack"] = function(ctx)
    do
        local _sw29 = ((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)())
        if _sw29 == 0 then
            services.messages.add(ctx:expand_text(services.translate("Your reflection feasts directly on your essence.")), "neutral")
            H.set_char_val_extra(H.u(ctx), "sleepiness", math.min(((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.global_var_num("portal_dungeon_reflect_strength")), 1200), "=")
            H.set_var("global", nil, ctx, "portal_dungeon_reflect_strength", (H.global_var_num("portal_dungeon_reflect_strength")) + (3))
        elseif _sw29 == 2 then
            services.messages.add(ctx:expand_text(services.translate("Your reflection uses your bond to feast on your essence.")), "neutral")
            H.set_char_val_extra(H.u(ctx), "sleepiness", math.min(((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) + H.global_var_num("portal_dungeon_reflect_strength")), 1200), "=")
            H.set_var("global", nil, ctx, "portal_dungeon_reflect_strength", (H.global_var_num("portal_dungeon_reflect_strength")) + (1))
        elseif _sw29 == 8 then
            do
                local _sw30 = services.random.native_int(0, H.round_half_away(10))
                if _sw30 == 0 then
                    services.messages.add(ctx:expand_text(services.translate("Your reflection clears the way between you two.")), "neutral")
                    H.eoc_loc_var(H.u(ctx), ctx, "global", "first", nil, nil, nil, nil, nil, false, true, {  }, {  })
                    H.eoc_loc_var(H.npc(ctx), ctx, "global", "second", nil, nil, nil, nil, nil, false, true, {  }, {  })
                    do local p1, p2, _g = H.get_tripoint_var("global", nil, ctx, "first"), H.get_tripoint_var("global", nil, ctx, "second"), H.safe_id('terrain_furniture_transform', "clear_portal_walls"); if p1 and p2 and _g then services.world.transform_line(p1, p2, _g) end end
                elseif _sw30 == 5 then
                    if ((H.global_var_num("portal_dungeon_level") > 0) and (H.mons_nearby(H.u(ctx), { "mon_guilt" }, 1000, H.get_tripoint_var("global", nil, ctx, "dungeon_loc")) < 1)) then
                        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_guilt") or H.safe_id('monster_group', "mon_guilt"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(2), max_radius = math.floor(4) }); 
                            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something deep inside you is manifested physically.")), 'warning') end
                        end end
                    end
                elseif _sw30 == 8 then
                    if ((H.global_var_num("portal_dungeon_level") > 0) and (H.mons_nearby(H.u(ctx), { "mon_sloth" }, 1000, H.get_tripoint_var("global", nil, ctx, "dungeon_loc")) < 1)) then
                        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_sloth") or H.safe_id('monster_group', "mon_sloth"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(2), max_radius = math.floor(4) }); 
                            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something deep inside you is manifested physically.")), 'warning') end
                        end end
                    end
                end
            end
        end
    end
    return true
    end
    COND["EOC_PORTAL_STORM_SHADOW_RESPAWN"] = function(ctx)
        return (services.random.native_probability((8), (10))) == true
    end
    EOC["EOC_PORTAL_STORM_SHADOW_RESPAWN"] = function(ctx)
    if (services.random.native_probability((8), (10))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(30), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_STORM_SHADOW_SPAWN"), nil) end end
        return true
    else
        H.lose_trait(H.u(ctx), "TAINTED_SHADOW")
        return false
    end
    end
    EOC["EOC_sloth_attack"] = function(ctx)
    H.set_var("global", nil, ctx, "portal_dungeon_slow_strength", math.max((H.global_var_num("portal_dungeon_slow_strength") - 1), (-75)))
    H.eoc_add_effect(H.u(ctx), "slowed_time", (function() local a, b = math.floor(14400), math.floor(21600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    EOC["EOC_guilt_attack"] = function(ctx)
    H.set_var("global", nil, ctx, "portal_dungeon_carry_strength", math.max((H.global_var_num("portal_dungeon_carry_strength") - 1), (-75)))
    H.eoc_add_effect(H.u(ctx), "strengthened_gravity", (function() local a, b = math.floor(14400), math.floor(21600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    COND["EOC_FEAR_PARALYZE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "fearparalyze"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_FEAR_PARALYZE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "fearparalyze"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_FEAR_PARALYZE2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FEAR_PARALYZE2"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "PSYSHIELD_PARTIAL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PSYSHIELD_PARTIAL")).value == true) and services.random.native_probability(1, (4)))) == true
    end
    EOC["EOC_FEAR_PARALYZE2"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "PSYSHIELD_PARTIAL") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PSYSHIELD_PARTIAL")).value == true) and services.random.native_probability(1, (4)))) then
        services.messages.add(ctx:expand_text(services.translate("The <npc_name> probes your mind, but is rebuffed!")), "neutral")
        return true
    else
        H.run_eoc("EOC_FEAR_PARALYZE3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_FEAR_PARALYZE3"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(20)) > (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))) == true
    end
    EOC["EOC_FEAR_PARALYZE3"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(20)) > (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))) then
        services.messages.add(ctx:expand_text(services.translate("The terrifying visage of the <npc_name> paralyzes you.")), "bad")
        H.eoc_add_effect(H.u(ctx), "fearparalyze", 5, nil, nil, nil)
        local _u31 = H.u(ctx)
        if _u31 then services.characters.adjust(_u31, { moves = -math.floor((((4 * (((H.char_snap(H.u(ctx)) or {}).movement or {}).speed or 0)) / 100)) * 100) }) end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You manage to avoid staring at the horrendous <npc_name>.")), "neutral")
        return false
    end
    end
    COND["EOC_STARE"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) == true
    end
    EOC["EOC_STARE"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true) or H.char_has_flag(H.npc(ctx), "DIMENSIONAL_ANCHOR"))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a strange reverberation across your body.")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_STARE2"] = function(ctx)
        return ((H.npc(ctx) ~= nil and services.creatures.player_can_see(H.npc(ctx)).value == true)) == true
    end
    EOC["EOC_STARE2"] = function(ctx)
    if ((H.npc(ctx) ~= nil and services.creatures.player_can_see(H.npc(ctx)).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("The <npc_name> stares at you, and you shudder.")), "bad")
        H.run_eoc("EOC_STARE_EFF", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel like you're being watched, it makes you sick.")), "bad")
        H.run_eoc("EOC_STARE_EFF", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_STARE_EFF"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "taint", (function() local a, b = math.floor(120), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, (H.creature_effect_intensity(H.u(ctx), "taint") + 1), nil)
    H.run_eoc("EOC_STARE_EFF2", ctx, nil, nil, nil)
    H.run_eoc("EOC_STARE_EFF3", ctx, nil, nil, nil)
    H.run_eoc("EOC_STARE_EFF4", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_STARE_EFF2"] = function(ctx)
        return (((H.creature_effect_intensity(H.u(ctx), "taint") >= 2) and services.random.native_probability(1, (2)))) == true
    end
    EOC["EOC_STARE_EFF2"] = function(ctx)
    if (((H.creature_effect_intensity(H.u(ctx), "taint") >= 2) and services.random.native_probability(1, (2)))) then
        H.eoc_add_effect(H.u(ctx), "hallu", (function() local a, b = math.floor(1500), math.floor(2100); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "") or H.safe_id('monster_group', ""); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), hallucinations = math.floor(1), lifespan = services.time.duration_from_turns(math.floor(60)) }); 
        end end
        return true
    end
    return false
    end
    COND["EOC_STARE_EFF3"] = function(ctx)
        return (((H.creature_effect_intensity(H.u(ctx), "taint") >= 3) and services.random.native_probability(1, (12)))) == true
    end
    EOC["EOC_STARE_EFF3"] = function(ctx)
    if (((H.creature_effect_intensity(H.u(ctx), "taint") >= 3) and services.random.native_probability(1, (12)))) then
        H.eoc_add_effect(H.u(ctx), "blind", (function() local a, b = math.floor(240), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Your sight darkens as the visions overtake you!")), "bad")
        return true
    end
    return false
    end
    COND["EOC_STARE_EFF4"] = function(ctx)
        return (((H.creature_effect_intensity(H.u(ctx), "taint") == 4) and services.random.native_probability(1, (12)))) == true
    end
    EOC["EOC_STARE_EFF4"] = function(ctx)
    if (((H.creature_effect_intensity(H.u(ctx), "taint") == 4) and services.random.native_probability(1, (12)))) then
        H.eoc_add_effect(H.u(ctx), "tindrift", 1, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Your sight darkens as the visions overtake you!")), "bad")
        return true
    end
    return false
    end
    COND["EOC_BLANK_BODY_AVATAR_COPY"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_BLANK_BODY_AVATAR_COPY"] = function(ctx)
    if (ctx:has_speaker()) then
        if (((H.char_snap(H.u(ctx)) or {}).avatar == true) and services.random.native_probability((1), (50))) then
            do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "blank_body_avatar_copy_polymorph", (cs and cs.kind == 'monster'), { hit_self = true }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_veiled_butterfly_irradiate"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_veiled_butterfly_irradiate"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        services.messages.add(ctx:expand_text(services.translate("The veiled butterfly's wings move in odd ways and a strange glow envelops you!")), "bad")
        H.set_char_val_extra(H.u(ctx), "rad", 20, "+=")
        return true
    end
    return false
    end
    EOC["EOC_ZOMBIE_SUMMONER_SUMMON_HORDES"] = function(ctx)
    H.eoc_add_effect(H.npc(ctx), "effect_zombie_summoner_increase_power", 900, nil, nil, nil)
    H.set_var("context", nil, ctx, "summon_effect", (200 + (H.creature_effect_intensity(H.npc(ctx), "effect_zombie_summoner_increase_power") * 50)))
    services.messages.add(ctx:expand_text(services.translate("Summoning power is <context_val:summon_effect>.")), "debug")
    H.eoc_loc_var(H.u(ctx), ctx, "context", "zombie_horde_target", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "zombie_horde_target"); if _p then services.hordes.broadcast_signal(_p, math.floor((ctx:get_number("summon_effect") or 0))) end end
    return true
    end
    EOC["_EOC_HURT_WEAVER"] = function(ctx)
    do local _g, _a = H.safe_id('damage_type', "pure"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, 20, { body_part = H.safe_id('body_part', "torso") }) end end
    return true
    end
    COND["EOC_HURT_WEAVER"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_HURT_WEAVER"] = function(ctx)
    if (ctx:has_speaker()) then
        if ((H.char_snap(H.u(ctx)) or {}).avatar == true) then
            services.messages.add(ctx:expand_text(services.translate("The limb shatters like a pane of glass!")), "good")
            do local _cs = H.creature_snap(H.npc(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(36), nil); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "_EOC_HURT_WEAVER" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
        end
        return true
    end
    return false
    end
    COND["eoc_start_update_quadraphract_walkers"] = function(ctx)
        return ((H.global_var_num("updating_quadraphracts") ~= 1)) == true
    end
    EOC["eoc_start_update_quadraphract_walkers"] = function(ctx)
    if ((H.global_var_num("updating_quadraphracts") ~= 1)) then
        H.run_eoc("eoc_update_quadraphract_walkers", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["avatar_sees_quadraphract_setup"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) == true
    end
    EOC["avatar_sees_quadraphract_setup"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("You see the alien construct unfold itself in a single graceful motion.")), "neutral")
        return true
    end
    return false
    end
    EOC["quadraphract_leg_assign"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "quad_id", (ctx:get_number("quad_uid") or 0))
    return true
    end
    COND["quadraphract_setup"] = function(ctx)
        return ((H.var_num(H.u(ctx), "setup") ~= 1)) == true
    end
    EOC["quadraphract_setup"] = function(ctx)
    if ((H.var_num(H.u(ctx), "setup") ~= 1)) then
        H.run_eoc("avatar_sees_quadraphract_setup", ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "quad_uid", services.random.native_int(0, H.round_half_away(1200)))
        H.set_var("actor", H.u(ctx), ctx, "quad_uid", (ctx:get_number("quad_uid") or 0))
        H.set_var("actor", H.u(ctx), ctx, "setup", 1)
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_yrax_quadraphract_leg") or H.safe_id('monster_group', "mon_yrax_quadraphract_leg"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(4), min_radius = math.floor(1), max_radius = math.floor(1) }); 
        end end
        do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(2), { H.safe_id('monster', "mon_yrax_quadraphract_leg") }); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "quadraphract_leg_assign" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_quadraphract_deltas", services.turn())
        H.set_var("actor", H.u(ctx), ctx, "timer_quadraphract_smoke", services.turn())
        return true
    end
    return false
    end
    EOC["quadraphract_combat_strategy"] = function(ctx)
    do
        local _sw32 = H.mons_nearby(H.u(ctx), {  }, 10, nil)
        if _sw32 == 6 then
            H.run_eoc("eoc_quadraphract_deltas", ctx, nil, nil, nil)
        elseif _sw32 == 15 then
            H.eoc_cast_spell(H.u(ctx), "overcharge_yrax", false, nil)
            H.run_eoc("eoc_quadraphract_deltas", ctx, nil, nil, nil)
        end
    end
    do
        local _sw33 = H.mons_nearby(H.u(ctx), {  }, 30, nil)
        if _sw33 == 20 then
            H.run_eoc("eoc_quadraphract_smoke", ctx, nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_QUADRAPHRACT_CONTROL"] = function(ctx)
    H.run_eoc("eoc_start_update_quadraphract_walkers", ctx, nil, nil, nil)
    H.run_eoc("quadraphract_setup", ctx, nil, nil, nil)
    H.run_eoc("quadraphract_combat_strategy", ctx, nil, nil, nil)
    return true
    end
    COND["eoc_update_quadraphract_walkers"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), { "mon_yrax_quadraphract" }, 60, nil) >= 1)) == true
    end
    EOC["eoc_update_quadraphract_walkers"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), { "mon_yrax_quadraphract" }, 60, nil) >= 1)) then
        H.set_var("global", nil, ctx, "updating_quadraphracts", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("eoc_update_quadraphract_walkers"), nil) end end
        do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(65), { H.safe_id('monster', "mon_yrax_quadraphract") }); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "eoc_quadraphract_walker" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
        return true
    else
        H.set_var("global", nil, ctx, "updating_quadraphracts", 0)
        return false
    end
    end
    COND["quadraphract_leg_tp"] = function(ctx)
        return ((H.var_num(H.u(ctx), "quad_id") == (ctx:get_number("quad_uid") or 0))) == true
    end
    EOC["quadraphract_leg_tp"] = function(ctx)
    if ((H.var_num(H.u(ctx), "quad_id") == (ctx:get_number("quad_uid") or 0))) then
        do local _p = H.get_tripoint_var("context", nil, ctx, "quad_pos_1"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _p = H.get_tripoint_var("context", nil, ctx, "quad_pos_2"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _p = H.get_tripoint_var("context", nil, ctx, "quad_pos_3"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _p = H.get_tripoint_var("context", nil, ctx, "quad_pos_4"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    end
    return false
    end
    EOC["eoc_quadraphract_walker"] = function(ctx)
    H.set_var("context", nil, ctx, "quad_uid", H.var_num(H.u(ctx), "quad_uid"))
    H.eoc_loc_var(H.u(ctx), ctx, "context", "quad_pos_1", nil, nil, nil, nil, { dx = math.floor(1) }, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "context", "quad_pos_2", nil, nil, nil, nil, { dx = math.floor(-1) }, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "context", "quad_pos_3", nil, nil, nil, nil, { dy = math.floor(1) }, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "context", "quad_pos_4", nil, nil, nil, nil, { dy = math.floor(-1) }, false, true, {  }, {  })
    do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(20), { H.safe_id('monster', "mon_yrax_quadraphract_leg") }); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "quadraphract_leg_tp" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
    return true
    end
    COND["quadraphract_leg_hurt"] = function(ctx)
        return ((H.var_num(H.u(ctx), "quad_uid") == (ctx:get_number("uid") or 0))) == true
    end
    EOC["quadraphract_leg_hurt"] = function(ctx)
    if ((H.var_num(H.u(ctx), "quad_uid") == (ctx:get_number("uid") or 0))) then
        H.eoc_cast_spell(H.u(ctx), "quadraphract_hurt_self", false, nil)
        return true
    end
    return false
    end
    EOC["EOC_QUADRAPHRACT_HURT"] = function(ctx)
    H.set_var("context", nil, ctx, "uid", H.var_num(H.npc(ctx), "quad_id"))
    do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(60), { H.safe_id('monster', "mon_yrax_quadraphract") }); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "quadraphract_leg_hurt" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
    return true
    end
    COND["quadraphract_leg_dies"] = function(ctx)
        return ((H.var_num(H.u(ctx), "quad_id") == (ctx:get_number("uid") or 0))) == true
    end
    EOC["quadraphract_leg_dies"] = function(ctx)
    if ((H.var_num(H.u(ctx), "quad_id") == (ctx:get_number("uid") or 0))) then
        H.eoc_cast_spell(H.u(ctx), "quadraphract_hurt_self", false, nil)
        return true
    end
    return false
    end
    EOC["EOC_QUADRAPHRACT_DIES"] = function(ctx)
    H.set_var("context", nil, ctx, "uid", H.var_num(H.npc(ctx), "quad_uid"))
    do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(20), { H.safe_id('monster', "mon_yrax_quadraphract_leg") }); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "quadraphract_leg_dies" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
    return true
    end
    COND["eoc_quadraphract_deltas"] = function(ctx)
        return (((H.time_since(H.var_num_opt(H.u(ctx), "timer_quadraphract_deltas"), 1) > 60) and (H.mons_nearby(H.u(ctx), { "mon_yrax_delta" }, 40, nil) < 3))) == true
    end
    EOC["eoc_quadraphract_deltas"] = function(ctx)
    if (((H.time_since(H.var_num_opt(H.u(ctx), "timer_quadraphract_deltas"), 1) > 60) and (H.mons_nearby(H.u(ctx), { "mon_yrax_delta" }, 40, nil) < 3))) then
        H.set_var("actor", H.u(ctx), ctx, "timer_quadraphract_deltas", services.turn())
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_yrax_delta") or H.safe_id('monster_group', "mon_yrax_delta"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(5), min_radius = math.floor(1), max_radius = math.floor(2) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Shards of gleaming alloy detach from the quadraphract's surface!")), 'warning') end
        end end
        return true
    end
    return false
    end
    COND["avatar_sees_quadraphract_smoke"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) == true
    end
    EOC["avatar_sees_quadraphract_smoke"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("Several bomblets are expelled from the quadraphract's crown!")), "neutral")
        return true
    end
    return false
    end
    COND["eoc_quadraphract_smoke"] = function(ctx)
        return (((H.time_since(H.var_num_opt(H.u(ctx), "timer_quadraphract_smoke"), 1) > 40))) == true
    end
    EOC["eoc_quadraphract_smoke"] = function(ctx)
    if (((H.time_since(H.var_num_opt(H.u(ctx), "timer_quadraphract_smoke"), 1) > 40))) then
        H.set_var("actor", H.u(ctx), ctx, "timer_quadraphract_smoke", services.turn())
        H.eoc_cast_spell(H.u(ctx), "quadraphract_smoke_mortar", false, nil)
        H.run_eoc("avatar_sees_quadraphract_smoke", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_FERAL_ARMUS_TAKE_ARMUS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_mon_feral_serum_user_armus", 86400, nil, nil, nil)
    return true
    end
    EOC["YELLOW_MAINTENANCE_ALARM"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_maintenance_yellow") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
        services.messages.add((services.snippets.native_random("lab_safety_maintenance_snippets") or ''), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_NWD"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "concrete_wall_o_lab_res_8_NW" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_NED"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "concrete_wall_o_lab_res_8_NE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["BLUE_MAINTENANCE_ALARM"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_maintenance_blue") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
        services.messages.add((services.snippets.native_random("lab_safety_maintenance_snippets") or ''), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_cargo_NW"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "concrete_wall_o_lab_res_8_NW" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_cargo_NE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "concrete_wall_o_lab_res_8_NE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["BLUE_MAINTENANCE_ALARM2"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_maintenance_blue") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
        services.messages.add((services.snippets.native_random("lab_safety_maintenance_snippets") or ''), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "underground_lab_central_-6W"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "lab_security_corridor_e" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "underground_lab_central_-6E"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "lab_security_corridor_f" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["GREEN_RESEARCHER_ALARM"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_mutagen_green") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_NW"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "bot_release_rearcher_green" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_NE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "bot_release_rearcher_green_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_NWD"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "bot_release_rearcher_green" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["BLACK_SECURITY_ALARM"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_security_black") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "underground_lab_central_-6W"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "toxic_gas_corridor" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "underground_lab_central_-6W"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "lab_security_corridor_c" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "underground_lab_central_-6E"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "lab_security_corridor_d" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["GREEN_MAINTENANCE_ALARM"] = function(ctx)
    if H.char_has_item(H.u(ctx), "id_science_maintenance_green") then
        services.messages.add(ctx:expand_text(services.translate("Hello, valued employee.")), "neutral")
        services.messages.add((services.snippets.native_random("lab_safety_maintenance_snippets") or ''), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Remain in place, unauthorized person.  Security has been activated.")), "neutral")
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_CORE_2x1_EC_ground"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "bots_center_garage" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    COND["EOC_STAR_VAMPIRE_FANGED_DRINK_BLOOD"] = function(ctx)
        return (((ctx:get_number("damage") or 0) > 0)) == true
    end
    EOC["EOC_STAR_VAMPIRE_FANGED_DRINK_BLOOD"] = function(ctx)
    if (((ctx:get_number("damage") or 0) > 0)) then
        H.set_var("context", nil, ctx, "star_vampire_amount_drained", services.random.native_float(250, 650))
        return true
    end
    return false
    end
    COND["EOC_STAR_VAMPIRE_COILING_DRINK_BLOOD"] = function(ctx)
        return (((ctx:get_number("damage") or 0) > 0)) == true
    end
    EOC["EOC_STAR_VAMPIRE_COILING_DRINK_BLOOD"] = function(ctx)
    if (((ctx:get_number("damage") or 0) > 0)) then
        H.set_var("context", nil, ctx, "star_vampire_amount_drained", services.random.native_float(125, 325))
        return true
    end
    return false
    end
    EOC["EOC_LIEUTENANT_DRAIN_LIFE_TERRAIN"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "global", "drain_terrain", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_grass") }, { min_radius = math.floor(5), max_radius = math.floor(10), target_min_radius = math.floor(5), target_max_radius = math.floor(10) }, nil, false, true, {  }, {  })
    H.set_var("global", nil, ctx, "ltnt_transform_radius", 10)
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "drain_terrain"), H.safe_id('terrain_furniture_transform', "ltnt_grass_drain"); if _p and _g then services.world.transform_radius(_p, math.floor(H.global_var_num("ltnt_transform_radius")), _g, nil) end end
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "drain_terrain"), H.safe_id('terrain_furniture_transform', "ltnt_tree_drain"); if _p and _g then services.world.transform_radius(_p, math.floor(H.global_var_num("ltnt_transform_radius")), _g, nil) end end
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_AMALGAMATIONS_SPAWNED"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(6), outdoor_only = true, temporary_drop_items = true, lifespan = { minimum = services.time.duration_from_turns(math.floor(15)), maximum = services.time.duration_from_turns(math.floor(30)) } }); 
    end end
    services.messages.add(ctx:expand_text(services.translate("The air rings out with a piercing shriek!")), "warning")
    return true
    end
    COND["EOC_LIEUTENANT_ACTIVATE_SHADOW"] = function(ctx)
        return ((((services.time.calendar().now.turns_since_cataclysm / 86400) >= 7) and (H.global_var_num("Lieutenants_active") < 1))) == true
    end
    EOC["EOC_LIEUTENANT_ACTIVATE_SHADOW"] = function(ctx)
    if ((((services.time.calendar().now.turns_since_cataclysm / 86400) >= 7) and (H.global_var_num("Lieutenants_active") < 1))) then
        H.set_var("global", nil, ctx, "Lieutenants_active", 1)
        H.set_var("global", nil, ctx, "Shadow_Lurking", 1)
        return true
    end
    return false
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS_SHOULD_SPAWN"] = function(ctx)
        return (services.random.native_probability(1, (6))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_SHOULD_SPAWN"] = function(ctx)
    if (services.random.native_probability(1, (6))) then
        return true
    end
    return false
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS_CAN_SPAWN"] = function(ctx)
        return (((not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.global_var_num("Lieutenants_active") > 0) and (H.global_var_num("Shadow_Lurking") > 0) and (H.global_var_num("Shadow_Warnings") >= 1))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_CAN_SPAWN"] = function(ctx)
    if (((not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.global_var_num("Lieutenants_active") > 0) and (H.global_var_num("Shadow_Lurking") > 0) and (H.global_var_num("Shadow_Warnings") >= 1))) then
        return true
    end
    return false
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest_water")))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest_water")))) then
        return true
    end
    return false
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS"] = function(ctx)
        return ((0 == 0)) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS"] = function(ctx)
    if ((0 == 0)) then
        return true
    end
    return false
    end
    COND["EOC_SHADOW_SPAWN_CONDITIONS"] = function(ctx)
        return ((H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_SHOULD_SPAWN", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_CAN_SPAWN", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS", ctx))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS"] = function(ctx)
    if ((H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_SHOULD_SPAWN", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_CAN_SPAWN", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION", ctx) and H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS_XE_EFFECTS", ctx))) then
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
        return (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) == true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
    if (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) then
        H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW_PREP", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_LIEUTENANT_SHADOW_WARN", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_PREP"] = function(ctx)
    H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW_NOW", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW_NOW"] = function(ctx)
    H.set_var("global", nil, ctx, "Shadow_Lurking", (H.global_var_num("Shadow_Lurking")) - (1))
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_lieutenant_shadow") or H.safe_id('monster_group', "mon_lieutenant_shadow"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(10), max_radius = math.floor(15) }); 
    end end
    H.eoc_loc_var(H.u(ctx), ctx, "global", "shadow_encounter_XYZ_pos", nil, nil, nil, { min_radius = math.floor(1), max_radius = math.floor(1) }, nil, false, true, {  }, {  })
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LIEUTENANT_SPAWN_SHADOW_MESSAGE"), nil) end end
    return true
    end
end
