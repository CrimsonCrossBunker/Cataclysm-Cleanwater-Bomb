local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("find_ocelopilli_trooper", function(hit)
    if not hit.creature then return true end
    local result = services.achievements.complete(services.types.id("achievement", "mom_find_dead_fifth_sun_ocelopilli_trooper"))
    if not result.ok then error(result.error.message) end
    return false
end)
