local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local mutations = services.mutations
local effects = services.effects
local spells = services.spells
local variables = services.variables
local shapeshift_armor = require("shapeshift_armor")

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function player_message(character, text, tone)
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate(text), tone)
    end
end

local function has_trait(character, trait_name)
    return value(mutations.has_id_text(character, trait_name))
end

local function deactivate_trait(character, trait_name)
    value(mutations.invoke_activation(character, id("mutation", trait_name), false))
end

local function effect_intensity(character, effect_name)
    local res = effects.get(character, id("effect", effect_name))
    if res.ok then
        return res.value.intensity
    end
    if res.error.code == "not_found" then
        return -1
    end
    error(res.error.message)
end

local function scale_calories(character, factor)
    local current = value(services.needs.get(character)).stored_kcal
    local delta = math.modf(current * factor - current)
    value(services.needs.modify_calories(character, delta, true))
end

local function assign_shift_activity(character, turns)
    value(services.activities.assign_timed(
        character, id("activity", "ACT_GENERIC_EOC"), services.time.duration_from_turns(turns)))
end

-- Silver claws
ccb.runtime.handler("werewolf_silver_claws_on", function(context)
    local character = context.character
    if has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") then
        value(mutations.replace(character, id("mutation", "WEREWOLF_SILVER_CLAWS_ACTIVE")))
        player_message(character, "Your claws shine like the moon.", "good")
    else
        ccb.tasks.after_character_turn(character, 0, "werewolf_silver_claws_deactivate")
    end
end)

ccb.runtime.handler("werewolf_silver_claws_off", function(context)
    value(mutations.erase(context.character, id("mutation", "WEREWOLF_SILVER_CLAWS_ACTIVE")))
end)

ccb.runtime.handler("werewolf_silver_claws_deactivate", function(context)
    deactivate_trait(context.character, "WEREWOLF_SILVER_CLAWS")
end)

-- Cure outside effects
local outside_ailment_effects = {
    "tpollen",
    "spores",
    "fungus",
    "vampire_virus",
    "hallucinogenic_acid_light",
    "hallucinogenic_acid_heavy",
    "taint",
    "migo_atmosphere",
    "glowing_gas",
    "glowing_gas_cover",
    "effect_hound_of_tindalos_slobber",
    "effect_hunting_horror_poison_light_sensitive",
    "blood_spiders",
    "effect_evil_eye",
    "vampire_need_living_blood",
}

local outside_vampire_traits = {
    "VAMPIRE",
    "VAMPIRE_TRUCE",
    "VAMPIRE_BLOOD_ARTS",
    "EYEGLEAM",
    "BLOOD_FUN",
    "VAMPIRIC_STRENGTH",
    "VAMPIRE_HEALTH_BONUS",
    "VAMPIRE_HEIGHTENED_SENSES",
    "VAMPIRE_SILENT_MOVE",
    "STAMINAFORBLOOD",
    "COMMUNE_NIGHT",
    "COAGULANTWEAVE",
    "VAMPIRE2",
    "BLOODHEAL",
    "VAMPIRIC_DODGE",
    "VAMPIRE_FEAR_GAZE",
    "VAMPIRE_FEIGN_DEATH",
    "VAMPIRE_BEAST_CLAWS",
    "VAMPIRE_SEE_HEAT",
    "VAMPIRE3",
    "VAMPIRE_WEAKNESS_MORE_BLOOD",
    "VAMPIRE_WEAKNESS_GROTESQUE",
    "VAMPIRE_WEAKNESS_EARTH_SLEEP",
    "VAMPIRE_WEAKNESS_HOLY_BURN",
    "VAMPIRE_WEAKNESS_VAST_WATER_BURN",
    "VAMPIRE_WEAKNESS_ANIMAL_HATE",
    "VAMPIRE_WEAKNESS_FIRE_VULNERABLE",
    "VAMPIRE_WEAKNESS_COLD_BLOODED",
    "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD",
    "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD",
    "VAMPIRE_WEAKNESS_BLOOD_CRAVING",
    "VAMPIRE_WEAKNESS_NO_FUN",
}

local function threshold_cost(intensity, rules)
    local total = 0
    for _, rule in ipairs(rules) do
        if intensity > rule[1] then
            total = total + rule[2]
        end
    end
    return total
end

