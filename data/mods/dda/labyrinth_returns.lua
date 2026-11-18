local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local id = services.types.id

local function can_leave(character)
    return not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "DIMENSIONAL_ANCHOR")))
        and not state.checked(services.characters.snapshot(character, 0)).movement.driving
end

local function travel(character, dimension, variable, success)
    local result = state.checked(services.relocation.travel_to_dimension(dimension,
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    state.message(character, result.accepted and success
        or services.translate("You feel a prickle at the edge of your senses."))
    local point = state.checked(services.variables.get_tripoint(character, variable)).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
    state.checked(services.relocation.teleport_character(character, point, { force = true }))
end

ccb.runtime.handler("labyrinth_home_transport", function(character)
    travel(character, "default", "player_location_home_before_labyrinth",
        services.translate("Your surroundings warp and fold into the recesses of the world you know."))
end)

ccb.runtime.handler("labyrinth_return_home", function(character)
    if not can_leave(character) then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        return
    end
    state.message(character, services.translate("Zworunk."), "neutral", true)
    ccb.runtime.call_character("labyrinth_home_transport", character)
    services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
end)

local function return_elsewhere(character, dimension, variable, announcement)
    if not can_leave(character) then
        state.message(character, services.translate("You feel a prickle at the edge of your senses."))
        return
    end
    state.message(character, announcement, "neutral", true)
    travel(character, dimension, variable,
        services.translate("Your surroundings warp and fold into the recesses of another world."))
    if dimension == "string_dimension" then
        state.checked(services.weather.append_light_event(125,
            services.time.duration(9999, "day"), "string_dimension_lights_on"))
    end
    services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
end

ccb.runtime.handler("labyrinth_return_to_string", function(character)
    return_elsewhere(character, "string_dimension", "player_location_string_dimension_before_labyrinth",
        services.translate("Zworunk."))
end)

ccb.runtime.handler("labyrinth_return_to_scarlet", function(character)
    return_elsewhere(character, "scarlet", "player_location_scarlet_before_labyrinth",
        services.translate("Pop."))
end)
