local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function expand(ctx, text)
    local point = ctx.position
    local position = services.coords.tripoint_abs_ms(point.x, point.y, point.z)
    return checked(services.text.expand_for(text, ctx.character, nil, nil,
        { this = ctx.furniture_id, pos = position }, true))
end

local function has_trait(actor, trait)
    return checked(services.mutations.has_id_text(actor, trait))
end

local function trait_set(list)
    local result = {}
    for _, item in ipairs(list) do
        result[item] = true
    end
    return result
end

local schools = {
    "ANIMIST",
    "BIOMANCER",
    "DRUID",
    "EARTHSHAPER",
    "KELVINIST",
    "MAGUS",
    "STORMSHAPER",
    "TECHNOMANCER",
}

local mastery_proficiencies = {
    "prof_magic_evocation_master",
    "prof_magic_channel_master",
    "prof_magic_summon_master",
    "prof_magic_enhancement_master",
    "prof_magic_enervation_master",
    "prof_magic_conveyance_master",
    "prof_magic_restoration_master",
    "prof_magic_transformation_master",
}

local allow_a = trait_set { "BLOOD_MAGE", "SHAMAN", "SHAPESHIFTER", "WITHER_MAGE" }
local allow_b = trait_set { "CLEANSING_FLAME", "FIRE_ELEMENTAL", "ICE_ELEMENTAL", "STORMCALLER", "STORM_ELEMENTAL", "TUNDRA_MAGE" }
local allow_c = trait_set { "FORCE_MAGE", "PERMAFROST_MAGE", "RADIATION_MAGE", "SUN_MAGE" }
local allow_c_plus = trait_set { "FORCE_MAGE", "PERMAFROST_MAGE", "RADIATION_MAGE", "SOULFIRE", "SUN_MAGE", "VOID_MAGE" }
local allow_d = trait_set { "ARTIFICER", "BOREAL_MAGE", "GLACIER_MAGE", "MAGNETISM_MAGE", "OVERCLOCKER", "VULCANIST" }
local allow_e = trait_set { "ALCHEMIST", "GOLEMANCER", "GRAVITY_MAGE", "ILLUSIONIST" }
local allow_f = trait_set { "BIOTEK", "CRUSADER", "EARTH_ELEMENTAL", "GAIAS_CHOSEN" }
local allow_f_shaman = trait_set { "BIOTEK", "CRUSADER", "EARTH_ELEMENTAL", "GAIAS_CHOSEN", "PERMAFROST_MAGE" }

