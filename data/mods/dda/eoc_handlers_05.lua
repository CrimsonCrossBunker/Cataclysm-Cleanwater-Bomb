local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PRE_THRESHOLD_SPIDER_SLEEP_MUTATION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "WEB_WALKER") == 1) and (not ((H.char_has_trait(H.u(ctx), "WEB_SPINNER") == 1))) and (not ((H.char_has_trait(H.u(ctx), "WEB_WEAVER") == 1))) and (H.field_strength(H.u(ctx), "fd_web", nil) < 3))) == true
    end
    EOC["EOC_PRE_THRESHOLD_SPIDER_SLEEP_MUTATION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "WEB_WALKER") == 1) and (not ((H.char_has_trait(H.u(ctx), "WEB_SPINNER") == 1))) and (not ((H.char_has_trait(H.u(ctx), "WEB_WEAVER") == 1))) and (H.field_strength(H.u(ctx), "fd_web", nil) < 3))) then
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "spider_clear_webs"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
        return true
    end
    return false
    end
    COND["EOC_LS_Teleport_to_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_Teleport_to_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        if ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "traveled_to_labyrinth_safehouse", "")))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
            H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_home_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
            H.set_var("actor", H.u(ctx), ctx, "traveled_home_to_labyrinth", "yes")
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            end
            if (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure") and 1 or 0)))) then
                H.eoc_loc_var(H.u(ctx), ctx, "actor", "safehouse_floor_portal_enclosure", { terrain = "labyrinth_safehouse" }, { special = H.safe_id('overmap_special', "labyrinth_safehouse") }, { kind = "furniture", id = H.safe_id("furniture", "f_exodii_floor_portal_enclosure") }, { target_max_radius = math.floor(250) }, nil, false, true, {  }, {  })
            end
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            if (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "traveled_to_labyrinth_safehouse", "")))))) then
                if H.u(ctx) then services.characters.open_topic(H.u(ctx), "COMP_labyrinthine_safehouse_computer_meeting") end
            end
        else
            ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
            H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_home_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
            H.set_var("actor", H.u(ctx), ctx, "traveled_home_to_labyrinth", "yes")
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
                if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
                if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
            end
            H.eoc_loc_var(H.u(ctx), ctx, "global", "original_labyrinth_portal_loc", { terrain = "labyrinth_entrance" }, { special = H.safe_id('overmap_special', "labyrinthine_structure") }, { kind = "furniture", id = H.safe_id("furniture", "f_scrap_antenna") }, { target_max_radius = math.floor(24) }, { dx = math.floor(1) }, false, true, {  }, {  })
            do local _p = H.get_tripoint_var("global", nil, ctx, "original_labyrinth_portal_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            H.run_eoc("EOC_LS_ROLL_FOR_STRING_DIMENSION_ENCOUNTER", ctx, nil, nil, nil)
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_SD_Teleport_to_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_SD_Teleport_to_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        if ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "traveled_to_labyrinth_safehouse", "")))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
            H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_string_dimension_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
            H.set_var("actor", H.u(ctx), ctx, "traveled_string_dimension_to_labyrinth", "yes")
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            end
            if (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure") and 1 or 0)))) then
                H.eoc_loc_var(H.u(ctx), ctx, "actor", "safehouse_floor_portal_enclosure", { terrain = "labyrinth_safehouse" }, { special = H.safe_id('overmap_special', "labyrinth_safehouse") }, { kind = "furniture", id = H.safe_id("furniture", "f_exodii_floor_portal_enclosure") }, { target_max_radius = math.floor(250) }, nil, false, true, {  }, {  })
            end
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            services.time.reschedule("string_dimension_lights_on", services.time.duration_from_turns(0))
            if (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "traveled_to_labyrinth_safehouse", "")))))) then
                if H.u(ctx) then services.characters.open_topic(H.u(ctx), "COMP_labyrinthine_safehouse_computer_meeting") end
            end
        else
            ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
            H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_string_dimension_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
            H.set_var("actor", H.u(ctx), ctx, "traveled_string_dimension_to_labyrinth", "yes")
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
                if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
                if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
            end
            H.eoc_loc_var(H.u(ctx), ctx, "global", "original_labyrinth_portal_loc", { terrain = "labyrinth_entrance" }, { special = H.safe_id('overmap_special', "labyrinthine_structure") }, { kind = "furniture", id = H.safe_id("furniture", "f_scrap_antenna") }, { target_max_radius = math.floor(24) }, { dx = math.floor(1) }, false, true, {  }, {  })
            do local _p = H.get_tripoint_var("global", nil, ctx, "original_labyrinth_portal_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            services.time.reschedule("string_dimension_lights_on", services.time.duration_from_turns(0))
            H.run_eoc("EOC_LS_ROLL_FOR_STRING_DIMENSION_ENCOUNTER", ctx, nil, nil, nil)
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_SAFEHOUSE_Teleport_to_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_SAFEHOUSE_Teleport_to_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_safehouse_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "traveled_safehouse_to_labyrinth", "yes")
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
        end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "original_labyrinth_portal_loc", { terrain = "labyrinth_entrance" }, { special = H.safe_id('overmap_special', "labyrinthine_structure") }, { kind = "furniture", id = H.safe_id("furniture", "f_scrap_antenna") }, { target_max_radius = math.floor(24) }, { dx = math.floor(1) }, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "original_labyrinth_portal_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        H.run_eoc("EOC_LS_ROLL_FOR_STRING_DIMENSION_ENCOUNTER", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_SAFEHOUSE_Teleport_to_labyrinth_reenter"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_SAFEHOUSE_Teleport_to_labyrinth_reenter"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_safehouse_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "traveled_safehouse_to_labyrinth", "yes")
        if ((("netherum_labyrinth") == (H.var_str("actor", H.u(ctx), ctx, "player_location_temp_labyrinth_return_dimension", "")))) then
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
                if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
                if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
            end
        end
        if ((("netherum_labyrinth2") == (H.var_str("actor", H.u(ctx), ctx, "player_location_temp_labyrinth_return_dimension", "")))) then
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth2", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
                if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
                if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
            end
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "player_location_temp_labyrinth_return_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_SAFEHOUSE_Exit_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_SAFEHOUSE_Exit_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        if ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "traveled_safehouse_to_labyrinth", "")))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Zworunk.")))
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
                if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold into a familiar place.")), 'good') end
                if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), 'bad') end
            end
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "player_location_safehouse_before_labyrinth"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
            services.gameplay.environment.clear_saved_dimension("netherum_labyrinth2")
        else
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            end
            if (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure") and 1 or 0)))) then
                H.eoc_loc_var(H.u(ctx), ctx, "actor", "safehouse_floor_portal_enclosure", { terrain = "labyrinth_safehouse" }, { special = H.safe_id('overmap_special', "labyrinth_safehouse") }, { kind = "furniture", id = H.safe_id("furniture", "f_exodii_floor_portal_enclosure") }, { target_max_radius = math.floor(250) }, nil, false, true, {  }, {  })
            end
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            ccb.presentation.notice(ctx:expand_text(services.translate("The world around you folds in on itself - zwoink.  Then, you hear three soft chimes, and find yourself standing in a metal ring.  A tall, bulbous computer screen looms before you, slightly too tall to comfortably look at without craning your neck.  Text starts to populate the screen.")))
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "COMP_labyrinthine_safehouse_computer_meeting") end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_SAFEHOUSE_Exit_labyrinth_temp"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_SAFEHOUSE_Exit_labyrinth_temp"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zworunk.")))
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_temp_labyrinth_return_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold into a familiar place.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), 'bad') end
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "player_location_safehouse_before_labyrinth"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    EOC["EOC_LS_Computer"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_LS_Passcode_Randomize"] = function(ctx)
    H.set_var("global", nil, ctx, "LS_Passcode_Selector", services.random.native_float(1, 3))
    return true
    end
    EOC["EOC_LS_Passcode_Selector"] = function(ctx)
    if ((H.global_var_num("LS_Passcode_Selector") == 3) and (H.char_has_trait(H.u(ctx), "LS_Passcode_3") == 1)) then
        H.set_var("global", nil, ctx, "LS_Passcode_Selector", (H.global_var_num("LS_Passcode_Selector")) - (1))
    end
    if ((H.global_var_num("LS_Passcode_Selector") == 2) and (H.char_has_trait(H.u(ctx), "LS_Passcode_2") == 1)) then
        H.set_var("global", nil, ctx, "LS_Passcode_Selector", (H.global_var_num("LS_Passcode_Selector")) - (1))
    end
    if ((H.global_var_num("LS_Passcode_Selector") == 1) and (H.char_has_trait(H.u(ctx), "LS_Passcode_1") == 1)) then
        H.set_var("global", nil, ctx, "LS_Passcode_Selector", (H.global_var_num("LS_Passcode_Selector")) - (1))
    end
    return true
    end
    EOC["EOC_LS_Bridge_control_deadend_1_Passcode0"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_Bridge_control_deadend_1_extend" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do
        local _sw11 = services.random.native_float(1, 1)
        if _sw11 == 1 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_deadend_1_room0" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["EOC_LS_Bridge_control_deadend_1_Passcode1"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_Bridge_control_deadend_1_extend" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do
        local _sw12 = services.random.native_float(1, 1)
        if _sw12 == 1 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_deadend_1_room1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["EOC_LS_Bridge_control_deadend_1_Passcode2"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_Bridge_control_deadend_1_extend" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do
        local _sw13 = services.random.native_float(1, 1)
        if _sw13 == 1 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_deadend_1_room2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["EOC_LS_Bridge_control_deadend_1_Passcode3"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_Bridge_control_deadend_1_extend" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do
        local _sw14 = services.random.native_float(1, 1)
        if _sw14 == 1 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_deadend_1_room3" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    EOC["EOC_LS_Unlock"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Unlock" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_LS_Lock"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Lock" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_LS_ReallyUnlock"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_ReallyUnlock" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_LS_Passcode_Generator"] = function(ctx)
    do
        local _sw15 = H.global_var_num("LS_Passcode_Selector")
        if _sw15 == 0 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Passcode_Generator_0" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        elseif _sw15 == 1 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Passcode_Generator_1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        elseif _sw15 == 2 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Passcode_Generator_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        elseif _sw15 == 3 then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "UM_LS_Passcode_Generator_3" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        end
    end
    return true
    end
    COND["EOC_TEST_PORTAL_TO_LABYRINTH_SAFEHOUSE"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_TEST_PORTAL_TO_LABYRINTH_SAFEHOUSE"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Kuhhh-wunk.")))
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
        end
        H.eoc_loc_var(H.u(ctx), ctx, "context", "safehouse_floor_portal_enclosure", { terrain = "labyrinth_safehouse" }, { special = H.safe_id('overmap_special', "labyrinth_safehouse") }, { kind = "furniture", id = H.safe_id("furniture", "f_exodii_floor_portal_enclosure") }, { target_max_radius = math.floor(100) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("context", nil, ctx, "safehouse_floor_portal_enclosure"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Something tickles at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_mission_boiler_teleport_to_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_mission_boiler_teleport_to_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.")))
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_safehouse_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "traveled_safehouse_to_labyrinth", "yes")
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
        end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "labyrinth_nl_boiler_loc", { terrain = "labyrinth_hall" }, { special = H.safe_id('overmap_special', "labyrinthine_structure_boiler") }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "labyrinth_nl_boiler_loc"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_nl_entry_boiler" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "labyrinth_nl_boiler_loc", { terrain = "labyrinth_hall" }, { special = H.safe_id('overmap_special', "labyrinthine_structure_boiler") }, { kind = "terrain", id = H.safe_id("terrain", "t_nl_obelisk_mission_boiler") }, { target_max_radius = math.floor(500) }, { dx = math.floor(1) }, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "labyrinth_nl_boiler_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_mission_water_coolor_teleport_to_labyrinth"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_mission_water_coolor_teleport_to_labyrinth"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zwoink.  You find yourself in a standard entry room, but instead of a terminal, this one houses an obelisk.")))
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "player_location_safehouse_before_labyrinth", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "traveled_safehouse_to_labyrinth", "yes")
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
        end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "original_labyrinth_portal_loc", { terrain = "labyrinth_flooded_entrance" }, { special = H.safe_id('overmap_special', "labyrinthine_structure_flooded") }, { kind = "furniture", id = H.safe_id("furniture", "f_scrap_antenna") }, { target_max_radius = math.floor(24) }, { dx = math.floor(1) }, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "original_labyrinth_portal_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_WATER_COOLER_LOC", { terrain = "labyrinth_flooded_hall" }, { special = H.safe_id('overmap_special', "labyrinthine_structure_flooded"), search_range = math.floor(20), min_distance = math.floor(5), random = true }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "LS_WATER_COOLER_LOC"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_nl_flooded_water_cooler_location" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_mission_boiler_teleport_to_safehouse"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_mission_boiler_teleport_to_safehouse"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zworunk.  The ground shakes for a moment.")))
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold into a familiar place.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), 'bad') end
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "player_location_safehouse_before_labyrinth"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
        H.run_eoc("EOC_LS_SAFEHOUSE_UPDATE_BOILER", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_mission_water_cooler_teleport_to_safehouse"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_mission_water_cooler_teleport_to_safehouse"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You move to prick your palm upon the device, but everything goes black.  Did you ever prick it?\n\nZworunk.  The ground shakes for a moment.  Then you hear water bubbling.")))
        do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold into a familiar place.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), 'bad') end
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "player_location_safehouse_before_labyrinth"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
        do local _mid = "MISSION_nl_water_coolor"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.finish(H.u(ctx), _m.token); break end end end end
        H.run_eoc("EOC_LS_SAFEHOUSE_UPDATE_WATER_COOLER", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    EOC["EOC_LS_SAFEHOUSE_UPDATE_BOILER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_SAFEHOUSE_1", { terrain = "labyrinth_safehouse" }, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "LS_SAFEHOUSE_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_safehouse_boiler" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "nl_boiler_placed", 1)
    return true
    end
    EOC["EOC_LS_SAFEHOUSE_UPDATE_UTILITY_SPACE_OBELISK"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_SAFEHOUSE_1", { terrain = "labyrinth_safehouse" }, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "LS_SAFEHOUSE_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_safehouse_utility_space_obelisk" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "nl_utility_space_obelisk_placed", 1)
    return true
    end
    EOC["EOC_LS_SAFEHOUSE_UPDATE_AUTODOC_OBELISK"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_SAFEHOUSE_1", { terrain = "labyrinth_safehouse" }, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "LS_SAFEHOUSE_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_safehouse_autodoc_obelisk" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "nl_autodoc_obelisk_placed", 1)
    return true
    end
    EOC["EOC_LS_SAFEHOUSE_UPDATE_WATER_COOLER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_SAFEHOUSE_1", { terrain = "labyrinth_safehouse" }, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "LS_SAFEHOUSE_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_safehouse_water_cooler" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("actor", H.u(ctx), ctx, "nl_safehouse_water_stock", 1)
    H.set_var("global", nil, ctx, "nl_water_cooler_placed", 1)
    do local _t = math.max(1, math.floor(64800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LS_SAFEHOUSE_WATER_COOLER_REFILL_CHECK"), nil) end end
    return true
    end
    EOC["EOC_LS_SAFEHOUSE_UPDATE_LIVING_SPACE_1_OBELISK"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_SAFEHOUSE_1", { terrain = "labyrinth_safehouse" }, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("global", nil, ctx, "LS_SAFEHOUSE_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_safehouse_living_space_1_obelisk" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "nl_living_space_1_obelisk_placed", 1)
    return true
    end
    COND["EOC_LS_ROLL_FOR_STRING_DIMENSION_ENCOUNTER"] = function(ctx)
        return ((services.random.native_probability(1, (5)) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "ls_used_holographic_shard", "")))))))) == true
    end
    EOC["EOC_LS_ROLL_FOR_STRING_DIMENSION_ENCOUNTER"] = function(ctx)
    if ((services.random.native_probability(1, (5)) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "ls_used_holographic_shard", "")))))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "LS_STRING_DIMENSION_ENCOUNTER_LOC", { terrain = "labyrinth_hall" }, { special = H.safe_id('overmap_special', "labyrinthine_structure"), search_range = math.floor(20), min_distance = math.floor(5), random = true }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "LS_STRING_DIMENSION_ENCOUNTER_LOC"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "labyrinth_nl_string_dimension_encounter" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    EOC["EOC_LS_SD_enter_tunnel"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You smell something acrid, then your mind reels - you suddenly find yourself standing upon a landscape, yourself and it completely flat.  You try to find your footing.")))
    do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
        if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Zwoink.")), 'good') end
        if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("Nope!")), 'bad') end
    end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "string_dimension_tunnel", { terrain = "labyrinth_string_dimension_tunnel_start" }, { special = H.safe_id('overmap_special', "labyrinth_string_dimension_tunnel") }, { kind = "furniture", id = H.safe_id("furniture", "f_exodii_lamp_string_warped") }, { target_max_radius = math.floor(24) }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "string_dimension_tunnel"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    COND["EOC_LS_earth_jaunt_4hours"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_LS_earth_jaunt_4hours"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("Zworunk.")))
        do local _dr = services.relocation.travel_to_dimension("default", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold into the recesses of the world you know.  For now.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), 'bad') end
        end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "earth_jaunt_loc", { terrain = "field" }, { search_range = math.floor(1000), min_distance = math.floor(0), random = true }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "earth_jaunt_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        do local _g = H.safe_id('mutation', "NL_MUTE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor(14400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LS_earth_jaunt_extraction"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You feel a prickle at the edge of your senses.")), "neutral")
        return false
    end
    end
    COND["EOC_LS_earth_jaunt_extraction"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx))) == true
    end
    EOC["EOC_LS_earth_jaunt_extraction"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx))) then
        if ((services.gameplay.environment.dimension() == "default") and (not (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "LIXA_unfolded_eff"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_floor_warped" end)()))) and (not (H.char_at_om_location(H.u(ctx), "nether_glass"))) and (not (H.char_at_om_location(H.u(ctx), "nether_glass_deep"))) and (not (H.char_at_om_location(H.u(ctx), "microlab_portal_elevator_nether_glass")))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("There is a tightening in your throat as the world folds in around you.")))
            do local _dr = services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            end
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "safehouse_floor_portal_enclosure"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            H.lose_trait(H.u(ctx), "NL_MUTE")
            H.set_var("global", nil, ctx, "scenario_trapped_in_labyrinth_anchor_counter", 0)
        else
            H.lose_trait(H.u(ctx), "NL_MUTE")
            H.lose_bionic(H.u(ctx), "bio_nl_collar")
            H.add_bionic(H.u(ctx), "bio_nl_collar_deactivated")
            ccb.presentation.notice(ctx:expand_text(services.translate("Your body tenses in expectation of the tightening in your throat, but it doesn't come.  Your voice has returned, and you feel a bit lighter.")))
        end
        return true
    else
        if (not ((H.global_var_num("scenario_trapped_in_labyrinth_anchor_counter") >= 1440))) then
            H.set_var("global", nil, ctx, "scenario_trapped_in_labyrinth_anchor_counter", (H.global_var_num("scenario_trapped_in_labyrinth_anchor_counter")) + (1))
            if services.random.native_probability(1, (2000)) then
                services.messages.add(ctx:expand_text(services.translate("You feel mentally and physically liberated under the effects of the anchor.")), "neutral")
            end
            if services.random.native_probability(1, (2000)) then
                services.messages.add(ctx:expand_text(services.translate("Your neck feels less stiff.")), "neutral")
            end
            if services.random.native_probability(1, (2000)) then
                services.messages.add(ctx:expand_text(services.translate("You feel a tickle at the edge of your senses.")), "neutral")
            end
            do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LS_earth_jaunt_extraction"), nil) end end
        else
            H.lose_trait(H.u(ctx), "NL_MUTE")
            H.lose_bionic(H.u(ctx), "bio_nl_collar")
            H.add_bionic(H.u(ctx), "bio_nl_collar_deactivated")
            ccb.presentation.notice(ctx:expand_text(services.translate("You suddenly feel a sharp pinch in the nape of your neck.  Your voice has returned and you once again feel at home.")))
        end
        return false
    end
    end
    COND["EOC_exodii_wrist_computer_record_labyrinth_location"] = function(ctx)
        return (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true) and (services.gameplay.environment.dimension() == "default"))) == true
    end
    EOC["EOC_exodii_wrist_computer_record_labyrinth_location"] = function(ctx)
    if (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true) and (services.gameplay.environment.dimension() == "default"))) then
        if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") and services.random.native_probability(1, (7200))) or (((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm") and services.random.native_probability(1, (1200))) or (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") and services.random.native_probability(1, (1200))) or services.random.native_probability(1, (604800))) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
            H.set_var("global", nil, ctx, "labyrinth_access_points", (H.global_var_num("labyrinth_access_points")) + (1))
            services.messages.add(ctx:expand_text(services.translate("Your Exodii wrist computer beeps and displays an unintelligible word.  It has recorded the extradimensional location of a Labyrinth.")), "info")
        end
        return true
    end
    return false
    end
    COND["EOC_LS_SAFEHOUSE_WATER_COOLER_REFILL_CHECK"] = function(ctx)
        return (((H.var_num(H.u(ctx), "nl_safehouse_water_stock") < 5) and ((services.gameplay.environment.dimension() == "netherum_labyrinth") or (services.gameplay.environment.dimension() == "netherum_labyrinth_safehouse")))) == true
    end
    EOC["EOC_LS_SAFEHOUSE_WATER_COOLER_REFILL_CHECK"] = function(ctx)
    if (((H.var_num(H.u(ctx), "nl_safehouse_water_stock") < 5) and ((services.gameplay.environment.dimension() == "netherum_labyrinth") or (services.gameplay.environment.dimension() == "netherum_labyrinth_safehouse")))) then
        H.set_var("actor", H.u(ctx), ctx, "nl_safehouse_water_stock", (H.var_num(H.u(ctx), "nl_safehouse_water_stock")) + (1))
        if (services.gameplay.environment.dimension() == "netherum_labyrinth_safehouse") then
            services.messages.add(ctx:expand_text(services.translate("You hear water bubbling.")), "neutral")
        end
        do local _t = math.max(1, math.floor(64800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LS_SAFEHOUSE_WATER_COOLER_REFILL_CHECK"), nil) end end
        return true
    else
        do local _t = math.max(1, math.floor(64800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LS_SAFEHOUSE_WATER_COOLER_REFILL_CHECK"), nil) end end
        return false
    end
    end
    EOC["EOC_nether_glass_no_map"] = function(ctx)
    services.world.override_place_name(H.var_str("global", nil, ctx, "place_name", "lost level"), services.time.duration_from_turns(math.floor(10)))
    return true
    end
    COND["EOC_nether_glass_lost_tp"] = function(ctx)
        return ((services.random.native_probability((1), (5)) and H.char_at_om_location(H.u(ctx), "nether_glass_deep"))) == true
    end
    EOC["EOC_nether_glass_lost_tp"] = function(ctx)
    if ((services.random.native_probability((1), (5)) and H.char_at_om_location(H.u(ctx), "nether_glass_deep"))) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "glass_place", { terrain = "nether_glass_deep" }, { z = math.floor(-10), min_distance = math.floor(3) }, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "glass_place"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        return true
    end
    return false
    end
    COND["EOC_nether_glass_yrax_encounter"] = function(ctx)
        return ((services.random.native_probability((1), (250)) and H.char_at_om_location(H.u(ctx), "nether_glass_deep"))) == true
    end
    EOC["EOC_nether_glass_yrax_encounter"] = function(ctx)
    if ((services.random.native_probability((1), (250)) and H.char_at_om_location(H.u(ctx), "nether_glass_deep"))) then
        H.set_var("actor", H.u(ctx), ctx, "general_yrax_u_met_apeirohedra", "yes")
        H.run_eoc("capture_generic_nre_anomaly", ctx, nil, nil, nil)
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_yrax_apeirogon") or H.safe_id('monster_group', "mon_yrax_apeirogon"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(3), max_radius = math.floor(10), lifespan = { minimum = services.time.duration_from_turns(math.floor(40)), maximum = services.time.duration_from_turns(math.floor(120)) } }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("The emptiness yields before an all-encompassing construct.")), 'warning') end
        end end
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_yrax_trifacet") or H.safe_id('monster_group', "mon_yrax_trifacet"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(15), min_radius = math.floor(3), max_radius = math.floor(20), lifespan = { minimum = services.time.duration_from_turns(math.floor(40)), maximum = services.time.duration_from_turns(math.floor(120)) } }); 
        end end
        if services.gameplay.mods.is_loaded("mindovermatter") then
            H.run_eoc("EOC_MOM_FIFTH_SUN_ON_SEEING_YRAX_APEIROHEDRON", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_nether_glass_event"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "nether_glass") or H.char_at_om_location(H.u(ctx), "nether_glass_deep") or H.char_at_om_location(H.u(ctx), "microlab_portal_elevator_nether_glass"))) == true
    end
    EOC["EOC_nether_glass_event"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "nether_glass") or H.char_at_om_location(H.u(ctx), "nether_glass_deep") or H.char_at_om_location(H.u(ctx), "microlab_portal_elevator_nether_glass"))) then
        H.run_eoc("EOC_nether_glass_no_map", ctx, nil, nil, nil)
        H.run_eoc("EOC_nether_glass_lost_tp", ctx, nil, nil, nil)
        H.run_eoc("EOC_nether_glass_yrax_encounter", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_MOM_FIFTH_SUN_ON_SEEING_YRAX_APEIROHEDRON"] = function(ctx)
    return true
    end
    EOC["EOC_YUGG_DEATH"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "death_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do
        local _sw16 = services.random.native_int(0, H.round_half_away(4))
        if _sw16 == 0 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "black_glass_shard"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(services.random.native_int(750, 2250))) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature quickly begins to darken and turn translucent, shattering like glass soon after.")), "info")
            end
        elseif _sw16 == 1 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_rubber"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature's skin turns darker and it falls limp like a pool noodle.")), "info")
            end
        elseif _sw16 == 2 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_mutflesh"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature seems to lose all detail and falls limply on the ground with a wet thud.")), "info")
            end
        elseif _sw16 == 3 then
            do local _p = H.get_tripoint_var("context", nil, ctx, "death_loc"); local _g = H.safe_id('item', "corpse_yugg_jade"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it stops moving, the creature seems to stiffen as it skins seems to harden and take a form not dissimilar to stone.")), "info")
            end
        elseif _sw16 == 4 then
            if H.npc(ctx) then services.characters.emit(H.npc(ctx), "emit_fog_plume", 1) end
            if (H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true) then
                services.messages.add(ctx:expand_text(services.translate("As it falls to the ground, strands of fog seem to tear away from the corpse.  The giant worm dissolves in the air in front of your eyes.")), "info")
            end
        end
    end
    return true
    end
    COND["EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1) and (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") and services.random.native_probability((5), (10))) or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") and services.random.native_probability((6), (10))) or (((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") and services.random.native_probability((8), (10))) or (((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (10)))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1) and (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or (((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") and services.random.native_probability((5), (10))) or (((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") and services.random.native_probability((6), (10))) or (((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") and services.random.native_probability((8), (10))) or (((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (10)))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) then
        if (H.global_var_num("ps_str") > 4) then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_GOOD"); table.insert(_wts, math.max(0, 10))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MORALE_GOOD"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_FOCUS_GOOD"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        else
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_GOOD"); table.insert(_wts, math.max(0, 10))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MORALE_GOOD"); table.insert(_wts, math.max(0, 5))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_FOCUS_GOOD"); table.insert(_wts, math.max(0, 2))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MORALE_GOOD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MORALE_GOOD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel a warm sense of being at home.")), "good")
        do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(20), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_ACCEPTANCE_TIMER"] = function(ctx)
        return (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60)) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE_TIMER"] = function(ctx)
    if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60)) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_1"); table.insert(_wts, math.max(0, 4))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_2"); table.insert(_wts, math.max(0, 3))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_3"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_4"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    else
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_1"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_ACCEPTANCE_2"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return false
    end
    end
    COND["EOC_PORTAL_DEPENDENT_ACCEPTANCE"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "REALITY_GRASP") == 1)))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "REALITY_GRASP") == 1)))) then
        H.run_eoc("EOC_PORTAL_DEPENDENT_ACCEPTANCE_TIMER", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE_1"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel a weight you didn't know you had on you, being lifted away.")), "good")
    local _a17 = H.u(ctx)
    if _a17 then services.characters.adjust(_a17, { pain = math.floor(-(5)) }) end
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE_2"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel wakeful and energized, as if something that was slowing you down is now gone.")), "good")
    H.set_char_val_extra(H.u(ctx), "sleepiness", 20, "-=")
    H.set_char_val_extra(H.u(ctx), "stamina", 20, "+=")
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE_3"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel as if invisible shackles are being lifted away…")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(40), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
    return true
    end
    COND["EOC_PORTAL_DEPENDENT_ACCEPTANCE_4"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm"))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_ACCEPTANCE_4"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm"))) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("You suddenly feel a profound sense of belonging take root inside you, spreading throughout your body.  It fades quickly, but something warm remains…")), "good")
            do local _g = H.safe_id('mutation', "REALITY_GRASP"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        else
            services.messages.add(ctx:expand_text(services.translate("You suddenly feel a profound sense of belonging take root inside you, but then abruptly grow cold.  You reach out for it, but it's gone now, taken away by the indoors.  You long for the sky…")), "warning")
        end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_FOCUS_GOOD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_FOCUS_GOOD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Everything suddenly feels more clear.")), "good")
        H.set_char_val_extra(H.u(ctx), "focus", 10, "+=")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_GOOD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_GOOD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_VARIED_GOOD") or ''), "good")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1) and (not ((((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm")))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1) and (not ((((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm")))) and (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))))) then
        if (not ((H.char_has_trait(H.u(ctx), "REALITY_GRASP") == 1))) then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_BAD"); table.insert(_wts, math.max(0, 18))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MORALE_BAD"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_FOCUS_BAD"); table.insert(_wts, math.max(0, 5))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_SHAKES"); table.insert(_wts, math.max(0, 4))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_NAUSEA"); table.insert(_wts, math.max(0, 4))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_STUN"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DOWNED"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_STATS_BAD"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_TELEPORT_STUCK_START"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_PAIN"); table.insert(_wts, math.max(0, 2))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_PAIN_CONSTANT"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DAMAGE_CONSTANT"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        else
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_BAD"); table.insert(_wts, math.max(0, 10))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_MORALE_BAD"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_FOCUS_BAD"); table.insert(_wts, math.max(0, 2))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_SHAKES"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_NAUSEA"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MORALE_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MORALE_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You suddenly feel like you shouldn't be here.")), "bad")
        do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-10), math.floor(-30), { duration = services.time.duration_from_turns(math.floor(2400)), decay_start = services.time.duration_from_turns(math.floor(600)) }) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_FOCUS_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_FOCUS_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You try to recall what you were about to do, but you can't focus…")), "bad")
        H.set_char_val_extra(H.u(ctx), "focus", 10, "-=")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_STATS_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_STATS_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_STR_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_DEX_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_PER_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_INT_BAD"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_STR_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_STR_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You suddenly feel feeble.  Your muscles wobble.")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_str_bad", 3000, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(600), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_DEPENDENT_MESSAGES_STR_BAD"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_DEX_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_DEX_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You suddenly feel a sharp pain in your hand.  You reach out to grab it, and miss.")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_dex_bad", 3000, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(600), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_DEPENDENT_MESSAGES_DEX_BAD"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_PER_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_PER_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You blink one time, and everything seems bigger.")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_per_bad", 3000, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(600), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_DEPENDENT_MESSAGES_PER_BAD"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_INT_BAD"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_INT_BAD"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You stop to think, but you can't seem to remember about what.")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_int_bad", 3000, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(600), math.floor(2400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_DEPENDENT_MESSAGES_INT_BAD"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_SHAKES"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_SHAKES"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You feel anxious for no reason.")), "bad")
        H.eoc_add_effect(H.u(ctx), "shakes", 300, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DEPENDENT_NAUSEA"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel as if your stomach and its contents are fighting.")), "bad")
    H.eoc_add_effect(H.u(ctx), "nausea", 300, nil, 2, nil)
    return true
    end
end
