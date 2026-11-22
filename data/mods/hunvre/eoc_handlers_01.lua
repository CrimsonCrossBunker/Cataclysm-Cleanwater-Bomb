local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_elevator_state_check"] = function(ctx)
    H.set_var("global", nil, ctx, "elevator_present", 1)
    services.messages.add(ctx:expand_text(services.translate("Works <context_val:elevator_controls_start>")), "neutral")
    return true
    end
    EOC["EOC_elevator_controls"] = function(ctx)
    H.set_var("global", nil, ctx, "elevator_present", 0)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(10) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "elevator_controls_start", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "elevator_controls_start"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_central_elevator" end)())) then for _, _eid in ipairs({ "EOC_elevator_state_check" }) do H.run_eoc(_eid, ctx) end; if true then break end end end end end
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "elevator_controls_start") end
    return true
    end
    EOC["EOC_elevator_call_down_start"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "elevator_platform_check"), H.safe_id('terrain_furniture_transform', "closed_elevator_to_open"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    services.messages.add(ctx:expand_text(services.translate("Works <context_val:elevator_platform_check>")), "neutral")
    services.messages.add(ctx:expand_text(services.translate("The elevator fails to arrive")), "bad")
    return true
    end
    EOC["EOC_elevator_controls_call"] = function(ctx)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(15) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "elevator_platform_check", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "elevator_platform_check"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_central_elevator_closed" end)())) then for _, _eid in ipairs({ "EOC_elevator_call_down_start" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
    return true
    end
    EOC["EOC_INTERACT_AIRLOCK"] = function(ctx)
    do local _sel = services.targeting.choose_map_square(ctx:expand_text(services.translate("Select point")), nil, false); if _sel then H.set_var("context", nil, ctx, "piratable_tile", _sel) end end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "piratable_tile"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_airlock_control" end)()) then
        do local _p = H.get_tripoint_var("context", nil, ctx, "piratable_tile"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "open_airlock" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR")), "neutral")
    end
    return true
    end
    EOC["EOC_elevator_decontamination"] = function(ctx)
    do local _sel = services.targeting.choose_map_square(ctx:expand_text(services.translate("Select point")), nil, false); if _sel then H.set_var("context", nil, ctx, "piratable_tile", _sel) end end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "piratable_tile"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_airlock_control" end)()) then
        do local _p = H.get_tripoint_var("context", nil, ctx, "piratable_tile"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "open_airlock" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    else
        services.messages.add(ctx:expand_text(services.translate("ERROR")), "neutral")
    end
    return true
    end
end
