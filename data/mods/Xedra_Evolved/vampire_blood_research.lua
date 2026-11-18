local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local time = services.time
local random = services.random
local timers = require("character_timers")

local activity = "ACT_VAMPIRE_STUDYING_BLOOD_GIFTS"
local studying = "effect_vampire_studying_blood_gifts"
local cooldown = "effect_vampire_recently_learned_blood_gifts"
local all_gifts_check = "effect_vampire_all_gift_check"
local research_due = "vampire_blood_research_due"
local refinement_due = "vampire_blood_refinement_due"
local passive_trait = "VAMPIRE_GAIN_BLOOD_GIFTS"

local gifts = {
    {
        "EYEGLEAM",
        "BLOOD_FUN",
        "STAMINAFORBLOOD",
        "COMMUNE_NIGHT",
        "VAMPIRIC_STRENGTH",
        "VAMPIRIC_RESILIENCE",
        "VAMPIRE_HEIGHTENED_SENSES",
        "VAMPIRE_SILENT_MOVE",
        "VAMPIRE_HEALTH_BONUS",
        "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    },
    {
        "BLOODHEAL",
        "COAGULANTWEAVE",
        "VAMPIRIC_DODGE",
        "VAMPIRE_FEAR_GAZE",
        "VAMPIRE_WALK_ON_WALLS",
        "VAMPIRE_BEAST_CLAWS",
        "VAMPIRE_SEE_HEAT",
        "VAMPIRIC_STEALTH_BONUS",
        "VAMPIRE_FEIGN_DEATH",
        "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    },
    {
        "BLOODHASTE",
        "MAGICFORBLOOD",
        "HYPNOTIC_GAZE",
        "VAMPIRE_COMMAND_BEAST",
        "VAMPIRE_EARTH_SLUMBER",
        "VAMPIRE_CARDIO_BONUS",
        "VAMPIRE_MOTION_ALARM",
        "VAMPIRE_BONUS_HP",
        "VAMPIRE_RENDING_TEETH",
    },
    {
        "TRUE_VAMPIRE_POWER",
        "VAMPIRE_TORPOR",
        "VAMPIRE_DOMINATE",
        "VAMPIRE_NO_BREATHE",
        "VAMPIRE_NO_ILLNESS",
        "VAMPIRE_BAT_FORM",
        "VAMPIRE_WOLF_FORM",
        "VAMPIRE_MIST_FORM",
        "VAMPIRE_SUMMON_SHADOWS",
    },
    {
        "VAMPIRE_MASTER_MORTAL_MIND",
        "VAMPIRE_DISTILLATE_INNER_BLOOD",
        "VAMPIRE_SHADOW_FORM",
        "VAMPIRE_LAST_BREATH_MIST",
        "VAMPIRE_IRON_MIND",
        "VAMPIRE_BLIND_THE_SUN",
    },
}

-- The passive trait rolls the same gifts in its original order.
local passive_fourth_tier = {
    "TRUE_VAMPIRE_POWER",
    "VAMPIRE_TORPOR",
    "VAMPIRE_DOMINATE",
    "VAMPIRE_NO_BREATHE",
    "VAMPIRE_NO_ILLNESS",
    "VAMPIRE_SUMMON_SHADOWS",
    "VAMPIRE_BAT_FORM",
    "VAMPIRE_WOLF_FORM",
    "VAMPIRE_MIST_FORM",
}
local passive_gifts = {}
for tier, pool in ipairs(gifts) do
    for _, trait in ipairs(tier == 4 and passive_fourth_tier or pool) do
        passive_gifts[#passive_gifts + 1] = trait
    end
end

local refinements = {
    {
        trait = "VAMPIRIC_STRENGTH_REFINEMENT_SMASHING_TILES",
        requires = { "VAMPIRIC_STRENGTH" },
        label = function() return ccb.services.translate("Refine Vigor Mortis: Unholy Destruction") end,
        description = function() return ccb.services.translate("From the strength boost of Vigor Mortis, you can focus that strength against inanimate objects to smash through barriers with incredible force.") end,
        learned = function() return ccb.services.translate("You learned Unholy Devastation, a new use for your Vigor Mortis Blood Art.") end,
    },
    {
        trait = "BLOODHASTE_REFINEMENT_WATER_RUN",
        requires = { "BLOODHASTE" },
        label = function() return ccb.services.translate("Refine Blood-driven Speed: Zephyr") end,
        description = function() return ccb.services.translate("With your Blood-driven Speed, move so quickly that you can even run on water.") end,
        learned = function() return ccb.services.translate("You learned Zephyr, a new use for your Blood-driven Speed Blood Art.") end,
    },
    {
        trait = "VAMPIRIC_RESILIENCE_REFINEMENT_INVINCIBILITY",
        requires = { "VAMPIRIC_RESILIENCE" },
        label = function() return ccb.services.translate("Refine Sanguine Resilience: Flesh of Marble") end,
        description = function() return ccb.services.translate("Improve Sanguine Resilience so the first attack after activating it shatters on your undead flesh.") end,
        learned = function() return ccb.services.translate("You learned Flesh of Marble, a new use for your Sanguine Resilience Blood Art.") end,
    },
    {
        trait = "VAMPIRE_HEIGHTENED_SENSES_REFINEMENT_SEE_INVISIBLE",
        requires = { "VAMPIRE_HEIGHTENED_SENSES", "VAMPIRE_SEE_HEAT" },
        label = function() return ccb.services.translate("Refine Predator's Senses/Crimson Vision: Soulsight") end,
        description = function() return ccb.services.translate("Combine your Predator's Senses with your Crimson Vision and learn to see even invisible creatures.") end,
        learned = function() return ccb.services.translate("You learned Soulsight, a new use for your Predator's Senses and Crimson Vision Blood Arts.") end,
    },
    {
        trait = "VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH",
        requires = { "VAMPIRE_FEIGN_DEATH", "VAMPIRE_TORPOR" },
        label = function() return ccb.services.translate("Refine Corpse's Countenance/Torpor: Corpse's Torpor") end,
        description = function() return ccb.services.translate("Combine your Corpse's Countenance with your Torpor so that you gain some of each's benefits while using the other.") end,
        learned = function() return ccb.services.translate("You learned Corpse's Torpor, a new use for your Corpse's Countenance and Torpor Blood Arts.") end,
    },
    {
        trait = "VAMPIRE_BLOOD_TEMPORARY_BOOST_REFINEMENT_MIND_BOOST",
        requires = { "VAMPIRE_BLOOD_TEMPORARY_BOOST" },
        label = function() return ccb.services.translate("Refine Carmine Vitality: Carmine Clarity") end,
        description = function() return ccb.services.translate("Refine your Carmine Vitality so it increases intelligence and perception as well.") end,
        learned = function() return ccb.services.translate("You learned Carmine Clarity, a new use for your Carmine Vitality Blood Art.") end,
    },
    {
        trait = "VAMPIRE_BAT_FORM_REFINEMENT_SWARM",
        requires = { "VAMPIRE_BAT_FORM" },
        label = function() return ccb.services.translate("Refine Shape of the Night Flier: Shape of the Night Fliers' Swarm") end,
        description = function() return ccb.services.translate("Modify your Shape of the Night Flier to turn in a multitude of bats, making you as durable in this form as you are in your default form.") end,
        learned = function() return ccb.services.translate("You learned Shape of the Night Fliers' Swarm, a new use for your Shape of the Night Flier Blood Art.") end,
    },
    {
        trait = "VAMPIRE_CARDIO_BONUS_REFINEMENT_STAMINAFORBLOOD",
        requires = { "VAMPIRE_CARDIO_BONUS", "STAMINAFORBLOOD" },
        label = function() return ccb.services.translate("Refine Incarnadine Energy/Unholy Endurance: Incarnadine Relentlessness") end,
        description = function() return ccb.services.translate("Expand your Incarnadine Energy so that each use of Unholy Endurance temporarily increases its effect.") end,
        learned = function() return ccb.services.translate("You learned Incarnadine Relentlessness, a new use for your Incarnadine Energy and Unholy Endurance Blood Arts.") end,
    },
    {
        trait = "VAMPIRE_WALK_ON_WALLS_REFINEMENT_LOW_GRAVITY",
        requires = { "VAMPIRE_WALK_ON_WALLS" },
        label = function() return ccb.services.translate("Refine Spider's Walk: Light as a Spider's Thread") end,
        description = function() return ccb.services.translate("Further lessen your gravity, increasing how much you can carry and allowing you to glide down from heights.") end,
        learned = function() return ccb.services.translate("You learned Light as a Spider's Thread, a new use for your Spider's Walk Blood Art.") end,
    },
    {
        trait = "VAMPIRE_EARTH_SLUMBER_REFINEMENT_CREATE_PITS",
        requires = { "VAMPIRE_EARTH_SLUMBER" },
        label = function() return ccb.services.translate("Refine Earthen Slumber: Earthen Grave") end,
        description = function() return ccb.services.translate("Learn to use your Earthen Slumber to instead create large holes for your enemies to fall in them.") end,
        learned = function() return ccb.services.translate("You learned Earthen Grave, a new use for your Earthen Slumber Blood Art.") end,
    },
}

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return value(services.effects.has(character, id("effect", effect)))
end

local function add_effect(character, effect, duration, unit)
    value(services.effects.add(character, id("effect", effect), time.duration(duration, unit)))
end

local function remove_effect(character, effect)
    value(services.effects.remove(character, id("effect", effect)))
end

local function message(character, text, kind)
    if character.subtype ~= "npc" then
        services.messages.add(text, kind)
    end
end

local function grant_missing(character, candidates)
    local ids = {}
    for index, trait in ipairs(candidates) do
        ids[index] = id("mutation", trait)
    end
    return value(services.progression.grant_random_missing(character, "mutation", ids)).granted
end

local function research_succeeded(character)
    if character.subtype ~= "npc" then
        local text = ccb.services.translate("You learn a new blood gift.")
        services.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text, "neutral")
    end
    if has_trait(character, "VAMPIRE_LAST_BREATH_MIST") and not has_trait(character, "VAMPIRE_MIST_FORM") then
        value(services.mutations.erase(character, id("mutation", "VAMPIRE_LAST_BREATH_MIST")))
        value(services.mutations.replace(character, id("mutation", "VAMPIRE_MIST_FORM")))
    end
    remove_effect(character, all_gifts_check)
    remove_effect(character, studying)
    add_effect(character, cooldown, 5, "day")
end

local function eligible_for_roll(character)
    return has_effect(character, studying) and not has_effect(character, cooldown)
end

local function research_score(character)
    local intelligence = value(services.characters.snapshot(character)).stats.intelligence
    local deduction = value(services.skills.level(character, "deduction"))
    return intelligence / 2 + deduction + random.native_int(0, 9) + 1 + random.native_int(0, 9) + 1
end

local function queue_roll(character, handler, minimum, maximum)
    local turns = random.native_int(time.duration(minimum, "minute").turns,
        time.duration(maximum, "minute").turns)
    ccb.tasks.after_character_turn(character, turns, handler)
end

local function research_finished(character)
    local all_gifts_learned = has_effect(character, all_gifts_check)
    remove_effect(character, studying)
    remove_effect(character, all_gifts_check)
    if all_gifts_learned then
        message(character, ccb.services.translate("You possess every single gift of the blood.  Nothing will be gained from further attempts.  However, there may still be further refinements of your existing gifts to discover."), "neutral")
    else
        message(character, ccb.services.translate("Your experiments are fruitless.  You'll have to try again."), "neutral")
    end
end

local function roll_gifts(character, highest_tier)
    for tier = highest_tier, 1, -1 do
        if grant_missing(character, gifts[tier]) then
            research_succeeded(character)
            return
        end
    end
    research_finished(character)
end

ccb.runtime.handler(research_due, function(event)
    local character = event.character
    if not eligible_for_roll(character) then
        return
    end

    -- The native switch uses the highest tier threshold the roll reaches.
    local score = research_score(character)
    if score >= 29 then
        if has_trait(character, "BLOOD_DRINKER") then
            add_effect(character, all_gifts_check, 1, "minute")
            roll_gifts(character, 5)
        else
            roll_gifts(character, 4)
            message(character, ccb.services.translate("Your vampirism isn't potent enough to unlock a gift of this level, so you have to settle for a weaker gift."), "bad")
        end
    elseif score >= 17 then
        roll_gifts(character, 1 + math.floor((score - 17) / 3))
    elseif score >= 0 then
        queue_roll(character, research_due, 90, 150)
    end
end, 1)

ccb.runtime.handler(refinement_due, function(event)
    local character = event.character
    if not eligible_for_roll(character) then
        return
    end
    if research_score(character) <= 26 then
        message(character, ccb.services.translate("Your experiments are fruitless.  You'll have to try again."), "bad")
        return
    end
    local entries = {}
    for index, refinement in ipairs(refinements) do
        local enabled = not has_trait(character, refinement.trait)
        for _, prerequisite in ipairs(refinement.requires) do
            enabled = enabled and has_trait(character, prerequisite)
        end
        entries[index] = {
            id = refinement.trait,
            label = refinement.label(),
            description = refinement.description(),
            enabled = enabled,
        }
    end
    entries[#entries + 1] = {
        id = "nothing",
        label = ccb.services.translate("Nothing"),
        description = ccb.services.translate("End your research."),
    }
    local choice = services.interaction.choose(entries, {
        title = ccb.services.translate("Your research uncovers…"),
        allow_cancel = true,
        highlight_disabled = false,
        show_descriptions = true,
    })
    local refinement = refinements[choice.index]
    if refinement then
        value(services.mutations.replace(character, id("mutation", refinement.trait)))
        message(character, refinement.learned(), "good")
        add_effect(character, cooldown, 12, "day")
    end
end, 1)

local function begin_research(craft, cost, handler, minimum, maximum)
    local character = craft.character
    local blood = id("vitamin", "human_blood_vitamin")
    for _ = 1, craft.batch do
        local available = value(services.needs.get_vitamin(character, blood))
        if available >= cost then
            value(services.needs.set_vitamin(character, blood, available - cost))
            add_effect(character, studying, 8, "hour")
            local assigned = services.activities.assign_timed(character, id("activity", activity),
                time.duration(8, "hour"))
            if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
                value(assigned)
            end
            queue_roll(character, handler, minimum, maximum)
        else
            message(character, ccb.services.translate("You do not have enough blood to experiment with your gifts."), "bad")
        end
    end
end

ccb.runtime.handler("begin_vampire_blood_research", function(craft)
    begin_research(craft, 3000, research_due, 120, 180)
end, 1)

ccb.runtime.handler("begin_vampire_blood_refinement", function(craft)
    begin_research(craft, 4500, refinement_due, 240, 360)
end, 1)

ccb.runtime.handler("finish_vampire_blood_research", function(event)
    research_finished(event.character)
end, 1)

ccb.runtime.handler("stop_vampire_blood_research", function(event)
    if event.data.activity == activity then
        local character = event.actors.character or services.characters.avatar()
        if has_effect(character, studying) then
            remove_effect(character, studying)
        end
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "stop_vampire_blood_research")

timers.register("vampire_blood_gift_timer", "vampire_passive_blood_gift_due",
    function()
        local turns = time.duration(7, "day").turns
        return random.native_int(turns, turns)
    end,
    function(character) return has_trait(character, passive_trait) end,
    function(character)
        if grant_missing(character, passive_gifts) then
            research_succeeded(character)
        end
    end)

content.add(content.ActivityType {
    id = activity,
    verb = ccb.content.text("studying blood gifts"),
    based_on = "time",
    activity_level = 2,
}:on_finish("finish_vampire_blood_research"))

local function register_recipe(recipe_id, name, description, handler)
    content.add(content.Recipe {
        id = recipe_id,
        name = name,
        description = description,
        category = "CC_XEDRA",
        subcategory = "CSC_XEDRA_RESEARCH",
        skill = "deduction",
        difficulty = 0,
        duration_moves = 3000,
        activity_level = 2,
        autolearn = false,
        flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
        scripted_output = true,
    }:on_complete(handler))
end

register_recipe("xe_vampire_blood_gift_research",
    ccb.content.text("research blood gifts"),
    ccb.content.text("With the expenditure of a large amount of blood and time, attempt to develop a new gift of the blood."),
    "begin_vampire_blood_research")

register_recipe("xe_vampire_blood_gift_refinement_research",
    ccb.content.text("research blood gift refinements"),
    ccb.content.text("With the expenditure of a large amount of blood and time, attempt to discover new applications of your existing gifts of the blood."),
    "begin_vampire_blood_refinement")
