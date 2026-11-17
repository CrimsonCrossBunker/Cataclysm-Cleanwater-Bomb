local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local time = services.time
local random = services.random
local weaknesses = require("vampire_weaknesses")
local timers = require("character_timers")

local anathema = "VAMPIRE_ANATHEMA"
local threshold = "THRESH_VAMPIRE_ANATHEMA"

local early_powers = {
    "VAMPIRE_STORE_MORE_BLOOD", "EYEGLEAM_UPGRADE", "VAMPIRE_INSTANT_BLEED",
    "VAMPIRE_DETECT_VAMPIRES", "VAMPIRE_BIG_STOMACH", "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    "BLOOD_FUN_UPGRADE", "VAMPIRE_SILENT_MOVE_UPGRADE"
}
local all_powers = {
    "VAMPIRE_STORE_MORE_BLOOD", "EYEGLEAM_UPGRADE", "VAMPIRE_INSTANT_BLEED",
    "VAMPIRE_DETECT_VAMPIRES", "VAMPIRE_BIG_STOMACH", "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    "BLOOD_FUN_UPGRADE", "VAMPIRE_SILENT_MOVE_UPGRADE", "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    "VAMPIRE_INVISIBLE_IN_DARK", "VAMPIRE_HEAL_IN_DARK", "VAMPIRE_BLOOD_FOR_POTENCY",
    "VAMPIRE_NO_ILLNESS_UPGRADE", "VAMPIRE_FORM_UPGRADE", "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    "VAMPIRE_DRINK_VAMPIRE_BLOOD", "VAMPIRE_GAIN_BLOOD_GIFTS", "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE"
}
local forms = { "VAMPIRE_BAT_FORM", "VAMPIRE_WOLF_FORM", "VAMPIRE_MIST_FORM", "VAMPIRE_SHADOW_FORM" }
local curses = { "ANATHEMA_WEAKNESS_SUN_BURN", "ANATHEMA_WEAKNESS_MIND_CHAOS", "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD" }
local upgrades = {
    { "VAMPIRE_STORE_MORE_BLOOD_UPGRADE", "VAMPIRE_STORE_MORE_BLOOD" },
    { "VAMPIRE_STORE_MORE_BLOOD", "VAMPIRE_DISTILLATE_INNER_BLOOD" },
    { "EYEGLEAM_UPGRADE", "EYEGLEAM" },
    { "BLOOD_FUN_UPGRADE", "BLOOD_FUN" },
    { "VAMPIRE_SILENT_MOVE_UPGRADE", "VAMPIRE_SILENT_MOVE" },
    { "VAMPIRE_NO_ILLNESS_UPGRADE", "VAMPIRE_NO_ILLNESS" },
}

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has(character, mutation)
    return value(services.mutations.has_id_text(character, mutation))
end

local function message(character, text, kind)
    if character.subtype == "avatar" then
        services.messages.add(text, kind)
    end
end

local function grant_missing(character, candidates)
    local ids = {}
    for index, mutation in ipairs(candidates) do
        ids[index] = id("mutation", mutation)
    end
    return value(services.progression.grant_random_missing(character, "mutation", ids)).granted
end

local function replace_upgrade(character, upgrade_name, prerequisite_name)
    if not has(character, upgrade_name) or has(character, prerequisite_name) then
        return
    end
    value(services.mutations.erase(character, id("mutation", upgrade_name)))
    value(services.mutations.replace(character, id("mutation", prerequisite_name)))
end

local function learn_power(character, candidates)
    if not grant_missing(character, candidates) then
        return false
    end
    message(character, ccb.services.translate("Suddenly you feel your blood boiling and you realize a new ability."), "neutral")
    for _, upgrade in ipairs(upgrades) do
        replace_upgrade(character, upgrade[1], upgrade[2])
    end
    local form_upgrade = "VAMPIRE_FORM_UPGRADE"
    if has(character, form_upgrade) then
        local has_form = false
        for _, form in ipairs(forms) do
            if has(character, form) then
                has_form = true
                break
            end
        end
        if not has_form then
            value(services.mutations.erase(character, id("mutation", form_upgrade)))
            grant_missing(character, forms)
        end
    end
    local last_breath = "VAMPIRE_LAST_BREATH_MIST"
    local last_breath_upgrade = "VAMPIRE_LAST_BREATH_MIST_UPGRADE"
    if has(character, last_breath_upgrade) and not has(character, last_breath) then
        replace_upgrade(character, "VAMPIRE_LAST_BREATH_MIST_UPGRADE", "VAMPIRE_LAST_BREATH_MIST")
        replace_upgrade(character, "VAMPIRE_LAST_BREATH_MIST", "VAMPIRE_MIST_FORM")
    end
    replace_upgrade(character, "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE", "VAMPIRE_MASTER_MORTAL_MIND")
    return true
