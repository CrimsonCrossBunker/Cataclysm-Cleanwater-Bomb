local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local concentration = require("psychic_concentration")
local training = require("psychic_training")

local learning = "effect_psi_learning_new_power"
local studying = "effect_psi_studying_power"
local selected_spell = "latest_studied_power_name"
local selected_difficulty = "latest_studied_power_difficulty"
local selected_proficiency = "latest_studied_power_proficiency"
local metaphysics_due = "psychic_contemplation_metaphysics"
local focus_due = "psychic_contemplation_focus"
local proficiency_due = "psychic_contemplation_proficiency"
local attunement_due = "psychic_contemplation_attunement"
local learn_due = "psychic_contemplation_learn"
local completion = "complete_psychic_contemplation"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function text(character, key)
    return checked(services.variables.get_string(character, key)).value
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function intensity(character, effect)
    local result = services.effects.get(character, id("effect", effect), id("body_part", "bp_null"))
    if not result.ok and result.error.code == "not_found" then
        return -1
    end
    return checked(result).intensity
end

local function vitamin(character, name)
    return checked(services.needs.get_vitamin(character, id("vitamin", name)))
end

local function message(character, text_value, level)
    if character.subtype ~= "npc" then
        services.messages.add(text_value, level)
    end
end

local function show_contemplation_notice(text_value)
    services.presentation.notice(text_value)
    services.activities.offer_interruption("")
    services.messages.add(text_value, "neutral")
end

local function queue(character, first, last, handler, data)
    local delay = services.random.native_int(math.min(first, last), math.max(first, last))
    ccb.tasks.after_character_turn(character, delay, handler, data)
end

local function set_focus(character, focus)
    checked(services.needs.set(character, { focus = focus }))
end

local function start_contemplating(character, new_power)
    if has_effect(character, "weary_7") or has_effect(character, "weary_8") then
        message(character, services.translate("You are too exhausted to contemplate anything."), "bad")
        return
    end
    if vitamin(character, "vitamin_maintained_powers") > 0 then
        local release = character.subtype ~= "avatar" or services.presentation.confirm(services.translate(
            "Would you like to end concentration on your powers before you begin to meditate?"
        ))
        if release then
            concentration.stop_all(character)
        end
    end

    local function assign(activity, duration)
        local assigned = services.activities.assign_timed(character, id("activity", activity), duration)
        if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
            checked(assigned)
        end
    end
    local function leave_crystal_dust()
        if number(character, selected_difficulty) > 3 then
            checked(services.inventory.receive_item(character, id("item", "matrix_crystal_drained_dust"), 1))
        end
    end

    if new_power then
        message(character, services.translate("You attempt to unlock new capabilities within your mind."))
        local duration = services.time.duration(16, "hour")
        leave_crystal_dust()
        assign("ACT_PSI_LEARNING_NEW_POWER", duration)
        checked(services.effects.add(character, id("effect", learning), duration))
    else
        message(character, services.translate("You spend some time meditating and contemplating your powers."), "good")
        store(character, "psi_studying_tick_experience_counter", 0)
        local duration = services.time.duration(24, "hour")
        checked(services.effects.add(character, id("effect", studying), duration))
        assign("ACT_PSI_STUDYING_POWER", duration)
        leave_crystal_dust()
        queue(character, 30, 300, metaphysics_due)
    end
end

ccb.runtime.handler(metaphysics_due, function(payload)
    local character = payload.character
    if not has_effect(character, studying) then
        return
    end
    local difficulty = number(character, selected_difficulty)
    if difficulty > checked(services.skills.level(character, "metaphysics")) then
        local skill = id("skill", "metaphysics")
        local prior = checked(services.skills.get(character, skill)).practical_exercise_raw
        local speed = services.gameplay.options.get_number("SKILL_TRAINING_SPEED")
        local exercise = math.modf(prior + 35 * difficulty * speed)
        checked(services.skills.set(character, skill, { exercise_raw = exercise }))
        queue(character, 30, 300, metaphysics_due)
    end
end, 1)

ccb.runtime.handler(focus_due, function(payload)
    local character = payload.character
    if has_effect(character, studying) then
        local focus = checked(services.needs.get(character)).focus
        if focus >= 25 then
            set_focus(character, focus - services.random.native_int(0, 1))
        end
        queue(character, 60, 60, focus_due)
    end
end, 1)

ccb.runtime.handler(proficiency_due, function(payload)
    local character = payload.character
    if not has_effect(character, studying) then
        return
    end
    local selected = id("proficiency", text(character, selected_proficiency))
    local state = checked(services.proficiencies.get(character, selected))
    local total = services.proficiencies.definition(selected).time_to_learn
    local practiced = state.practiced.turns
    local percent = practiced * 100 / total.turns + services.random.native_int(0, 4) / 66
    local target = math.modf((total * percent).turns / 100)
    local added = target - practiced
    if added > 0 then
        checked(services.proficiencies.practice(character, selected, services.time.duration(added, "turn")))
    end
    queue(character, 60, 60, proficiency_due)
end, 1)

ccb.runtime.handler(attunement_due, function(payload)
    local character = payload.character
    if has_effect(character, studying) then
        training.add_attunement(character, services.random.native_int(0, 2))
        local kcal = 1.2 * number(character, selected_difficulty) * services.random.native_float(0.3, 1.7)
            * number(character, "nether_attunement_power_scaling")
        if intensity(character, "effect_nether_attunement_extra_kcal") > 0 then
            kcal = kcal * 3
        end
        checked(services.needs.modify_calories(character, math.modf(-kcal), false))
        queue(character, 180, 180, attunement_due)
    end
end, 1)

