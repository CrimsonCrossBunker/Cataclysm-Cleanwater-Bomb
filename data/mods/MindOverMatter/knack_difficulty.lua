local ccb = require("ccb")
local services = ccb.services

for _, power in ipairs(require("knack_powers")) do
    ccb.runtime.handler(power .. "_knack_difficulty", function(context)
        local actor = context.speaker
        if actor == nil or (actor.subtype ~= "avatar" and actor.subtype ~= "npc" and actor.subtype ~= "character") then
            return 1
        end
        local difficulty = services.spells.difficulty(actor, services.types.id("spell", power))
        if not difficulty.ok then
            error(difficulty.error.message)
        end
        return math.ceil(math.max(difficulty.value / 2, 1))
    end)
end
