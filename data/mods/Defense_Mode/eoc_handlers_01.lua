local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["defense_mode_game_start_final_setup"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("Get ready for the first wave, it's not that far away!")))
    H.run_eoc("DEFENSE_MODE_WAVE_CONTROL", ctx, nil, nil, nil)
    return true
    end
    COND["defense_mode_caravan_spawn"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, (((H.var_num(H.u(ctx), "search_radius") == 3)) and 1 or 0), nil) <= 0)) == true
    end
    EOC["defense_mode_caravan_spawn"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, (((H.var_num(H.u(ctx), "search_radius") == 3)) and 1 or 0), nil) <= 0)) then
        H.spawn_npc(H.u(ctx), "defense_mode_merchant", { min_radius = math.floor(2), max_radius = math.floor(3) }, nil)
        services.messages.add(ctx:expand_text(services.translate("A caravan approaches!")), "good")
        return true
    end
    return false
    end
    EOC["defense_mode_hire_merc_true"] = function(ctx)
    H.spawn_npc(H.u(ctx), "follower_mercenary", { min_radius = math.floor(2), max_radius = math.floor(3) }, nil)
    return true
    end
    COND["defense_mode_money_add_npc"] = function(ctx)
        return ((not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_got_money", ""))))))) == true
    end
    EOC["defense_mode_money_add_npc"] = function(ctx)
    if ((not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "general_trade_u_got_money", ""))))))) then
        if H.u(ctx) then services.characters.adjust(H.u(ctx), { cash = -math.floor((H.global_var_num("wave_number") * H.global_var_num("wave_money_modifier"))) }) end
        H.set_var("actor", H.npc(ctx), ctx, "general_trade_u_got_money", "yes")
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_FORTRESS_TRAP"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "field", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest_thick", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(0)) end)()))) == true
    end
    EOC["DEFENSE_MODE_FORTRESS_TRAP"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "field", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest_thick", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(0)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(0)) end)()))) then
        services.messages.add(ctx:expand_text(services.translate("You can't leave your fortress behind!")), "bad")
        do local _p = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    end
    return false
    end
    COND["EOC_DEFENSE_MODE_PREVENT_DEATH"] = function(ctx)
        return ((H.global_var_num("revivication_counter") >= 1)) == true
    end
    EOC["EOC_DEFENSE_MODE_PREVENT_DEATH"] = function(ctx)
    if ((H.global_var_num("revivication_counter") >= 1)) then
        do local _eg = H.safe_id('effect', "hypovolemia"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "redcells_anemia"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "grabbed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "staggered"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bite"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        H.set_char_val_extra(H.u(ctx), "pkill", H.char_val_extra(H.u(ctx), "pkill"), "=")
        H.set_char_val_extra(H.u(ctx), "stim", H.char_val_extra(H.u(ctx), "stim"), "=")
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor((0) - (H.char_pain(_a1))) }) end
        H.set_char_val_extra(H.u(ctx), "sleepiness", 0, "=")
        H.set_char_val_extra(H.u(ctx), "stamina", 8500, "=")
        H.set_var("global", nil, ctx, "revivication_counter", (H.global_var_num("revivication_counter")) - (1))
        H.eoc_cast_spell(H.u(ctx), "remove_opponents", false, nil)
        ccb.presentation.notice(ctx:expand_text(services.translate("For an instant that is also an eternity, you exist only in an empty void.  Then you feel something vast, alien, and merciless reach through a preexisting connection to give you just enough energy to exist.  Its motives for doing so are not likely to be benign.")))
        H.set_char_hp(H.u(ctx), "torso", math.max(H.char_hp(H.u(ctx), "torso", false), 100), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.char_hp(H.u(ctx), "head", false), 100), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.char_hp(H.u(ctx), "arm_l", false), 100), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.char_hp(H.u(ctx), "arm_r", false), 100), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.char_hp(H.u(ctx), "leg_l", false), 100), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.char_hp(H.u(ctx), "leg_r", false), 100), "=")
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_RANDOM_EVENT"] = function(ctx)
        return (((H.global_var_num("random_events_allowed") == 0) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and services.random.native_probability((7), (10)))) == true
    end
    EOC["DEFENSE_MODE_RANDOM_EVENT"] = function(ctx)
    if (((H.global_var_num("random_events_allowed") == 0) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and services.random.native_probability((7), (10)))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_DEFENSE_MODE_RANDOM_NPC"); table.insert(_wts, math.max(0, 10))
            table.insert(_ids, "EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_DEFENSE_MODE_BANDIT_ATTACK"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    EOC["EOC_DEFENSE_MODE_RANDOM_NPC"] = function(ctx)
    H.spawn_npc(H.u(ctx), "random_survivor", { min_radius = math.floor(15), max_radius = math.floor(40), outdoor_only = true }, nil)
    return true
    end
    EOC["EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER"] = function(ctx)
    H.spawn_npc(H.u(ctx), "random_survivor_nefarious", { min_radius = math.floor(15), max_radius = math.floor(40), outdoor_only = true }, nil)
    return true
    end
    EOC["EOC_DEFENSE_MODE_BANDIT_ATTACK"] = function(ctx)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    return true
    end
    EOC["DEFENSE_MODE_WAVE_CONTROL"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    H.set_var("global", nil, ctx, "wave_number", (H.global_var_num("wave_number")) + (1))
    services.messages.add(ctx:expand_text(services.translate("Welcome to wave <global_val:wave_number>!")), "bad")
    H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_DECIDER", ctx, nil, nil, nil)
    return true
    end
    COND["DEFENSE_MODE_WAVE_SPECIAL_DECIDER"] = function(ctx)
        return (((H.global_var_num("special_waves_allowed") == 0) and ((H.global_var_num("wave_number") == 5) or (H.global_var_num("wave_number") == 15) or (H.global_var_num("wave_number") == 30) or (H.global_var_num("wave_number") == 50)))) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPECIAL_DECIDER"] = function(ctx)
    if (((H.global_var_num("special_waves_allowed") == 0) and ((H.global_var_num("wave_number") == 5) or (H.global_var_num("wave_number") == 15) or (H.global_var_num("wave_number") == 30) or (H.global_var_num("wave_number") == 50)))) then
        H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_FERALS", ctx, nil, nil, nil)
        H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_RATKIN", ctx, nil, nil, nil)
        H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_MILITARY", ctx, nil, nil, nil)
        H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_SHADOW", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_FALLBACK"] = function(ctx)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_ZOMBIES"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_SPECIAL_ZOMBIES"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_SPIDERS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_ROBOTS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_TRIFFIDS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_SUBSPACE"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_DINOS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_LIZARDFOLK"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_GOLEMS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_GOBLINS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_ORCS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_MEGAFAUNA"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_PSYCHICS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_CANDY"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_MYTHOS"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_EXODII"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_XEDRA"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "DEFENSE_MODE_WAVE_SPAWN_AFTERSHOCK"); table.insert(_wts, math.max(0, 1))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_ZOMBIES"] = function(ctx)
        return ((H.global_var_num("regular_zombies_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_ZOMBIES"] = function(ctx)
    if ((H.global_var_num("regular_zombies_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_VANILLA_ONLY_HUMANS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_SPECIAL_ZOMBIES"] = function(ctx)
        return ((H.global_var_num("special_zombies_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_SPECIAL_ZOMBIES"] = function(ctx)
    if ((H.global_var_num("special_zombies_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_ZOMBIE"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_SPIDERS"] = function(ctx)
        return ((H.global_var_num("spiders_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_SPIDERS"] = function(ctx)
    if ((H.global_var_num("spiders_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_SPIDER_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_ROBOTS"] = function(ctx)
        return ((H.global_var_num("robots_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_ROBOTS"] = function(ctx)
    if ((H.global_var_num("robots_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_ROBOT_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_TRIFFIDS"] = function(ctx)
        return ((H.global_var_num("triffids_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_TRIFFIDS"] = function(ctx)
    if ((H.global_var_num("triffids_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_TRIFFID_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_SUBSPACE"] = function(ctx)
        return ((H.global_var_num("subspace_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_SUBSPACE"] = function(ctx)
    if ((H.global_var_num("subspace_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_NETHER_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPECIAL_FERALS"] = function(ctx)
        return ((H.global_var_num("wave_number") == 5)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPECIAL_FERALS"] = function(ctx)
    if ((H.global_var_num("wave_number") == 5)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_FERAL"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("You hear the wild howls of crazed individuals and unintelligible, carnal gibberish and slavering cries.  Something is coming, and it doesn't have your best interest in mind.")))
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_WAVE_SPECIAL_RATKIN"] = function(ctx)
        return ((H.global_var_num("wave_number") == 15)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPECIAL_RATKIN"] = function(ctx)
    if ((H.global_var_num("wave_number") == 15)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_RATKIN_EVOLVED"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Squeaking and chittering can be heard nearby, with the pattering of many feet, like a swarm of rats traveling quickly.  However, this sounds more, organized?  Almost like they're all walking in formation.")))
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_WAVE_SPECIAL_MILITARY"] = function(ctx)
        return ((H.global_var_num("wave_number") == 30)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPECIAL_MILITARY"] = function(ctx)
    if ((H.global_var_num("wave_number") == 30)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MIL_HELIPAD"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("You hear crazed, half-pronounced orders screamed from afar.  The tamping of boots and off-beat shouts of two-three-four sound like the signs of an approaching army, but all the footfall is out of tune.")))
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_WAVE_SPECIAL_SHADOW"] = function(ctx)
        return ((H.global_var_num("wave_number") == 50)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPECIAL_SHADOW"] = function(ctx)
    if ((H.global_var_num("wave_number") == 50)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_boss_shadow") or H.safe_id('monster_group', "mon_boss_shadow"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Your vision flickers with black, blob-like creatures for a moment.  An intense feeling of paranoia washes over you, as if the world itself is now out to kill you, the night itself reaching for your mind to rip it apart.  Somethings wicked comes this way, and it wants you dead.")))
        return true
    end
    return false
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_DINOS"] = function(ctx)
        return ((H.global_var_num("dinos_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_DINOS"] = function(ctx)
    if ((H.global_var_num("dinos_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_DINOSAUR_DANGEROUS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_MYTHOS"] = function(ctx)
        return ((H.global_var_num("mythos_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_MYTHOS"] = function(ctx)
    if ((H.global_var_num("mythos_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MYTHOS_SPAWN"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_AFTERSHOCK"] = function(ctx)
        return ((H.global_var_num("aftershock_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_AFTERSHOCK"] = function(ctx)
    if ((H.global_var_num("aftershock_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "AFS_GROUP_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_troubleseek_on"] = function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) + (0.25))
    services.messages.add(ctx:expand_text(services.translate("You start seeking trouble.")), "neutral")
    return true
    end
    EOC["EOC_troubleseek_off"] = function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) - (0.25))
    services.messages.add(ctx:expand_text(services.translate("You stop seeking trouble for now.")), "neutral")
    return true
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_LIZARDFOLK"] = function(ctx)
        return ((H.global_var_num("lizardfolk_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_LIZARDFOLK"] = function(ctx)
    if ((H.global_var_num("lizardfolk_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_LIZARDFOLK_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_GOLEMS"] = function(ctx)
        return ((H.global_var_num("golems_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_GOLEMS"] = function(ctx)
    if ((H.global_var_num("golems_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_GOLEM_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_GOBLINS"] = function(ctx)
        return ((H.global_var_num("goblins_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_GOBLINS"] = function(ctx)
    if ((H.global_var_num("goblins_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_GOBLIN_STANDARD"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_ORCS"] = function(ctx)
        return ((H.global_var_num("orcs_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_ORCS"] = function(ctx)
    if ((H.global_var_num("orcs_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_ORC_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_MEGAFAUNA"] = function(ctx)
        return ((H.global_var_num("megafauna_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_MEGAFAUNA"] = function(ctx)
    if ((H.global_var_num("megafauna_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MEGAFAUNA_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_PSYCHICS"] = function(ctx)
        return ((H.global_var_num("mindovermatter_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_PSYCHICS"] = function(ctx)
    if ((H.global_var_num("mindovermatter_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_FERAL_PSYCHIC_DM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(H._jm_wave_spawn_number(ctx)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_VANILLA_ONLY_HUMANS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 2)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_CANDY"] = function(ctx)
        return ((H.global_var_num("candymonsters_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_CANDY"] = function(ctx)
    if ((H.global_var_num("candymonsters_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_SWEET_HORDE"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_EXODII"] = function(ctx)
        return ((H.global_var_num("exodii_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_EXODII"] = function(ctx)
    if ((H.global_var_num("exodii_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_DEFENSE_MODE_EXODII"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_SPAWN_XEDRA"] = function(ctx)
        return ((H.global_var_num("xedra_allowed") == 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_SPAWN_XEDRA"] = function(ctx)
    if ((H.global_var_num("xedra_allowed") == 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_DEFENSE_MODE_XEDRA"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((H._jm_wave_spawn_number(ctx) * 3)), min_radius = math.floor(20), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_SPAWN_FALLBACK", ctx, nil, nil, nil)
        return false
    end
    end
end
