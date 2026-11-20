local ccb = require("ccb")

ccb.runtime.handler("mark_mission_completed_antiparasitic", function(context)
    ccb.services.variables.set_string_notifying(context.character, "mission_completed_antiparasitic", "yes")
end)
