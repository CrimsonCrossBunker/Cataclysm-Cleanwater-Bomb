local near = require("ccb").services.overmap.matches_location_near

local settlements = {
    { "evac_center_13", 3 }, { "evac_center_18", 6 }, { "isolated_road_field_0", 2 },
    { "horse_farm_isherwood_9", 3 }, { "farm_isherwood_2", 3 }, { "dairy_farm_isherwood_SW", 3 },
    { "lumbermill_0_0_ocu", 1 }, { "ranch_camp_41", 6 }, { "godco_5", 3 },
    { "smallscrapyard_ocu", 1 }, { "robofachq_surface_entrance", 4 },
}

return function(omt)
    for _, settlement in ipairs(settlements) do
        if near(omt, settlement[1], settlement[2]) then return true end
    end
    return false
end
