local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_DIVING_INTO_WATER_CHECK"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true)) == true
    end
    EOC["EOC_DIVING_INTO_WATER_CHECK"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true)) then
        if (((function() local eg = H.safe_id('effect', "spores"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (10))) then
            services.messages.add(ctx:expand_text(services.translate("You scrub your body extensively, and spores are finally gone.")), "good")
            do local _eg = H.safe_id('effect', "spores"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        if ((function() local eg = H.safe_id('effect', "boomered"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            services.messages.add(ctx:expand_text(services.translate("You wash the bile from your face.")), "good")
            do local _eg = H.safe_id('effect', "boomered"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        if ((function() local eg = H.safe_id('effect', "corroding"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            services.messages.add(ctx:expand_text(services.translate("You wash the acid from your body.")), "good")
            do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return true
    end
    return false
    end
    COND["EOC_MISSION_OLD_GUARD_REP_3_CHECK"] = function(ctx)
        return (((H.global_var_num("old_guard_rep_scouting") == 1) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(0)) end)()))) == true
    end
    EOC["EOC_MISSION_OLD_GUARD_REP_3_CHECK"] = function(ctx)
    if (((H.global_var_num("old_guard_rep_scouting") == 1) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(0)) end)()))) then
        H.set_var("global", nil, ctx, "old_guard_rep_scouting", 0)
        H.set_var("actor", H.u(ctx), ctx, "missions_old_guard_u_scouted_exodii", "yes")
        return true
    end
    return false
    end
    COND["EOC_godco_hate_u_mutant"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELFA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN", "THRESH_CHIROPTERAN", "THRESH_RABBIT" }))) == true
    end
    EOC["EOC_godco_hate_u_mutant"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELFA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN", "THRESH_CHIROPTERAN", "THRESH_RABBIT" }))) then
        H.set_var("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "yes")
        return true
    end
    return false
    end
    COND["theresa_remove"] = function(ctx)
        return ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_completed_theresa_going_away", "")))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_3", math.floor(12)) end)()))) == true
    end
    EOC["theresa_remove"] = function(ctx)
    if ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_completed_theresa_going_away", "")))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_3", math.floor(12)) end)()))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "godco_3"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "theresa_remove" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "general_completed_theresa_going_away", nil)
        H.set_var("actor", H.u(ctx), ctx, "general_completed_theresa_gone", "yes")
        return true
    end
    return false
    end
    COND["godco_place_trader"] = function(ctx)
        return (((H.global_var_num("godco_met_merchants") == 0) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 7) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(2)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(1)) end)()))))) == true
    end
    EOC["godco_place_trader"] = function(ctx)
    if (((H.global_var_num("godco_met_merchants") == 0) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 7) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(2)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(1)) end)()))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "godco_enter"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "godco_permanent_trader_predatory_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "godco_met_merchants", 1)
        return true
    end
    return false
    end
    COND["godco_change_trader"] = function(ctx)
        return (((H.global_var_num("freemerch_godco_trader_investigated") == 1) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(2)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(1)) end)()))))) == true
    end
    EOC["godco_change_trader"] = function(ctx)
    if (((H.global_var_num("freemerch_godco_trader_investigated") == 1) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(2)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(1)) end)()))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "godco_enter"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "godco_permanent_trader_change" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "freemerch_godco_trader_investigated", 2)
        return true
    end
    return false
    end
    COND["GODCO_EDDIE_CANNING_MISSION_ADD"] = function(ctx)
        return (((H.global_var_num("godco_has_canningpots") == 1) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_missions_got_mission", "")))))))) == true
    end
    EOC["GODCO_EDDIE_CANNING_MISSION_ADD"] = function(ctx)
    if (((H.global_var_num("godco_has_canningpots") == 1) and (not (((("yes") == (H.var_str("actor", H.npc(ctx), ctx, "dialogue_missions_got_mission", "")))))))) then
        do local _g = H.safe_id('mission', "MISSION_GODCO_FOOD_GUARD_CANNING_STARTUP"); if H.npc(ctx) and _g then services.npcs.missions.offer(H.npc(ctx), _g) end end
        H.set_var("actor", H.npc(ctx), ctx, "dialogue_missions_got_mission", "yes")
        return true
    end
    return false
    end
    COND["hallucinate_effect"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_thorazine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["hallucinate_effect"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_thorazine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "minor_hallucinations"); table.insert(_wts, math.max(0, 10))
            table.insert(_ids, "intermediate_hallucinations"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "bad_hallucinations"); table.insert(_wts, math.max(0, 4))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    EOC["minor_hallucinations"] = function(ctx)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "paranoid"); table.insert(_wts, math.max(0, 75))
        table.insert(_ids, "grandiose"); table.insert(_wts, math.max(0, 25))
        table.insert(_ids, "self_talk"); table.insert(_wts, math.max(0, 14))
        table.insert(_ids, "weapon_talk_hallucination"); table.insert(_wts, math.max(0, 14))
        table.insert(_ids, "false_npc_talk"); table.insert(_wts, math.max(0, 12))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    EOC["intermediate_hallucinations"] = function(ctx)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "self_shout"); table.insert(_wts, math.max(0, 30))
        table.insert(_ids, "hear_false_sound"); table.insert(_wts, math.max(0, 20))
        table.insert(_ids, "formication"); table.insert(_wts, math.max(0, 20))
        table.insert(_ids, "numbness"); table.insert(_wts, math.max(0, 15))
        table.insert(_ids, "shaking"); table.insert(_wts, math.max(0, 10))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    EOC["bad_hallucinations"] = function(ctx)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "creature_hallucinations"); table.insert(_wts, math.max(0, 20))
        table.insert(_ids, "visuals"); table.insert(_wts, math.max(0, 10))
        table.insert(_ids, "hallucination_swarm"); table.insert(_wts, math.max(0, 4))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    EOC["paranoid"] = function(ctx)
    services.messages.add((services.snippets.native_random("schizo_delusion_paranoid") or ''), "neutral")
    do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-100), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    return true
    end
    EOC["self_talk"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(5), "speech", (services.snippets.native_random("schizo_self_talk") or ''), false) end end
    return true
    end
    EOC["grandiose"] = function(ctx)
    services.messages.add((services.snippets.native_random("schizo_delusion_grandiose") or ''), "neutral")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(100), { duration = services.time.duration_from_turns(math.floor(1800)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    return true
    end
    COND["weapon_talk_hallucination"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_thorazine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["weapon_talk_hallucination"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_thorazine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.char_has_trait(H.u(ctx), "SCHIZOPHRENIC") == 1) or ((function() local eg = H.safe_id('effect', "hallu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true) then
            H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true } }, { "item_talks_to_you" }, {  })
        else
            H.run_eoc("minor_hallucinations", ctx, nil, nil, nil)
        end
        return true
    else
        H.run_eoc("minor_hallucinations", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["item_talks_to_you"] = function(ctx)
    if (H.char_hp(H.npc(ctx), "ALL", false) < H.char_hp(H.npc(ctx), "bp_null", true)) then
        services.messages.add(ctx:expand_text(services.translate("Your <npc_name> says \"<schizo_weapon_talk_damaged>\"")), "neutral")
    else
        if ((H.char_hp(H.u(ctx), "ALL", false) * 1.4) < H.char_hp(H.u(ctx), "bp_null", true)) then
            services.messages.add(ctx:expand_text(services.translate("Your <npc_name> says \"<schizo_weapon_talk_bleeding>\"")), "neutral")
        else
            if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (H.mons_nearby(H.u(ctx), {  }, 10, nil) >= 1)) then
                services.messages.add(ctx:expand_text(services.translate("Your <npc_name> says \"<schizo_weapon_talk_monster>\"")), "neutral")
            else
                services.messages.add(ctx:expand_text(services.translate("Your <npc_name> says \"<schizo_weapon_talk_misc>\"")), "neutral")
            end
        end
    end
    return true
    end
    EOC["false_npc_talk"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<full_name> says \"<lets_talk>\"")), "info")
    return true
    end
    EOC["self_shout"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(20), "activity", (services.snippets.native_random("schizo_self_shout") or ''), false) end end
    return true
    end
    EOC["hear_false_sound"] = function(ctx)
    services.messages.add((services.snippets.native_random("schizo_hear_sound") or ''), "warning")
    return true
    end
    EOC["formication"] = function(ctx)
    services.messages.add((services.snippets.native_random("schizo_formication") or ''), "bad")
    H.eoc_add_effect(H.u(ctx), "formication", 2700, "RANDOM", nil, nil)
    return true
    end
    EOC["numbness"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel so numb…")), "mixed")
    H.eoc_add_effect(H.u(ctx), "pkill1_generic", 900, nil, nil, nil)
    return true
    end
    COND["shaking"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["shaking"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin to shake uncontrollably.")), "mixed")
        H.eoc_add_effect(H.u(ctx), "shakes", (function() local a, b = math.floor(120), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return true
    else
        H.run_eoc("intermediate_hallucinations", ctx, nil, nil, nil)
        return false
    end
    end
    COND["creature_hallucinations"] = function(ctx)
        return (((services.random.native_int(0, H.round_half_away(3)) < 3) and (H.mons_nearby(H.u(ctx), {  }, 1000, nil) > 0) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) == true
    end
    EOC["creature_hallucinations"] = function(ctx)
    if (((services.random.native_int(0, H.round_half_away(3)) < 3) and (H.mons_nearby(H.u(ctx), {  }, 1000, nil) > 0) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "") or H.safe_id('monster_group', ""); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), hallucinations = math.floor((1 + services.random.native_int(0, H.round_half_away(4)))), lifespan = { minimum = services.time.duration_from_turns(math.floor(7200)), maximum = services.time.duration_from_turns(math.floor(32400)) } }); 
        end end
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "creature_hallucinations"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_NONE"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    else
        H.run_eoc("creature_hallucinations_fears", ctx, nil, nil, nil)
        return false
    end
    end
    COND["creature_hallucinations_fears"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).avatar == true)) == true
    end
    EOC["creature_hallucinations_fears"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).avatar == true)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_YOUR_FEARS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), hallucinations = math.floor((1 + services.random.native_int(0, H.round_half_away(2)))), max_radius = math.floor(40), lifespan = { minimum = services.time.duration_from_turns(math.floor(3600)), maximum = services.time.duration_from_turns(math.floor(14400)) } }); 
        end end
        return true
    end
    return false
    end
    EOC["visuals"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your vision becomes very distorted…")), "bad")
    H.eoc_add_effect(H.u(ctx), "visuals", (function() local a, b = math.floor(15), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    COND["hallucination_swarm"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 1000, nil) > 1)) == true
    end
    EOC["hallucination_swarm"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 1000, nil) > 1)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "") or H.safe_id('monster_group', ""); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), hallucinations = math.floor(services.random.native_int(50, 100)), max_radius = math.floor(50), lifespan = { minimum = services.time.duration_from_turns(math.floor(7200)), maximum = services.time.duration_from_turns(math.floor(32400)) } }); 
        end end
        return true
    end
    return false
    end
    EOC["isherwood_mission_initialization_eoc"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "mission_return_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if (H.global_var_num("isherwood_family_coming") == 1) then
        H.run_eoc("isherwood_mission_family_included_eoc", ctx, nil, nil, nil)
        H.run_eoc("isherwood_mission_set_teleport_position", ctx, nil, nil, nil)
        H.set_var("global", nil, ctx, "currently_invading_map", 1)
    else
        if (H.global_var_num("isherwood_family_coming") ~= 1) then
            H.eoc_loc_var(H.u(ctx), ctx, "global", "invasion_map", { terrain = "barry_mi-go_scout_tower_1" }, { z = math.floor(0) }, nil, nil, nil, false, true, {  }, {  })
            do local _p = H.get_tripoint_var("global", nil, ctx, "invasion_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            H.run_eoc("isherwood_mission_chris_spawn_eoc", ctx, nil, nil, nil)
            H.run_eoc("isherwood_mission_lisa_spawn_eoc", ctx, nil, nil, nil)
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "mission_return_position"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            H.set_var("global", nil, ctx, "is_isherwood_flee_eoc_activated", 0)
        end
    end
    if (H.global_var_num("isherwood_luke_truck_coming") == 1) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "barry_mi-go_scout_tower_1"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "truck_bomb_spawn" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    return true
    end
    EOC["isherwood_mission_chris_spawn_eoc"] = function(ctx)
    if (H.global_var_num("isherwood_gear_status") == 1) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_chris_swat_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    else
        if (H.global_var_num("isherwood_gear_status") ~= 1) then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_chris_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["isherwood_mission_lisa_spawn_eoc"] = function(ctx)
    if ((H.global_var_num("isherwood_lisa_coming") == 1) and (H.global_var_num("isherwood_gear_status") == 1)) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_lisa_swat_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    else
        if ((H.global_var_num("isherwood_lisa_coming") == 1) and (H.global_var_num("isherwood_gear_status") ~= 1)) then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_lisa_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["isherwood_mission_family_included_eoc"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "invasion_map", { terrain = "barry_mi-go_scout_tower_1" }, { z = math.floor(0) }, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "invasion_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    if (H.global_var_num("isherwood_gear_status") < 1) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_firing_line_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    else
        if (H.global_var_num("isherwood_gear_status") == 1) then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_firing_line_swat_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    if (H.global_var_num("isherwood_wall_status") == 1) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_Isherwood_firing_wall_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    H.run_eoc("isherwood_mission_chris_spawn_eoc", ctx, nil, nil, nil)
    H.run_eoc("isherwood_mission_lisa_spawn_eoc", ctx, nil, nil, nil)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "invasion_map_proper_place", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_dirt_isherwood_player_spawnpoint") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(60) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "invasion_map_proper_place"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    EOC["isherwood_mission_lisa_coming"] = function(ctx)
    H.set_var("global", nil, ctx, "isherwood_lisa_coming", 1)
    return true
    end
    EOC["EOC_BARRY_LEAVE"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "invasion_map", { terrain = "horse_farm_isherwood_13" }, { z = math.floor(0) }, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "invasion_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "horse_farm_isherwood_13"; local _sp = "Isherwood Farm Mutable"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_barry_and_company" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_BARRY_TRAVEL_HOME"] = function(ctx)
    do local _a = H.u(ctx); local _cs = H.creature_snap(_a); if _a and _cs then local _omt = services.overmap.find_target(_cs.position:project_to('omt'), "horse_farm_isherwood_14", { special = H.safe_id('overmap_special', "Isherwood Farm Mutable") }); if _omt then services.npcs.set_goal(_a, _omt) end end end
    return true
    end
    COND["isherwood_mission_barry_return_home"] = function(ctx)
        return (((H.global_var_num("isherwood_barry_rescued") ~= 1) and (H.global_var_num("isherwood_family_coming") ~= 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_barry_following", "")))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_13", math.floor(30)) end)()))) == true
    end
    EOC["isherwood_mission_barry_return_home"] = function(ctx)
    if (((H.global_var_num("isherwood_barry_rescued") ~= 1) and (H.global_var_num("isherwood_family_coming") ~= 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_barry_following", "")))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_13", math.floor(30)) end)()))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Barry raises a hand to signal you to stop.  \"This is it.  Thank you so much.  I can't believe I'm here, alive.  It almost feels like I'm dreaming, like it can't be real.\"  He stares at you, his eyes glistening.  \"Whoever you are, thank you.  I'm going to head the rest of the way now and catch up to my family.  Come by and talk to me later when I've had a moment to rest.\"")))
        H.set_var("actor", H.u(ctx), ctx, "general_knowledge_u_dont_know_about_farm", nil)
        if H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") then
            do for _, _uid in ipairs({ "CHRIS_MISSION", "LISA_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_BARRY_LEAVE" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
        end
        if ((not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1"))) and (not (H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM")))) then
            do local _g = H.safe_id('mission', "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
            do local _mid = "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.finish(H.u(ctx), _m.token); break end end end end
        end
        if H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") then
            do local _mid = "MISSION_ISHERWOOD_CHRIS_1"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.finish(H.u(ctx), _m.token); break end end end end
        end
        if H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM") then
            do local _mid = "MISSION_ISHERWOOD_BARRY_RETURN_TO_FARM"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.finish(H.u(ctx), _m.token); break end end end end
        end
        do for _, _uid in ipairs({ "BARRY_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_BARRY_TRAVEL_HOME" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
        H.set_var("global", nil, ctx, "barry_travelling_home", 1)
        return true
    end
    return false
    end
    EOC["EOC_BARRY_CHECK_IF_HOME_DEACTIVATE"] = function(ctx)
    H.set_var("global", nil, ctx, "barry_travelling_home", 2)
    return true
    end
    COND["EOC_BARRY_CHECK_IF_HOME_TRUE_EFFECT"] = function(ctx)
        return (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_14", math.floor(0)) end)())) == true
    end
    EOC["EOC_BARRY_CHECK_IF_HOME_TRUE_EFFECT"] = function(ctx)
    if (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "horse_farm_isherwood_14", math.floor(0)) end)())) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "barry_return_home_map", { terrain = "horse_farm_isherwood_13" }, { special = H.safe_id('overmap_special', "Isherwood Farm Mutable"), z = math.floor(0) }, { kind = "furniture", id = H.safe_id("furniture", "f_sofa") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "barry_return_home_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        do local _t = math.max(1, math.floor(25)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BARRY_CHECK_IF_HOME_DEACTIVATE"), nil) end end
        H.eoc_spawn_item(H.u(ctx), "NC_Isherwood_Barry_equip", 1, true, true, nil)
        H.eoc_spawn_item(H.u(ctx), "3006", services.random.native_int(8, 16), false, false, nil)
        return true
    end
    return false
    end
    COND["EOC_BARRY_CHECK_IF_HOME"] = function(ctx)
        return ((H.global_var_num("barry_travelling_home") == 1)) == true
    end
    EOC["EOC_BARRY_CHECK_IF_HOME"] = function(ctx)
    if ((H.global_var_num("barry_travelling_home") == 1)) then
        do for _, _uid in ipairs({ "BARRY_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_BARRY_CHECK_IF_HOME_TRUE_EFFECT" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
        return true
    end
    return false
    end
    COND["EOC_ISHERWOODS_TOO_MUCH_DAMAGE_FLEE"] = function(ctx)
        return (((H.char_hp(H.u(ctx), "ALL", false) <= (H.char_hp(H.u(ctx), "bp_null", true) * 0.7)) or (H.creature_effect_intensity(H.u(ctx), "bleed") >= 3))) == true
    end
    EOC["EOC_ISHERWOODS_TOO_MUCH_DAMAGE_FLEE"] = function(ctx)
    if (((H.char_hp(H.u(ctx), "ALL", false) <= (H.char_hp(H.u(ctx), "bp_null", true) * 0.7)) or (H.creature_effect_intensity(H.u(ctx), "bleed") >= 3))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "_teleport_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "isherwood_rescue_remove_npcs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "currently_invading_map", 0)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("isherwood_mission_damage_flee_message"), nil) end end
        return true
    end
    return false
    end
    COND["isherwood_mission_large_damage_retreat"] = function(ctx)
        return ((H.global_var_num("currently_invading_map") == 1)) == true
    end
    EOC["isherwood_mission_large_damage_retreat"] = function(ctx)
    if ((H.global_var_num("currently_invading_map") == 1)) then
        if (H.global_var_num("isherwood_family_coming") == 1) then
            do for _, _uid in ipairs({ "CHRIS_MISSION", "LISA_MISSION", "CARLOS_MISSION", "EDDIE_MISSION", "LUKE_MISSION", "JESSE_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_ISHERWOODS_TOO_MUCH_DAMAGE_FLEE" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
        end
        return true
    end
    return false
    end
    EOC["EOC_ISHERWOODS_PLAYER_LEAVE_FLEE"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "_teleport_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "isherwood_rescue_remove_npcs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    COND["isherwood_mission_player_leaves_map"] = function(ctx)
        return ((H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_barry_following", "")))))) and ((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_2", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_3", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_4", math.floor(2)) end)())))) and (H.global_var_num("currently_invading_map") == 1))) == true
    end
    EOC["isherwood_mission_player_leaves_map"] = function(ctx)
    if ((H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_barry_following", "")))))) and ((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_2", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_3", math.floor(2)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_4", math.floor(2)) end)())))) and (H.global_var_num("currently_invading_map") == 1))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Chris sees you leaving the tower, and gives you a harsh look.  \"Where are you going?  Dammit, we're backing out?  Fine.  I'll make sure everyone knows.\"")))
        do for _, _uid in ipairs({ "CHRIS_MISSION", "LISA_MISSION", "CARLOS_MISSION", "EDDIE_MISSION", "LUKE_MISSION", "JESSE_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_ISHERWOODS_PLAYER_LEAVE_FLEE" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
        H.set_var("global", nil, ctx, "currently_invading_map", 0)
        H.set_var("global", nil, ctx, "is_isherwood_flee_eoc_activated", 0)
        H.eoc_loc_var(H.u(ctx), ctx, "global", "isherwood_mission_success_return_map", { terrain = "horse_farm_isherwood_13" }, { z = math.floor(0) }, { kind = "furniture", id = H.safe_id("furniture", "f_chair") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "isherwood_mission_success_return_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    end
    return false
    end
    EOC["isherwood_mission_set_teleport_position_effect"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "_teleport_pos", nil, nil, nil, nil, nil, false, true, {  }, {  })
    return true
    end
    EOC["isherwood_mission_set_teleport_position"] = function(ctx)
    do for _, _uid in ipairs({ "CHRIS_MISSION", "LISA_MISSION", "CARLOS_MISSION", "EDDIE_MISSION", "LUKE_MISSION", "JESSE_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "isherwood_mission_set_teleport_position_effect" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
    return true
    end
    EOC["EOC_ISHERWOODS_TELEPORT_ALL"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "invasion_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    EOC["isherwood_mission_remove_all_isherwoods"] = function(ctx)
    do for _, _uid in ipairs({ "CHRIS_MISSION", "LISA_MISSION", "CARLOS_MISSION", "EDDIE_MISSION", "LUKE_MISSION", "JESSE_MISSION" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_ISHERWOODS_TELEPORT_ALL" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
    if (H.global_var_num("isherwood_family_coming") == 1) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "isherwood_barry_rescue_field"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "isherwood_rescue_remove_npcs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "barry_mi-go_scout_tower_1"; local _sp = "Barry's Mi-Go Scout Tower"; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "isherwood_rescue_remove_npcs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "currently_invading_map", 0)
    H.set_var("global", nil, ctx, "is_isherwood_flee_eoc_activated", 0)
    return true
    end
    EOC["isherwood_mission_damage_flee_message"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You hear a horn honk, and one of the Isherwoods calling out from their truck.  \"We're swarmed out here!  We're going to have to head back and regroup!\"  The horn bleats again, and there's a sound of an engine revving, followed by the fleshy 'smack' of something large hitting a windshield.")))
    H.eoc_loc_var(H.u(ctx), ctx, "global", "isherwood_mission_success_return_map", { terrain = "horse_farm_isherwood_13" }, { z = math.floor(0) }, { kind = "furniture", id = H.safe_id("furniture", "f_chair") }, { min_radius = math.floor(0), max_radius = math.floor(0), target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "isherwood_mission_success_return_map"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    COND["isherwood_mission_player_leaves_map_setup"] = function(ctx)
        return ((H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("isherwood_family_coming") == 0) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(2)) end)()) and (H.global_var_num("is_isherwood_flee_eoc_activated") == 0))) == true
    end
    EOC["isherwood_mission_player_leaves_map_setup"] = function(ctx)
    if ((H.char_has_mission(H.u(ctx), "MISSION_ISHERWOOD_CHRIS_1") and (H.global_var_num("isherwood_family_coming") == 0) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(2)) end)()) and (H.global_var_num("is_isherwood_flee_eoc_activated") == 0))) then
        H.set_var("global", nil, ctx, "currently_invading_map", 1)
        H.set_var("global", nil, ctx, "is_isherwood_flee_eoc_activated", 1)
        return true
    end
    return false
    end
    COND["EOC_HAVE_U_BEEN_TO_MIGOS"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_portal", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2-1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2-2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_4", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_4", math.floor(3)) end)()))) == true
    end
    EOC["EOC_HAVE_U_BEEN_TO_MIGOS"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_portal", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2-1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_camp2-2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mi-go_scout_tower_4", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_2", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "barry_mi-go_scout_tower_4", math.floor(3)) end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "u_been_to_migos", "yes")
        return true
    end
    return false
    end
    EOC["EOC_GAVE_BEGGAR_CANNIBAL_PROOF"] = function(ctx)
    do local g = H.safe_id("faction", "free_merchants"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "lobby_beggars"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    H.npc_mood_write(H.npc(ctx), "anger", 100, "=")
    H.npc_mood_write(H.npc(ctx), "trust", (-100), "=")
    ccb.presentation.notice(ctx:expand_text(services.translate("They know what you've done.")))
    return true
    end
    EOC["EOC_GAVE_BEGGAR_FOOD"] = function(ctx)
    H.eoc_add_effect(H.npc(ctx), "beggar_has_eaten", 3600, nil, nil, nil)
    H.npc_mood_write(H.u(ctx), "trust", 1, "+=")
    H.npc_mood_write(H.u(ctx), "value", 1, "+=")
    H.npc_mood_write(H.u(ctx), "fear", (-1), "+=")
    H.npc_mood_write(H.u(ctx), "anger", (-1), "+=")
    return true
    end
    EOC["EOC_BEGGAR_TEST_IF_FOOD_CANNIBAL"] = function(ctx)
    H.eoc_run_inv_eocs(H.npc(ctx), ctx, "random", nil, { { _cond_fn = function(ctx) return ((H.char_vitamin(H.npc(ctx), "human_flesh_vitamin") >= 1)) end } }, { "EOC_GAVE_BEGGAR_CANNIBAL_PROOF" }, { "EOC_GAVE_BEGGAR_FOOD" })
    return true
    end
    COND["EOC_EXODII_FM_UPDATES_RECURRANCE"] = function(ctx)
        return (((H.global_var_num("exodii_FM_negotiation_failed") ~= 1) and ((H.global_var_num("FM_exodii_caravan_placed") ~= 1) or (H.global_var_num("FM_exodii_butte_building_placed") ~= 1) or (H.global_var_num("FM_exodii_autodoc_placed") ~= 1)))) == true
    end
    EOC["EOC_EXODII_FM_UPDATES_RECURRANCE"] = function(ctx)
    if (((H.global_var_num("exodii_FM_negotiation_failed") ~= 1) and ((H.global_var_num("FM_exodii_caravan_placed") ~= 1) or (H.global_var_num("FM_exodii_butte_building_placed") ~= 1) or (H.global_var_num("FM_exodii_autodoc_placed") ~= 1)))) then
        H.run_eoc("EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_EXODII", ctx, nil, nil, nil)
        H.run_eoc("EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_FM", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_EXODII"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_EXODII"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(2)) end)()))))) then
        if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60) and (H.global_var_num("FM_exodii_caravan_placed") ~= 1)) then
            H.set_var("global", nil, ctx, "FM_exodii_caravan_placed", 1)
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "exodii_base_x0y3z0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_TENTS" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
        if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 120) and (H.global_var_num("FM_exodii_butte_building_placed") ~= 1)) then
            H.set_var("global", nil, ctx, "FM_exodii_butte_building_placed", 1)
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "exo_base_safehouse_stone_0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_WAREHOUSE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
        return true
    end
    return false
    end
    COND["EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_FM"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_EXODII_FM_UPDATES_RECURRANCE_EVENT_FM"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(2)) end)()))))) then
        if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 360) and (H.global_var_num("FM_exodii_autodoc_placed") ~= 1)) then
            H.set_var("global", nil, ctx, "FM_exodii_autodoc_placed", 1)
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_17"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_AUTODOC" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
        return true
    end
    return false
    end
    EOC["EOC_EXODII_FM_UPDATES"] = function(ctx)
    H.run_eoc("EOC_EXODII_FM_UPDATE_BUILD_BASE_AT_EXODII", ctx, nil, nil, nil)
    H.run_eoc("EOC_EXODII_FM_UPDATE_PLACE_AUTODOC", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_EXODII_FM_UPDATE_BUILD_BASE_AT_EXODII"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_EXODII_FM_UPDATE_BUILD_BASE_AT_EXODII"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y3z0", math.floor(2)) end)()))))) then
        H.set_var("global", nil, ctx, "FM_exodii_caravan_placed", 1)
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "exodii_base_x0y3z0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_TENTS" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        if (H.global_var_num("exodii_FM_butte_building") == 1) then
            H.set_var("global", nil, ctx, "FM_exodii_butte_building_placed", 1)
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "exo_base_safehouse_stone_0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_WAREHOUSE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
        return true
    else
        do local _t = math.max(1, math.floor(43200)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_FM_UPDATE_BUILD_BASE_AT_EXODII"), nil) end end
        return false
    end
    end
    COND["EOC_EXODII_FM_UPDATE_PLACE_AUTODOC"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_EXODII_FM_UPDATE_PLACE_AUTODOC"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_17", math.floor(2)) end)()))))) then
        if (H.global_var_num("exodii_FM_autodoc") == 1) then
            H.set_var("global", nil, ctx, "FM_exodii_autodoc_placed", 1)
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_17"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EXODII_FM_UPDATE_PLACE_AUTODOC" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
        return true
    else
        do local _t = math.max(1, math.floor(43200)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_EXODII_FM_UPDATE_PLACE_AUTODOC"), nil) end end
        return false
    end
    end
    COND["EOC_ROBOFAC_PAT_CHATTING_ON_RADIO"] = function(ctx)
        return (((not ((H.global_var_num("robofac_pat_is_dead") == 1))) and (services.gameplay.environment.dimension() == "default"))) == true
    end
    EOC["EOC_ROBOFAC_PAT_CHATTING_ON_RADIO"] = function(ctx)
    if (((not ((H.global_var_num("robofac_pat_is_dead") == 1))) and (services.gameplay.environment.dimension() == "default"))) then
        H.set_var("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", "yes")
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT") end
        H.set_var("actor", H.u(ctx), ctx, "robofac_pat_chatting_on_radio", nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You chirp Pat's frequency twice, but nobody responds.")), "neutral")
        return false
    end
    end
    COND["EOC_ROBOFAC_CHOP_SHOP_REPORTED_YOU_TO_HUB"] = function(ctx)
        return ((not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1)))) == true
    end
    EOC["EOC_ROBOFAC_CHOP_SHOP_REPORTED_YOU_TO_HUB"] = function(ctx)
    if ((not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1)))) then
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        H.run_eoc("EOC_ROBOFAC_LOCK_INTERCOM", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_ROBOFAC_LOCK_INTERCOM"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_entrance"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_intercom" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "hub01_intercom_locked", 1)
    return true
    end
end
