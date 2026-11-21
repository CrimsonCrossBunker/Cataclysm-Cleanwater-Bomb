local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local tasks = ccb.tasks

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("scenario_defense_mode_due", function(payload)
    local actor = payload.character
    checked(services.variables.set_global("diffulty_modifier", 1, { include_before = false }))
    checked(services.variables.set_global("wave_money_modifier", -1000, { include_before = false }))
    checked(services.characters.open_topic(actor, "TALK_DEFENSE_MODE_MAIN_MENU"))
    local origin = checked(services.creatures.snapshot(actor)).position
    local spawn = services.world.find_location(origin, nil, {
        target_max_radius = 2,
        min_radius = 0,
        max_radius = 0,
    }).position or origin
    checked(services.variables.set_global("your_spawnpoint", spawn, { include_before = false }))
end)

ccb.runtime.handler("scenario_defense_mode_start", function(payload)
    tasks.after_character_turn(payload.character, 0, "scenario_defense_mode_due")
end)

content.replace(content.Scenario {
    id = "defense_mode_fortified",
    inherits = "defense_mode_fortified",
    on_start = "scenario_defense_mode_start",
})
