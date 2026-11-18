local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local stages = {
    {
        id = "ACT_MOM_SHADOW_URGE_GAIN_STRENGTH",
        success = {
            first = "STR_UP",
            upgraded = "STR_UP_2",
            alternatives = { "STRONGBACK", "STRONG_LEGS_MOM" },
        },
        failure = {
            first = "WEAK_MOM",
            upgraded = "WEAK_MOM_2",
            alternatives = { "BADKNEES", "LIGHT_BONES", "LIGHTWEIGHT", "BADBACK" },
        },
        debug = true,
    },
    {
        id = "ACT_MOM_SHADOW_URGE_GAIN_AGILITY",
        success = {
            first = "DEX_UP",
            upgraded = "DEX_UP_2",
            alternatives = { "FLEET", "QUICK" },
        },
        failure = {
            first = "CLUMSY_MOM",
            upgraded = "CLUMSY_MOM_2",
            alternatives = { "JITTERY", "CLUMSY" },
        },
    },
    {
        id = "ACT_MOM_SHADOW_URGE_GAIN_RESILIENCE",
        success = {
            first = "TOUGH",
            upgraded = "TOUGH2",
            alternatives = { "THICKSKIN", "TOUGH_FEET" },
        },
        failure = {
            first = "FLIMSY",
            upgraded = "FLIMSY2",
            alternatives = { "LIGHT_BONES", "GLASSJAW" },
        },
    },
    {
        id = "ACT_MOM_SHADOW_URGE_GAIN_RECOVERY",
        success = {
            first = "FASTHEALER",
            upgraded = "FASTHEALER2",
            alternatives = { "PAINREC1", "PAINRESIST" },
        },
        failure = {
            first = "SLOWHEALER",
            upgraded = "SLOWHEALER2",
            alternatives = { "MORE_PAIN", "WEAKSTOMACH" },
        },
    },
}

local disciplines = {
    "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC",
    "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC",
}

local concentration = {
    { id = "prof_concentration_basic", modifier = 5 },
    { id = "prof_concentration_intermediate", modifier = 10 },
    { id = "prof_concentration_master", modifier = 20 },
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function calculate_chance(character)
    local awakenings = 0
    for _, discipline in ipairs(disciplines) do
        if has_trait(character, discipline) then
            awakenings = awakenings + 1
        end
    end
    awakenings = awakenings + checked(services.spells.count(character, id("mutation", "PSYCHIC_KNACK"))) * 0.25

    local modifier = awakenings * -10
    for _, proficiency in ipairs(concentration) do
        if checked(services.proficiencies.has_id_text(character, proficiency.id)) then
            modifier = modifier + proficiency.modifier
        end
    end
    modifier = math.max(-90, math.min(35, modifier))
    return 97 + modifier, awakenings, modifier
end

local function show_debug_value(text, field, value)
    services.messages.add(text:gsub("<context_val:" .. field .. ">", string.format("%.15g", value)), "debug")
end

local outcomes = {}
for _, stage in ipairs(stages) do
    outcomes[stage.id] = stage
end

ccb.runtime.handler("finish_shadow_urge", function(activity)
    local character = activity.character
    local position = checked(services.creatures.snapshot(character)).position
    checked(services.world.spawn_item(position, id("item", "matrix_crystal_drained"), 1, true))

    local stage = outcomes[activity.activity_type_id]
    local chance, awakenings, modifier = calculate_chance(character)
    if stage.debug and character.subtype == "avatar" then
        show_debug_value(ccb.services.translate("Awakening calculation is <context_val:awakenings>."), "awakenings", awakenings)
        show_debug_value(ccb.services.translate("Modifier calculation is <context_val:calculations>."), "calculations", modifier)
        show_debug_value(ccb.services.translate("Success chance is is <context_val:success_chance>."), "success_chance", chance)
    end

    local success = services.random.native_probability(chance, 100)
    local outcome = success and stage.success or stage.failure
    local preferred = has_trait(character, outcome.first) and outcome.upgraded or outcome.first
    local candidates = { id("mutation", preferred) }
    for _, alternative in ipairs(outcome.alternatives) do
        candidates[#candidates + 1] = id("mutation", alternative)
    end
    checked(services.progression.grant_random_missing(character, "mutation", candidates))
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("You come to, a bit groggy, and experimentally try to move.  You feel…different."),
            success and "good" or "bad")
    end
end, 1)

for _, stage in ipairs(stages) do
    content.add(content.ActivityType {
        id = stage.id,
        verb = ccb.content.text("undergoing the SHADOW URGE process"),
        based_on = "time",
        activity_level = 1,
        can_resume = false,
        interruptable = false,
    }:on_finish("finish_shadow_urge"))
end