local function read_char_number(character, key)
    local read = value(variables.get_number(character, key))
    return read.exists and read.value or 0
end

local function cure_outside_effects_mana_cost(character)
    local cost = 0
    cost = cost + threshold_cost(effect_intensity(character, "vampire_virus"), {
        { -1, 250 }, { 1, 250 }, { 2, 250 },
    })
    if has_trait(character, "VAMPIRE") then cost = cost + 250 end
    if has_trait(character, "VAMPIRE2") then cost = cost + 500 end
    if has_trait(character, "VAMPIRE3") then cost = cost + 700 end
    cost = cost + read_char_number(character, "vampire_total_tier_one_traits") * 100
    cost = cost + read_char_number(character, "vampire_total_tier_two_traits") * 150
    cost = cost + read_char_number(character, "vampire_total_tier_three_traits") * 200
    if effect_intensity(character, "tpollen") > -1 then cost = cost + 350 end
    if effect_intensity(character, "spores") > -1 then cost = cost + 100 end
    if effect_intensity(character, "fungus") > -1 then cost = cost + 500 end
    if effect_intensity(character, "hallucinogenic_acid_light") > -1 then cost = cost + 150 end
    if effect_intensity(character, "hallucinogenic_acid_heavy") > -1 then cost = cost + 300 end
    cost = cost + threshold_cost(effect_intensity(character, "taint"), {
        { -1, 200 }, { 1, 200 }, { 2, 200 }, { 3, 200 },
    })
    if effect_intensity(character, "migo_atmosphere") > -1 then cost = cost + 100 end
    if effect_intensity(character, "glowing_gas") > -1 then cost = cost + 250 end
    if effect_intensity(character, "glowing_gas_cover") > -1 then cost = cost + 150 end
    if effect_intensity(character, "effect_hound_of_tindalos_slobber") > -1 then cost = cost + 300 end
    if effect_intensity(character, "effect_hunting_horror_poison_light_sensitive") > -1 then cost = cost + 500 end
    if effect_intensity(character, "blood_spiders") > -1 then cost = cost + 200 end
    cost = cost + threshold_cost(effect_intensity(character, "effect_evil_eye"), {
        { -1, 100 }, { 1, 100 }, { 2, 100 }, { 3, 100 }, { 4, 100 },
    })
    return cost
end

ccb.runtime.handler("werewolf_cure_outside_effects", function(context)
    local character = context.character
    local cost = cure_outside_effects_mana_cost(character)
    local mana = value(spells.mana(character)).current
    if mana < cost then
        player_message(character,
            "You try to focus your mana, but you don't have enough to purge yourself from the Outsiders' ailments.",
            "bad")
        return
    end
    value(spells.set_mana_raw(character, math.modf(mana - cost)))
    player_message(character,
        "You focus your mana within your body, using it to destroy your ailments like you use your claws to destroy the Outsiders.",
        "good")
    for _, effect_name in ipairs(outside_ailment_effects) do
        value(effects.remove(character, id("effect", effect_name)))
    end
    for _, trait_name in ipairs(outside_vampire_traits) do
        value(mutations.erase(character, id("mutation", trait_name)))
    end
    value(services.needs.remove_morale(character, id("morale", "morale_vw_no_fun")))
    value(services.needs.set_vitamin(character, id("vitamin", "human_blood_vitamin"), 0))
end)

-- Regeneration
local main_limbs = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }

local function restore_blood_vitamin(character, vitamin_name)
    local vid = id("vitamin", vitamin_name)
    if value(services.needs.get_vitamin(character, vid)) < 0 then
        value(services.needs.modify_vitamin(character, vid, 150))
    end
    if value(services.needs.get_vitamin(character, vid)) < -1000 then
        value(services.needs.modify_vitamin(character, vid, 500))
    end
    if value(services.needs.get_vitamin(character, vid)) < -10000 then
        value(services.needs.modify_vitamin(character, vid, 2500))
    end
end