end

local function boost_potency(character)
    local potency = id("effect", "effect_player_anathema_potency_boost")
    local existing = services.effects.get(character, potency, id("body_part", "bp_null"))
    local intensity = 0
    if existing.ok or existing.error.code ~= "not_found" then
        intensity = value(existing).intensity + 1
    end
    local applied = services.effects.add(character, potency, time.duration(1, "turn"),
        { permanent = true, intensity = intensity })
    if not applied.ok and applied.error.code ~= "rejected" then
        error(applied.error.message)
    end
    message(character, ccb.services.translate("Your power has grown a little more thanks to all the vampire blood you drank."), "neutral")
end

local function advance(character)
    local blood = id("vitamin", "vampire_blood_vitamin")
    if random.native_float(0, 1) > (value(services.needs.get_vitamin(character, blood)) - 600) / 100 then
        return
    end
    if has(character, threshold) then
        local stored = value(services.needs.get_vitamin(character, blood))
        value(services.needs.set_vitamin(character, blood, stored - 600))
        if not learn_power(character, all_powers) then
            boost_potency(character)
        end
    end
    if not has(character, threshold) then
        local learned = 0
        for _, power in ipairs(early_powers) do
            if has(character, power) then
                learned = learned + 1
            end
        end
        local crossed = random.native_float(0, 1) <= (learned - 3) / 4
        local stored = value(services.needs.get_vitamin(character, blood))
        value(services.needs.set_vitamin(character, blood, stored - 600))
        if crossed then
            message(character, ccb.services.translate("Like the Anathema before you, there is no more limit to how powerful you can be.  Only your limited supply of vampire blood stand in your way.  Will this power be worth the heavy cost?"), "mixed")
            value(services.mutations.replace(character, id("mutation", threshold)))
            weaknesses.grant(character, 3)
            message(character, ccb.services.translate("A vampiric curse far more dire than any other has manifested within you."), "bad")
            grant_missing(character, curses)
        else
            learn_power(character, early_powers)
        end
    end
end

timers.register("anathema_progression_timer", "anathema_progression_due",
    function()
        return random.native_int(time.duration(3, "hour").turns, time.duration(4, "hour").turns)
    end,
    function(character) return has(character, anathema) end,
    advance)

ccb.runtime.handler("drink_anathema_catalyst", function(context)
    local character = context.character
    local crossed = value(services.characters.has_flag(character, id("json_flag", "MUTATION_THRESHOLD")))
    if crossed then
        message(character, ccb.services.translate("The blood's power tries to take hold, but another sinister power prevents it from doing so!"), "bad")
    elseif not has(character, "BLOOD_DRINKER") then
        message(character, ccb.services.translate("The blood's power tries to take hold, but you lack the vampiric potency it requires to do so!"), "bad")
    else
        message(character, ccb.services.translate("Your hunger for blood submerges you for a moment, as the blood of the Anathema combines with your own.  Vampires, mortals, what's the difference?  You'll drink them all dry anyway."), "mixed")
        value(services.mutations.replace(character, id("mutation", anathema)))
        weaknesses.grant(character, 2)
    end
end)

local catalyst = ccb.content.Item {
    id = "anathema_blood_catalyst",
    name = ccb.content.plural_text("blood of the Anathema", "blood of the Anathema"),
    description = ccb.content.text("Vampire blood that been forced to gain the ability to devour vampire blood to survive.  Consuming it will allow you to devour vampire blood to gain power, like that vampire did before you caused their end."),
    looks_like = "vampire_blood",
    symbol = "~",
    color = "red",
    mass_grams = 235,
    volume_ml = 250,
    price_postapoc_cents = 0,
}
catalyst:material("vampire_blood", 1):flag("TRADER_AVOID")
catalyst:comestible { type = "DRINK", calories = 0, charges = 0 }
ccb.content.add(catalyst:on_consume("drink_anathema_catalyst"))
