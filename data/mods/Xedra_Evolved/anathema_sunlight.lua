local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local time = services.time

local weakness = "ANATHEMA_WEAKNESS_SUN_BURN"
local shroud = "vampire_blind_the_sun"
local burning = "effect_slain_by_the_sun"
local limiter = "effect_slain_by_the_sun_limiter"
local burn_task = "anathema_sun_burn_due"
local sunrise_task = "anathema_sunrise_due"
local parts = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_effect(character, effect)
    return value(services.effects.has(character, id("effect", effect)))
end

local function add_effect(character, effect, duration, options)
    local result = services.effects.add(character, effect, duration, options)
    if not result.ok and result.error.code ~= "rejected" then
        error(result.error.message)
    end
end

local function add_permanent(character, effect)
    add_effect(character, id("effect", effect), time.duration(1, "turn"), { permanent = true })
end

local function has_weakness(character)
    return value(services.mutations.has_id_text(character, weakness))
end

local function exposed_to_sunlight(character)
    return not time.now():is_night() and value(services.creatures.snapshot(character)).outside
        and not has_effect(character, shroud)
end

local function burn(character)
    if not has_effect(character, burning) then
        return
    end

    add_permanent(character, limiter)
    local resilience = services.effects.get(character, id("effect", "effect_vampiric_resilience"),
        id("body_part", "bp_null"))
    local resilient = resilience.ok and resilience.value.intensity > -1
    if not resilience.ok and resilience.error.code ~= "not_found" then
        error(resilience.error.message)
    end
    local chance = resilient and 120 or 30
    local on_fire = id("effect", "onfire")
    local fire_duration = time.duration(30, "turn")
    for _, part in ipairs(parts) do
        if services.random.native_float(0, 1) <= 1 / chance then
            add_effect(character, on_fire, fire_duration, { body_part = id("body_part", part) })
        end
    end

    local text = ccb.services.translate("You are burning in the sunlight!  Your burn chance is 1 in <context_val:vampire_burning_chance>.")
    services.messages.add(value(services.text.expand_for(
        text, character, nil, nil, { vampire_burning_chance = chance }, true)), "debug")
    ccb.tasks.after_character_turn(character, 1, burn_task)
end

local function schedule_sunrise()
    local now = time.now()
    local turns = (now:sunrise() - now).turns
    if turns < 0 then
        turns = turns + time.duration(1, "day").turns
    end
    ccb.tasks.ensure_avatar_turn(turns, sunrise_task)
end

ccb.runtime.handler(burn_task, function(task)
    burn(task.character)
end)

ccb.runtime.handler(sunrise_task, function(task)
    if has_weakness(task.character) and exposed_to_sunlight(task.character) then
        burn(task.character)
    end
    schedule_sunrise()
end)

ccb.runtime.handler("anathema_schedule_sunrise", function(event)
    if event.actors.character.subtype == "avatar" then
        schedule_sunrise()
    end
end)
ccb.runtime.on("character_ready", "anathema_schedule_sunrise")

ccb.runtime.handler("anathema_move_in_sunlight", function()
    local character = services.creatures.avatar()
    if not has_weakness(character) then
        return
    end
    if exposed_to_sunlight(character) then
        add_permanent(character, burning)
        if not has_effect(character, limiter) then
            burn(character)
        end
    else
        value(services.effects.remove(character, id("effect", burning)))
        value(services.effects.remove(character, id("effect", limiter)))
    end
end)
ccb.runtime.on("game:avatar_moves", "anathema_move_in_sunlight")
