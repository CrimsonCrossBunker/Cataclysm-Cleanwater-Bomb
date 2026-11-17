local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local time = services.time
local random = services.random
local tasks = ccb.tasks
local timers = require("character_timers")
local weaknesses = require("vampire_weaknesses")

-- The roll order and the traits that count toward the limit are independent.
-- Keep the counts in sync with the legacy spell formulas until those migrate.
local tiers = {
    {
        powers = {
            "EYEGLEAM", "BLOOD_FUN", "STAMINAFORBLOOD", "COMMUNE_NIGHT",
            "VAMPIRIC_STRENGTH", "VAMPIRIC_RESILIENCE", "VAMPIRE_HEIGHTENED_SENSES",
            "VAMPIRE_SILENT_MOVE", "VAMPIRE_HEALTH_BONUS", "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
        },
        additional = { "DHAMPIR_REDUCED_COLD_TEMPS" },
    },
    {
        powers = {
            "BLOODHEAL", "COAGULANTWEAVE", "VAMPIRIC_DODGE", "VAMPIRIC_STEALTH_BONUS",
            "VAMPIRE_FEAR_GAZE", "VAMPIRE_FEIGN_DEATH", "VAMPIRE_WALK_ON_WALLS",
            "VAMPIRE_BEAST_CLAWS", "VAMPIRE_SEE_HEAT", "VAMPIRE_BLOOD_TEMPORARY_BOOST",
        },
        additional = {
            "EYEGLEAM_UPGRADE", "VAMPIRE_SEE_THROUGH_NIGHT_EYES", "BLOOD_FUN_UPGRADE", "VAMPIRE_SILENT_MOVE_UPGRADE",
            "DHAMPIR_FANGS", "DHAMPIR_SLOWFALL", "DHAMPIR_RESIST_DISEASE_POISON_INFECTION", "DHAMPIR_BLACKEN_SOUL_ARION",
        },
    },
    {
        powers = {
            "BLOODHASTE", "MAGICFORBLOOD", "HYPNOTIC_GAZE", "CANNIBAL", "VAMPIRE_COMMAND_BEAST",
            "VAMPIRE_EARTH_SLUMBER", "VAMPIRE_CARDIO_BONUS", "VAMPIRE_MOTION_ALARM",
            "VAMPIRE_BONUS_HP", "VAMPIRE_RENDING_TEETH",
        },
        excluded = { CANNIBAL = true, VAMPIRE_RENDING_TEETH = true },
        additional = {
            "VAMPIRE_STORE_MORE_BLOOD", "VAMPIRE_INSTANT_BLEED", "VAMPIRE_BIG_STOMACH",
            "VAMPIRE_DETECT_VAMPIRES", "DHAMPIR_REDUCED_PAIN", "DHAMPIR_MEND_WOUNDS_FASTER",
            "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
        },
    },
    {
        powers = {
            "TRUE_VAMPIRE_POWER", "VAMPIRE_TORPOR", "VAMPIRE_DOMINATE", "VAMPIRE_NO_BREATHE",
            "VAMPIRE_NO_ILLNESS", "VAMPIRE_SUMMON_SHADOWS", "VAMPIRE_BAT_FORM", "VAMPIRE_WOLF_FORM", "VAMPIRE_MIST_FORM",
        },
        excluded = { VAMPIRE_SUMMON_SHADOWS = true },
        additional = {
            "VAMPIRE_STORE_MORE_BLOOD_UPGRADE", "VAMPIRE_INVISIBLE_IN_DARK",
            "VAMPIRE_NO_ILLNESS_UPGRADE", "VAMPIRE_FORM_UPGRADE", "VAMPIRE_BLOOD_FOR_POTENCY",
        },
    },
    {
        powers = {
            "VAMPIRE_MASTER_MORTAL_MIND", "VAMPIRE_DISTILLATE_INNER_BLOOD", "VAMPIRE_SHADOW_FORM",
            "VAMPIRE_LAST_BREATH_MIST", "VAMPIRE_IRON_MIND", "VAMPIRE_BLIND_THE_SUN",
        },
        additional = {
            "VAMPIRE_HEAL_IN_DARK", "VAMPIRE_DRINK_VAMPIRE_BLOOD", "VAMPIRE_GAIN_BLOOD_GIFTS",
            "VAMPIRE_LAST_BREATH_MIST_UPGRADE", "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
        },
    },
}

