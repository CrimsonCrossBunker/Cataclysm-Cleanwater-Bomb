local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local duration = services.time.duration
local random = services.random

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return value(services.effects.has(character, id("effect", effect)))
end

local function message(character, text, type)
    if character.subtype == "avatar" then
        services.messages.add(text, type)
    end
end

local function blood_morale(character)
    local upgraded = has_trait(character, "BLOOD_FUN_UPGRADE")
    value(services.morale.add(character, id("morale", "morale_drank_blood"),
        upgraded and 90 or 30, upgraded and 180 or 60, {
            duration = duration(upgraded and 60 or 20, "minute"),
            decay_start = duration(upgraded and 30 or 10, "minute"),
        }))
end

-- Nyctophobia and pyromania are excluded from this pool.
local mental_weaknesses = {
    "BADTEMPER", "CHEMIMBALANCE", "SHOUT3", "JITTERY", "SEASONAL_AFFECTIVE",
    "SCHIZOPHRENIC", "MOODSWINGS", "INSOMNIA", "JEKYLL", "NOMAD2",
    "HATES_BOOKS", "INATTENTIVE", "PACIFIST", "SAVANT", "SLOWLEARNER",
    "UNOBSERVANT", "SQUEAMISH", "SLOWREADER", "TABLEMANNERS",
}

local function apply_mind_chaos(character)
    local key = "counter_anathema_mind_chaos"
    local count = value(services.variables.get_number(character, key)).value or 0
    if random.native_float(0, 1) > count / 100 then
        value(services.variables.set(character, key, count + 1, { include_before = false }))
        return
    end

    local candidates = {}
    for index, trait in ipairs(mental_weaknesses) do
        candidates[index] = id("mutation", trait)
    end
    if value(services.progression.grant_random_missing(character, "mutation", candidates)).granted then
        message(character, ccb.services.translate("The chaos within your head coalesces and destabilizes your mind."), "bad")
    else
        message(character, ccb.services.translate("The chaos within your head coalesces but it cannot latch on your mind, so it will remain there until it decoheres."), "bad")
        local chaos = id("effect", "effect_anathema_mind_chaos")
        local current = services.effects.get(character, chaos)
        local intensity = 0
        if current.ok or current.error.code ~= "not_found" then
            intensity = value(current).intensity + 1
        end
        value(services.effects.add(character, chaos, duration(86400 + random.native_int(0, 259200), "turn"),
            { intensity = intensity }))
    end
    value(services.variables.set(character, key, 0, { include_before = false }))
end

local function drink_vampire_blood(character)
    if not has_trait(character, "VAMPIRE_ANATHEMA") then
        message(character, ccb.services.translate("You need the blood of the living, not the blood of the dead."), "bad")
        return
    end

    local nourished = has_trait(character, "VAMPIRE_DRINK_VAMPIRE_BLOOD")
    if nourished then
        value(services.needs.modify_vitamin(character, id("vitamin", "human_blood_vitamin"),
            400 + random.native_int(0, 100)))
    end
    value(services.needs.modify_vitamin(character, id("vitamin", "vampire_blood_vitamin"),
        30 + random.native_int(0, 20)))

    if nourished then
        message(character, ccb.services.translate("This blood is the best you could drink.  You want more."), "good")
        if has_trait(character, "BLOOD_FUN") then
            blood_morale(character)
        end
    else
        message(character, ccb.services.translate("Though it cannot sustain you, this blood can empower you."), "mixed")
    end
    if has_trait(character, "ANATHEMA_WEAKNESS_MIND_CHAOS") then
        apply_mind_chaos(character)
    end
    if has_trait(character, "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD") then
        value(services.effects.add(character, id("effect", "effect_recent_vampire_drink"), duration(4, "day")))
        value(services.effects.remove(character, id("effect", "effect_anathema_need_vampire_blood")))
    end
end

local partial_nourishment = { demihuman_blood = true, mutant_human_blood = true, fae_blood = true }

ccb.runtime.handler("apply_vampire_diet", function(event)
    local item = event.data.itype
    local animal_blood = item == "animal_blood" or item == "blood_tainted"
    if item ~= "vampire_blood" and not animal_blood and not partial_nourishment[item] then
        return
    end
    local character = event.actors.character or services.characters.avatar()
    if item == "vampire_blood" then
        if has_trait(character, "VAMPIRE") or has_effect(character, "vampire_virus") then
            drink_vampire_blood(character)
        end
        if not has_effect(character, "vampire_virus") then
            message(character, ccb.services.translate("As you drink, some of the vampire blood enters your gums."), "mixed")
            value(services.effects.add(character, id("effect", "vampire_virus"), duration(1, "turn"),
                { intensity = 1, permanent = true }))
        end
    elseif animal_blood then
        if has_trait(character, "VAMPIRE") or has_effect(character, "vampire_virus") then
            message(character, ccb.services.translate("You still feel as hungry as before.  This blood cannot sustain you."), "bad")
        end
    elseif has_trait(character, "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD") then
        -- The legacy direct-feeding rule runs before this adjustment.
        value(services.needs.modify_vitamin(character, id("vitamin", "human_blood_vitamin"),
            -200 - random.native_int(0, 50)))
    end
end, 1)
ccb.runtime.on("game:character_eats_item", "apply_vampire_diet")
