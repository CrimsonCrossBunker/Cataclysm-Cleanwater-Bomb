local ccb = require("ccb")
local services = ccb.services
local creatures = services.creatures
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function effect_intensity(creature, effect, part)
    return checked(services.effects.exact_intensity(creature, id("effect", effect),
        part and id("body_part", part)))
end

ccb.runtime.handler("allow_fangs_bite_goblin", function(combat)
    return not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
        and not (effect_intensity(combat.attacker, "GRAB") ~= nil)
end)

ccb.runtime.handler("allow_fangs_bite_goblin_grab", function(combat)
    return checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
        and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
end)
