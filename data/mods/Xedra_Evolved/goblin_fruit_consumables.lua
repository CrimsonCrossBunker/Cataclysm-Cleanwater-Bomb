local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(character, text, kind)
    if character.subtype == "avatar" then
        services.messages.add(text, kind)
    end
end

local function has_mutation(character, mutation)
    return checked(services.mutations.has_id_text(character, mutation))
end

local fruit_group = id("item_group", "spell_spawned_goblin_fruit")

ccb.runtime.handler("eat_mysterious_goblin_fruit", function(context)
    local character = context.character
    checked(services.inventory.receive_group(character, fruit_group))
    message(character, ccb.services.translate("You peel open the mysterious fruit and find another whole fruit inside."), "info")
end)

ccb.runtime.handler("eat_goblin_fruit_cluster", function(context)
    local character = context.character
    -- Native group delivery draws the group once, even when a count is supplied.
    checked(services.inventory.receive_group(character, fruit_group))
    message(character, ccb.services.translate("Some hard chunks of that horrible fruit jump from your mouth and turn into fresh goblin fruits."), "info")
end)

local vampire_traits = { "VAMPIRE", "VAMPIRE2", "VAMPIRE3", "VAMPIRE4", "BLOOD_DRINKER" }

local function needs_vampire_blood(character)
    for _, trait in ipairs(vampire_traits) do
        if has_mutation(character, trait) then return true end
    end
    return false
end

ccb.runtime.handler("eat_blood_goblin_fruit", function(context)
    local character = context.character
    if needs_vampire_blood(character) then
        message(character, ccb.services.translate("This isn't the blood you need."), "neutral")
    else
        message(character, ccb.services.translate("You feel a pressure in your veins, then it passes."), "neutral")
    end
    for _, vitamin in ipairs({ "blood", "redcells" }) do
        local vitamin_id = id("vitamin", vitamin)
        local current = checked(services.needs.get_vitamin(character, vitamin_id))
        checked(services.needs.set_vitamin(character, vitamin_id, current + 5000))
    end
end)

local numb = id("mutation", "NUMB")
local end_numbness = "end_goblin_fruit_numbness"

ccb.runtime.handler("eat_numbing_goblin_fruit", function(context)
    local character = context.character
    if has_mutation(character, "NUMB") then
        message(character, ccb.services.translate("You don't feel more numb than you currently are."), "neutral")
        return
    end
    message(character, ccb.services.translate("Everything goes numb."), "good")
    checked(services.mutations.replace(character, numb))
    ccb.tasks.after_character_turn(character, 2000 + services.random.native_int(0, 3000), end_numbness)
end)

ccb.runtime.handler(end_numbness, function(task)
    local character = task.character
    message(character, ccb.services.translate("The numbness goes away."), "info")
    checked(services.mutations.erase(character, numb))
end)

ccb.runtime.handler("eat_shadow_goblin_fruit", function(context)
    local character = context.character
    local position = checked(services.creatures.snapshot(character)).position
    checked(services.spawns.population(id("monster", "mon_dream_shadow_player"), position, {
        count = function() return 2 + services.random.native_int(0, 3) end,
        min_radius = 0,
        max_radius = 3,
        lifespan = {
            minimum = services.time.duration_from_turns(2500),
            maximum = services.time.duration_from_turns(5000),
        },
    }))
    message(character, ccb.services.translate("A few shadows emerge from the ground near you."), "info")
end)

local growth = id("mutation", "GOBLIN_FRUIT_GIANT_GROWTH")
local end_growth = "end_goblin_fruit_giant_growth"
local calorie_factors = { 12, 6, 2, 1.5 }

local function scale_calories(character, size, shrinking)
    local factor = calorie_factors[size]
    if not factor then return end
    local current = checked(services.needs.get(character)).stored_kcal
    local target = shrinking and current / factor or current * factor
    checked(services.needs.modify_calories(character, math.modf(target - current), true))
end

ccb.runtime.handler("eat_giant_growth_goblin_fruit", function(context)
    local character = context.character
    if has_mutation(character, "HUGE") or has_mutation(character, "HUGE_OK") then
        message(character, ccb.services.translate("You eat the goblin fruit but nothing happens.  Oh well."), "neutral")
        return
    end
    message(character, ccb.services.translate("Your body swells and warps as your size increases!"), "good")
    local size = checked(services.characters.snapshot(character, 0)).demographics.size_index
    checked(services.variables.set(character, "preshift_size", size, { include_before = false }))
    scale_calories(character, size, false)
    checked(services.mutations.replace(character, growth))
    ccb.tasks.after_character_turn(character, 3000 + services.random.native_int(0, 10000), end_growth)
end)

ccb.runtime.handler(end_growth, function(task)
    local character = task.character
    message(character, ccb.services.translate("Your body shrinks and warps as your size decreases!"), "mixed")
    local size = checked(services.variables.get_number(character, "preshift_size")).value
    local size_band = size and math.floor(size) or 0
    scale_calories(character, size_band, true)
    checked(services.mutations.erase(character, growth))
end)

local sleep_healing = id("effect", "effect_goblin_fruit_heal_after_sleep")
local wake_healing = "heal_from_goblin_fruit_on_wake"

ccb.runtime.handler("eat_restful_goblin_fruit", function(context)
    local character = context.character
    local previous = services.effects.get(character, sleep_healing)
    local intensity = 0
    if previous.ok or previous.error.code ~= "not_found" then
        intensity = checked(previous).intensity + 1
    end
    local applied = services.effects.add(character, sleep_healing, services.time.duration_from_turns(1),
        { permanent = true, intensity = intensity })
    if not applied.ok and applied.error.code ~= "rejected" then checked(applied) end
end)

ccb.runtime.handler(wake_healing, function(event)
    local character = event.actors.character or services.characters.avatar()
    if not checked(services.effects.has(character, sleep_healing)) then return end
    local effect = checked(services.effects.get(character, sleep_healing))
    local hp = checked(services.characters.hp_group(character, "ALL"))
    hp = hp + effect.intensity * (15 + services.random.native_int(0, 5))
    checked(services.characters.set_hp_group(character, "ALL", hp))
    message(character, ccb.services.translate("Some of the aches of yesterday are gone."), "neutral")
    checked(services.effects.remove(character, sleep_healing))
end)
ccb.runtime.on("game:character_wakes_up", wake_healing)

local morale_thresholds = { 100, 75, 50, 25, -25, -50, -75, -100 }

ccb.runtime.handler("eat_boring_goblin_fruit", function(context)
    local character = context.character
    local morale = checked(services.needs.morale(character)).total
    for _, threshold in ipairs(morale_thresholds) do
        if morale >= threshold then
            checked(services.morale.add(character, id("morale", "morale_boring_fruit"), -threshold, -threshold))
            return
        end
    end
end)
