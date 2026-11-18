local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("check_anima_meditation", function(activity)
    local character = activity.character
    local energy = checked(services.bionics.summary(character))
    if not energy.has_capacity or energy.power:compare(energy.maximum_power) ~= 0 then
        return
    end
    checked(services.activities.cancel(character))
    checked(services.effects.remove(character, services.types.id("effect", "effect_pattern_tattoo_meditation")))
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Replete with anima, you cease your meditations."), "good")
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_XEDRAWOOD_MEDITATE",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
}:on_turn("check_anima_meditation"))
