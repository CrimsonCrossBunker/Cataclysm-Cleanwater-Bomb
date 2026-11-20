local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function intensity(creature, name)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name)))
end

ccb.runtime.handler("allow_armed_strike", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)
