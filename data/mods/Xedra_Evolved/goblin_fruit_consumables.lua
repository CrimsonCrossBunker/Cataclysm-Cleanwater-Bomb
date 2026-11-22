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

local song_trait = id("mutation", "GOBLIN_FRUIT_MUSIC")
local song_item = id("item", "internal_mp3_fruit_on")
local song_end = "end_goblin_fruit_song"

ccb.runtime.handler("eat_musical_goblin_fruit", function(context)
    local character = context.character
    if has_mutation(character, "GOBLIN_FRUIT_MUSIC") then
        message(character, ccb.services.translate("Another song is already struck in your head and won't share its space with another."), "neutral")
        return
    end
    message(character, ccb.services.translate("The fruit's melody fills your head."), "good")
    checked(services.mutations.replace(character, song_trait))
    local position = checked(services.creatures.snapshot(character)).position
    for _, item in ipairs(checked(services.inventory.worn_items(character))) do
        if checked(services.items.snapshot(item, 0)).id.value == "internal_mp3_fruit" then
            checked(services.items.activate(item, character, "transform", { target = position }))
        end
    end
    ccb.tasks.after_character_turn(character, 10000 + services.random.native_int(0, 10000), song_end)
end)

ccb.runtime.handler(song_end, function(task)
    local character = task.character
    message(character, ccb.services.translate("The song in your head fades."), "info")
    checked(services.mutations.erase(character, song_trait))
    checked(services.inventory.consume_by_type(character, song_item, 1, 0))
end)

local function set_world_number(key, number)
    checked(services.variables.set_global(key, number, { include_before = false }))
end

local function native_float(number)
    return (string.unpack("f", string.pack("f", number)))
end

-- Match the float constants used by the native Fahrenheit conversion.
local rain_threshold_kelvin = (31 + native_float(459.67)) / native_float(1.8)
local drizzle = "magic_weather_light_drizzle"
local stop_drizzle = "end_goblin_fruit_drizzle"

ccb.runtime.handler("eat_weeping_goblin_fruit", function(context)
    local character = context.character
    if services.weather.current().precise.temperature:value("kelvin") <= rain_threshold_kelvin then
        message(character, ccb.services.translate("A few droplets fall from the sky, but nothing more happen."), "info")
        return
    end
    set_world_number(drizzle, 1)
    services.weather.request_update()
    ccb.tasks.after_character_turn(character, 2500 + services.random.native_int(0, 1000), stop_drizzle)
    message(character, ccb.services.translate("A light drizzle starts falling from the sky."), "info")
end)

ccb.runtime.handler(stop_drizzle, function(task)
    set_world_number(drizzle, 0)
    services.weather.request_update()
    message(task.character, ccb.services.translate("The drizzle the fruit caused ends."), "info")
end)

local animal_ignore = id("mutation", "GOBLIN_FRUIT_ANIMAL_IGNORE")
local animal_ignore_end = "end_goblin_fruit_animal_ignore"

local function animals_notice(character)
    message(character, ccb.services.translate("Nearby animals stop ignoring your presence."), "info")
end

ccb.runtime.handler("eat_furry_goblin_fruit", function(context)
    local character = context.character
    if has_mutation(character, "GOBLIN_FRUIT_ANIMAL_IGNORE") then
        message(character, ccb.services.translate("Animals can't tolerate your presence more than they are currently doing."), "neutral")
        return
    end
    message(character, ccb.services.translate("Nearby animals tolerate your presence a little more."), "good")
    checked(services.mutations.replace(character, animal_ignore))
    ccb.tasks.after_character_turn(character, 12500 + services.random.native_int(0, 5000), animal_ignore_end)
end)

ccb.runtime.handler(animal_ignore_end, function(task)
    local character = task.character
    if has_mutation(character, "GOBLIN_FRUIT_ANIMAL_IGNORE") then
        animals_notice(character)
        checked(services.mutations.erase(character, animal_ignore))
    end
end)

