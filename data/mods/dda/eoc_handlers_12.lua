local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_FACTION_SUCCESSION_COOLDOWN_GAMEBEGIN_CHECK"] = function(ctx)
    H.run_eoc("EOC_FACTION_SUCCESSION_COOLDOWN", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_FACTION_SUCCESSION_COOLDOWN"] = function(ctx)
    H.set_var("global", nil, ctx, "time_between_succession", 259200)
    return true
    end
    COND["EOC_FACTION_SUCCESSION_IMMEDIATE"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).avatar == true) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_time_of_last_succession") and 1 or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_time_of_last_succession"), 1) < H.global_var_num("time_between_succession")) and (H.char_hp(H.u(ctx), "torso", false) ~= 0) and (H.char_hp(H.u(ctx), "head", false) ~= 0))) == true
    end
    EOC["EOC_FACTION_SUCCESSION_IMMEDIATE"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).avatar == true) and H.truthy((H.var_exists("actor", H.u(ctx), ctx, "timer_time_of_last_succession") and 1 or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_time_of_last_succession"), 1) < H.global_var_num("time_between_succession")) and (H.char_hp(H.u(ctx), "torso", false) ~= 0) and (H.char_hp(H.u(ctx), "head", false) ~= 0))) then
        do local _mid = "MISSION_CAMP_LEADERSHIP_CHANGE"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        services.messages.add(ctx:expand_text(services.translate("You've been badly wounded.  It might be better to rest for a while and let someone else scavenge.  (Changing characters is now available at any camp board.)")), "mixed")
        H.set_var("actor", H.u(ctx), ctx, "timer_time_of_last_succession", (H.var_num(H.u(ctx), "timer_time_of_last_succession")) - (H.global_var_num("time_between_succession")))
        return true
    end
    return false
    end
    EOC["EOC_BEM_ANCHOR_SELLER_GONE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_ancilla_bar_remove_BEM_anchor_seller" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_BEM_BEM_CHATTING_VETERANS_DRUNK_TP"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "subway_floor", nil, nil, nil, nil, { dz = math.floor(-1) }, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "subway_floor"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["EOC_BEM_BEM_CHATTING_VETERANS_DRUNK_MESSAGE"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<ANCILLA_BAR_HANGOVER>")))
    return true
    end
    EOC["EOC_BEM_HUMAN_SAMPLE_BUY"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_subline_a1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "EOC_BEM_HUMAN_SAMPLE_BUY_MAP" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_ROBOFAC_CHOP_SHOP_HATES_YOU"] = function(ctx)
    do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
    return true
    end
    COND["EOC_ROBOFAC_CHOP_SHOP_SCIENTIST_1_REPORTED_YOU_TO_HUB"] = function(ctx)
        return (((not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1))) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_kill_orders") == 1))))) == true
    end
    EOC["EOC_ROBOFAC_CHOP_SHOP_SCIENTIST_1_REPORTED_YOU_TO_HUB"] = function(ctx)
    if (((not ((H.global_var_num("robofac_chop_shop_scientist_1_is_dead") == 1))) and (not ((H.global_var_num("robofac_chop_shop_scientist_1_kill_orders") == 1))))) then
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        H.run_eoc("EOC_ROBOFAC_LOCK_INTERCOM", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE"] = function(ctx)
        return (((H.global_var_num("ancilla_autodoc_placed") == 1) and (H.global_var_num("robofac_exodii_cbm_knowledge") <= 99))) == true
    end
    EOC["EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE"] = function(ctx)
    if (((H.global_var_num("ancilla_autodoc_placed") == 1) and (H.global_var_num("robofac_exodii_cbm_knowledge") <= 99))) then
        if (H.global_var_num("robofac_chop_shop_scientist_1_is_dead") ~= 1) then
            H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
        end
        if (H.global_var_num("ancilla_bionic_garage_placed") == 1) then
            H.set_var("global", nil, ctx, "robofac_exodii_cbm_knowledge", (H.global_var_num("robofac_exodii_cbm_knowledge")) + (1))
        end
        return true
    end
    return false
    end
    COND["EOC_INTERCOM_SPAWN_ARMOR_SET"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "armor_type"))) == true
    end
    EOC["EOC_INTERCOM_SPAWN_ARMOR_SET"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "armor_type"))) then
        if ((("robofac_armor_pieces_rig") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_armor_rig", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_head_rig", 1, false, false, nil)
        end
        if ((("robofac_armor_pieces_basic") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_basic_mantle", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_basic_skirt", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_basic_vambraces", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_basic_greaves", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_basic_helmet", 1, false, false, nil)
        end
        if ((("robofac_armor_pieces_nomex") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_nomex_mantle", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_nomex_skirt", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_nomex_vambraces", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_nomex_greaves", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_nomex_helmet", 1, false, false, nil)
        end
        if ((("robofac_armor_pieces_kevlar") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_kevlar_mantle", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_kevlar_skirt", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_kevlar_vambraces", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_kevlar_greaves", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_kevlar_helmet", 1, false, false, nil)
        end
        if ((("robofac_armor_pieces_rubber") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_rubber_skirt", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_rubber_vambraces", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_rubber_greaves", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_rubber_mantle", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_rubber_helmet", 1, false, false, nil)
        end
        if ((("robofac_armor_pieces_military") == (H.var_str("context", nil, ctx, "armor_type", "")))) then
            H.eoc_spawn_item(H.u(ctx), "robofac_military_skirt", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_military_vambraces", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_military_greaves", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_military_mantle", 1, false, false, nil)
            H.eoc_spawn_item(H.u(ctx), "robofac_military_helmet", 1, false, false, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_Nunez_Travel_To_Tacoma"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "counter_refugee_center_refugee_happiness", (H.var_num(H.u(ctx), "counter_refugee_center_refugee_happiness")) + (1))
    do local _p = H.get_tripoint_var("context", nil, ctx, "tacoma_nunez_trailer_arrive"); if _p then local _omt = _p:project_to('omt'); local _om = "ranch_camp_55"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "tacoma_nunez_trailer_arrive" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = H.get_tripoint_var("context", nil, ctx, "refcenter_nunez_departure"); if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_7"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "refcenter_nunez_departure" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_PRE_CONJUNCTIVITIS_VIRAL"] = function(ctx)
    return true
    end
    EOC["EOC_PRE_CONJUNCTIVITIS_BACTERIAL"] = function(ctx)
    return true
    end
    EOC["EOC_CONJUNCTIVITIS"] = function(ctx)
    return true
    end
    EOC["EOC_crazy_cataclysm_benadryl"] = function(ctx)
    return true
    end
    EOC["bile_in_eyes"] = function(ctx)
    return true
    end
    EOC["bile_stink"] = function(ctx)
    return true
    end
    EOC["bile_unstink"] = function(ctx)
    return true
    end
    EOC["eoc_conjunctivitis_itch"] = function(ctx)
    return true
    end
    EOC["EOC_Nunez_Travel"] = function(ctx)
    return true
    end
    EOC["EOC_vitrified_farm_entry"] = function(ctx)
    return true
    end
    EOC["scenario_assassin_convict"] = function(ctx)
    return true
    end
    EOC["EOC_insect_wings_shutoff"] = function(ctx)
    return true
    end
    COND["EOC_PORTAL_STORM_DUNGEON_EXIT"] = function(ctx)
        return ((H.global_var_num("portal_dungeon_level") ~= 0)) == true
    end
    EOC["EOC_PORTAL_STORM_DUNGEON_EXIT"] = function(ctx)
    if ((H.global_var_num("portal_dungeon_level") ~= 0)) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "dungeon_loc"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "portal_dungeon_cleanup" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "original_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        H.run_eoc("EOC_PORTAL_DUNGEON_REWARD", ctx, nil, nil, nil)
        H.set_var("global", nil, ctx, "portal_dungeon_level", 0)
        services.time.reschedule("portal_dungeon", services.time.duration_from_turns(0))
        return true
    end
    return false
    end
    COND["EOC_PORTAL_STORM_DUNGEON_REFLECTION_SPAWN"] = function(ctx)
        return (true) == true
    end
    EOC["EOC_PORTAL_STORM_DUNGEON_REFLECTION_SPAWN"] = function(ctx)
    if (true) then
        do
            local _sw37 = H.global_var_num("portal_dungeon_reflect_strength")
            if _sw37 == 0 then
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_pale_reflection") or H.safe_id('monster_group', "mon_pale_reflection"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(8), max_radius = math.floor(12) }); 
                    if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something your mind can't fully parse appears, despite the distance and obstacles you know where it is.  You can feel its presence as if it was a part of you.")), 'warning') end
                end end
            elseif _sw37 == 5 then
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_twisted_reflection") or H.safe_id('monster_group', "mon_twisted_reflection"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(8), max_radius = math.floor(12) }); 
                    if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something your mind can't fully parse appears, despite the distance and obstacles you know where it is.  You can feel its presence as if it was a part of you.")), 'warning') end
                end end
            elseif _sw37 == 10 then
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_dark_reflection") or H.safe_id('monster_group', "mon_dark_reflection"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(8), max_radius = math.floor(12) }); 
                    if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something your mind can't fully parse appears, despite the distance and obstacles you know where it is.  You can feel its presence as if it was a part of you.")), 'warning') end
                end end
            elseif _sw37 == 15 then
                do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_better_half") or H.safe_id('monster_group', "mon_better_half"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(8), max_radius = math.floor(12) }); 
                    if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Something your mind can't fully parse appears, despite the distance and obstacles you know where it is.  You can feel its presence as if it was a part of you.")), 'warning') end
                end end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_STORM_DUNGEON_REFLECTION_RESPAWN"] = function(ctx)
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(30), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_STORM_DUNGEON_REFLECTION_SPAWN"), nil) end end
    return true
    end
end
