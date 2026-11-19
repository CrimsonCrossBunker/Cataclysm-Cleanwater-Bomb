local ccb = require("ccb")
local services = ccb.services
local cure_early_vampirism = require("blood_treatments")
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(character, text)
    if character.subtype == "avatar" then services.messages.add(text, "good") end
end

local function add_effect(character, effect, turns)
    local result = services.effects.add(character, effect, services.time.duration_from_turns(turns))
    if not result.ok and result.error.code ~= "rejected" then checked(result) end
end

local function remove_effect(character, effect)
    checked(services.effects.remove(character, effect))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, effect))
end

local function has_mutation(character, mutation)
    return checked(services.mutations.has_id_text(character, mutation))
end

local function season()
    return checked(services.variables.get_global_number("global_what_is_the_season")).value or 0
end

local tree_form = id("effect", "effect_changeling_spring_turn_target_into_tree")
local progress = id("effect", "effect_changeling_spring_turn_target_into_tracker")
local extra_day = id("effect", "effect_changeling_spring_turn_target_one_more_day")
local tracker = id("mutation", "CHANGELING_SPRING_TURN_INTO_TREE_TRACKER")
local school = id("mutation", "CHANGELING_SEASONAL_MAGIC_SPRING")

local function spell_inputs(character)
    local count = checked(services.spells.count(character, school))
    local level = math.modf(checked(services.skills.level(character, "gramarye")))
    return count, level
end

local function min_duration(spells, skill, multiplier)
    return (172848.61 + spells * 5184.31 + skill * 29413.51) * multiplier
end

local function max_duration(spells, skill, multiplier)
    return (483844.89 + spells * 15861.23 + skill * 45945.12) * multiplier
end

local function toggle_tree(character)
    if has_effect(character, tree_form) then
        remove_effect(character, tree_form)
        remove_effect(character, progress)
        checked(services.mutations.erase(character, tracker))
        return
    end
    local spells, skill = spell_inputs(character)
    local multiplier = season() == 3 and 0.4 or 1
    local turns = services.random.native_float(min_duration(spells, skill, multiplier),
        max_duration(spells, skill, multiplier))
    add_effect(character, tree_form, math.modf(turns))
    checked(services.mutations.replace(character, tracker))
end

ccb.runtime.handler("changeling_tree_can_cast", function(context)
    return checked(services.creatures.snapshot(context.speaker)).outside
end)

ccb.runtime.handler("changeling_tree_min_duration", function(context)
    local spells, skill = spell_inputs(context.speaker)
    return (17284861 + spells * 518431 + skill * 2941351) * (season() == 3 and 0.4 or 1)
end)

ccb.runtime.handler("changeling_tree_max_duration", function(context)
    local spells, skill = spell_inputs(context.speaker)
    return (48384489 + spells * 1586123 + skill * 4594512) * (season() == 3 and 0.4 or 1)
end)

ccb.runtime.handler("changeling_tree_energy", function(context)
    local spells, skill = spell_inputs(context.speaker)
    return math.max(1800 - spells * 10 - skill * 22, 1200)
end)

ccb.runtime.handler("changeling_tree_casting_time", function(context)
    local spells, skill = spell_inputs(context.speaker)
    return math.max(30000 - spells * 125 - skill * 200, 6000)
end)

ccb.runtime.handler("changeling_tree_impact", function(impact)
    local target = impact.target_creature
    if target and target.subtype ~= "monster" then toggle_tree(target) end
end)

local infection = id("effect", "vampire_virus")
local blood_spiders = id("effect", "blood_spiders")
local gout_incubation = id("effect", "xe_hydrating_gout_incubation")
local gout = id("effect", "xe_hydrating_gout")

local function address_tree_illnesses(character)
    if has_effect(character, infection) and not has_mutation(character, "VAMPIRE")
        and services.random.native_probability(1, 1000) then
        add_effect(character, id("effect", "curevamp"), 72 * 3600)
        message(character, ccb.services.translate("The blood cravings vanish like they were cut out of you with a knife."))
    end
    if has_mutation(character, "VAMPIRE") and not has_mutation(character, "VAMPIRE4")
        and season() == 1 and services.random.native_probability(1, 20000) then
        cure_early_vampirism(character)
    end
    if has_effect(character, blood_spiders) and services.random.native_probability(1, 5000) then
        remove_effect(character, blood_spiders)
        message(character, ccb.services.translate("The itching in your veins fades away."))
    end
    if (has_effect(character, gout_incubation) or has_effect(character, gout))
        and services.random.native_probability(1, 2500) then
        remove_effect(character, gout_incubation)
        remove_effect(character, gout)
        message(character, ccb.services.translate("You suddenly feel thirsty again."))
    end
end

local body_parts = { "torso", "head", "arm_l", "arm_r", "leg_l", "leg_r" }

local function wounds_mended(character)
    for _, body_part in ipairs(body_parts) do
        local part = id("body_part", body_part)
        if checked(services.characters.hp(character, part)) ~= checked(services.characters.hp_max(character, part)) then
            return false
        end
    end
    return true
end

local function asks_to_remain(character)
    if not has_mutation(character, "VAMPIRE") then return false end
    if not (has_effect(character, infection) or has_effect(character, blood_spiders)
            or has_effect(character, gout_incubation) or has_effect(character, gout)) then
        return false
    end
    return character.subtype ~= "avatar" or ccb.presentation.confirm(ccb.services.translate(
        "Your body is healed but you are suffering from a supernatural illness.  Do you wish to remain in the form of a tree to attempt to purge it?"))
end

ccb.runtime.handler("track_changeling_tree_healing", function(context)
    local character = context.character
    local effect = services.effects.get(character, progress)
    if not effect.ok and effect.error.code ~= "not_found" then checked(effect) end
    if not effect.ok or effect.value.intensity < 60 then
        add_effect(character, progress, 600)
        return
    end

    address_tree_illnesses(character)
    if not wounds_mended(character) or has_effect(character, extra_day) then
        remove_effect(character, progress)
    elseif asks_to_remain(character) then
        remove_effect(character, progress)
        add_effect(character, extra_day, 24 * 3600)
    else
        toggle_tree(character)
    end
end)
