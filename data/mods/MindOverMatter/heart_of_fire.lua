local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local tasks = ccb.tasks
local effects = services.effects
local disciplines = require("matrix_awakening_data")

local need_to_channel = id("effect", "effect_scenario_heart_of_fire_need_to_channel")
local protected = id("effect", "effect_scenario_heart_of_fire_channeled_power_protector")
local inner_blaze = id("effect", "effect_scenario_heart_of_fire_damage")
local sleep = id("effect", "sleep")
local cannot_concentrate = id("effect", "effect_psi_too_much_pain_cant_channel")
local torso = id("body_part", "torso")
local burned_parts = { id("body_part", "head"), torso, id("body_part", "arm_l"), id("body_part", "arm_r"),
    id("body_part", "leg_l"), id("body_part", "leg_r") }
local burning_thresholds = { [5] = true, [7] = true, [9] = true, [10] = true }
local starting_powers = {
    { id("spell", "pyrokinetic_eruption_knack"), 8 },
    { id("spell", "pyrokinetic_call_flames_knack"), 7 },
    { id("spell", "pyrokinetic_flamethrower_knack"), 6 },
    { id("spell", "pyrokinetic_aura_knack"), 5 },
    { id("spell", "pyrokinetic_blast_knack"), 5 },
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

local function has_heart_of_fire(character)
    return has_trait(character, "SCEN_HEART_OF_FIRE")
end

local function intensity(character, effect, part)
    local result = effects.get(character, effect, part)
    if not result.ok and result.error.code == "not_found" then
        return -1
    end
    return value(result).intensity
end

local function add_effect(character, effect, turns, options)
    local result = effects.add(character, effect, services.time.duration(turns, "turn"), options)
    if not result.ok and result.error.code ~= "rejected" then
        error(result.error.message)
    end
end

local function apply_blaze(character, level)
    for _, part in ipairs(burned_parts) do
        add_effect(character, inner_blaze, 1, { permanent = true, body_part = part, intensity = level })
    end
end

ccb.runtime.handler("heart_of_fire_start", function(start)
    if start.character.subtype == "avatar" then
        local delay = (services.time.turn_zero() - services.time.now()).turns
        tasks.after_character_turn(start.character, delay, "heart_of_fire_start_due")
    end
end)

ccb.runtime.handler("heart_of_fire_start_due", function(task)
    local character = task.character
    for _, spell in ipairs(starting_powers) do
        value(services.spells.set_level(character, spell[1], spell[2]))
    end
    value(services.recipes.learn(character, id("recipe", "psi_centering_meditation_drain_reduce_heart_of_fire")))
    local count = value(services.variables.get_number(character, "awakening_countup")).value or 0
    value(services.variables.set(character, "awakening_countup", count + 50, { include_before = false }))
end)

ccb.runtime.handler("heart_of_fire_channel", function(event)
    local character = event.actors.character or services.characters.avatar()
    if not event.data.success or not has_heart_of_fire(character) then
        return
    end
    value(effects.remove(character, protected))
    local pressure = intensity(character, need_to_channel) - 1
    value(effects.remove(character, need_to_channel))
    if pressure > 0 then
        add_effect(character, need_to_channel, 1, { permanent = true, intensity = pressure })
    end
    local blaze = intensity(character, inner_blaze, torso)
    if blaze >= 1 then
        for _, part in ipairs(burned_parts) do
            value(effects.remove(character, inner_blaze, part))
        end
        if blaze >= 2 then
            apply_blaze(character, blaze - 1)
        end
    end
    add_effect(character, protected, 3600 + services.random.native_int(0, 18000))
end, 1)
ccb.runtime.on("game:spellcasting_finish", "heart_of_fire_channel")

ccb.runtime.handler("heart_of_fire_wake", function(event)
    local character = event.actors.character or services.characters.avatar()
    if has_heart_of_fire(character) and not value(effects.has(character, need_to_channel)) then
        add_effect(character, need_to_channel, 1, { permanent = true })
    end
end, 1)
ccb.runtime.on("game:character_wakes_up", "heart_of_fire_wake")

local function schedule_pressure(character)
    local roll = services.random.native_int
    local lower = 1800 + roll(0, 5400)
    local upper = 5400 + roll(0, 7200)
    tasks.after_character_turn(character, roll(math.min(lower, upper), math.max(lower, upper)), "heart_of_fire_pressure_due")
end

ccb.runtime.handler("heart_of_fire_pressure_due", function(task)
    local character = task.character
    if has_heart_of_fire(character) and not (value(effects.has(character, sleep)) or value(effects.has(character, protected))) then
        add_effect(character, need_to_channel, 1, { permanent = true })
        if burning_thresholds[intensity(character, need_to_channel)] then
            apply_blaze(character)
        end
    end
    schedule_pressure(character)
end)

ccb.runtime.handler("heart_of_fire_ensure_pressure", function(event)
    local character = event.actors.character
    if not tasks.has_character_turn(character, "heart_of_fire_pressure_due") then
        schedule_pressure(character)
    end
end)
ccb.runtime.on("character_ready", "heart_of_fire_ensure_pressure")

local function pain_threshold(character)
    for _, discipline in ipairs(disciplines) do
        if has_trait(character, discipline.trait) then
            return 40
        end
    end
    if has_heart_of_fire(character) then
        return 60
    end
end

local function concentration_bonus(character)
    return (has_trait(character, "CONCENTRATION_GOOD") and 1 or 0)
        - (has_trait(character, "CONCENTRATION_BAD") and 1 or 0)
        + (has_trait(character, "INT_ALPHA") and 1 or 0)
        + (has_trait(character, "CONCENTRATION_DEBUG") and 50 or 0)
        + (value(services.proficiencies.has_id_text(character, "prof_concentration_basic")) and 1 or 0)
        + (value(services.proficiencies.has_id_text(character, "prof_concentration_intermediate")) and 2 or 0)
        + (value(services.proficiencies.has_id_text(character, "prof_concentration_master")) and 3 or 0)
end

ccb.runtime.handler("check_psionic_concentration", function(event)
    local character = event.actors.character or services.characters.avatar()
    local threshold = pain_threshold(character)
    if threshold and not value(services.creatures.has_flag_text(character, "PAIN_IMMUNE"))
        and not value(effects.has(character, cannot_concentrate))
        and value(services.creatures.snapshot(character)).perceived_pain >= threshold + 15 * concentration_bonus(character) then
        add_effect(character, cannot_concentrate, 0)
    end
end, 1)
ccb.runtime.on("game:opens_spellbook", "check_psionic_concentration")
