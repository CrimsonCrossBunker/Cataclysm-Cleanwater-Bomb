local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local random = services.random
local tasks = ccb.tasks

local activity_id = "ACT_XE_DECIPHERING_HEDGE_TOME"
local activity_type = id("activity", activity_id)
local study_effect = id("effect", "effect_xe_deciphering_hedge_tome")
local progress_key = "most_recent_hedge_research_progress"
local difficulty_key = "most_recent_hedge_research_difficulty"
local study_time_key = "most_recent_hedge_research_time"
local time_limit_key = "most_recent_hedge_research_time_upper_limit"
local current_tome_key = "latest_studied_occult_text_name"
local completion_key = "hedge_tome_completion_key"
local focus_handler = "hedge_tome_focus_due"

-- A running study activity in an older save stores the completion choice under
-- its old callback name. Newly started activities save the destination key.
local saved_completion_keys = {
    EOC_HEDGE_RESEARCH_PROGRESS_FARM_COMPLETION = "deciphered_spellbook_hedge_farm",
    EOC_HEDGE_RESEARCH_PROGRESS_WARD_DEMONS_COMPLETION = "deciphered_spellbook_hedge_ward_demons",
    EOC_HEDGE_RESEARCH_PROGRESS_DOCTOR_BOOK_COMPLETION = "deciphered_spellbook_hedge_doctor_book",
    EOC_HEDGE_RESEARCH_PROGRESS_BLOOD_BOOK_COMPLETION = "deciphered_spellbook_hedge_blood_book",
    EOC_HEDGE_RESEARCH_PROGRESS_WARD_DREAMS_COMPLETION = "deciphered_spellbook_hedge_ward_dreams",
    EOC_HEDGE_RESEARCH_PROGRESS_SNARE_CHANGELINGS_COMPLETION = "deciphered_spellbook_hedge_snare_changelings",
    EOC_HEDGE_RESEARCH_PROGRESS_BATHHOUSE_AT_MIDNIGHT_COMPLETION = "deciphered_spellbook_hedge_bathhouse_at_midnight",
    EOC_HEDGE_RESEARCH_PROGRESS_ABRAMELIN_THE_MAGE_COMPLETION = "deciphered_spellbook_hedge_abramelin_the_mage",
    EOC_HEDGE_RESEARCH_PROGRESS_PSYCHIC_DEFENSE_COMPLETION = "deciphered_spellbook_hedge_psychic_defense",
    EOC_HEDGE_RESEARCH_PROGRESS_BOOK_OF_RAZIEL_COMPLETION = "deciphered_spellbook_hedge_book_of_raziel",
    EOC_HEDGE_RESEARCH_PROGRESS_AVODAH_ZARAH_COMPLETION = "deciphered_spellbook_hedge_avodah_zarah",
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function number(actor, key)
    return checked(services.variables.get_number(actor, key)).value or 0
end

local function string_value(actor, key)
    return checked(services.variables.get_string(actor, key)).value
end

local function store(actor, key, value)
    checked(services.variables.set(actor, key, value, { include_before = false }))
end

local function studying(character)
    return checked(services.effects.has(character, study_effect))
end

local function stop_studying(character)
    checked(services.effects.remove(character, study_effect))
end

local function notice(character, text)
    if character.subtype == "avatar" then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text)
    end
end

local function decipher_tome(character, key)
    if not key then return end
    stop_studying(character)
    notice(character, ccb.services.translate(
        "You've done it.  All the pieces finally fall into place.  You've unlocked the occult secrets of this work, and can now study the rituals within."
    ))
    store(character, key, 1)
end

