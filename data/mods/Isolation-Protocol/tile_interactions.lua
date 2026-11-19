local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("examine_f_experimental_crafter_terminal", function(ctx)
    local actor = ctx.character
    services.interaction.open_topic(actor, "ISO_CRAFTER_INTRO")
end)