local function can_learn_power(character)
    if not has_effect(character, learning) then
        return false
    end
    for _, effect in ipairs { "sleep", "effect_vitakin_wakeful_resting", "lack_sleep", "sleep_deprived", "under_operation" } do
        if has_effect(character, effect) then
            return false
        end
    end
    return not checked(services.mutations.has_id_text(character, "CANNOT_GAIN_PSIONICS"))
end

local function roll_learning(character, difficulty)
    local skill = checked(services.skills.level(character, "metaphysics"))
    local intelligence = checked(services.characters.snapshot(character, 1)).stats.intelligence
    local proficiency = text(character, selected_proficiency)
    local roll = math.max(services.random.native_int(math.min(0, skill), math.max(0, skill)), skill / 2)
        + services.random.native_int(0, math.floor(intelligence / 2 + 0.5))
        + (checked(services.proficiencies.has_id_text(character, proficiency)) and 5 or 0)
        + services.random.native_float(-2, 8) + services.random.native_float(-2, 8)
    local drain = intensity(character, "effect_disease_psionic_drain")
    roll = roll + (drain > 5 and 1 or 0) + (drain > 10 and 1 or 0)
        + (intensity(character, "psi_nether_attention") > 0 and 2 or 0)
    local maintained_modifier = math.max(0, math.min(10, vitamin(character, "vitamin_maintained_powers") * 2 - 1))
    local target = difficulty * 1.5 + 7 + maintained_modifier + math.max(0, -concentration.limit(character))
    return roll >= target
end

ccb.runtime.handler(learn_due, function(payload)
    local character = payload.character
    local spell = payload.data.spell
    if spell ~= text(character, selected_spell) or not can_learn_power(character) then
        return
    end
    local difficulty = number(character, selected_difficulty)
    local spell_id = id("spell", spell)
    if roll_learning(character, difficulty) then
        if character.subtype ~= "npc" then
            local name = services.spells.definition(spell_id).name
            local debug_text = services.translate(
                "You are studying <spell_name:<u_val:latest_studied_power_name>> whose ID is <u_val:latest_studied_power_name> with Difficulty <u_val:latest_studied_power_difficulty> and requires the <u_val:latest_studied_power_proficiency> proficiency"
            ):gsub("<spell_name:<u_val:latest_studied_power_name>>", function() return name end)
                :gsub("<u_val:latest_studied_power_name>", spell)
                :gsub("<u_val:latest_studied_power_difficulty>", tostring(difficulty))
                :gsub("<u_val:latest_studied_power_proficiency>", text(character, selected_proficiency))
            message(character, debug_text, "debug")
            local unlock_text = services.translate(
                "As you meditate, all the pieces suddenly come together.  You've unlocked: <spell_name:<u_val:latest_studied_power_name>>."
            ):gsub("<spell_name:<u_val:latest_studied_power_name>>", function() return name end)
            show_contemplation_notice(unlock_text)
        end
        checked(services.spells.set_level(character, spell_id, 1))
        if spell == "teleport_loci_establishment" then
            checked(services.spells.set_level(character, id("spell", "teleport_loci_technique"), 1))
            checked(services.recipes.learn(character, id("recipe", "practice_teleport_loci_technique")))
        end
    elseif character.subtype ~= "npc" then
        show_contemplation_notice(services.translate(
            "You just couldn't manage to grasp the technique.  You'll have to try again."
        ))
    end
    training.add_attunement(character, services.random.native_float(difficulty * 10, difficulty * 20))
    checked(services.effects.remove(character, id("effect", learning)))
    checked(services.activities.cancel(character))
end, 1)

local contemplations = {}
ccb.runtime.handler(completion, function(payload)
    local character = payload.character
    local recipe = contemplations[payload.recipe_id]
    for _ = 1, payload.batch do
        if (not recipe.trait or checked(services.mutations.has_id_text(character, recipe.trait)))
            and (not recipe.require_known or checked(services.spells.effective_level(character, recipe.spell)) >= 1) then
            store(character, selected_spell, recipe.spell)
            store(character, selected_proficiency, recipe.proficiency)
            local difficulty = recipe.difficulty or checked(services.spells.difficulty(character, id("spell", recipe.spell)))
            store(character, selected_difficulty, difficulty)
            if recipe.learning == "study" or checked(services.spells.effective_level(character, recipe.spell)) >= 1 then
                start_contemplating(character, false)
                queue(character, 60, 60, focus_due)
                queue(character, 60, 60, proficiency_due)
                queue(character, 180, 180, attunement_due)
            elseif recipe.learning == "discover" then
                start_contemplating(character, true)
                training.spend_focus(character)
                local horizon = (number(character, selected_difficulty) + 2) * 60 * 60
                local earliest = math.modf(horizon * 0.8)
                local latest = math.modf(horizon * 1.2)
                queue(character, earliest, latest, learn_due, { spell = recipe.spell })
            end
        end
    end
end, 1)

local function register(options)
    contemplations[options.id] = {
        spell = options.spell,
        trait = options.trait,
        proficiency = options.proficiency,
        difficulty = options.difficulty,
        learning = options.learning,
        require_known = options.require_known,
    }
    local recipe = content.Recipe {
        id = options.id,
        name = options.name,
        description = options.description,
        category = options.category or "CC_*",
        subcategory = options.subcategory or "CSC_*_NESTED",
        skill = "metaphysics",
        difficulty = options.crafting_difficulty or 0,
        duration_moves = 0,
        activity_level = 2,
        autolearn = false,
        flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
        scripted_output = true,
    }
    if options.tools then
        recipe:tool_any(options.tools)
    end
    if options.component then
        recipe:component(options.component, 1)
    end
    recipe:proficiency(options.proficiency, { required = false })
    content.add(recipe:on_complete(completion))
end

return register