local function random_carried_tome(character, item_type)
    local books = checked(services.inventory.items_of_type(character, item_type, true))
    return books[#books]
end

local function lower_focus(character, amount)
    if checked(services.needs.get(character)).focus > 5 then
        checked(services.characters.adjust(character, { focus = -amount }))
    end
end

local function queue_research(character, handler)
    local intelligence = checked(services.characters.snapshot(character, 1)).stats.intelligence
    local factor = math.min((intelligence + 10) / 20, 2)
    local first = math.modf(3000 / factor)
    local last = math.modf(4200 / factor)
    tasks.after_character_turn(character, random.native_int(first, last), handler)
end

local function learn_spells(character, stub)
    checked(services.inventory.receive_item(character, stub, 1))
    local book = random_carried_tome(character, stub)
    if book then
        local position = checked(services.creatures.snapshot(character)).position
        checked(services.items.activate(book, character, "learn_spell", { target = position }))
    end
    checked(services.inventory.remove_type(character, stub))
end

local function register_tome(tome)
    local handler = "study_" .. tome.id
    local timer = "research_" .. tome.id .. "_due"
    local item_type = id("item", tome.id)
    local failure_target = tome.failure_book and id("item", tome.failure_book) or item_type
    local stub = id("item", tome.stub)
    local deciphered = tome.deciphered

    ccb.runtime.handler(handler, function(context)
        local character = context.character
        if not character then return 0 end
        if number(character, deciphered) == 1 then
            learn_spells(character, stub)
            return 0
        end

        store(character, current_tome_key, tome.id)
        store(character, completion_key, tome.activity_completion or deciphered)
        store(character, time_limit_key, tome.time_limit)
        local book = random_carried_tome(character, item_type)
        if book then
            local failed = number(book, "already_failed_research") == 1
            store(character, difficulty_key, failed and tome.retry_difficulty or tome.difficulty)
            store(character, study_time_key, number(book, study_time_key))
            store(character, progress_key, number(book, progress_key))
        end

        local session_length = services.time.duration(8, "hour")
        local assigned = services.activities.assign_timed(character, activity_type, session_length, {
            allow_auto_needs = true,
        })
        if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
            checked(assigned)
        end
        checked(services.effects.add(character, study_effect, session_length))
        queue_research(character, timer)
        queue_research(character, focus_handler)
        return 0
    end, 1)

    ccb.runtime.handler(timer, function(payload)
        local character = payload.character
        if not studying(character) or string_value(character, current_tome_key) ~= tome.id then return end

        if number(character, time_limit_key) > tome.time_limit then
            notice(character, ccb.services.translate(
                "You can't make heads of tails of this work.  You'll have to start over."
            ))
            stop_studying(character)
            local failed = random_carried_tome(character, failure_target)
            if failed then store(failed, "already_failed_research", 1) end
            return
        end

        local progress = number(character, progress_key)
        if progress > number(character, difficulty_key) then
            decipher_tome(character, deciphered)
            return
        end

        local deduction = math.modf(checked(services.skills.level(character, "deduction")))
        local advancement = deduction + random.native_float(-2, 8) + random.native_float(-2, 8)
        progress = progress + advancement
        store(character, progress_key, progress)
        local book = random_carried_tome(character, item_type)
        if book then
            store(book, study_time_key, number(character, study_time_key))
            store(book, progress_key, progress)
        end
        lower_focus(character, 5)
        queue_research(character, timer)
    end, 1)

    return handler
end

ccb.runtime.handler(focus_handler, function(payload)
    local character = payload.character
    if studying(character) then
        lower_focus(character, 1)
        tasks.after_character_turn(character, random.native_int(60, 180), focus_handler)
    end
end, 1)

ccb.runtime.handler("track_hedge_tome_study", function(activity)
    local character = activity.character
    local progress = number(character, progress_key)
    local difficulty = number(character, difficulty_key)
    if progress <= difficulty then
        store(character, study_time_key, number(character, study_time_key) + 1)
        local senses = checked(services.characters.snapshot(character, 1)).senses
        if senses.fine_detail_vision_legacy >= 4
            and not checked(services.characters.has_flag(character, id("json_flag", "READ_IN_DARKNESS"))) then
            checked(services.activities.cancel(character))
            if character.subtype == "avatar" then
                services.messages.add(ccb.services.translate("It's too dark to continue studying the occult."), "bad")
            end
        end
    elseif progress > difficulty then
        local target = string_value(character, completion_key)
        if not target or target == "" then
            target = saved_completion_keys[string_value(character, "latest_completion_eoc")]
        end
        decipher_tome(character, target)
    end
end, 1)

ccb.runtime.handler("finish_hedge_tome_study", function(activity)
    local character = activity.character
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You finish your study session."), "neutral")
    end
    stop_studying(character)
end, 1)

ccb.runtime.handler("cancel_hedge_tome_study", function(event)
    local character = event.actors.character
    if character and event.data.activity == activity_id and event.data.canceled then
        stop_studying(character)
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "cancel_hedge_tome_study")

content.add(content.ActivityType {
    id = activity_id,
    verb = ccb.content.text("deciphering the secrets of the occult"),
    based_on = "time",
    can_resume = false,
    auto_needs = true,
}:on_turn("track_hedge_tome_study"):on_finish("finish_hedge_tome_study"))

return { register_tome = register_tome }
