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

local function intensity(creature, name, body_part)
    local part = body_part and services.types.id("body_part", body_part)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name), part))
end

ccb.runtime.handler("allow_ant_soldier_mega_drag_followup", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and flag(attack.attacker, "GRAB_FILTER")
        and flag(attack.target, "GRAB")
end)

ccb.runtime.handler("allow_ant_soldier_mega_grab_drag", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
        and not flag(attack.attacker, "GRAB_FILTER")
end)

ccb.runtime.handler("monster_attack_intact_mandibles", function(attack)
    return intensity(attack.attacker, "maimed_mandible") == nil
end)