local animal_species = {
    MAMMAL = true, AMPHIBIAN = true, BIRD = true, REPTILE = true, FISH = true,
    KRAKEN = true, INSECT = true, CENTIPEDE = true, INSECT_FLYING = true, SPIDER = true,
}
local animal_attack = "break_goblin_fruit_animal_ignore_on_attack"

ccb.runtime.handler(animal_attack, function(event)
    local target = event.participants.interlocutor
    local character = event.actors.speaker
    if not target or not character or not has_mutation(character, "GOBLIN_FRUIT_ANIMAL_IGNORE") then return end
    for _, species in ipairs(target.species) do
        if animal_species[species] then
            checked(services.mutations.erase(character, animal_ignore))
            animals_notice(character)
            return
        end
    end
end)
ccb.runtime.on("game:character_ranged_attacks_monster", animal_attack)
ccb.runtime.on("game:character_melee_attacks_monster", animal_attack)

local mended_limbs = {
    { "arm_l", function() return ccb.services.translate("The bones of your left arm mend together in an instant!") end },
    { "arm_r", function() return ccb.services.translate("The bones of your right arm mend together in an instant!") end },
    { "leg_l", function() return ccb.services.translate("The bones of your left leg mend together in an instant!") end },
    { "leg_r", function() return ccb.services.translate("The bones of your right leg mend together in an instant!") end },
}

ccb.runtime.handler("eat_remolding_goblin_fruit", function(context)
    local character = context.character
    for _, limb in ipairs(mended_limbs) do
        local part = id("body_part", limb[1])
        if checked(services.characters.hp(character, part)) == 0 then
            checked(services.characters.set_hp(character, part, 30, true))
            message(character, limb[2](), "good")
            return
        end
    end
    message(character, ccb.services.translate("You feel your bones itch for a moment, but nothing happens."), "info")
end)

local dreamless = id("mutation", "DREAMLESS")
local dream_cooldown = id("effect", "effect_goblin_fruit_cure_dreamless_cooldown")
local other_magic = {
    "CHANGELING_MAGIC", "NATIVE_SHAPESHIFTER", "LILIN_TRAITS", "GRACKEN", "ARVORE",
    "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "VAMPIRE",
}

local function raise_dream_potential(key)
    local previous = checked(services.variables.get_global_number(key)).value or 0
    set_world_number(key, previous + 1)
end

ccb.runtime.handler("eat_cloudy_goblin_fruit", function(context)
    local character = context.character
    for _, trait in ipairs(other_magic) do
        if has_mutation(character, trait) then
            message(character, ccb.services.translate("Not even the power of this fruit could grant you access to dream magic."), "bad")
            return
        end
    end
    if checked(services.effects.has(character, dream_cooldown)) then
        message(character, ccb.services.translate("Your dreams are still digesting another cloudy fruit, preventing this one from having any effect."), "bad")
        return
    end

    if has_mutation(character, "DREAMLESS") then
        checked(services.mutations.erase(character, dreamless))
        message(character, ccb.services.translate("Your mind fills with dreams of an intensity you have never seen before!"), "good")
    elseif not has_mutation(character, "EATER") and not has_mutation(character, "DREAMER") then
        set_world_number("eater_dreamer_sequence", 5)
        set_world_number("magic_potential", 1)
        message(character, ccb.services.translate("Your mind fills with oddly real dreams!"), "good")
    elseif not has_mutation(character, "INVENTOR") and not has_mutation(character, "DREAMSMITH") then
        set_world_number("inventor_dreamsmith_sequence", 7)
        set_world_number("magic_potential", 1)
        message(character, ccb.services.translate("Your mind fills with dreams you could make real!"), "good")
    elseif has_mutation(character, "EATER") then
        raise_dream_potential("xe_eater_leveling")
        message(character, ccb.services.translate("You feel your Eater potential grow!"), "good")
    else
        raise_dream_potential("xe_dreamer_leveling")
        message(character, ccb.services.translate("You feel your Dreamer potential grow!"), "good")
    end
    local applied = services.effects.add(character, dream_cooldown, services.time.duration_from_turns(90 * 86400))
    if not applied.ok and applied.error.code ~= "rejected" then checked(applied) end
end)
