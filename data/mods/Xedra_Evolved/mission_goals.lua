local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("complete_get_components_for_tier_5", function()
    return false
end)

ccb.runtime.handler("complete_kill_your_best_friend", function()
    return false
end)

ccb.runtime.handler("complete_mission_draco_fae", function(context)
    return services.variables.get_string(context.speaker, "general_meeting_u_met_boann_sidhe").value.value == "yes"
end)
