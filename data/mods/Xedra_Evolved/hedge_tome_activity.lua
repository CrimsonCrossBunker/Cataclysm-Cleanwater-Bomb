local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local activity_id = "ACT_XE_DECIPHERING_HEDGE_TOME"
local study_effect = "effect_xe_deciphering_hedge_tome"
local progress_key = "most_recent_hedge_research_progress"
local difficulty_key = "most_recent_hedge_research_difficulty"
local study_time_key = "most_recent_hedge_research_time"

-- The item actions and existing saves store these completion choices.
local deciphered_keys = {
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

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function stop_studying(character)
    checked(services.effects.remove(character, id("effect", study_effect)))
end

local function decipher_tome(character)
    local completion = checked(services.variables.get_string(character, "latest_completion_eoc")).value
    local key = deciphered_keys[completion]
    if not key then
        return
    end
    stop_studying(character)
    if character.subtype == "avatar" then
        ccb.presentation.notice(services.translate(
            "You've done it.  All the pieces finally fall into place.  You've unlocked the occult secrets of this work, and can now study the rituals within."))
        services.activities.offer_interruption("")
    end
    store(character, key, 1)
end

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
                services.messages.add(services.translate("It's too dark to continue studying the occult."), "bad")
            end
        end
    elseif progress > difficulty then
        decipher_tome(character)
    end
end, 1)

ccb.runtime.handler("finish_hedge_tome_study", function(activity)
    local character = activity.character
    if character.subtype == "avatar" then
        services.messages.add(services.translate("You finish your study session."), "neutral")
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
    verb = content.text("deciphering the secrets of the occult"),
    based_on = "time",
    can_resume = false,
    auto_needs = true,
}:on_turn("track_hedge_tome_study"):on_finish("finish_hedge_tome_study"))
