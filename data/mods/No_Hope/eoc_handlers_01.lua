local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "pond_field") or H.char_at_om_location(H.u(ctx), "natural_spring") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "trailhead") or H.char_at_om_location(H.u(ctx), "forest_trail") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "road") or H.char_at_om_location(H.u(ctx), "meadow_core") or H.char_at_om_location(H.u(ctx), "meadow_end") or H.char_at_om_location(H.u(ctx), "farmland_turn") or H.char_at_om_location(H.u(ctx), "farmland_straight")))) == true
    end
    EOC["EOC_SHADOW_SPAWN_CONDITIONS_VALID_LOCATION"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "pond_field") or H.char_at_om_location(H.u(ctx), "natural_spring") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "trailhead") or H.char_at_om_location(H.u(ctx), "forest_trail") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "road") or H.char_at_om_location(H.u(ctx), "meadow_core") or H.char_at_om_location(H.u(ctx), "meadow_end") or H.char_at_om_location(H.u(ctx), "farmland_turn") or H.char_at_om_location(H.u(ctx), "farmland_straight")))) then
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
        return (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) == true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
    if (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) then
        return true
    else
        return false
    end
    end
end
