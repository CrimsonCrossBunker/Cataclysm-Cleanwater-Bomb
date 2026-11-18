local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")

return function(options, introduction, completed)
    local item = options.item
    local start = "sky_island_upgrade_start_" .. options.id
    local finish = "sky_island_upgrade_finish_" .. options.id
    ccb.runtime.handler(start, function(payload)
        state.checked(services.recipes.learn(payload.character, services.types.id("recipe", item)))
        state.message(payload.character, introduction(), "neutral", true)
    end)
    ccb.runtime.handler(finish, function(payload)
        completed(payload.character)
    end)
    options.goal = "MGOAL_FIND_ITEM"
    options.item_count = 1
    options.has_generic_rewards = false
    local mission = ccb.content.Mission(options)
    mission:start_with(start)
    mission:finish_with(finish)
    ccb.content.add(mission)
end