local function apply_werewolf_regeneration(character, heal_delta, bite_denom, infected_denom)
    if value(services.characters.snapshot(character, 0)).pain >= 1 then
        value(services.needs.modify_raw_pain(character, -1))
    end
    restore_blood_vitamin(character, "redcells")
    restore_blood_vitamin(character, "blood")

    for _, part in ipairs(main_limbs) do
        local bp = id("body_part", part)
        local hp = value(services.characters.hp(character, bp))
        local hp_max = value(services.characters.hp_max(character, bp))
        if hp < hp_max then
            value(services.characters.set_hp(character, bp, math.modf(hp + heal_delta), true))
        end
    end
    for _, part in ipairs(main_limbs) do
        local bp = id("body_part", part)
        if value(effects.has(character, id("effect", "bite"), bp)) and services.random.one_in(bite_denom) then
            value(effects.remove(character, id("effect", "bite"), bp))
        end
    end
    for _, part in ipairs(main_limbs) do
        local bp = id("body_part", part)
        if value(effects.has(character, id("effect", "infected"), bp)) and services.random.one_in(infected_denom) then
            value(effects.remove(character, id("effect", "infected"), bp))
        end
    end
    for _, part in ipairs(main_limbs) do
        local bp = id("body_part", part)
        if value(services.characters.hp(character, bp)) < value(services.characters.hp_max(character, bp)) then
            value(effects.remove(character, id("effect", "bleed"), bp))
        end
    end
end

local tier_four_traits = {
    "WEREWOLF_SUPER_FAST_REGENERATION",
    "WEREWOLF_SUMMON_FOG",
    "WEREWOLF_MOON_ARMOR",
}

local tier_five_traits = {
    "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
    "WEREWOLF_CLOSE_TEAR_IN_REALITY",
    "WEREWOLF_WALK_THROUGH_WALLS",
    "WEREWOLF_SUMMON_SHADOW_PACK",
}

local function count_traits(character, list)
    local total = 0
    for _, trait_name in ipairs(list) do
        if has_trait(character, trait_name) then
            total = total + 1
        end
    end
    return total
end

ccb.runtime.handler("werewolf_super_fast_regeneration", function(context)
    local character = context.character
    local tier4 = count_traits(character, tier_four_traits)
    local tier5 = count_traits(character, tier_five_traits)
    local heal_delta = 1 + math.min(tier4 * 0.1 + tier5 * 0.2, 3)
    apply_werewolf_regeneration(character, heal_delta, 15, 65)
end)

ccb.runtime.handler("werewolf_hybrid_form_healing", function(context)
    local character = context.character
    if not has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") then
        return
    end
    local ticks = read_char_number(character, "werewolf_healing_tick_counter") + 1
    if ticks >= 6 then
        value(variables.set(character, "werewolf_healing_tick_counter", ticks - 6, { include_before = false }))
        apply_werewolf_regeneration(character, 1, 100, 250)
    else
        value(variables.set(character, "werewolf_healing_tick_counter", ticks, { include_before = false }))
    end
end)

