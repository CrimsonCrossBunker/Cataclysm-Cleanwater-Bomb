local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local communion = "ACT_BLOODTHORNE_DRUID_COMMUNION"
local ready = "effect_bloodthorn_druid_upgrade_ready"
local active = "effect_bloodthorn_druid_upgrade_active"
local whip = "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP"
local aura = "BLOODTHORNE_DRUID_AURA_OF_VINES"
local thorn_prison = "BLOODTHORNE_DRUID_CREATE_THORN_PRISON"
local required_kills = "bloodthorn_druid_vampires_killed_to_upgrade"
local required_traits = "bloodthorn_druid_required_arvore_traits"
local recorded_kills = "bloodthorn_druid_vampire_heartwhip_kills"

local nearby_great_tree = {
    "great_tree_z0_nw",
    "great_tree_z0_se",
    "great_tree_z1_nw",
    "great_tree_z1_se",
    "great_tree_z2_nw",
    "great_tree_z2_se",
    "great_tree_z3_06",
    "great_tree_z3_11",
    "great_tree_z4_06",
    "great_tree_z4_11",
    "great_tree_z5_06",
    "great_tree_z5_11",
    "great_tree_z6_nw",
    "great_tree_z6_se",
    "great_tree_z6_n2",
    "great_tree_z6_se",
    "great_tree_z7_nw",
    "great_tree_z7_se",
    "great_tree_crown_06",
    "great_tree_crown_11",
    "great_tree_crown_top_01",
    "great_tree_crown_top_04",
    "great_tree_roots",
    "great_tree_roots_se",
    "great_tree_roots_nw",
}
local first_gifts = {
    "BLOODTHORNE_DRUID_REGAIN_BLOOD",
    "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
    "BLOODTHORNE_DRUID_STOP_BLEEDING",
    "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
    "BLOODTHORNE_DRUID_GAIN_STRENGTH_DEXTERITY_BUFF",
    "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE",
}
local second_gifts = {
    "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
    "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
    "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
    "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, severity)
    if character.subtype ~= "npc" then
        services.messages.add(text, severity)
    end
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, id("effect", effect)))
end

local function add_trait(character, trait)
    checked(services.mutations.replace(character, id("mutation", trait)))
end

local function number(character, name)
    return checked(services.variables.get_number(character, name)).value or 0
end

local function store(character, name, value)
    checked(services.variables.set(character, name, value, { include_before = false }))
end

local function overmap_position(character)
    return checked(services.creatures.snapshot(character)).position:project_to("omt")
end

local function is_communion_site(character)
    if services.overmap.matches_location_near(overmap_position(character), "road", 2) then
        return false
    end
    if services.overmap.matches_location(overmap_position(character), "forest_thick") then
        return true
    end
    for _, terrain in ipairs(nearby_great_tree) do
        if services.overmap.matches_location_near(overmap_position(character), terrain, 2) then
            return true
        end
    end
    return false
end

local function grant_a_gift(character, gifts)
    local candidates = {}
    for index, trait in ipairs(gifts) do
        candidates[index] = id("mutation", trait)
    end
    return checked(services.progression.grant_random_missing(character, "mutation", candidates)).granted
end

local function advance_research(character)
    local threshold = number(character, required_kills)
    store(character, required_kills, threshold < 16 and threshold + 2 or 16)
    store(character, required_traits, number(character, required_traits) + 1)
    store(character, recorded_kills, 0)
    checked(services.effects.remove(character, id("effect", ready)))
    message(character, services.translate("The twitching of your heartvines subsides.  You have unlocked new gifts of nature."), "good")
end

ccb.runtime.handler("finish_heartvine_communion", function(payload)
    local character = payload.character
    if not has_trait(character, whip) then
        add_trait(character, whip)
        message(character, services.translate("You feel the heartvines extending themselves into your arms, coiling and lurking near your wrists.  With a moment's concentration, you could extend part of them into a whip and scourge the blood-drinkers with it, and in doing so, feed your heartvines.  Call them forth and rid the world of the vampiric scourge.\n\nKills with the heartwhip will empower your heartvines; enough kills and further gifts will be revealed to you."), "good")
        store(character, required_kills, 5)
        store(character, required_traits, 4)
        for _, arm in ipairs { "arm_l", "arm_r" } do
            local duration = services.time.duration(services.random.native_int(1800, 7200), "turn")
            checked(services.effects.add(character, id("effect", "formication"), duration,
                { body_part = id("body_part", arm) }))
        end
    elseif grant_a_gift(character, first_gifts) then
        advance_research(character)
    elseif not has_trait(character, aura) then
        add_trait(character, aura)
        advance_research(character)
    elseif grant_a_gift(character, second_gifts) then
        advance_research(character)
    elseif not has_trait(character, thorn_prison) then
        add_trait(character, thorn_prison)
        message(character, services.translate("You've reached the pinnacle of druidic powers.  Now the blood-drinkers will tremble."), "good")
    end
end, 1)

ccb.runtime.handler("start_heartvine_communion", function(payload)
    local character = payload.character
    for _ = 1, payload.batch do
        if not has_effect(character, ready) then
            message(character, services.translate("Your heartvine is not ready to grow.  You must water it with vampire blood."), "bad")
        elseif not is_communion_site(character) then
            message(character, services.translate("You must commune with nature in the wild places.  Seek the depths of the sylvan wilderness."), "mixed")
        else
            local duration = services.time.duration(8, "hour")
            checked(services.effects.add(character, id("effect", active), duration))
            local assigned = services.activities.assign_timed(character, id("activity", communion), duration)
            if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
                checked(assigned)
            end
        end
    end
end, 1)

ccb.runtime.handler("interrupt_heartvine_communion", function(event)
    if event.data.activity == communion and event.data.canceled then
        local character = event.actors.character or services.characters.avatar()
        checked(services.effects.remove(character, id("effect", active)))
    end
end, 1)
ccb.runtime.on("game:character_finished_activity", "interrupt_heartvine_communion")

content.add(content.ActivityType {
    id = communion,
    verb = content.text("communing with nature"),
    based_on = "time",
    activity_level = 2,
}:on_finish("finish_heartvine_communion"))

content.add(content.Recipe {
    id = "xe_bloodthorn_druid_upgrade_recipe",
    name = content.text("heartvine communion"),
    description = content.text("Your heartvine has drunk up enough vampire blood that it is ready to grant you a new gift.  Seek out the wild places to allow it to grow."),
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    skill = "deduction",
    difficulty = 0,
    duration_moves = 0,
    activity_level = 2,
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    scripted_output = true,
}:on_complete("start_heartvine_communion"))
