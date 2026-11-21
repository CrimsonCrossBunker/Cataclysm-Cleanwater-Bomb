local ccb = require("ccb")

ccb.runtime.handler("talk_balthazar", function(context)
    local opened = ccb.services.characters.open_topic(context.character, "ISO_BALTHAZAR_MAIN")
    if not opened.ok then
        error(opened.error.message)
    end
end)
