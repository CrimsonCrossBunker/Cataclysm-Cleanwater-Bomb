local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_AFS_FIND_PORT_AUGUSTMOON"] = function(ctx)
        return ((H.global_var_num("searched_port_augustmoon") ~= 1)) == true
    end
    EOC["EOC_AFS_FIND_PORT_AUGUSTMOON"] = function(ctx)
    if ((H.global_var_num("searched_port_augustmoon") ~= 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Port_augustmoon", { terrain = "augustmoon_docking_arm" }, { z = math.floor(-9) }, { kind = "zone", id = H.safe_id("zone", "ZONE_START_POINT") }, { target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Port_augustmoon_cargo", { terrain = "augustmoon_docking_arm" }, { z = math.floor(-9) }, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_destination") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "augustmoon_main_concourse1", { terrain = "augustmoon_main_concourse1" }, { z = math.floor(-9) }, nil, nil, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "augustmoon_main_concourse2", { terrain = "augustmoon_main_concourse2" }, { z = math.floor(-9) }, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "searched_port_augustmoon", 1)
        return true
    end
    return false
    end
    COND["EOC_AFS_FIND_LANDING_PAD"] = function(ctx)
        return ((H.global_var_num("searched_landing_pad") ~= 1)) == true
    end
    EOC["EOC_AFS_FIND_LANDING_PAD"] = function(ctx)
    if ((H.global_var_num("searched_landing_pad") ~= 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "landing_pad", { terrain = "land_pad_outpost_a1" }, { z = math.floor(0), search_range = math.floor(380), random = true }, { kind = "zone", id = H.safe_id("zone", "ZONE_START_POINT") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "landing_pad_cargo", { terrain = "land_pad_outpost_a1" }, { z = math.floor(0), search_range = math.floor(380), random = true }, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_destination") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "searched_landing_pad", 1)
        return true
    end
    return false
    end
    COND["EOC_AFS_CALL_AUGUSTMOON_SHUTTLE"] = function(ctx)
        return ((H.global_var_num("augustmoon_shuttle_inprogress") ~= 1)) == true
    end
    EOC["EOC_AFS_CALL_AUGUSTMOON_SHUTTLE"] = function(ctx)
    if ((H.global_var_num("augustmoon_shuttle_inprogress") ~= 1)) then
        H.consume_item(H.u(ctx), "afs_shuttle_radiobeacon", 1, 0)
        ccb.presentation.notice(ctx:expand_text(services.translate("Order Received: Shuttle inbound to your location.")))
        do local _t = math.max(1, math.floor(1800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_LAND_AUGUSTMOON_SHUTTLE"), nil) end end
        H.set_var("global", nil, ctx, "augustmoon_shuttle_inprogress", 1)
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("WARNING: Cannot schedule landing, shuttle already inbound.")))
        return false
    end
    end
    COND["EOC_AFS_LAND_AUGUSTMOON_SHUTTLE"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_AFS_LAND_AUGUSTMOON_SHUTTLE"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "landing_site", { terrain = "afs_landed_shuttle" }, { z = math.floor(0), search_range = math.floor(10), min_distance = math.floor(4), random = true }, nil, nil, nil, false, true, {  }, {  })
        ccb.presentation.notice(ctx:expand_text(services.translate("You see the engine plume of your landing drone shuttle in the distance.  You'll have about four hours to reach it before it leaves.")))
        do local _g = H.safe_id('mission', "MISSION_REACH_AUGUSTMOON_SHUTTLE"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "landing_site"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "augustmoon_shuttle_ground" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor(14400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_AUGUSTMOON_SHUTTLE_RECALL"), nil) end end
        return true
    else
        do local _t = math.max(1, math.floor(10)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_LAND_AUGUSTMOON_SHUTTLE"), nil) end end
        return false
    end
    end
    COND["EOC_AFS_AUGUSTMOON_SHUTTLE_RECALL"] = function(ctx)
        return ((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "afs_landed_shuttle", math.floor(4)) end)())))) == true
    end
    EOC["EOC_AFS_AUGUSTMOON_SHUTTLE_RECALL"] = function(ctx)
    if ((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "afs_landed_shuttle", math.floor(4)) end)())))) then
        H.set_var("global", nil, ctx, "augustmoon_shuttle_inprogress", 0)
        do local _mid = "MISSION_REACH_AUGUSTMOON_SHUTTLE"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "landing_site"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "augustmoon_shuttle_ground_left" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    else
        do local _t = math.max(1, math.floor(10)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_AUGUSTMOON_SHUTTLE_RECALL"), nil) end end
        return false
    end
    end
    EOC["_EOC_AFS_AUGUSTMOON_CARGO_TP"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("global", nil, ctx, "Port_augustmoon_cargo"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    return true
    end
    EOC["EOC_AFS_AUGUSTMOON_SPACEPORT_TP"] = function(ctx)
    H.set_var("global", nil, ctx, "augustmoon_shuttle_inprogress", 0)
    H.run_eoc("EOC_VALIDATE_PORT_AUGUSTMOON", ctx, nil, nil, nil)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_augustmoon_reroll_vending_machine"), nil) end end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "crate_loc", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_source") }, { target_max_radius = math.floor(24) }, nil, false, true, {  }, {  })
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", H.get_tripoint_var("context", nil, ctx, "crate_loc"), 0, 0, nil, nil, { "_EOC_AFS_AUGUSTMOON_CARGO_TP" })
    do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_AFS_TEST_AUGUSTMOON_TP" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    ccb.presentation.notice(ctx:expand_text(services.translate("The shuttle's ascent is a little rough, but you're soon on your way to Port Augustmoon.")))
    do local _p = H.get_tripoint_var("global", nil, ctx, "Port_augustmoon"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["EOC_AFS_AUGUSTMOON_TO_LANDING_PAD_CARGO_TP"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("global", nil, ctx, "landing_pad_cargo"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    return true
    end
    EOC["EOC_PORT_TO_LANDING_PAD_TP"] = function(ctx)
    H.run_eoc("EOC_VALIDATE_LANDING_PAD", ctx, nil, nil, nil)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "crate_loc", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_source") }, { target_max_radius = math.floor(24) }, nil, false, true, {  }, {  })
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", H.get_tripoint_var("context", nil, ctx, "crate_loc"), 0, 0, nil, nil, { "EOC_AFS_AUGUSTMOON_TO_LANDING_PAD_CARGO_TP" })
    do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_AFS_LANDING_PAD_TP" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "landing_pad"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    ccb.presentation.notice(ctx:expand_text(services.translate("An orbital drop in a rackety cargo shuttle preceded by an almost interminable wait within Port Augustmoon customs level leads you to the planetary wastes below.\n\n What passes by the spaceport is nothing but a small radio outpost surrounded by chainlink fencing.  Beyond it, any guarantees of civilization are left behind.")))
    return true
    end
    COND["EOC_VALIDATE_PORT_AUGUSTMOON"] = function(ctx)
        return ((H.truthy((H.var_exists("global", nil, ctx, "Port_augustmoon") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "Port_augustmoon_cargo") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "augustmoon_main_concourse1") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "augustmoon_main_concourse2") and 1 or 0)))) == true
    end
    EOC["EOC_VALIDATE_PORT_AUGUSTMOON"] = function(ctx)
    if ((H.truthy((H.var_exists("global", nil, ctx, "Port_augustmoon") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "Port_augustmoon_cargo") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "augustmoon_main_concourse1") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "augustmoon_main_concourse2") and 1 or 0)))) then
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("MANUALLY FINDING PORT AUGUSTMOON AS A FALLBACK.  (PRESS SPACE).")))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Port_augustmoon", { terrain = "augustmoon_docking_arm" }, { z = math.floor(-9) }, { kind = "zone", id = H.safe_id("zone", "ZONE_START_POINT") }, { target_max_radius = math.floor(30) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "Port_augustmoon_cargo", { terrain = "augustmoon_docking_arm" }, { z = math.floor(-9) }, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_destination") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "augustmoon_main_concourse1", { terrain = "augustmoon_main_concourse1" }, { z = math.floor(-9) }, nil, nil, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "augustmoon_main_concourse2", { terrain = "augustmoon_main_concourse2" }, { z = math.floor(-9) }, nil, nil, nil, false, true, {  }, {  })
        return false
    end
    end
    COND["EOC_VALIDATE_LANDING_PAD"] = function(ctx)
        return ((H.truthy((H.var_exists("global", nil, ctx, "landing_pad") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "landing_pad_cargo") and 1 or 0)))) == true
    end
    EOC["EOC_VALIDATE_LANDING_PAD"] = function(ctx)
    if ((H.truthy((H.var_exists("global", nil, ctx, "landing_pad") and 1 or 0)) and H.truthy((H.var_exists("global", nil, ctx, "landing_pad_cargo") and 1 or 0)))) then
        return true
    else
        ccb.presentation.notice(ctx:expand_text(services.translate("MANUALLY FINDING THE LANDING PAD AS A FALLBACK.  (PRESS SPACE).")))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "landing_pad", { terrain = "land_pad_outpost_a1" }, { z = math.floor(0), search_range = math.floor(1380), random = true }, { kind = "zone", id = H.safe_id("zone", "ZONE_START_POINT") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "landing_pad_cargo", { terrain = "land_pad_outpost_a1" }, { z = math.floor(0), search_range = math.floor(1380), random = true }, { kind = "terrain", id = H.safe_id("terrain", "t_intermodal_crate_scripted_destination") }, { target_max_radius = math.floor(26) }, nil, false, true, {  }, {  })
        return false
    end
    end
    COND["EOC_AFS_TEST_AUGUSTMOON_TP"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).npc_state or {}).following == true)) == true
    end
    EOC["EOC_AFS_TEST_AUGUSTMOON_TP"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).npc_state or {}).following == true)) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "Port_augustmoon"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    end
    return false
    end
    COND["EOC_AFS_LANDING_PAD_TP"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).npc_state or {}).following == true)) == true
    end
    EOC["EOC_AFS_LANDING_PAD_TP"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).npc_state or {}).following == true)) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "landing_pad"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    end
    return false
    end
    EOC["EOC_augustmoon_reroll_vending_machine"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "augustmoon_main_concourse1"); if _p then local _omt = _p:project_to('omt'); local _om = "augustmoon_main_concourse1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "augustmoon_concourse_vending1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "augustmoon_main_concourse2"); if _p then local _omt = _p:project_to('omt'); local _om = "augustmoon_main_concourse2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "augustmoon_concourse_vending2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["_update_ui"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "cryosuit_power", H.char_bionic_power(H.npc(ctx), "power_percentage"))
    if ((H.var_num(H.u(ctx), "cryosuit_power") < 5) and (H.var_num(H.u(ctx), "cryosuit_power") > 0) and (not (((function() local eg = H.safe_id('effect', "afs_cryosuit_warning"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        if ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _eg = H.safe_id('effect', "sleep"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        ccb.presentation.notice(ctx:expand_text(services.translate("Your cryosuit sounds a critical power warning!")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Your cryosuit sounds a critical power warning!")))
        H.eoc_add_effect(H.u(ctx), "afs_cryosuit_warning", 900, nil, nil, nil)
    else
        if ((H.var_num(H.u(ctx), "cryosuit_power") < 15) and (not (((function() local eg = H.safe_id('effect', "afs_cryosuit_warning"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
            if ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
                do local _eg = H.safe_id('effect', "sleep"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            end
            ccb.presentation.notice(ctx:expand_text(services.translate("Your cryosuit sounds a low power warning!")))
            services.activities.offer_interruption(ctx:expand_text(services.translate("Your cryosuit sounds a low power warning!")))
            H.eoc_add_effect(H.u(ctx), "afs_cryosuit_warning", 2700, nil, nil, nil)
        end
    end
    return true
    end
    EOC["afs_cryosuit_ui_eoc"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "_update_ui" }, {  })
    return true
    end
    COND["EOC_CONDITION_CAN_DATA_SALVAGE"] = function(ctx)
        return ((((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_wrist_computer" ~= nil) and H.safe_id('item', "afs_wrist_computer") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()) or ((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_bio_deck_jack" ~= nil) and H.safe_id('item', "afs_bio_deck_jack") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()) or ((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_wrist_computer" ~= nil) and H.safe_id('item', "afs_wrist_computer") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()))) == true
    end
    EOC["EOC_CONDITION_CAN_DATA_SALVAGE"] = function(ctx)
    if ((((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_wrist_computer" ~= nil) and H.safe_id('item', "afs_wrist_computer") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()) or ((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_bio_deck_jack" ~= nil) and H.safe_id('item', "afs_bio_deck_jack") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()) or ((function() local ig = H.safe_id('item', "software_archiving"); if not ig or not H.u(ctx) then return false end; local dg = ("afs_wrist_computer" ~= nil) and H.safe_id('item', "afs_wrist_computer") or nil; local r = services.inventory.has_software(H.u(ctx), ig, math.floor(5), dg); return r.ok and r.value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_DATA_SALVAGE"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "data_type"))) == true
    end
    EOC["EOC_DATA_SALVAGE"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "data_type"))) then
        H.set_var("global", nil, ctx, "computer_salvageable", (H.global_var_num("computer_salvageable")) - (1))
        services.messages.add(ctx:expand_text(services.translate("Data salvaged from the drive has been copied to your inventory.")), "neutral")
        if (((H.var_str("context", nil, ctx, "data_type", "")) == ("generic_ruin"))) then
            H.eoc_spawn_item(H.u(ctx), "generated_ruin_data", 1, true, true, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_AFS_MEDIGEL_REMOVE"] = function(ctx)
        return ((((("disinfected") == (H.var_str("context", nil, ctx, "effect", "")))) and ((function() local eg = H.safe_id('effect', "afs_medigel_eff"); local bpg = (H.var_str("context", nil, ctx, "bodypart", "") ~= nil) and H.safe_id('body_part', H.var_str("context", nil, ctx, "bodypart", "")) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_AFS_MEDIGEL_REMOVE"] = function(ctx)
    if ((((("disinfected") == (H.var_str("context", nil, ctx, "effect", "")))) and ((function() local eg = H.safe_id('effect', "afs_medigel_eff"); local bpg = (H.var_str("context", nil, ctx, "bodypart", "") ~= nil) and H.safe_id('body_part', H.var_str("context", nil, ctx, "bodypart", "")) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "afs_medigel_eff"); local _bp = (H.var_str("context", nil, ctx, "bodypart", "") ~= nil) and H.safe_id('body_part', H.var_str("context", nil, ctx, "bodypart", "")) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_MEDIGEL_ADD"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "afs_medigel_eff_trigger"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("disinfected") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_AFS_MEDIGEL_ADD"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "afs_medigel_eff_trigger"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("disinfected") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.set_var("actor", H.u(ctx), ctx, "heal_part", H.var_str("context", nil, ctx, "bodypart", ""))
        H.eoc_add_effect(H.u(ctx), "afs_medigel_eff", 259200, H.var_str("actor", H.u(ctx), ctx, "heal_part", ""), nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_STIMPACK"] = function(ctx)
        return (((("afs_stimpack") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_AFS_STIMPACK"] = function(ctx)
    if (((("afs_stimpack") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor(-(80)) }) end
        H.set_char_val_extra(H.u(ctx), "stamina", 2500, "+=")
        return true
    end
    return false
    end
    COND["EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (((("AFS_ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_PRECOG") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_TELEPATH") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (((("AFS_ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_PRECOG") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("AFS_TELEPATH") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_premonition"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    COND["EOC_AFS_PSI_PRACTICE_FOCUS_MOD"] = function(ctx)
        return ((H.char_val_extra(H.u(ctx), "focus") >= 75)) == true
    end
    EOC["EOC_AFS_PSI_PRACTICE_FOCUS_MOD"] = function(ctx)
    if ((H.char_val_extra(H.u(ctx), "focus") >= 75)) then
        H.set_char_val_extra(H.u(ctx), "focus", 50, "-=")
        return true
    else
        H.run_eoc("EOC_AFS_PSI_PRACTICE_FOCUS_MOD_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_2"] = function(ctx)
        return ((H.char_val_extra(H.u(ctx), "focus") >= 50)) == true
    end
    EOC["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_2"] = function(ctx)
    if ((H.char_val_extra(H.u(ctx), "focus") >= 50)) then
        H.set_char_val_extra(H.u(ctx), "focus", 25, "-=")
        return true
    else
        H.run_eoc("EOC_AFS_PSI_PRACTICE_FOCUS_MOD_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_3"] = function(ctx)
        return ((H.char_val_extra(H.u(ctx), "focus") >= 34)) == true
    end
    EOC["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_3"] = function(ctx)
    if ((H.char_val_extra(H.u(ctx), "focus") >= 34)) then
        H.set_char_val_extra(H.u(ctx), "focus", 10, "-=")
        return true
    else
        H.run_eoc("EOC_AFS_PSI_PRACTICE_FOCUS_MOD_4", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_4"] = function(ctx)
        return ((H.char_val_extra(H.u(ctx), "focus") >= 30)) == true
    end
    EOC["EOC_AFS_PSI_PRACTICE_FOCUS_MOD_4"] = function(ctx)
    if ((H.char_val_extra(H.u(ctx), "focus") >= 30)) then
        H.set_char_val_extra(H.u(ctx), "focus", 5, "-=")
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_CHANNEL_COSTS_FOCUS"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) == true
    end
    EOC["EOC_AFS_ESPER_CHANNEL_COSTS_FOCUS"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) then
        H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        return true
    end
    return false
    end
    COND["EOC_AFS_CONCENTRATION_COSTS_FOCUS"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) == true
    end
    EOC["EOC_AFS_CONCENTRATION_COSTS_FOCUS"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0) and (H.char_val_extra(H.u(ctx), "focus") >= 15))) then
        H.set_char_val_extra(H.u(ctx), "focus", 1, "-=")
        return true
    end
    return false
    end
    COND["EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER_2"] = function(ctx)
        return ((H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value") < 25)) == true
    end
    EOC["EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER_2"] = function(ctx)
    if ((H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value") < 25)) then
        H.set_var("actor", H.u(ctx), ctx, "afs_psi_repeated_channeling_value", (H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value")) + (services.random.native_float(1, 2.4)))
        return true
    end
    return false
    end
    COND["EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.run_eoc("EOC_AFS_REPEATED_CHANNELING_VALUE_INCREASER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER"] = function(ctx)
        return ((H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value") > 0)) == true
    end
    EOC["EOC_AFS_REPEATED_CHANNELING_VALUE_DECREASER"] = function(ctx)
    if ((H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value") > 0)) then
        H.set_var("actor", H.u(ctx), ctx, "afs_psi_repeated_channeling_value", (H.var_num(H.u(ctx), "afs_psi_repeated_channeling_value")) - (1))
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "afs_psi_repeated_channeling_value", 0)
        return false
    end
    end
    COND["EOC_AFS_PSI_MAKES_YOU_WEARY"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_AFS_PSI_MAKES_YOU_WEARY"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.set_var("context", nil, ctx, "channeling_weariness", H._jm_psionics_weariness_calculations(ctx, (ctx:get_number("difficulty") or 0)))
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("channeling_weariness") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("channeling_weariness") or 0); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("channeling_weariness") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("channeling_weariness") or 0); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    end
    return false
    end
    EOC["EOC_AFS_PSI_MAINTENANCE_MAKES_YOU_WEARY"] = function(ctx)
    H.set_var("context", nil, ctx, "channeling_weariness", H._jm_psionics_weariness_calculations(ctx, (ctx:get_number("difficulty") or 0)))
    do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("channeling_weariness") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("channeling_weariness") or 0); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor((ctx:get_number("channeling_weariness") or 0) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (ctx:get_number("channeling_weariness") or 0); local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
    return true
    end
    COND["EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER_2"] = function(ctx)
        return ((H.var_num(H.u(ctx), "esper_repeated_channeling_value") < 20)) == true
    end
    EOC["EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER_2"] = function(ctx)
    if ((H.var_num(H.u(ctx), "esper_repeated_channeling_value") < 20)) then
        H.set_var("actor", H.u(ctx), ctx, "esper_repeated_channeling_value", (H.var_num(H.u(ctx), "esper_repeated_channeling_value")) + (services.random.native_float(1, 5)))
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.run_eoc("EOC_AFS_ESPER_CONSEQUENCES_VALUE_INCREASER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER"] = function(ctx)
        return ((H.var_num(H.u(ctx), "esper_repeated_channeling_value") > 0)) == true
    end
    EOC["EOC_AFS_ESPER_CONSEQUENCES_VALUE_DECREASER"] = function(ctx)
    if ((H.var_num(H.u(ctx), "esper_repeated_channeling_value") > 0)) then
        H.set_var("actor", H.u(ctx), ctx, "esper_repeated_channeling_value", (H.var_num(H.u(ctx), "esper_repeated_channeling_value")) - (1))
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "esper_repeated_channeling_value", 0)
        return false
    end
    end
    EOC["EOC_AFS_POWER_MAINTENANCE_PLUS_ONE"] = function(ctx)
    do local _a, _v = H.u(ctx), "vitamin_afs_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    H.run_eoc("EOC_AFS_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_AFS_POWER_MAINTENANCE_MINUS_ONE"] = function(ctx)
    do local _a, _v = H.u(ctx), "vitamin_afs_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    H.run_eoc("EOC_AFS_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_AFS_END_PSI_POWERS_MAINTAINED"] = function(ctx)
    H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_SEE_ELECTRICITY", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_HACKING_INTERFACE", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_PERSONAL_BATTERY", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_PRECOG_REMOVE_DANGER_SENSE", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_PRECOG_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_TELEKIN_REMOVE_MOMENTUM", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_TELEPATH_REMOVE_SENSE_MINDS", ctx, nil, nil, nil)
    H.run_eoc("EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SUGGESTION", ctx, nil, nil, nil)
    do local _a, _v = H.u(ctx), "vitamin_afs_maintained_powers"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    COND["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) == true
    end
    EOC["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_master", ((services.random.native_int(0, H.round_half_away(4)) / 96) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    end
    return false
    end
    COND["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_INT"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) == true
    end
    EOC["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_INT"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_intermediate", ((services.random.native_int(0, H.round_half_away(4)) / 48) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    else
        H.run_eoc("EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_MASTER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY"] = function(ctx)
        return (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) == true
    end
    EOC["EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY"] = function(ctx)
    if (((not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value == true))) and (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > 0))) then
        H.add_proficiency_progress(H.u(ctx), "prof_concentration_basic", ((services.random.native_int(0, H.round_half_away(4)) / 24) * (services.gameplay.options.get_number("PROFICIENCY_TRAINING_SPEED") or 0)), "percent", false, "+=")
        return true
    else
        H.run_eoc("EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY_INT", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") >= H._jm_concentration_calculations(ctx)) and services.random.native_probability(((((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") / math.max(H._jm_concentration_calculations(ctx), 1)) * 5) + (H.clamp_num(H._jm_concentration_calculations(ctx), (-20), 0) * (-10)))), (100)))) == true
    end
    EOC["EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") >= H._jm_concentration_calculations(ctx)) and services.random.native_probability(((((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") / math.max(H._jm_concentration_calculations(ctx), 1)) * 5) + (H.clamp_num(H._jm_concentration_calculations(ctx), (-20), 0) * (-10)))), (100)))) then
        services.messages.add(ctx:expand_text(services.translate("Your concentration breaks!")), "bad")
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        local _a2 = H.u(ctx)
        local _sg3 = H.safe_id("skill", "metaphysics")
        if _a2 and _sg3 then services.skills.set(_a2, _sg3, { exercise_raw = math.floor((H.char_skill_exp(_a2, "metaphysics", true)) + (((35 * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return true
    else
        H.run_eoc("EOC_AFS_CONCENTRATION_SUCCESS_PROFICIENCY", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PSI_SKILL_INCREASE_ON_USE_FINALIZE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_CONCENTRATION_COSTS_FOCUS", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PSI_MAINTENANCE_MAKES_YOU_WEARY", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_CONCENTRATION_VS_LIMIT_CALCULATIONS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_CONCENTRATION_VS_LIMIT_CALCULATIONS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > H._jm_concentration_calculations(ctx))) == true
    end
    EOC["EOC_AFS_CONCENTRATION_VS_LIMIT_CALCULATIONS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") > H._jm_concentration_calculations(ctx))) then
        services.messages.add(ctx:expand_text(services.translate("It's taking you a lot of concentration to maintain your powers.  You're not sure you'll be able to do it for very long.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_afs_psi_intense_concentration", -1, nil, nil, nil)
        return true
    else
        if ((function() local eg = H.safe_id('effect', "effect_afs_psi_intense_concentration"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            services.messages.add(ctx:expand_text(services.translate("As you stop concentrating, your mind clears a bit.  It's easier to think now.")), "good")
            do local _eg = H.safe_id('effect', "effect_afs_psi_intense_concentration"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return false
    end
    end
    COND["EOC_AFS_PSIONICS_ADVERSE_EVENTS"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx))) == true
    end
    EOC["EOC_AFS_PSIONICS_ADVERSE_EVENTS"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx))) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", (ctx:get_number("difficulty") or 0))
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_AFS_PSIONICS_ADVERSE_EVENT_NOSEBLEED"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_AFS_PSIONICS_ADVERSE_EVENT_HEADACHE"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_AFS_PSIONICS_ADVERSE_EVENT_HEALTH_PENALTY"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    COND["EOC_AFS_PSIONICS_ADVERSE_EVENT_NOSEBLEED"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) == true
    end
    EOC["EOC_AFS_PSIONICS_ADVERSE_EVENT_NOSEBLEED"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, blood drips from your nose.")), "bad")
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "head", 1, nil)
        H.set_char_hp(H.u(ctx), "head", 1, "-=")
        return true
    end
    return false
    end
    COND["EOC_AFS_PSIONICS_ADVERSE_EVENT_HEADACHE"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) == true
    end
    EOC["EOC_AFS_PSIONICS_ADVERSE_EVENT_HEADACHE"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, your head begins to throb.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_afs_esper_headache", services.random.native_float(900, 3600), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_PSIONICS_ADVERSE_EVENT_HEALTH_PENALTY"] = function(ctx)
        return (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) == true
    end
    EOC["EOC_AFS_PSIONICS_ADVERSE_EVENT_HEALTH_PENALTY"] = function(ctx)
    if (services.random.native_probability(((((H.var_num(H.u(ctx), "esper_repeated_channeling_value") * 8) + (H.var_num(H.u(ctx), "latest_channeled_power_difficulty") * 3)) + (H.char_vitamin(H.u(ctx), "vitamin_afs_maintained_powers") * 20))), (1000))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel enervated.")), "bad")
        H.set_char_health(H.u(ctx), (10 + services.random.native_int(0, H.round_half_away(25))), "-=")
        return true
    end
    return false
    end
    COND["EOC_AFS_PSI_SKILL_INCREASE_ON_USE_INITIALIZE"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) == true
    end
    EOC["EOC_AFS_PSI_SKILL_INCREASE_ON_USE_INITIALIZE"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_ESPER_TRAIT_AND_SCHOOL_LIST", ctx)) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", (ctx:get_number("difficulty") or 0))
        H.run_eoc("EOC_AFS_PSI_SKILL_INCREASE_ON_USE_FINALIZE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_AFS_PSI_SKILL_INCREASE_ON_USE_FINALIZE"] = function(ctx)
    local _a4 = H.u(ctx)
    local _sg5 = H.safe_id("skill", "metaphysics")
    if _a4 and _sg5 then services.skills.set(_a4, _sg5, { exercise_raw = math.floor((H.char_skill_exp(_a4, "metaphysics", true)) + (((150 * H.var_num(H.u(ctx), "latest_channeled_power_difficulty")) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
    return true
    end
    EOC["EOC_AFS_ESPER_BROKEN_LIMB_ENDS_POWERS"] = function(ctx)
    H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_AFS_ESPER_SLEEP_ENDS_POWERS"] = function(ctx)
        return ((((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("lying_down") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_AFS_ESPER_SLEEP_ENDS_POWERS"] = function(ctx)
    if ((((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("lying_down") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_WINDED_ENDS_POWERS"] = function(ctx)
        return ((((("winded") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_AFS_ESPER_WINDED_ENDS_POWERS"] = function(ctx)
    if ((((("winded") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_STUNNED_ENDS_POWERS"] = function(ctx)
        return (((((("stunned") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_stunned") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx))) == true
    end
    EOC["EOC_AFS_ESPER_STUNNED_ENDS_POWERS"] = function(ctx)
    if (((((("stunned") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("psi_stunned") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx))) then
        services.messages.add(ctx:expand_text(services.translate("As your head rings and your mind reels, you lose control of your powers!")), "bad")
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_DAZED_ENDS_POWERS_2"] = function(ctx)
        return (((services.random.native_int(1, math.floor(12)) + (((((((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 2) + H.char_skill(H.u(ctx), "metaphysics")) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0) * 2)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0) * 3)))) > (20))) == true
    end
    EOC["EOC_AFS_ESPER_DAZED_ENDS_POWERS_2"] = function(ctx)
    if (((services.random.native_int(1, math.floor(12)) + (((((((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 2) + H.char_skill(H.u(ctx), "metaphysics")) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0) * 2)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0) * 3)))) > (20))) then
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your head is swimming.  You can no longer maintain your powers!")), "bad")
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_ESPER_DAZED_ENDS_POWERS"] = function(ctx)
        return (((((("dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("downed") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx))) == true
    end
    EOC["EOC_AFS_ESPER_DAZED_ENDS_POWERS"] = function(ctx)
    if (((((("dazed") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("downed") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx))) then
        H.run_eoc("EOC_AFS_ESPER_DAZED_ENDS_POWERS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ESPER_WEARINESS_ENDS_POWERS"] = function(ctx)
        return (((((("weary_7") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_8") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))))) == true
    end
    EOC["EOC_AFS_ESPER_WEARINESS_ENDS_POWERS"] = function(ctx)
    if (((((("weary_7") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("weary_8") == (H.var_str("context", nil, ctx, "effect", ""))))) and H.test_eoc("EOC_CONDITION_ESPER_MAINTAINED_POWERS_LIST", ctx) and (not ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value == true))))) then
        services.messages.add(ctx:expand_text(services.translate("You are almost too tired to think, and can't concentrate on maintaining your powers")), "bad")
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_ELECTROKINETIC_RECIPE_TEACHER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1)) == true
    end
    EOC["EOC_AFS_ELECTROKINETIC_RECIPE_TEACHER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1)) then
        H.run_eoc("EOC_TEACH_AFS_ELECTROKINETIC_CONTEMPLATE_RECIPES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TEACH_AFS_ELECTROKINETIC_CONTEMPLATE_RECIPES"] = function(ctx)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SEE_ELECTRIC", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SHOCK_TOUCH", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_ZAP_ENEMIES", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_HACKING_INTERFACE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_PERSONAL_BATTERY", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_RECHARGE_VEHICLE", ctx, nil, nil, nil)
    return true
    end
end
