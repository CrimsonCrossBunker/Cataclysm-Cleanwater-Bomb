local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("finish_hacking_activity", function(activity)
    local character = activity.character
    checked(services.effects.add(character, services.types.id("effect", "afs_hack_done"),
        services.time.duration(3, "second")))
    checked(services.characters.adjust(character, { moves = -100 }))
end, 1)

content.add(content.ActivityType {
    id = "ACT_afs_hack",
    verb = content.text("hacking"),
    based_on = "time",
    can_resume = false,
}:on_finish("finish_hacking_activity"))
