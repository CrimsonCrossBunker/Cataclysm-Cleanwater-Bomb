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

local chronomancer_meditation = "ACT_XEDRA_CHRONOMANCER_MEDITATE"

local function end_chronomancer_meditation(character)
    local id = services.types.id
    checked(services.effects.remove(character, id("effect", "effect_xedra_rewrite_wound_causality")))
    checked(services.effects.remove(character, id("effect", "effect_xedra_rewrite_equipment_causality")))
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You finish your meditations."), "good")
    end
end

ccb.runtime.handler("finish_chronomancer_meditation", function(activity)
    end_chronomancer_meditation(activity.character)
end, 1)

ccb.runtime.handler("cleanup_chronomancer_meditation", function(event)
    local character = event.actors.character
    if character and event.data.activity == chronomancer_meditation then
        end_chronomancer_meditation(character)
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "cleanup_chronomancer_meditation")

content.add(content.ActivityType {
    id = chronomancer_meditation,
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
    rooted = true,
}:on_finish("finish_chronomancer_meditation"))

ccb.runtime.handler("finish_keypad_entry", function(activity)
    local character = activity.character
    -- The original dialogue skill check truncates the effective skill level.
    local deduction = math.modf(checked(services.skills.level(character, "deduction")))
    local unlocked = services.random.native_int(1, 10) + deduction > 12
    if unlocked then
        local position = checked(services.creatures.snapshot(character)).position
        checked(services.world.transform_radius(position, 2,
            services.types.id("terrain_furniture_transform", "unlock_elock")))
    end
    if character.subtype == "avatar" then
        if unlocked then
            ccb.presentation.notice(services.translate("The numpad glows green and emits a happy chirp as the door unlocks."))
        else
            ccb.presentation.notice(services.translate("The numpad flashes while beeping angrily at you."))
        end
        services.activities.offer_interruption("")
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_KEYPAD_ENTRY",
    verb = ccb.content.text("pressing keys"),
    based_on = "speed",
    can_resume = false,
    interruptable = false,
    interruptable_with_keyboard = false,
}:on_finish("finish_keypad_entry"))
