local ccb = require("ccb")
local travel = require("dimension_travel")

ccb.runtime.handler("inner_cabin_door_trigger", function(payload)
    if payload.creature and payload.creature.subtype == "avatar" then
        travel.warped_cabin(payload.creature)
    end
    return false
end)

local door = ccb.content.Trap {
    id = "tr_inner_cabins_door_o",
    name = ccb.content.text("strange open door"),
    symbol = "'", color = "brown", action = "none",
    visibility = 1000, avoidance = 99, difficulty = 99,
    trap_radius = 2, always_invisible = true,
}
door:flag("UNDODGEABLE")
door:flag("AVATAR_ONLY")
door:on_trigger("inner_cabin_door_trigger")
ccb.content.add(door)
