local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local recurring = require("island_timer")
local trait = "mut_skyisland_temperature_adaptation"

local function has_climate_control(character)
    return state.has_trait(character, trait)
end

recurring("sky_island_climate", has_climate_control, function() return 3 end, function(character)
    local omt = state.position(character):project_to("omt")
    if (services.overmap.matches_location(omt, "open_air")
        or services.overmap.matches_location_near(omt, "sky_island_subcore", 1)) and omt.z == 6 then
        local temperature = services.units.new("temperature", 70, "fahrenheit")
        state.checked(services.weather.set_current_temperature(temperature))
    end
end)

ccb.runtime.handler("sky_island_climate_surface", function()
    local character = services.creatures.avatar()
    if has_climate_control(character)
        and services.overmap.matches_location(state.position(character):project_to("omt"), "sky_island_core") then
        state.checked(services.weather.refresh())
    end
end)
ccb.runtime.on("game:avatar_enters_omt", "sky_island_climate_surface")

ccb.content.add(ccb.content.Mutation {
    id = trait,
    name = ccb.content.text("Climate Control"),
    description = ccb.content.text("The climate is controlled for you when you are in the bunker."),
    points = 0,
    valid = false,
    player_display = false,
    purifiable = false,
})