local perception_traits = {}
local perception_multiplier = { 0.20, 0.30, 0.45, 0.60 }
for index, tier in ipairs(tiers) do
    tier.counted = {}
    for _, mutation in ipairs(tier.powers) do
        if not tier.excluded or not tier.excluded[mutation] then
            tier.counted[#tier.counted + 1] = mutation
        end
    end
    for _, mutation in ipairs(tier.additional) do
        tier.counted[#tier.counted + 1] = mutation
    end
    if perception_multiplier[index] then
        for _, mutation in ipairs(tier.counted) do
            perception_traits[#perception_traits + 1] = mutation
        end
    end
end

ccb.runtime.handler("vampire_heightened_perception", function(ctx)
    local traits = ctx.character_inputs.traits
    local bonus = 1
    for index, multiplier in ipairs(perception_multiplier) do
        local count = 0
        for _, mutation in ipairs(tiers[index].counted) do
            if traits[mutation] then
                count = count + 1
            end
        end
        if index == 4 and traits.TRUE_VAMPIRE_POWER then
            count = count + 5
        end
        bonus = bonus + count * multiplier
    end
    return bonus
end)

ccb.content.add(ccb.content.Enchantment {
    id = "ench_vampire_heightened_senses_perception",
    condition = "ALWAYS",
    load_character_inputs = { traits = perception_traits },
}:value("PERCEPTION", { add_handler = "vampire_heightened_perception" }))

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has(character, mutation)
    return value(services.mutations.has_id_text(character, mutation))
end

local function add_trait(character, mutation)
    value(services.mutations.replace(character, id("mutation", mutation)))
end

local function intensity(character, effect)
    local result = services.effects.get(character, id("effect", effect), id("body_part", "bp_null"))
    if not result.ok and result.error.code == "not_found" then
        return -1
    end
    return value(result).intensity
end

local function message(character, text)
    if character.subtype == "avatar" then
        services.messages.add(text, "neutral")
    end
end

local function reached_limit(character, tier)
    local count = 0
    for _, mutation in ipairs(tier.counted) do
        if has(character, mutation) then
            count = count + 1
        end
    end
    return count >= 4
end

local function learn_power(character, tier)
    local candidates = {}
    for index, mutation in ipairs(tier.powers) do
        candidates[index] = id("mutation", mutation)
    end
    if not value(services.progression.grant_random_missing(character, "mutation", candidates)).granted then
        return false
    end
    message(character, ccb.services.translate("Suddenly you feel your heart pounding and you realize a new ability."))
    if has(character, "VAMPIRE_LAST_BREATH_MIST") and not has(character, "VAMPIRE_MIST_FORM") then
        value(services.mutations.erase(character, id("mutation", "VAMPIRE_LAST_BREATH_MIST")))
        add_trait(character, "VAMPIRE_MIST_FORM")
    end
    return true
end

local function blood_desire(character)
    message(character, ccb.services.translate("You flush with desire as you think about blood."))
end

local function tier_four(character)
    if intensity(character, "vampire_virus_ascendant") >= 1 and not reached_limit(character, tiers[4]) then
        if not has(character, "VAMPIRE4") or not learn_power(character, tiers[4]) then
            message(character, ccb.services.translate("You can advance no further without more guidance from your mentor."))
        end
    end
end

local function tier_three_complete(character)
    if has(character, "VAMPIRE4") then
        tier_four(character)
    else
        message(character, ccb.services.translate("You can advance no further without access to a mentor.  Maybe you could find one where you've found the other vampires?"))
    end
end

local function tier_three(character)
    if intensity(character, "vampire_virus") ~= 3 then
        return
    end
    if reached_limit(character, tiers[3]) then
        tier_three_complete(character)
    elseif not has(character, "VAMPIRE3") then
        add_trait(character, "VAMPIRE3")
        weaknesses.grant(character, 1)
        message(character, ccb.services.translate("You feel the absence of your heart beating for several seconds and then it resumes at this new rhythm."))
    elseif not learn_power(character, tiers[3]) then
        tier_three_complete(character)
    end
end

local function delay_for_intensity(character, days, handler)
    tasks.after_character_turn(character, random.native_int(time.duration(8, "hour").turns,
        time.duration(days, "day").turns), handler)
end

local function tier_two(character)
    if intensity(character, "vampire_virus") ~= 2 or reached_limit(character, tiers[2]) then
        return
    end
    if not has(character, "VAMPIRE2") then
        add_trait(character, "VAMPIRE2")
        message(character, ccb.services.translate("With a popping sound several of your teeth fall out but when you put a finger into your mouth to feel the hole, there are new sharp fangs where you expected nothing."))
        return
    end
    if not learn_power(character, tiers[2]) then
        blood_desire(character)
        tier_three(character)
    end
    delay_for_intensity(character, 15, "vampire_intensity_three_due")
end

local function tier_one(character)
    if intensity(character, "vampire_virus") ~= 1 or reached_limit(character, tiers[1]) then
        return
    end
    if not has(character, "VAMPIRE") then
        add_trait(character, "VAMPIRE")
        add_trait(character, "VAMPIRE_BLOOD_ARTS")
        message(character, ccb.services.translate("You suddenly understand that drinking someones blood will make you feel better than you've ever felt before in your life."))
        return
    end
    if not learn_power(character, tiers[1]) then
        blood_desire(character)
        tier_two(character)
    end
    delay_for_intensity(character, 5, "vampire_intensity_two_due")
end

local function escalate(character)
    if intensity(character, "vampire_virus") < 0 or intensity(character, "blood_treatment") >= 0 then
        return
    end
    tier_one(character)
    tier_two(character)
    tier_three(character)
    tier_four(character)
    if intensity(character, "vampire_virus_post_mortal") >= 1 and not reached_limit(character, tiers[5]) then
        if not has(character, "BLOOD_DRINKER") or not learn_power(character, tiers[5]) then
            blood_desire(character)
        end
    end
end

local function move_infection_to(character, tier)
    if not reached_limit(character, tiers[tier - 1]) then
        return
    end
    local result = services.effects.add(character, id("effect", "vampire_virus"), time.duration(1, "turn"),
        { permanent = true, intensity = tier })
    if not result.ok and result.error.code ~= "rejected" then
        error(result.error.message)
    end
end

ccb.runtime.handler("vampire_intensity_two_due", function(context) move_infection_to(context.character, 2) end)
ccb.runtime.handler("vampire_intensity_three_due", function(context) move_infection_to(context.character, 3) end)

local function always()
    return true
end

timers.register("vampire_infection_timer", "vampire_infection_due",
    function() return random.native_int(48 * 3600, 72 * 3600 + 15 * 60) end, always, escalate)

timers.register("vampire_hunger_timer", "vampire_hunger_due",
    function() return random.native_int(8 * 3600, 14 * 3600 + 15 * 60) end, always,
    function(character)
        if value(services.needs.get_vitamin(character, id("vitamin", "human_blood_vitamin"))) <= -450
            and intensity(character, "vampire_virus") >= 1 and has(character, "VAMPIRE") then
            message(character, ccb.services.translate("You need to consume human blood to stay alive."))
        end
    end)

local avatar_handler = "avatar_vampire_infection_due"
local function storm_interval(key, default_days)
    local stored = value(services.variables.get_global_number(key))
    return math.modf(stored.value or time.duration(default_days, "day").turns)
end
local function schedule_avatar_infection()
    if not tasks.has_avatar_turn(avatar_handler) then
        local earliest = storm_interval("ps_min_woc", 1)
        local latest = storm_interval("ps_max_woc", 2)
        tasks.ensure_avatar_turn(random.native_int(earliest, latest), avatar_handler)
    end
end

ccb.runtime.handler(avatar_handler, function(context)
    escalate(context.character)
    schedule_avatar_infection()
end)

ccb.runtime.handler("start_avatar_vampire_infection_timer", function(event)
    if event.actors.character.subtype == "avatar" then
        schedule_avatar_infection()
    end
end)
ccb.runtime.on("character_ready", "start_avatar_vampire_infection_timer")
