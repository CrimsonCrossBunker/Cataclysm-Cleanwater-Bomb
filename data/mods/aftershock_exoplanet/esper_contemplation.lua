local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local activity = "ACT_AFS_ESPER_STUDYING_POWER"
local studying = "effect_afs_esper_studying_power"
local selected_power = "latest_studied_power_name"
local selected_difficulty = "latest_studied_power_difficulty"
local experience_counter = "afs_esper_studying_tick_experience_counter"

local metaphysics_due = "esper_metaphysics_due"
local focus_due = "esper_study_focus_due"
local study_duration_hours = 24
local LIGHT_EXERCISE = 2

local exhaustion = {
    weary_5 = true,
    weary_6 = true,
    weary_7 = true,
    weary_8 = true,
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function read_number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function has_trait(character, trait)
    return checked(services.mutations.has(character, id("mutation", trait)))
end

local function can_advance(character)
    return has_trait(character, "ESPER_ADVANCEMENT_OKAY") or has_trait(character, "ESPER_STARTER_ADVANCEMENT_OKAY")
end

local function exhausted(character)
    for effect in pairs(exhaustion) do
        if has_effect(character, effect) then
            return true
        end
    end
    return false
end

local function add_power_experience(character)
    local power = checked(services.variables.get_string(character, selected_power)).value
    if not power or power == "" then
        return
    end
    local spell = id("spell", power)
    if not spell:is_valid() then
        return
    end
    local known = services.spells.get(character, spell)
    if not known.ok and known.error.code == "not_known" then
        -- The original spell experience counter starts at -1 for an unknown spell.
        checked(services.spells.set_level(character, spell, 0))
    else
        checked(services.spells.set_experience(character, spell, checked(known).experience + 1))
    end
end

ccb.runtime.handler("esper_study_turn", function(payload)
    local character = payload.character
    if not has_effect(character, studying) or not can_advance(character) then
        return
    end
    local focus = checked(services.needs.get(character)).focus
    local counter = read_number(character, experience_counter) + focus * 18
    store(character, experience_counter, counter)
    if counter >= 1 then
        add_power_experience(character)
        store(character, experience_counter, read_number(character, experience_counter) - 1)
    end
end, 1)

local function queue_metaphysics(character)
    ccb.tasks.after_character_turn(character, services.random.native_int(30, 300), metaphysics_due)
end

ccb.runtime.handler(metaphysics_due, function(payload)
    local character = payload.character
    if not has_effect(character, studying) then
        return
    end
    local difficulty = read_number(character, selected_difficulty)
    if difficulty > checked(services.skills.level(character, "metaphysics")) then
        local skill = id("skill", "metaphysics")
        local prior = checked(services.skills.get(character, skill)).practical_exercise_raw
        local speed = services.gameplay.options.get_number("SKILL_TRAINING_SPEED")
        local exercise = math.modf(prior + 35 * difficulty * speed)
        checked(services.skills.set(character, skill, { exercise_raw = exercise }))
        queue_metaphysics(character)
    end
end, 1)

local function queue_focus(character)
    -- The original equal-endpoint duration range still draws from the game RNG.
    ccb.tasks.after_character_turn(character, services.random.native_int(60, 60), focus_due)
end

ccb.runtime.handler(focus_due, function(payload)
    local character = payload.character
    if not has_effect(character, studying) then
        return
    end
    local focus = checked(services.needs.get(character)).focus
    if focus >= 25 then
        checked(services.needs.set(character, { focus = focus - services.random.native_int(0, 1) }))
    end
    queue_focus(character)
end, 1)

local function start_studying(character)
    local player = character.subtype ~= "npc"
    if exhausted(character) then
        if player then
            services.messages.add(services.translate("You are too exhausted to develop your powers."), "bad")
        end
        return
    end
    if player then
        if can_advance(character) then
            services.messages.add(services.translate("You spend some time meditating and developing your powers."), "good")
        else
            services.messages.add(services.translate("You spend some time meditating but something seems missing."), "good")
        end
    end
    store(character, experience_counter, 0)
    local duration = services.time.duration(study_duration_hours, "hour")
    checked(services.effects.add(character, id("effect", studying), duration))
    local assigned = services.activities.assign_timed(character, id("activity", activity), duration)
    if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
        checked(assigned)
    end
    queue_metaphysics(character)
end

ccb.runtime.handler("esper_study_finished", function(event)
    if event.data.activity ~= activity then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if has_effect(character, studying) then
        checked(services.effects.remove(character, id("effect", studying)))
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "esper_study_finished")

ccb.runtime.handler("esper_study_exhausted", function(event)
    if not exhaustion[event.data.effect] then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if has_effect(character, studying) then
        checked(services.effects.remove(character, id("effect", studying)))
        if character.subtype ~= "npc" then
            services.presentation.notice(services.translate(
                "You're so exhausted you can barely think straight, and certainly can't concentrate on studying your powers."
            ))
        end
    end
end, 1)
ccb.runtime.on("game:character_gains_effect", "esper_study_exhausted")

content.add(content.EffectType {
    id = studying,
    rating = "good",
})

content.add(content.ActivityType {
    id = activity,
    verb = content.text("meditating"),
    based_on = "time",
    rooted = true,
    activity_level = LIGHT_EXERCISE,
}:on_turn("esper_study_turn"))

local completion = "esper_contemplate_power"
local recipes = {}

ccb.runtime.handler(completion, function(payload)
    local character = payload.character
    local power = recipes[payload.recipe_id]
    for _ = 1, payload.batch do
        if has_trait(character, power.trait) then
            store(character, selected_power, power.spell)
            local difficulty = power.difficulty
            if difficulty == nil then
                difficulty = checked(services.spells.difficulty(character, id("spell", power.spell)))
            end
            store(character, selected_difficulty, difficulty)
            start_studying(character)
            queue_focus(character)
        end
    end
end, 1)

local function register_contemplation(trait, powers)
    for _, power in ipairs(powers) do
        local recipe_id, name, description, spell, minutes, difficulty = table.unpack(power)
        recipes[recipe_id] = { trait = trait, spell = spell, difficulty = difficulty }
        content.add(content.Recipe {
            id = recipe_id,
            name = name,
            description = description,
            category = "CC_*",
            subcategory = "CSC_*_NESTED",
            skill = "metaphysics",
            difficulty = 0,
            duration_moves = minutes * 60 * 100,
            activity_level = LIGHT_EXERCISE,
            autolearn = false,
            flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
            scripted_output = true,
        }:on_complete(completion))
    end
end

register_contemplation("AFS_ELECTROKINETIC", {
    {
        "practice_afs_electrokinetic_see_electric",
        content.text("contemplation: spark sight"),
        content.text("Contemplate your powers and improve your ability to detect electrical creatures or robots."),
        "afs_electrokinetic_see_electric", 0, 2,
    },
    {
        "practice_afs_electrokinetic_shock_touch",
        content.text("contemplation: static touch"),
        content.text("Contemplate your powers and improve your ability to build up a charge in your hand and unleash it."),
        "afs_electrokinetic_shock_touch", 0, 2,
    },
    {
        "practice_afs_electrokinetic_zap_enemies",
        content.text("contemplation: electrical discharge"),
        content.text("Contemplate your powers and improve your ability to electrocute those who attack you in melee."),
        "afs_electrokinetic_zap_enemies", 0, 3,
    },
    {
        "practice_afs_electrokinetic_hacking_interface",
        content.text("contemplation: hacking interface"),
        content.text("Contemplate your powers and improve your ability to psychically hack nearby devices."),
        "afs_electrokinetic_hacking_interface", 0, 4,
    },
    {
        "practice_afs_electrokinetic_personal_battery",
        content.text("contemplation: electron overflow"),
        content.text("Contemplate your powers and improve your ability to psychically fuel personal electronic devices."),
        "afs_electrokinetic_personal_battery", 0, 5,
    },
    {
        "practice_afs_electrokinetic_recharge_vehicle",
        content.text("contemplation: re-energize"),
        content.text("Contemplate your powers and improve your ability to recharge large-scale batteries or connected power grids."),
        "afs_electrokinetic_recharge_vehicle", 0, 8,
    },
})

register_contemplation("AFS_PRECOG", {
    {
        "practice_afs_precog_danger_sense",
        content.text("contemplation: premonition"),
        content.text("Contemplate your powers and improve your sense of nearby danger."),
        "afs_precog_danger_sense", 0,
    },
    {
        "practice_afs_precog_damage_foresee",
        content.text("contemplation: forewarning"),
        content.text("Contemplate your powers and improve your sense of nearby danger."),
        "afs_precog_damage_foresee", 0,
    },
    {
        "practice_afs_precog_ranged_enhance",
        content.text("contemplation: marksman's eye"),
        content.text("Contemplate your powers and improve your ability to aim ranged weapons with precision."),
        "afs_precog_ranged_enhance", 0,
    },
    {
        "practice_afs_precog_craft_bonus",
        content.text("contemplation: intuitive artisan"),
        content.text("Contemplate your powers and improve your ability to search through the future to determine exactly how you should build that thing you're working on."),
        "afs_precog_craft_bonus", 0,
    },
    {
        "practice_afs_precog_dodge_bonus",
        content.text("contemplation: prescient evasion"),
        content.text("Contemplate your powers and improve your ability to evade the blows and shots of your enemies."),
        "afs_precog_dodge_bonus", 0,
    },
    {
        "practice_afs_precog_melee_enhance",
        content.text("contemplation: martial trance"),
        content.text("Contemplate your powers and improve your ability to predict the flows of melee combat."),
        "afs_precog_melee_enhance", 0,
    },
})

register_contemplation("AFS_TELEKINETIC", {
    {
        "practice_afs_telekinetic_move_items",
        content.text("contemplation: far hand"),
        content.text("Contemplate your powers and improve your ability to pick up and move items without touching them."),
        "afs_telekinetic_move_item", 0, 2,
    },
    {
        "practice_afs_telekinetic_move_creatures",
        content.text("contemplation: force shove"),
        content.text("Contemplate your powers and improve your ability to pick up and move beings without touching them."),
        "afs_telekinetic_move_creature", 0, 3,
    },
    {
        "practice_afs_telekinetic_momentum",
        content.text("contemplation: momentum alteration"),
        content.text("Contemplate your powers and improve your control of momentum."),
        "afs_telekinetic_momentum", 0, 4,
    },
    {
        "practice_afs_telekinetic_wave",
        content.text("contemplation: wave of force"),
        content.text("Contemplate your powers and develop your ability to control bursts of telekinetic force."),
        "afs_telekinetic_wave", 0, 5,
    },
    {
        "practice_afs_telekinetic_hammer",
        content.text("contemplation: mindhammer"),
        content.text("Contemplate your powers and improve your ability to smash a small area with telekinetic force."),
        "afs_telekinetic_hammer", 0, 7,
    },
})

register_contemplation("AFS_TELEPATH", {
    {
        "practice_afs_telepathic_shield",
        content.text("contemplation: telepathic shield"),
        content.text("Contemplate your powers and improve the resilience of your mind."),
        "afs_telepathic_shield", 0, 2,
    },
    {
        "practice_afs_telepathic_mind_sense",
        content.text("contemplation: mind sense"),
        content.text("Contemplate your powers and improve your ability to detect other minds."),
        "afs_telepathic_mind_sense", 0, 3,
    },
    {
        "practice_afs_telepathic_suggestion",
        content.text("contemplation: telepathic suggestion"),
        content.text("Contemplate your powers and improve your ability to persuade others."),
        "afs_telepathic_suggestion", 0, 4,
    },
    {
        "practice_afs_telepathic_confusion",
        content.text("contemplation: sensory deprivation"),
        content.text("Contemplate your powers and improve your ability to confound your enemies's senses."),
        "afs_telepathic_confusion", 30, 5,
    },
    {
        "practice_afs_telepathic_blast",
        content.text("contemplation: synaptic overload"),
        content.text("Contemplate your powers and improve your mental strength to telepathically assault your enemies."),
        "afs_telepathic_blast", 30, 7,
    },
})
