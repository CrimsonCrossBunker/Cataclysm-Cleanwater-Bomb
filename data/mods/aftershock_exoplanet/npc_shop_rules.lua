local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function from_earth(context)
    return checked(services.mutations.has_id_text(context.customer, "BKGR_EARTH"))
end

ccb.runtime.handler("augustmoon_armament_license", function(context)
    return checked(services.proficiencies.has_id_text(context.customer, "prof_armament_license"))
end)

ccb.runtime.handler("uica_earth_customer", from_earth)
ccb.runtime.handler("uica_other_customer", function(context)
    return not from_earth(context)
end)
