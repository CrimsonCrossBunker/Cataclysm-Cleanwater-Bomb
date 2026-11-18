local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(key)
    return checked(variables.get_global_number(key)).value or 0
end

ccb.runtime.handler("portal_storm_begin_early", function(character)
    local weather = services.weather.current().weather.value
    if number("portal_storms_allowed") ~= 0 or weather == "portal_storm" or weather == "early_portal_storm"
        or number("cause_portal_storm") == 1 or number("cause_early_portal_storm") == 1 then return end
    local origin = checked(services.creatures.snapshot(character)).position
    local location = services.world.find_location(origin, nil, { min_radius = 30, max_radius = 75 })
    if location.found then checked(variables.set_global("portal_storm_center", location.position, { include_before = false })) end
    ccb.runtime.call_character("portal_storm_finish_early", character)
end)
