local ccb = require("ccb")

local function vampire_hunt_morale(context)
    ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
        30, 50, { duration = ccb.services.time.duration(24, "hour"),
            decay_start = ccb.services.time.duration(12, "hour") })
end

ccb.runtime.handler("morale_mission_low_vampire_hunter", vampire_hunt_morale)
ccb.runtime.handler("morale_mission_vampire_hunter", vampire_hunt_morale)

ccb.runtime.handler("gamehunt_morale", function(context)
    local hour = ccb.services.time.duration(1, "hour")
    ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
        10, 50, { duration = hour, decay_start = hour })
end)
