local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_XW_CHIRURGEONS_ATTACK"] = function(ctx)
        return (((not ((not services.gameplay.environment.is_night()))) and (H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) == true
    end
    EOC["EOC_XW_CHIRURGEONS_ATTACK"] = function(ctx)
    if (((not ((not services.gameplay.environment.is_night()))) and (H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) then
        if ((H.mons_nearby(H.u(ctx), {  }, 30, nil) == 0) and (H.chars_nearby(H.u(ctx), 20, "allies") == 0)) then
            if (H.char_at_om_location(H.u(ctx), "forest") and services.random.native_probability((1), (250000))) then
                ccb.presentation.notice(ctx:expand_text(services.translate("Shadows suddenly move around you under the boughs of the trees.")))
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_xw_chirurgeon") or H.safe_id('monster_group', "mon_xw_chirurgeon"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((services.random.native_int(0, H.round_half_away(2)) + 3)), min_radius = math.floor(8), max_radius = math.floor(20), outdoor_only = true, lifespan = { minimum = services.time.duration_from_turns(math.floor(600)), maximum = services.time.duration_from_turns(math.floor(900)) } }); 
                end end
            end
            if (H.char_at_om_location(H.u(ctx), "forest_thick") and services.random.native_probability((1), (75000))) then
                ccb.presentation.notice(ctx:expand_text(services.translate("Shadows suddenly move around you under the boughs of the trees.")))
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_xw_chirurgeon") or H.safe_id('monster_group', "mon_xw_chirurgeon"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((services.random.native_int(0, H.round_half_away(2)) + 3)), min_radius = math.floor(8), max_radius = math.floor(20), outdoor_only = true, lifespan = { minimum = services.time.duration_from_turns(math.floor(600)), maximum = services.time.duration_from_turns(math.floor(900)) } }); 
                end end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_XW_KILLED_BY_CHIRURGEONS_MUTATE"] = function(ctx)
    H.set_var("context", nil, ctx, "dart_mutation_category", ctx:expand_text("<random_category>"))
    services.messages.add(ctx:expand_text(services.translate("Mutation category is <context_val:dart_mutation_category>.")), "debug")
    do local _g = H.safe_id('mutation_category', H.var_str("context", nil, ctx, "dart_mutation_category", "")); if H.u(ctx) and _g then services.mutations.mutate_category(H.u(ctx), _g, false, true) end end
    return true
    end
    COND["EOC_XW_KILLED_BY_CHIRURGEONS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_mon_xw_chirurgeon_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_XW_KILLED_BY_CHIRURGEONS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_mon_xw_chirurgeon_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        ccb.presentation.notice(ctx:expand_text(services.translate("You collapse to the ground as darkness creeps in across your vision and the pain grows more and more distant.  The last thing you see are the cloaked forms closing in around you and reaching for you with their clawed hands.")))
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor((0) - (H.char_pain(_a1))) }) end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "ALL_MINOR", 999, "=")
        H.set_char_hp(H.u(ctx), "torso", math.max(H.char_hp(H.u(ctx), "torso", false), 15), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.char_hp(H.u(ctx), "head", false), 15), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.char_hp(H.u(ctx), "arm_l", false), 15), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.char_hp(H.u(ctx), "arm_r", false), 15), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.char_hp(H.u(ctx), "leg_l", false), 15), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.char_hp(H.u(ctx), "leg_r", false), 15), "=")
        H.eoc_loc_var(H.u(ctx), ctx, "context", "chirurgeon_teleport", { terrain = "forest_thick" }, { z = math.floor(0), search_range = math.floor(250), min_distance = math.floor(45), random = true }, nil, nil, nil, false, true, {  }, {  })
        H.eoc_add_effect(H.u(ctx), "effect_mon_xw_chirurgeon_sleeper", 28800, nil, nil, nil)
        H.set_var("context", nil, ctx, "chirurgeons_iterations", (services.random.native_int(0, H.round_half_away(3)) + 1))
        services.messages.add(ctx:expand_text(services.translate("You will gain <context_val:chirurgeons_iterations> mutations.")), "debug")
        do local _p = H.get_tripoint_var("context", nil, ctx, "chirurgeon_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        for _i = 1, math.floor((ctx:get_number("chirurgeons_iterations") or 0)) do
            H.run_eoc("EOC_XW_KILLED_BY_CHIRURGEONS_MUTATE", ctx, nil, nil, nil)
        end
        H.set_char_val_extra(H.u(ctx), "sleepiness", 250, "+=")
        H.eoc_add_effect(H.u(ctx), "sleep", 21600, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XW_KILLED_BY_CHIRURGEONS_AWAKEN"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_mon_xw_chirurgeon_sleeper"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_XW_KILLED_BY_CHIRURGEONS_AWAKEN"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_mon_xw_chirurgeon_sleeper"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Time passes before you wake up.  You don't know how much.  When you finally do awaken, you're in an unfamiliar part of the forest, and something about you is different.")))
        do local _eg = H.safe_id('effect', "effect_mon_xw_chirurgeon_sleeper"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LIZARDFOLK_BUILD") == 1)) == true
    end
    EOC["EOC_XEDRAWOOD_LIZARDFOLK_HAVE_NO_HAIR_GLOBAL_NPCS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LIZARDFOLK_BUILD") == 1)) then
        H.mutate_towards(H.u(ctx), "LIZARDFOLK_NO_HAIR", "ANY", false)
        return true
    end
    return false
    end
    EOC["EOC_XEDRAWOOD_HOLLOW_ONES_RESET_RELATIONS"] = function(ctx)
    do local g = H.safe_id("faction", "hollow_ones_faction"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = 1; local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "hollow_ones_faction"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = 1; local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    return true
    end
    COND["EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN"] = function(ctx)
        return ((services.random.native_probability(1, (12)) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "forest_water") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)())))) == true
    end
    EOC["EOC_SWAMP_TRAVEL_GHOST_LIGHT_SPAWN"] = function(ctx)
    if ((services.random.native_probability(1, (12)) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "forest_water") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)())))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_ghost_light") or H.safe_id('monster_group', "mon_ghost_light"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(2, 4)), min_radius = math.floor(20), max_radius = math.floor(50) }); 
        end end
        services.messages.add(ctx:expand_text(services.translate("You see flickering lights in the distance.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_XEDRAWOOD_VERY_RARE_GHOSTS_SPAWN_ON_ROADS"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and H.char_at_om_location(H.u(ctx), "ancient_road") and (not ((not services.gameplay.environment.is_night()))) and (H.char_val_extra(H.u(ctx), "fine_detail_vision_mod") >= 4) and (H.moon_phase() ~= 4) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "clear"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "sunny"))) and services.random.native_probability((1), (2500)))) == true
    end
    EOC["EOC_XEDRAWOOD_VERY_RARE_GHOSTS_SPAWN_ON_ROADS"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and H.char_at_om_location(H.u(ctx), "ancient_road") and (not ((not services.gameplay.environment.is_night()))) and (H.char_val_extra(H.u(ctx), "fine_detail_vision_mod") >= 4) and (H.moon_phase() ~= 4) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "clear"))) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "sunny"))) and services.random.native_probability((1), (2500)))) then
        services.messages.add(ctx:expand_text(services.translate("As your footsteps thud on the ancient road, you suddenly hear the sound of other footsteps behind you.")), "bad")
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_ghostly_warrior") or H.safe_id('monster_group', "mon_ghostly_warrior"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(2, 4)), min_radius = math.floor(services.random.native_int(5, 7)), max_radius = math.floor(services.random.native_int(8, 15)) }); 
        end end
        return true
    end
    return false
    end
    EOC["EOC_PROFESSION_PATTERN_TATTOO_MOUNTAIN"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mountain_tattoo_count", 4)
    return true
    end
    COND["EOC_XEDRAWOOD_SORCERY_XP_GAIN"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "FOREST_MAGIC" }) and (((("FOREST_MAGIC") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_XEDRAWOOD_SORCERY_XP_GAIN"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "FOREST_MAGIC" }) and (((("FOREST_MAGIC") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        if ((ctx:get_number("success") or 0) == H.global_var_num("false")) then
            local _a2 = H.u(ctx)
            local _sg3 = H.safe_id("skill", "deduction")
            if _a2 and _sg3 then services.skills.set(_a2, _sg3, { exercise_raw = math.floor((H.char_skill_exp(_a2, "deduction", true)) + (((100 * (ctx:get_number("difficulty") or 0)) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        else
            local _a4 = H.u(ctx)
            local _sg5 = H.safe_id("skill", "deduction")
            if _a4 and _sg5 then services.skills.set(_a4, _sg5, { exercise_raw = math.floor((H.char_skill_exp(_a4, "deduction", true)) + (((20 * (ctx:get_number("difficulty") or 0)) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        end
        return true
    end
    return false
    end
    COND["EOC_XEDRAWOOD_WEARINESS_COST"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "FOREST_MAGIC" }) and (((("FOREST_MAGIC") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_XEDRAWOOD_WEARINESS_COST"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "FOREST_MAGIC" }) and (((("FOREST_MAGIC") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        H.set_var("actor", H.u(ctx), ctx, "spell_weariness_cost", ((12 * ((ctx:get_number("difficulty") or 0) * 0.4)) * math.max(((30 - H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))) / 30), 0.5)))
        if ((ctx:get_number("success") or 0) ~= H.global_var_num("false")) then
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "spell_weariness_cost") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "spell_weariness_cost"); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "spell_weariness_cost") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "spell_weariness_cost"); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        else
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((H.var_num(H.u(ctx), "spell_weariness_cost") / 5) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (H.var_num(H.u(ctx), "spell_weariness_cost") / 5); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((H.var_num(H.u(ctx), "spell_weariness_cost") / 5) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (H.var_num(H.u(ctx), "spell_weariness_cost") / 5); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        end
        return true
    end
    return false
    end
    COND["EOC_XEDRAWOOD_THE_WISE_NO_STAFF_HARDER_SORCERY"] = function(ctx)
        return ((not (((function() local fg = H.safe_id('json_flag', "WISE_SORCERY_AID"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())))) == true
    end
    EOC["EOC_XEDRAWOOD_THE_WISE_NO_STAFF_HARDER_SORCERY"] = function(ctx)
    if ((not (((function() local fg = H.safe_id('json_flag', "WISE_SORCERY_AID"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())))) then
        H.set_spell_adj(H.u(ctx), "cost", "FOREST_MAGIC", "", "", 0.5, "=")
        H.set_spell_adj(H.u(ctx), "casting_time", "FOREST_MAGIC", "", "", 1, "=")
        return true
    end
    return false
    end
    COND["EOC_XedraWood_RandEnc"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_XedraWood_RandEnc"), 1) >= 86400) and (ctx:evaluate_conditional("random_enc_condition") == true))) == true
    end
    EOC["EOC_XedraWood_RandEnc"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_XedraWood_RandEnc"), 1) >= 86400) and (ctx:evaluate_conditional("random_enc_condition") == true))) then
        services.messages.add(ctx:expand_text(services.translate("XedraWood random encounter has met its conditions.")), "debug")
        H.eoc_loc_var(H.u(ctx), ctx, "global", "XedraWood_randenc_loc", { terrain = H.var_str("context", nil, ctx, "omt", "") }, { search_range = math.floor(30), min_distance = math.floor(3), random = true }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "XedraWood_randenc_loc"); if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("context", nil, ctx, "omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("context", nil, ctx, "map_update", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_XedraWood_RandEnc", services.turn())
        H.set_var("global", nil, ctx, "XedraWood_RandEnc", 1)
        H.copy_var("context", nil, "omt", "global", nil, "XedraWood_random_encounter_omt", ctx)
        H.copy_var("context", nil, "map_removal", "global", nil, "XedraWood_random_encounter_map_remove", ctx)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("XedraWood random encounter has not met its conditions.")), "debug")
        return false
    end
    end
    COND["EOC_XedraWood_RandEnc_remove"] = function(ctx)
        return (((H.time_since(H.var_num_opt(H.u(ctx), "timer_XedraWood_RandEnc"), 1) > 7200) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "XedraWood_random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("XedraWood_RandEnc") == 1))) == true
    end
    EOC["EOC_XedraWood_RandEnc_remove"] = function(ctx)
    if (((H.time_since(H.var_num_opt(H.u(ctx), "timer_XedraWood_RandEnc"), 1) > 7200) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "XedraWood_random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("XedraWood_RandEnc") == 1))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "XedraWood_randenc_loc"); if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("global", nil, ctx, "XedraWood_random_encounter_omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("global", nil, ctx, "XedraWood_random_encounter_map_remove", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "XedraWood_RandEnc", 0)
        return true
    end
    return false
    end
    EOC["EOC_RandEnc_Roadstop_camper_add"] = function(ctx)
    return true
    end
    COND["EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC"] = function(ctx)
        return ((H.global_var_num("XedraWood_RandEnc") ~= 1)) == true
    end
    EOC["EOC_XEDRAWOOD_LIZARDFOLK_HUNTING_PARTY_SWAMP_RANDENC"] = function(ctx)
    if ((H.global_var_num("XedraWood_RandEnc") ~= 1)) then
        ctx:set_conditional("random_enc_condition", (not ((services.time_snapshot().season_id == string.lower("winter")))))
        services.messages.add(ctx:expand_text(services.translate("lizardfolk encounter has triggered!")), "debug")
        H.run_eoc("EOC_XedraWood_RandEnc", ctx, { ["omt"] = "forest_water", ["map_update"] = "nest_RandEnc_lizardfolk_hunting_party_add", ["map_removal"] = "nest_RandEnc_lizardfolk_hunting_party_remove", ["chance"] = 1, ["days_till_spawn"] = 0 }, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "great_tree_z0_nw") or H.char_at_om_location(H.u(ctx), "great_tree_z0_ne") or H.char_at_om_location(H.u(ctx), "great_tree_z0_sw") or H.char_at_om_location(H.u(ctx), "great_tree_z0_se")))))) == true
    end
    EOC["EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "great_tree_z0_nw") or H.char_at_om_location(H.u(ctx), "great_tree_z0_ne") or H.char_at_om_location(H.u(ctx), "great_tree_z0_sw") or H.char_at_om_location(H.u(ctx), "great_tree_z0_se")))))) then
        do local _eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("As you exit the forest, your spell fades.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER_INDOORS"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))))) == true
    end
    EOC["EOC_FOREST_TRAVERSE_THE_WILDS_REMOVER_INDOORS"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))))) then
        do local _eg = H.safe_id('effect', "effect_forest_traverse_the_wilds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("As you step indoors, your spell fades.")), "bad")
        return true
    end
    return false
    end
    EOC["EOC_MOUNTAIN_TWO_ON"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mountain_tattoo_two_active", 1)
    return true
    end
    EOC["EOC_MOUNTAIN_TWO_OFF"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mountain_tattoo_two_active", 0)
    return true
    end
    EOC["EOC_MOUNTAIN_SIX_ON"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "item_mountain_tattoo_six", 1, false, true, nil)
    return true
    end
    EOC["EOC_MOUNTAIN_SIX_OFF"] = function(ctx)
    do local g = H.safe_id('item', "item_mountain_tattoo_six"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
end