local attunements = {
    { trait = "ARTIFICER", schools = { "STORMSHAPER", "TECHNOMANCER" }, allowed = allow_a },
    { trait = "ALCHEMIST", schools = { "ANIMIST", "TECHNOMANCER" }, allowed = allow_b },
    { trait = "BIOTEK", schools = { "BIOMANCER", "TECHNOMANCER" }, allowed = allow_c },
    { trait = "BLOOD_MAGE", schools = { "BIOMANCER", "ANIMIST" }, allowed = allow_d },
    {
        trait = "BOREAL_MAGE",
        schools = { "KELVINIST", "TECHNOMANCER" },
        allowed = allow_a,
        grants = { "BOREAL_MAGE", "BOREAL_MAGE_COLD_AURA" },
    },
    { trait = "CLEANSING_FLAME", schools = { "DRUID", "KELVINIST" }, allowed = allow_e },
    { trait = "CRUSADER", schools = { "DRUID", "TECHNOMANCER" }, allowed = allow_c_plus },
    { trait = "EARTH_ELEMENTAL", schools = { "BIOMANCER", "EARTHSHAPER" }, allowed = allow_c_plus },
    { trait = "FIRE_ELEMENTAL", schools = { "BIOMANCER", "KELVINIST" }, allowed = allow_e },
    { trait = "FORCE_MAGE", schools = { "MAGUS", "STORMSHAPER" }, allowed = allow_f },
    { trait = "GAIAS_CHOSEN", schools = { "DRUID", "EARTHSHAPER" }, allowed = allow_c_plus },
    {
        trait = "GLACIER_MAGE",
        schools = { "EARTHSHAPER", "KELVINIST" },
        allowed = allow_a,
        grants = { "FROZEN_PRESSURE_OFF", "GLACIER_MAGE" },
    },
    { trait = "GOLEMANCER", schools = { "ANIMIST", "EARTHSHAPER" }, allowed = allow_b },
    { trait = "GRAVITY_MAGE", schools = { "EARTHSHAPER", "MAGUS" }, allowed = allow_b },
    { trait = "ICE_ELEMENTAL", schools = { "BIOMANCER", "KELVINIST" }, allowed = allow_e },
    { trait = "ILLUSIONIST", schools = { "MAGUS", "TECHNOMANCER" }, allowed = allow_b },
    { trait = "MAGNETISM_MAGE", schools = { "EARTHSHAPER", "STORMSHAPER" }, allowed = allow_a },
    { trait = "OVERCLOCKER", schools = { "KELVINIST", "TECHNOMANCER" }, allowed = allow_a },
    { trait = "PERMAFROST_MAGE", schools = { "KELVINIST", "MAGUS" }, allowed = allow_f },
    {
        trait = "RADIATION_MAGE",
        schools = { "ANIMIST", "STORMSHAPER" },
        allowed = allow_f,
        grants = { "CLAIRVOYANCE_OFF", "RADIATION_MAGE" },
    },
    {
        trait = "SHAMAN",
        schools = { "ANIMIST", "DRUID" },
        allowed = allow_f_shaman,
        grants = { "MIND_READ_OFF", "SHAMAN" },
    },
    { trait = "SHAPESHIFTER", schools = { "BIOMANCER", "MAGUS" }, allowed = allow_d },
    {
        trait = "SOULFIRE",
        schools = { "ANIMIST", "KELVINIST" },
        allowed = allow_f,
        grants = { "SOUL_PRESSURE_OFF", "SOULFIRE" },
    },
    { trait = "STORM_ELEMENTAL", schools = { "BIOMANCER", "STORMSHAPER" }, allowed = allow_e },
    { trait = "STORMCALLER", schools = { "DRUID", "STORMSHAPER" }, allowed = allow_e },
    { trait = "SUN_MAGE", schools = { "KELVINIST", "MAGUS" }, allowed = allow_f },
    {
        trait = "TUNDRA_MAGE",
        schools = { "DRUID", "KELVINIST" },
        allowed = allow_e,
        grants = { "FREEZING_AURA_OFF", "TUNDRA_MAGE" },
    },
    { trait = "VOID_MAGE", schools = { "ANIMIST", "KELVINIST" }, allowed = allow_f },
    { trait = "VULCANIST", schools = { "EARTHSHAPER", "KELVINIST" }, allowed = allow_a },
    {
        trait = "WITHER_MAGE",
        schools = { "DRUID", "MAGUS" },
        allowed = allow_d,
        grants = { "TOXIC_AURA_OFF", "WITHER_MAGE" },
    },
}

local function has_conflicting_attunement(owned, entry)
    if owned["MAGIC_EMPTY"] or owned[entry.trait] then
        return true
    end
    for trait in pairs(owned) do
        if trait ~= entry.trait and not entry.allowed[trait] then
            return true
        end
    end
    return false
end

local function check_proficiency_mastery(actor)
    for _, proficiency in ipairs(mastery_proficiencies) do
        if checked(services.proficiencies.has_id_text(actor, proficiency)) then
            return true
        end
    end
    return false
end

local failure_entries = {
    {
        id = "not_a_mage",
        check = function(s) return not s.is_mage end,
        severity = "neutral",
        message = "The altar does not respond to your touch.  Only a mage can unlock its secrets.",
    },
    {
        id = "not_enough_spells",
        check = function(s) return s.is_mage and not s.two_schools_count end,
        severity = "bad",
        message = "The altar does not respond to your touch.  You need more breadth in your spell selection before you can attempt attunement.",
    },
    {
        id = "not_enough_spell_levels",
        check = function(s) return s.is_mage and s.two_schools_count and not s.two_schools_levels end,
        severity = "bad",
        message = "The altar does not respond to your touch.  While you know many spells, your knowledge of them is still too shallow.",
    },
    {
        id = "not_enough_proficiencies",
        check = function(s)
            return s.is_mage and s.two_schools_count and s.two_schools_levels and not s.proficiency_met
        end,
        severity = "bad",
        message = "The altar does not respond to your touch.  While your knowledge of spells is considerable, your understanding of the fundamentals of spellcasting needs work.",
    },
    {
        id = "no_level_fifteen_spell",
        check = function(s)
            return s.is_mage and s.two_schools_count and s.two_schools_levels and s.proficiency_met
                and not s.level15_met
        end,
        severity = "bad",
        message = "The altar does not respond to your touch.  Your spell knowledge is broad and deep, but you must master at least one spell to level 15 before attempting attunement.",
    },
}

