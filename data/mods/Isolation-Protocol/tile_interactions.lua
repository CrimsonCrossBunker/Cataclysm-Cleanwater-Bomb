local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("examine_f_experimental_crafter_terminal", function(ctx)
    local actor = ctx.character
    checked(services.characters.open_topic(actor, "ISO_CRAFTER_INTRO"))
end)
