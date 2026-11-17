local ccb = require("ccb")
local services = ccb.services
local variables = services.variables

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(key, fallback)
    return checked(variables.get_global_number(key)).value or fallback or 0
end

ccb.runtime.handler("portal_storm_cycle", function(character)
    if services.gameplay.environment.dimension() == "default" then
        checked(variables.set_global("saved_portal_storms", number("saved_portal_storms") + 1,
            { include_before = false }))
    elseif number("saved_portal_storms") > 0 then
        ccb.runtime.call_character("portal_storm_begin_early", character)
        checked(variables.set_global("saved_portal_storms", number("saved_portal_storms") - 1,
            { include_before = false }))
    end
end)

ccb.runtime.handler("portal_storm_cycle_interval", function()
    local minimum = math.modf(number("ps_min_woc", 5 * 24 * 3600))
    local maximum = math.modf(number("ps_max_woc", 18 * 24 * 3600))
    return services.random.native_int(minimum, maximum)
end)
