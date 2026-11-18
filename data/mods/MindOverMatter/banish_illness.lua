local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local cures = {
    ACT_VITAKIN_BANISH_ILLNESS_MINOR_AILMENT = {
        threshold = 10,
        cost = { 15, 30 },
        success = function()
            return ccb.services.translate("You feel much better.")
        end,
        failure = function()
            return ccb.services.translate("The ailment proved tenacious.  You'll have to try again.")
        end,
        effects = { "pre_common_cold", "common_cold", "pre_flu", "flu" },
    },
    ACT_VITAKIN_BANISH_ILLNESS_ASTHMA = {
        threshold = 12,
        cost = { 20, 45 },
        success = function()
            return ccb.services.translate("You breathe easily once again.")
        end,
        trait = "ASTHMA",
        effects = { "effect_asthma_disease_absorbed" },
    },
    ACT_VITAKIN_BANISH_ILLNESS_CHEMIMBALANCE = {
        threshold = 14,
        cost = { 35, 65 },
        success = function()
            return ccb.services.translate("You body feels more normal.")
        end,
        trait = "CHEMIMBALANCE",
    },
    ACT_VITAKIN_BANISH_ILLNESS_SCHIZOPHRENIC = {
        threshold = 16,
        cost = { 60, 90 },
        success = function()
            return ccb.services.translate("You mind feels more normal.")
        end,
        trait = "SCHIZOPHRENIC",
    },
    ACT_VITAKIN_BANISH_ILLNESS_JITTERY = {
        threshold = 12,
        cost = { 30, 65 },
        success = function()
            return ccb.services.translate("You muscles stop trembling.")
        end,
        trait = "JITTERY",
    },
    ACT_VITAKIN_BANISH_ILLNESS_MOODSWINGS = {
        threshold = 15,
        cost = { 30, 65 },
        success = function()
            return ccb.services.translate("You mood calms.")
        end,
        trait = "MOODSWINGS",
    },
    ACT_VITAKIN_BANISH_ILLNESS_WEAKENING = {
        threshold = 15,
        cost = { 45, 75 },
        success = function()
            return ccb.services.translate("New vigor fills your body.")
        end,
        trait = "ROT1",
    },
    ACT_VITAKIN_BANISH_ILLNESS_NARCOLEPTIC = {
        threshold = 13,
        cost = { 50, 100 },
        success = function()
            return ccb.services.translate("New vigor fills your body.")
        end,
        trait = "NARCOLEPTIC",
    },
    ACT_VITAKIN_BANISH_ILLNESS_SEASONAL_ALLERGIES = {
        threshold = 14,
        cost = { 40, 80 },
        success = function()
            return ccb.services.translate("You take a deep breath and your nose and throat clears.")
        end,
        trait = "SEASONAL_ALLERGIES",
    },
    ACT_VITAKIN_BANISH_ILLNESS_SEASONAL_AFFECTIVE = {
        threshold = 15,
        cost = { 45, 90 },
        success = function()
            return ccb.services.translate("You genuinely smile for the first time in a while.  Maybe it won't be so bad.")
        end,
        trait = "SEASONAL_AFFECTIVE",
    },
}

if content.is_mod_active("xedra_evolved") then
    cures.ACT_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM = {
        threshold = 17,
        cost = { 60, 120 },
        success = function()
            return ccb.services.translate("The odd taste in your mouth vanishes.  Maybe you're cured?")
        end,
        effects = { "vampire_virus" },
    }
end

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function spell_roll(character, spell)
    local level = checked(services.spells.effective_level(character, spell))
    return services.random.native_int(math.min(0, level), math.max(0, level))
end

local function recovery_score(character)
    local score = spell_roll(character, "vita_banish_illness")
    score = score + spell_roll(character, "vita_banish_illness_knack")
    local intelligence = checked(services.characters.snapshot(character)).stats.intelligence
    score = score + services.random.native_int(0, math.ceil(intelligence / 2))
    score = score + services.random.native_float(-2, 8)
    score = score + services.random.native_float(-2, 8)

    local drain = services.effects.get(character, id("effect", "effect_disease_psionic_drain"),
        id("body_part", "bp_null"))
    if not drain.ok and drain.error.code == "not_found" then
        return score
    end
    local intensity = checked(drain).intensity
    return score + (intensity > 5 and 1 or 0) + (intensity > 10 and 1 or 0)
end

local function message(character, text, severity)
    if character.subtype == "avatar" then
        services.messages.add(text, severity)
    end
end

ccb.runtime.handler("finish_banish_illness", function(activity)
    local character = activity.character
    local cure = cures[activity.activity_type_id]
    if recovery_score(character) < cure.threshold then
        local text = cure.failure and cure.failure() or ccb.services.translate("The disease proved tenacious.  You'll have to try again.")
        message(character, text, "bad")
    elseif activity.activity_type_id == "ACT_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM"
        and checked(services.mutations.has_id_text(character, "VAMPIRE")) then
        message(character, ccb.services.translate("This is the strangest disease you've ever seen.  Every time you think you eliminate it you find hidden pockets in places you've definitely cleared, almost like it's deliberately hiding and waiting until you let down your guard.  But that's impossible, isn't it?"), "bad")
    else
        message(character, cure.success(), "good")
        if cure.trait then
            checked(services.mutations.erase(character, id("mutation", cure.trait)))
        end
        for _, effect in ipairs(cure.effects or {}) do
            checked(services.effects.remove(character, id("effect", effect)))
        end
    end

    local drain = id("vitamin", "vitamin_psionic_drain")
    local level = checked(services.needs.get_vitamin(character, drain))
    local cost = services.random.native_float(cure.cost[1], cure.cost[2])
    local adjusted = math.modf(level + cost)
    checked(services.needs.set_vitamin(character, drain, adjusted))
end, 1)

local activity_ids = {}
for activity_id in pairs(cures) do
    activity_ids[#activity_ids + 1] = activity_id
end
table.sort(activity_ids)
for _, activity_id in ipairs(activity_ids) do
    content.add(content.ActivityType {
        id = activity_id,
        verb = ccb.content.text("meditating"),
        based_on = "time",
        activity_level = 2,
    }:on_finish("finish_banish_illness"))
end