-- Shapeshifting forms
local function leave_wolf_form(character)
    if not has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") then
        return
    end
    assign_shift_activity(character, 1.5)
    player_message(character, "Your body shifts and contracts and you return to your humanoid form.", "neutral")
    value(mutations.erase(character, id("mutation", "VAMPIRE_WOLF_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "CARNIVORE")))
    shapeshift_armor.restore(character)
end

local function leave_hybrid_form(character)
    if not has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") then
        return
    end
    assign_shift_activity(character, 1.5)
    player_message(character, "Your body shifts and contracts and you return to your humanoid form.", "neutral")
    value(mutations.erase(character, id("mutation", "WEREWOLF_HYBRID_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "CARNIVORE")))
    scale_calories(character, 1 / 3)
    shapeshift_armor.restore(character)
end

local function leave_primal_form(character)
    if not has_trait(character, "WEREWOLF_PRIMAL_FORM_TRAITS") then
        return
    end
    assign_shift_activity(character, 1.5)
    player_message(character, "Your body shifts and contracts and you return to your humanoid form.", "neutral")
    value(mutations.erase(character, id("mutation", "WEREWOLF_PRIMAL_FORM_TRAITS")))
    value(mutations.erase(character, id("mutation", "CARNIVORE")))
    scale_calories(character, 1 / 3)
end

ccb.runtime.handler("werewolf_wolf_form_on", function(context)
    local character = context.character
    if has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") or has_trait(character, "WEREWOLF_PRIMAL_FORM_TRAITS") then
        deactivate_trait(character, "WEREWOLF_HYBRID_FORM")
        if has_trait(character, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM") then
            deactivate_trait(character, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM")
        end
    end
    if has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") then
        leave_wolf_form(character)
        return
    end
    local mana = value(spells.mana(character)).current
    if mana >= 20 then
        assign_shift_activity(character, 1.5)
        value(spells.set_mana_raw(character, mana - 20))
        shapeshift_armor.subsume(character)
        value(mutations.replace(character, id("mutation", "VAMPIRE_WOLF_FORM_TRAITS")))
        value(mutations.replace(character, id("mutation", "CARNIVORE")))
        player_message(character,
            "Your body shifts and you fall on all fours as fur sprouts from your skin and your mouth and teeth lengthen.",
            "good")
    else
        player_message(character, "You don't have enough mana to transform into a wolf.", "bad")
        ccb.tasks.after_character_turn(character, 0, "werewolf_wolf_form_deactivate")
    end
end)

ccb.runtime.handler("werewolf_wolf_form_off", function(context)
    leave_wolf_form(context.character)
end)

ccb.runtime.handler("werewolf_wolf_form_deactivate", function(context)
    deactivate_trait(context.character, "WEREWOLF_ANIMAL_FORM")
end)

ccb.runtime.handler("werewolf_hybrid_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") or has_trait(character, "WEREWOLF_PRIMAL_FORM_TRAITS") then
        deactivate_trait(character, "WEREWOLF_ANIMAL_FORM")
        if has_trait(character, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM") then
            deactivate_trait(character, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM")
        end
    end
    if has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") then
        leave_hybrid_form(character)
        return
    end
    local mana = value(spells.mana(character)).current
    if mana >= 20 then
        assign_shift_activity(character, 1.5)
        value(spells.set_mana_raw(character, mana - 20))
        scale_calories(character, 3)
        value(variables.set(character, "werewolf_healing_tick_counter", 0, { include_before = false }))
        shapeshift_armor.subsume(character)
        value(mutations.replace(character, id("mutation", "WEREWOLF_HYBRID_FORM_TRAITS")))
        value(mutations.replace(character, id("mutation", "CARNIVORE")))
        player_message(character,
            "Your body shifts and grows as enormous fangs and claws erupt from your skin and your mouth lengthens into a muzzle.",
            "good")
    else
        player_message(character, "You don't have enough mana to transform into your war form.", "bad")
        ccb.tasks.after_character_turn(character, 0, "werewolf_hybrid_form_deactivate")
    end
end)

ccb.runtime.handler("werewolf_hybrid_form_off", function(context)
    leave_hybrid_form(context.character)
end)

ccb.runtime.handler("werewolf_hybrid_form_deactivate", function(context)
    deactivate_trait(context.character, "WEREWOLF_HYBRID_FORM")
end)

ccb.runtime.handler("werewolf_primal_form_on", function(context)
    local character = context.character
    if has_trait(character, "VAMPIRE_WOLF_FORM_TRAITS") or has_trait(character, "WEREWOLF_HYBRID_FORM_TRAITS") then
        deactivate_trait(character, "WEREWOLF_HYBRID_FORM")
        deactivate_trait(character, "WEREWOLF_ANIMAL_FORM")
    end
    if has_trait(character, "WEREWOLF_PRIMAL_FORM_TRAITS") then
        leave_primal_form(character)
        return
    end
    local mana = value(spells.mana(character)).current
    if mana >= 50 then
        assign_shift_activity(character, 2.5)
        value(spells.set_mana_raw(character, mana - 50))
        scale_calories(character, 3)
        value(variables.set(character, "werewolf_healing_tick_counter", 0, { include_before = false }))
        value(mutations.replace(character, id("mutation", "WEREWOLF_PRIMAL_FORM_TRAITS")))
        value(mutations.replace(character, id("mutation", "CARNIVORE")))
        player_message(character,
            "Your body shifts and grows as you fall on all fours, and enormous fangs and claws erupt from your skin and your mouth lengthens into a muzzle as you transform into an atavistic terror.",
            "good")
    else
        player_message(character, "You don't have enough mana to transform into the primal form.", "bad")
        ccb.tasks.after_character_turn(character, 0, "werewolf_primal_form_deactivate")
    end
end)

ccb.runtime.handler("werewolf_primal_form_off", function(context)
    leave_primal_form(context.character)
end)

ccb.runtime.handler("werewolf_primal_form_deactivate", function(context)
    deactivate_trait(context.character, "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM")
end)