ccb.runtime.handler("examine_f_attunement_altar", function(ctx)
    local actor = ctx.character
    local required_spell_count = 9
    local required_spell_levels = 120

    local has_school = {}
    local spell_count = {}
    local level_sum = {}
    local level15_sum = {}
    local is_mage = false
    local schools_with_count = 0
    local schools_with_levels = 0
    local qualified_schools = 0
    local high_level_schools = 0

    for _, school in ipairs(schools) do
        local school_id = id("mutation", school)
        local present = has_trait(actor, school)
        local count = checked(services.spells.count(actor, school_id))
        local sum = checked(services.spells.level_sum(actor, school_id))
        local high = checked(services.spells.level_sum(actor, school_id, 15))
        has_school[school] = present
        spell_count[school] = count
        level_sum[school] = sum
        level15_sum[school] = high
        if present then
            is_mage = true
        end
        if count >= required_spell_count then
            schools_with_count = schools_with_count + 1
        end
        if sum >= required_spell_levels then
            schools_with_levels = schools_with_levels + 1
        end
        if present and count >= required_spell_count and sum >= required_spell_levels then
            qualified_schools = qualified_schools + 1
            if high > 0 then
                high_level_schools = high_level_schools + 1
            end
        end
    end

    local owned_attunements = {}
    for _, entry in ipairs(attunements) do
        if has_trait(actor, entry.trait) then
            owned_attunements[entry.trait] = true
        end
    end
    if has_trait(actor, "MAGIC_EMPTY") then
        owned_attunements["MAGIC_EMPTY"] = true
    end

    local summary = {
        is_mage = is_mage,
        two_schools_count = schools_with_count >= 2,
        two_schools_levels = schools_with_levels >= 2,
        level15_met = qualified_schools >= 2 and high_level_schools >= 1,
        proficiency_met = check_proficiency_mastery(actor),
    }

    local actions = {}
    local menu = {}
    for _, entry in ipairs(attunements) do
        local s1, s2 = entry.schools[1], entry.schools[2]
        if has_school[s1] and has_school[s2]
            and not has_conflicting_attunement(owned_attunements, entry)
            and spell_count[s1] >= required_spell_count and spell_count[s2] >= required_spell_count
            and level_sum[s1] >= required_spell_levels and level_sum[s2] >= required_spell_levels
            and level15_sum[s1] + level15_sum[s2] > 0
            and summary.proficiency_met then
            actions[#actions + 1] = { kind = "grant", entry = entry }
            menu[#menu + 1] = {
                id = entry.trait,
                label = expand(ctx, "<trait_name:" .. entry.trait .. ">"),
                description = expand(ctx, "<trait_description:" .. entry.trait .. ">"),
            }
        end
    end

    local touch_label = expand(ctx, ccb.services.translate("Touch the altar"))
    for _, failure in ipairs(failure_entries) do
        if failure.check(summary) then
            actions[#actions + 1] = {
                kind = "fail",
                severity = failure.severity,
                message = failure.message,
            }
            menu[#menu + 1] = {
                id = failure.id,
                label = touch_label,
                description = touch_label,
            }
        end
    end

    actions[#actions + 1] = { kind = "cancel" }
    menu[#menu + 1] = {
        id = "back_away",
        label = expand(ctx, ccb.services.translate("Back away")),
        description = expand(ctx, ccb.services.translate("Leave the altar alone")),
    }

    local selection = services.interaction.choose(menu, {
        title = expand(ctx, ccb.services.translate("You reach out to touch the attunement altar.")),
        allow_cancel = true,
        show_descriptions = true,
    })
    local picked = selection.index and actions[selection.index]
    if not picked then
        return
    end
    if picked.kind == "grant" then
        local traits = picked.entry.grants or { picked.entry.trait }
        for _, trait in ipairs(traits) do
            checked(services.mutations.replace(actor, id("mutation", trait)))
        end
        if actor.subtype == "avatar" then
            services.messages.add(ccb.services.translate(
                "As you touch the altar, you feel your ley lines twitch before they reconfigure themselves into new patterns.  Power flows through your body in a torrent along the new channels.  You have attained attunement, the rarest of all magical accomplishments."),
                "good")
        end
    elseif picked.kind == "fail" and actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate(picked.message), picked.severity)
    end
end)
