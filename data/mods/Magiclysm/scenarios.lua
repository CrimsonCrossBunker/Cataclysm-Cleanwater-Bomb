local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("magiclysm_lost_faith_due", function(payload)
    local actor = payload.character
    checked(services.inventory.receive_item(actor, id("item", "priest_beginner"), 1))
    checked(services.inventory.receive_item(actor, id("item", "priest_advanced"), 1))
end)

ccb.runtime.handler("magiclysm_lost_faith_start", function(payload)
    ccb.tasks.after_character_turn(payload.character, 0, "magiclysm_lost_faith_due")
end)

content.replace(content.Scenario {
    id = "lost_faith",
    inherits = "lost_faith",
    on_start = "magiclysm_lost_faith_start",
})
