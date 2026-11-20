local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function flag(creature, name)
    return checked(services.creatures.has_flag_text(creature, name))
end

ccb.runtime.handler("allow_while_grabbing", function(attack)
    return flag(attack.attacker, "GRAB_FILTER")
end)
