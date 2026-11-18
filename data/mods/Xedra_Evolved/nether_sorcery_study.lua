local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local activity = "ACT_STUDY_NETHER_SORCERY"
local start = "start_nether_sorcery_study"
local check_vision = "check_nether_sorcery_study_vision"
local finish = "finish_nether_sorcery_study"
local sorcery = "XE_NETHER_SORCERY"
local studied_before = "xe_studied_opening_of_the_way_before"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, severity)
    if character.subtype ~= "npc" then
        services.messages.add(text, severity)
    end
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function whole_body_effect(character, effect)
    local result = services.effects.get(character, id("effect", effect), id("body_part", "bp_null"))
    if not result.ok and result.error.code == "not_found" then
        return nil
    end
    return checked(result)
end

local function effective_deduction(character)
    return checked(services.skills.level(character, "deduction"))
end

local function understands_sorcery(character)
    local taint = whole_body_effect(character, "taint")
    if taint and taint.intensity >= 1 then
        return true
    end
    local attention = whole_body_effect(character, "attention")
    if attention and attention.duration.turns >= 1 then
        return true
    end
    local resonance = checked(services.characters.snapshot(character, 1)).combat.artifact_resonance
    if resonance >= 5000
        or has_effect(character, "visuals")
        or has_effect(character, "hallu")
        or has_effect(character, "relative_physics") then
        return true
    end
    local creativity = whole_body_effect(character, "creativity")
    return (creativity and creativity.intensity >= 3)
        or checked(services.needs.get_vitamin(character, id("vitamin", "xedra_knowing_lies"))) >= 1
        or effective_deduction(character) >= 9
end

ccb.runtime.handler(start, function(payload)
    local character = payload.character
    for _ = 1, payload.batch do
        if checked(services.mutations.has_id_text(character, sorcery)) then
            message(character, services.translate("You've already discerned everything you need here."), "mixed")
        else
            message(character, services.translate("You attempt to discern the meaning of the strange text."), "mixed")
            local assigned = services.activities.assign_timed(character, id("activity", activity),
                services.time.duration(9, "hour"))
            if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
                checked(assigned)
            end
        end
    end
end, 1)

ccb.runtime.handler(check_vision, function(payload)
    local character = payload.character
    local senses = checked(services.characters.snapshot(character, 1)).senses
    if senses.fine_detail_vision_legacy >= 4
        and not checked(services.characters.has_flag(character, id("json_flag", "READ_IN_DARKNESS"))) then
        checked(services.activities.cancel(character))
        message(character, services.translate("It's too dark to continue studying the occult."), "bad")
    end
end, 1)

ccb.runtime.handler(finish, function(payload)
    local character = payload.character
    if understands_sorcery(character) then
        local understood_by_deduction = effective_deduction(character) >= 9
        if understood_by_deduction then
            message(character, services.translate(
                "Nothing in this book makes any sense.  It talks in circles, goes on tangents, and abruptly ends thoughts midsentence…but you can see through the words to meaning hidden behind them.  You know enough about the way the universe really works that you can finish the author's thoughts when they don't bother to.  There is true power hidden in this book, and your studies have enabled you to reach out and grasp it."
            ), "good")
        else
            message(character, services.translate(
                "Others would call the author of this book mad, but they are fools.  They cannot see as you can see, hear as you can hear, feel as you can feel.  The twists and paths are laid plain before you, and you swim through the words like water and reach the whirlpool at the center.  The Opening of the Way, it is called, and the way opens before you."
            ), "good")
        end
        checked(services.mutations.erase(character, id("mutation", "XE_NO_NETHER_SORCERY")))
        checked(services.mutations.replace(character, id("mutation", sorcery)))
        if not understood_by_deduction and has_effect(character, "creativity") then
            checked(services.needs.set_vitamin(character, id("vitamin", "creative_spark"), 0))
        end
    elseif checked(services.variables.get_string(character, studied_before)).value == "yes" then
        message(character, services.translate(
            "No matter how many times you study the book, you can't seem to figure out its secrets.  You're starting to wonder if it even has any, or if it was written as a sick joke by someone who should have been in an asylum."
        ), "bad")
    else
        -- The native variable write draws even when there is one possible value.
        services.random.native_int(0, 0)
        checked(services.variables.set(character, studied_before, "yes", { include_before = false }))
        services.native_events.emit("u_var_changed", { studied_before, "yes" })
        message(character, services.translate(
            "Nothing in this book makes any sense.  It talks in circles, goes on tangents, and abruptly ends thoughts midsentence.  You can't get anything useful out of it.  You'd have to be mad to understand it."
        ), "bad")
    end
end, 1)

content.add(content.ActivityType {
    id = activity,
    verb = content.text("studying the text"),
    based_on = "time",
    can_resume = false,
    activity_level = 1,
}:on_turn(check_vision):on_finish(finish))

content.add(content.Recipe {
    id = "xe_learn_nether_sorcery_book",
    name = content.text("study On the Opening of the Way"),
    description = content.text("Study On the Opening of the Way and see what you can learn from the text."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    skill = "deduction",
    difficulty = 5,
    duration_moves = 0,
    activity_level = 2,
    autolearn = false,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:book("book_nether_sorcery_opening_of_the_way", 5)
    :tool("book_nether_sorcery_opening_of_the_way", 1)
    :on_complete(start))
