local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

content.add(content.ActivityType {
    id = "ACT_CHANGELING_DREAMDROSS_TO_DREAMSPARKS",
    verb = ccb.content.text("extracting dreams"),
    based_on = "time",
    activity_level = 1,
})

content.add(content.ActivityType {
    id = "act_xedra_time_freeze",
    verb = ccb.content.text("frozen in time"),
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
})

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("ierde_vigil_turn", function(activity)
    local character = activity.character
    local needs = checked(services.needs.get(character))
    if needs.sleepiness + needs.sleep_deprivation < 0 then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You are fully refreshed and end your vigil."), "neutral")
        end
        checked(services.activities.cancel(character))
        return
    end
    local sleep_deprivation = needs.sleep_deprivation
    if needs.sleepiness >= 0 and services.random.native_probability(1, 35) then
        local updated = checked(services.needs.set(character, { sleepiness = needs.sleepiness - 1 }))
        sleep_deprivation = updated.after.sleep_deprivation
    end
    if sleep_deprivation >= 0 then
        checked(services.needs.set(character, { sleep_deprivation = sleep_deprivation - 1 }))
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_IERDE_NO_SLEEP_MEDITATE",
    verb = ccb.content.text("watching"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
    rooted = true,
}:on_turn("ierde_vigil_turn"))
