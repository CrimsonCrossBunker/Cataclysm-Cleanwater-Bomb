local ccb = require("ccb")

ccb.runtime.handler("morale_mission_last_dance", function(context)
    ccb.services.morale.add(context.character, ccb.services.types.id("morale", "morale_feeling_good"),
        20, 50, { duration = ccb.services.time.duration(120, "minute"),
            decay_start = ccb.services.time.duration(120, "minute") })
end)
