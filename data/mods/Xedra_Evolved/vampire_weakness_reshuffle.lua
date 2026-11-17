local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local time = services.time
local random = services.random
local weaknesses = require("vampire_weaknesses")

local activity = "ACT_VAMPIRE_RESHUFFLING_WEAKNESSES"
local task = "vampire_weakness_reshuffle_due"
local tiers = {
    { "VAMPIRE3", 1 },
    { "VAMPIRE4", 1 },
    { "BLOOD_DRINKER", 2 },
    { "VAMPIRE_ANATHEMA", 2 },
    { "THRESH_VAMPIRE_ANATHEMA", 3 },
}

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, kind)
    if character.subtype == "avatar" then
        services.messages.add(text, kind)
    end
end

local function popup(character, text)
    if character.subtype == "avatar" then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
end

local function remove_reshuffle_effect(character)
    value(services.effects.remove(character, id("effect", "effect_vampire_reshuffling_weaknesses")))
end

local function queue_reshuffle(character, minimum, maximum)
    local turns = random.native_int(time.duration(minimum, "minute").turns,
        time.duration(maximum, "minute").turns)
    ccb.tasks.after_character_turn(character, turns, task)
end

local function replace_weaknesses(character)
    popup(character, ccb.services.translate("Your current weaknesses vanish, but are immediately replaced by new ones."))
    weaknesses.clear(character)
    value(services.effects.remove(character, id("effect", "vampire_need_living_blood")))
    value(services.morale.remove(character, id("morale", "morale_vw_no_fun")))

    for _, tier in ipairs(tiers) do
        if value(services.mutations.has_id_text(character, tier[1])) then
            weaknesses.grant(character, tier[2])
        end
    end

    remove_reshuffle_effect(character)
    value(services.effects.add(character, id("effect", "effect_vampire_recently_reshuffled_weaknesses"),
        time.duration(5, "day")))
end

ccb.runtime.handler(task, function(context)
    local character = context.character
    if not value(services.effects.has(character, id("effect", "effect_vampire_reshuffling_weaknesses"))) or
        value(services.effects.has(character, id("effect", "effect_vampire_recently_reshuffled_weaknesses"))) then
        return
    end
    local intelligence = value(services.characters.snapshot(character)).stats.intelligence
    local deduction = value(services.skills.level(character, "deduction"))
    local score = intelligence / 2 + deduction + random.native_int(0, 9) + 1 + random.native_int(0, 9) + 1
    if score >= 17 then
        replace_weaknesses(character)
    elseif score >= 0 then
        queue_reshuffle(character, 90, 150)
    end
end)

ccb.runtime.handler("begin_vampire_weakness_reshuffle", function(craft)
    local character = craft.character
    local blood = id("vitamin", "human_blood_vitamin")
    for _ = 1, craft.batch do
        local amount = value(services.needs.get_vitamin(character, blood))
        if amount >= 3000 then
            value(services.needs.set_vitamin(character, blood, amount - 3000))
            local duration = time.duration(8, "hour")
            value(services.effects.add(character, id("effect", "effect_vampire_reshuffling_weaknesses"), duration))
            value(services.activities.assign_timed(character, id("activity", activity), duration))
            queue_reshuffle(character, 120, 180)
        else
            message(character, ccb.services.translate("You do not have enough blood to try to change your weaknesses."), "bad")
        end
    end
end)

ccb.runtime.handler("vampire_weakness_reshuffle_finished", function(context)
    remove_reshuffle_effect(context.character)
    message(context.character, ccb.services.translate("Your attempts are fruitless.  You'll have to try again."), "neutral")
end)

ccb.runtime.handler("vampire_weakness_reshuffle_stopped", function(event)
    if event.data.activity == activity then
        remove_reshuffle_effect(event.actors.character or services.characters.avatar())
    end
end)
ccb.runtime.on("game:character_finished_activity", "vampire_weakness_reshuffle_stopped")

local reshuffle = ccb.content.ActivityType {
    id = activity,
    verb = ccb.content.text("reshuffling vampiric weaknesses"),
    based_on = "time",
    activity_level = 2,
}
ccb.content.add(reshuffle:on_finish("vampire_weakness_reshuffle_finished"))

local recipe = ccb.content.Recipe {
    id = "xe_vampire_blood_weaknesses_reshuffle",
    name = ccb.content.text("reshuffle vampiric weaknesses"),
    description = ccb.content.text("With the expenditure of a large amount of blood and time, attempt to replace your weaknesses by new ones.  This cannot increase or decrease how many weaknesses you have."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    duration_moves = 3000,
    activity_level = 2,
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
ccb.content.add(recipe:on_complete("begin_vampire_weakness_reshuffle"))
