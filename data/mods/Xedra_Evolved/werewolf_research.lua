local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local threshold_key = "werewolf_xp_threshold"
local increase_key = "werewolf_xp_threshold_updater"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function under_moonlight(character)
    return services.gameplay.environment.is_night()
        and checked(services.creatures.snapshot(character)).outside
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

ccb.runtime.handler("check_moon_gift_research", function(activity)
    local character = activity.character
    if under_moonlight(character) then
        return
    end
    if character.subtype == "avatar" then
        services.messages.add(services.translate("You can only learn a new Gift of the Moon under the moon's light."),
            "mixed")
    end
    checked(services.activities.cancel(character))
end, 1)

ccb.runtime.handler("finish_moon_gift_research", function(activity)
    local character = activity.character
    if not under_moonlight(character) then
        return
    end
    local trait = checked(services.variables.get_string(character, "xe_werewolf_power_to_gain")).value
    checked(services.mutations.replace(character, id("mutation", trait)))
    local increase = number(character, increase_key)
    store(character, threshold_key, number(character, threshold_key) + increase)
    store(character, increase_key, increase + 25)
    checked(services.effects.remove(character, id("effect", "effect_werewolf_gain_more_powers")))
    if character.subtype == "avatar" then
        services.messages.add(services.translate("You learned a new Gift of the Moon."), "good")
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_WEREWOLF_LEARNING_MOON_GIFT",
    verb = content.text("learning a new gift"),
    based_on = "time",
    can_resume = false,
}:on_turn("check_moon_gift_research"):on_finish("finish_moon_gift_research"))
