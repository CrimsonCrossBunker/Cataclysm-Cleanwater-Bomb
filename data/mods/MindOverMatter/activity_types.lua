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

local trance_activities = {
    ACT_BIOKIN_VITAMINOSIS_MEDITATE = {
        effect = "effect_biokin_vitaminosis",
        message = function()
            return ccb.services.translate("You exit your trance and feel somehow fuller.")
        end,
    },
    ACT_VITAKIN_HEALING_TRANCE_MEDITATE = {
        effect = "effect_vitakin_healing_trance",
        message = function()
            return ccb.services.translate("You exit your trance and your wounds feel less painful")
        end,
    },
}

local function end_trance(character, trance)
    checked(services.effects.remove(character, services.types.id("effect", trance.effect)))
    if character.subtype == "avatar" then
        services.messages.add(trance.message(), "good")
    end
end

ccb.runtime.handler("finish_psionic_trance", function(activity)
    end_trance(activity.character, trance_activities[activity.activity_type_id])
end, 1)

ccb.runtime.handler("cleanup_psionic_trance", function(event)
    local character = event.actors.character
    local trance = trance_activities[event.data.activity]
    if character and trance and checked(services.effects.has(character, services.types.id("effect", trance.effect))) then
        end_trance(character, trance)
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "cleanup_psionic_trance")

for _, activity_id in ipairs({ "ACT_BIOKIN_VITAMINOSIS_MEDITATE", "ACT_VITAKIN_HEALING_TRANCE_MEDITATE" }) do
    content.add(content.ActivityType {
        id = activity_id,
        verb = ccb.content.text("meditating"),
        based_on = "time",
        activity_level = 1,
        can_resume = false,
        rooted = true,
    }:on_finish("finish_psionic_trance"))
end

local sterilization_activity = "ACT_PSI_PHOTOKIN_RADIATION_STERILIZATION"

ccb.runtime.handler("finish_photokinetic_sterilization", function(activity)
    local character = activity.character
    local id = services.types.id
    if not checked(services.effects.has(character, id("effect", "effect_photokin_sterilization"))) then
        return
    end
    local pending = id("json_flag", "PHOTOKIN_IRRADIATION_READY")
    local finished = id("json_flag", "IRRADIATED")
    for _, item in ipairs(checked(services.inventory.items_with_flag(character, pending))) do
        if item:is_valid() then
            checked(services.items.set_flag(item, pending, false))
            checked(services.items.set_flag(item, finished, true))
            local state = checked(services.items.snapshot(item, 0))
            if state.goes_bad and state.relative_rot >= 0 then
                checked(services.items.update(item, { relative_rot = state.relative_rot * 0.25 }))
            end
        end
    end
end, 1)

ccb.runtime.handler("cleanup_photokinetic_sterilization", function(event)
    local character = event.actors.character
    if character and event.data.activity == sterilization_activity then
        checked(services.effects.remove(character, services.types.id("effect", "effect_photokin_sterilization")))
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "cleanup_photokinetic_sterilization")

content.add(content.ActivityType {
    id = sterilization_activity,
    verb = ccb.content.text("sterilizing"),
    based_on = "time",
    activity_level = 2,
    can_resume = false,
}:on_finish("finish_photokinetic_sterilization"))
