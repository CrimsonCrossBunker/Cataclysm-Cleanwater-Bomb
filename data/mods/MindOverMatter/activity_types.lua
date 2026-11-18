local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

content.add(content.ActivityType {
    id = "ACT_VITAKIN_BANISH_FOLLOWER_ILLNESS",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 2,
    interruptable = false,
})

content.add(content.ActivityType {
    id = "ACT_PSI_TELEPORTER_ATTUNING",
    verb = ccb.content.text("attuning to area"),
    based_on = "time",
    activity_level = 2,
    rooted = true,
})

content.add(content.ActivityType {
    id = "ACT_CRYSTAL_AWAKENING_MEDITATION",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 2,
    interruptable = false,
    interruptable_with_keyboard = false,
})

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("wakeful_rest_turn", function(activity)
    local character = activity.character
    local needs = checked(services.needs.get(character))
    if needs.sleepiness + needs.sleep_deprivation < 0 then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You are fully refreshed, and end your meditations."), "good")
        end
        checked(services.activities.cancel(character))
        checked(services.effects.remove(character, services.types.id("effect", "effect_vitakin_wakeful_resting")))
        return
    end
    local sleep_deprivation = needs.sleep_deprivation
    if needs.sleepiness >= 0 then
        local level = checked(services.spells.effective_level(character, "vita_sleeping_trance"))
        local skill = checked(services.skills.level(character, "metaphysics"))
        if services.random.native_probability(1, math.max(55 - level * 2 - skill, 15)) then
            local updated = checked(services.needs.set(character, { sleepiness = needs.sleepiness - 1 }))
            sleep_deprivation = updated.after.sleep_deprivation
        end
    end
    if sleep_deprivation >= 0 then
        checked(services.needs.set(character, { sleep_deprivation = sleep_deprivation - 1 }))
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_VITAKIN_WAKEFUL_REST_MEDITATE",
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 0.85,
    can_resume = false,
    rooted = true,
}:on_turn("wakeful_rest_turn"))
