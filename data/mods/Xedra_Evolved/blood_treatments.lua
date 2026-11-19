local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(character, text, kind)
    if character.subtype == "avatar" then services.messages.add(text, kind) end
end

local function intensity(character, effect)
    local result = services.effects.get(character, effect)
    if not result.ok and result.error.code == "not_found" then return -1 end
    return checked(result).intensity
end

local function add_effect(character, effect, turns, options)
    local result = services.effects.add(character, effect, services.time.duration_from_turns(turns), options)
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local function erase_mutations(character, mutations)
    for _, mutation in ipairs(mutations) do
        checked(services.mutations.erase(character, id("mutation", mutation)))
    end
end

local function forget_spells(character, spells)
    for _, spell in ipairs(spells) do
        checked(services.spells.set_level(character, id("spell", spell), -1))
    end
end

local infection = id("effect", "vampire_virus")
local ascendant = id("effect", "vampire_virus_ascendant")
local post_mortal = id("effect", "vampire_virus_post_mortal")
local treatment = id("effect", "blood_treatment")
local cure = id("effect", "curevamp")
local saint = id("mutation", "BLOOD_OF_SAINTS")

local early_traits = {
    "VAMPIRE", "VAMPIRE_BLOOD_ARTS", "EYEGLEAM", "BLOOD_FUN", "STAMINAFORBLOOD", "COMMUNE_NIGHT",
    "VAMPIRIC_STRENGTH", "VAMPIRIC_RESILIENCE", "VAMPIRE_HEIGHTENED_SENSES", "VAMPIRE_SILENT_MOVE",
}
local early_spells = { "vampire_smell_nearby_blood_spell", "vampire_stamina_for_blood_spell" }
local middle_traits = {
    "VAMPIRE2", "COAGULANTWEAVE", "BLOODHEAL", "VAMPIRIC_DODGE", "VAMPIRIC_STEALTH_BONUS",
    "VAMPIRE_FEAR_GAZE", "VAMPIRE_WALK_ON_WALLS", "VAMPIRE_BEAST_CLAWS", "VAMPIRE_SEE_HEAT",
    "VAMPIRE_BLOOD_TEMPORARY_BOOST", "VAMPIRE_FEIGN_DEATH",
}
local middle_spells = { "spell_blood_heal", "vampire_fear_gaze_spell" }
local late_traits = {
    "VAMPIRE3", "HYPNOTIC_GAZE", "BLOODHASTE", "MAGICFORBLOOD", "VAMPIRE_COMMAND_BEAST",
    "VAMPIRE_EARTH_SLUMBER", "VAMPIRE_WEAKNESS_MORE_BLOOD", "VAMPIRE_WEAKNESS_GROTESQUE",
    "VAMPIRE_WEAKNESS_EARTH_SLEEP", "VAMPIRE_WEAKNESS_HOLY_BURN", "VAMPIRE_WEAKNESS_VAST_WATER_BURN",
    "VAMPIRE_WEAKNESS_ANIMAL_HATE", "VAMPIRE_WEAKNESS_FIRE_VULNERABLE", "VAMPIRE_WEAKNESS_COLD_BLOODED",
    "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD", "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD",
    "VAMPIRE_WEAKNESS_BLOOD_CRAVING", "VAMPIRE_WEAKNESS_NO_FUN",
}
local late_spells = { "vampire_magic_for_blood_spell", "spell_hypnotic_gaze", "vampire_command_beast_spell" }

local function cure_early_vampirism(character)
    if intensity(character, infection) < 1 or intensity(character, ascendant) == 1 then return end
    checked(services.effects.remove(character, infection))
    erase_mutations(character, early_traits)
    forget_spells(character, early_spells)
    erase_mutations(character, middle_traits)
    forget_spells(character, middle_spells)
    erase_mutations(character, late_traits)
    checked(services.effects.remove(character, id("effect", "vampire_need_living_blood")))
    checked(services.morale.remove(character, id("morale", "morale_vw_no_fun")))
    forget_spells(character, late_spells)
    message(character, ccb.services.translate("The light seems less bright and the air fresher."), "good")
    add_effect(character, cure, 72 * 86400)
    checked(services.needs.set_vitamin(character, id("vitamin", "human_blood_vitamin"), 0))
end

local function failed_treatment(character)
    message(character, ccb.services.translate("Your veins burn and ache.  What were you thinking trying this?  You are already one of the damned!"), "bad")
end

local function treat_ascendant(character)
    if checked(services.effects.has(character, ascendant, nil, 1)) and intensity(character, ascendant) == 1 then
        add_effect(character, id("effect", "poisoned_blood"), 4 * 3600, { intensity = 1 })
        failed_treatment(character)
    end
end

local function treat_post_mortal(character)
    if checked(services.effects.has(character, post_mortal, nil, 1))
        and intensity(character, post_mortal) == 1 then
        add_effect(character, id("effect", "poisoned_blood2"), 3600, { intensity = 1 })
        failed_treatment(character)
    end
end

ccb.runtime.handler("drink_blood_treatment", function(context)
    local character = context.character
    if checked(services.effects.has(character, treatment)) then return end
    add_effect(character, treatment, 3600)
    message(character, ccb.services.translate("You take a blood treatment."), "info")
    cure_early_vampirism(character)
    treat_ascendant(character)
    treat_post_mortal(character)
end)

ccb.runtime.handler("drink_blood_of_saints", function(context)
    local character = context.character
    if checked(services.effects.has(character, post_mortal)) then
        add_effect(character, id("effect", "poisoned_blood2"), 2 * 3600)
        failed_treatment(character)
        return
    end
    message(character, ccb.services.translate("You imbibed the concoction and you feel your veins flex in a warm glow."), "good")
    checked(services.mutations.replace(character, saint))
    add_effect(character, treatment, 1, { permanent = true })
end)

local saint_due = "blood_of_saints_treatment_due"
local interval = 16 * 3600

local function schedule_saint_treatment()
    if not ccb.tasks.has_avatar_turn(saint_due) then
        ccb.tasks.ensure_avatar_turn(services.random.native_int(interval, interval), saint_due)
    end
end

ccb.runtime.handler(saint_due, function(task)
    if checked(services.mutations.has(task.character, saint)) then
        cure_early_vampirism(task.character)
        treat_ascendant(task.character)
    end
    schedule_saint_treatment()
end)

ccb.runtime.handler("start_blood_of_saints_timer", function(event)
    if event.actors.character.subtype == "avatar" then schedule_saint_treatment() end
end)
ccb.runtime.on("character_ready", "start_blood_of_saints_timer")

return cure_early_vampirism
