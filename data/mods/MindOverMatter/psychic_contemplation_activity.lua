local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local learning_activity = "ACT_PSI_LEARNING_NEW_POWER"
local studying_activity = "ACT_PSI_STUDYING_POWER"
local learning = "effect_psi_learning_new_power"
local studying = "effect_psi_studying_power"
local study_turn = "psychic_contemplation_turn"
local light_exercise = 2

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function add_selected_spell_experience(character)
    local selected = checked(services.variables.get_string(character, "latest_studied_power_name")).value
    if not selected or selected == "" then
        return
    end
    local spell = id("spell", selected)
    if not spell:is_valid() then
        return
    end

    local known = services.spells.get(character, spell)
    if not known.ok and known.error.code == "not_known" then
        -- The native experience read returns -1 for an unknown spell.
        checked(services.spells.set_level(character, spell, 0))
    else
        checked(services.spells.set_experience(character, spell, checked(known).experience + 1))
    end
end

ccb.runtime.handler(study_turn, function(payload)
    local character = payload.character
    if not has_effect(character, studying) then
        return
    end

    local focus = checked(services.needs.get(character)).effective_focus
    local scaling = number(character, "nether_attunement_power_scaling")
    local maintained = checked(services.needs.get_vitamin(character, id("vitamin", "vitamin_maintained_powers")))
    local concentration_factor = 1
    if maintained > 0 then
        local mastered = checked(services.proficiencies.has_id_text(character, "prof_concentration_master"))
        concentration_factor = math.max(0.1, math.min(1, (mastered and 2 or 1) / (1 + maintained)))
    end

    local key = "psi_studying_tick_experience_counter"
    local progress = number(character, key) + focus * 0.004 * scaling * concentration_factor
    checked(services.variables.set(character, key, progress, { include_before = false }))
    if progress >= 1 then
        add_selected_spell_experience(character)
        checked(services.variables.set(character, key, number(character, key) - 1, { include_before = false }))
    end
end, 1)

local function remove_contemplation_effects(character)
    local removed = false
    for _, effect in ipairs({ learning, studying }) do
        if has_effect(character, effect) then
            checked(services.effects.remove(character, id("effect", effect)))
            removed = true
        end
    end
    return removed
end

ccb.runtime.handler("psychic_contemplation_interrupt", function(event)
    remove_contemplation_effects(event.actors.character or services.characters.avatar())
end, 1)
ccb.runtime.on("game:avatar_moves", "psychic_contemplation_interrupt")
ccb.runtime.on("game:spellcasting_finish", "psychic_contemplation_interrupt")

ccb.runtime.handler("psychic_contemplation_finished", function(event)
    if event.data.activity == learning_activity or event.data.activity == studying_activity then
        remove_contemplation_effects(event.actors.character or services.characters.avatar())
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "psychic_contemplation_finished")

ccb.runtime.handler("psychic_contemplation_exhausted", function(event)
    if event.data.effect ~= "weary_7" and event.data.effect ~= "weary_8" then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if remove_contemplation_effects(character) and character.subtype ~= "npc" then
        services.presentation.notice(services.translate(
            "You're so exhausted you can barely think straight, and certainly can't concentrate on studying your powers."
        ))
    end
end, 1)
ccb.runtime.on("game:character_gains_effect", "psychic_contemplation_exhausted")

-- These hidden effects are also read by the existing recipes and delayed learning checks.
content.add(content.EffectType { id = learning, rating = "good" })
content.add(content.EffectType { id = studying, rating = "good" })

content.add(content.ActivityType {
    id = learning_activity,
    verb = content.text("meditating"),
    based_on = "time",
    rooted = true,
    activity_level = light_exercise,
})

content.add(content.ActivityType {
    id = studying_activity,
    verb = content.text("meditating"),
    based_on = "time",
    rooted = true,
    activity_level = light_exercise,
}:on_turn(study_turn))
