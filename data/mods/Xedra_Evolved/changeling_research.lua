local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local trait_cost = "changeling_new_trait_dreamdross_research_cost"
local dream_counter = "changeling_advancement_dreams_counter"
local glamour_cost = "changeling_seasonal_magic_dreamdross_research_cost"
local glamour_cost_step = "changeling_seasonal_magic_dreamdross_research_cost_modifier"
local daydreaming = content.text("daydreaming")

-- Successor traits can share a category but cannot all be present together.
local mortal_limits = {
    { "FAIR_FOLK_NOBLE", 31 },
    { "FAIR_FOLK_COMMONER_BROWNIE", 31 },
    { "FAIR_FOLK_COMMONER_POOKA", 40 },
    { "FAIR_FOLK_COMMONER_SELKIE", 30 },
    { "FAIR_FOLK_COMMONER_TROW", 27 },
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function store(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function reached_mortal_limit(character)
    for _, limit in ipairs(mortal_limits) do
        local count = checked(services.mutations.category_count(character,
            id("mutation_category", limit[1]), "ALL", true))
        if count >= limit[2] then
            return true
        end
    end
    return false
end

ccb.runtime.handler("finish_changeling_trait_research", function(activity)
    local character = activity.character
    local avatar = character.subtype == "avatar"
    if avatar then
        services.messages.add(services.translate("You sit back with a smile.  It is done."), "good")
    end
    local cost = math.modf(number(character, trait_cost))
    checked(services.inventory.consume_by_type(character, id("item", "scrap_dreamdross"), cost, 0))
    store(character, trait_cost, number(character, trait_cost) + 35)
    store(character, dream_counter, number(character, dream_counter) + 1)
    if reached_mortal_limit(character) and avatar then
        ccb.presentation.notice(services.translate(
            "You have reached the pinnacle of power possible in the mortal lands.  For any greater advancements, you'll need to travel Under the Hill."))
        services.activities.offer_interruption("")
    end
end, 1)

content.add(content.ActivityType {
    id = "ACT_CHANGELING_RESEARCH_NEW_POWERS",
    verb = daydreaming,
    based_on = "time",
    activity_level = 2,
    can_resume = false,
}:on_finish("finish_changeling_trait_research"))

local seasons = {
    {
        name = "SPRING",
        done = function()
            return services.translate("You are a mighty sorcerer, and the power of spring has but few secrets which are unknown to you.")
        end,
        tiers = {
            {
                "changeling_spring_summon_grass_field_spell",
                "changeling_spring_minor_restore_stamina_and_pain_spell",
                "changeling_spring_reduce_scent_spell",
            },
            {
                "changeling_spring_growing_plants_spell",
                "changeling_spring_prevent_bad_conditions_spell",
                "changeling_spring_summon_flower_warriors_spell",
            },
            {
                "changeling_spring_protective_plant_armor_spell",
                "changeling_spring_remove_fatigue_and_sleep_deprivation_spell",
                "changeling_spring_summon_rain_shower_spell",
                "changeling_spring_enchanted_butterfly_wings_spell",
            },
            {
                "changeling_spring_healing_increase_while_outside_spell",
                "changeling_spring_summon_smashing_plants_spell",
                "changeling_spring_fertilize_plant_aoe_spell",
            },
            {
                "changeling_spring_charm_control_target_spell",
                "changeling_spring_turn_target_into_tree_spell",
            },
        },
    },
    {
        name = "SUMMER",
        done = function()
            return services.translate("You are a mighty sorcerer, and the power of summer has but few secrets which are unknown to you.")
        end,
        tiers = {
            {
                "changeling_summer_light_spell",
                "changeling_summer_light_fire_spell",
                "changeling_summer_sun_glasses_spell",
            },
            {
                "changeling_summer_fire_melee_damage_spell",
                "changeling_summer_jump_distance_spell",
                "changeling_summer_protect_from_hot_weather_spell",
                "changeling_summer_absorb_strength_spell",
            },
            {
                "changeling_summer_run_for_long_periods_spell",
                "changeling_summer_bonus_stamina_near_enemies_spell",
                "changeling_summer_slow_and_sweat_debuff_spell",
                "changeling_summer_lightning_bolt_from_storm_spell",
            },
            {
                "changeling_summer_create_thunderstorm_spell",
                "changeling_summer_ring_of_flames_spell",
            },
            {
                "changeling_summer_powerful_sunlight_spell",
                "changeling_summer_combat_prowess_powerful_buff_spell",
            },
        },
    },
    {
        name = "AUTUMN",
        done = function()
            return services.translate("You are a mighty sorcerer, and the power of autumn has but few secrets which are unknown to you.")
        end,
        tiers = {
            {
                "changeling_autumn_scare_animals_spell",
                "changeling_autumn_touch_of_frailty_spell",
                "changeling_autumn_detect_magic_user_spell",
                "changeling_autumn_clean_nearby_spills_spell",
            },
            {
                "changeling_autumn_damage_plants_spell",
                "changeling_autumn_call_mists_spell",
                "changeling_autumn_harm_and_stun_robots_spell",
            },
            {
                "changeling_autumn_protection_from_ranged_spell",
                "changeling_autumn_scare_humans_spell",
                "changeling_autumn_stop_supernatural_healing_spell",
            },
            {
                "changeling_autumn_create_confusion_mist_spell",
                "changeling_autumn_plants_to_harvest_spell",
                "changeling_autumn_freeze_in_place_spell",
            },
            {
                "changeling_autumn_time_fells_mighty_warrior",
                "changeling_autumn_giant_withering_aoe_spell",
            },
        },
    },
    {
        name = "WINTER",
        done = function()
            return services.translate("You are a mighty sorcerer, and the power of winter has but few secrets which are unknown to you.")
        end,
        tiers = {
            {
                "changeling_winter_walk_on_water_spell",
                "changeling_winter_freeze_target_in_place_spell",
                "changeling_winter_walk_in_silence",
                "changeling_winter_create_field_of_ice_spell",
                "changeling_winter_walk_on_the_snow",
            },
            {
                "changeling_winter_frozen_breath_spell",
                "changeling_winter_feign_death_spell",
                "changeling_winter_silence_spell",
                "changeling_winter_stop_bleeding_spell",
                "changeling_winter_blinding_spell",
            },
            {
                "changeling_winter_neutralize_morale_spell",
                "changeling_winter_see_craft_darkness_spell",
            },
            {
                "changeling_winter_hail_attack_spell",
                "changeling_winter_close_the_reality_tear_spell",
            },
            {
                "changeling_winter_pure_area_darkness_spell",
                "changeling_winter_cut_off_fey_nature_spell",
            },
        },
    },
}

local function pay_glamour_cost(character)
    local cost = math.modf(number(character, glamour_cost))
    local dreamdross = id("item", "scrap_dreamdross")
    if checked(services.inventory.has_items(character, dreamdross, cost, 0)) then
        checked(services.inventory.consume_by_type(character, dreamdross, cost, 0))
    elseif character.subtype == "avatar" then
        services.messages.add(services.translate(
            "Somehow, you researched a glamour without having enough dreamdross for it.  Please report this bug."),
            "debug")
    end
end

local function learn_glamour(character, season)
    pay_glamour_cost(character)
    local school = id("mutation", "CHANGELING_SEASONAL_MAGIC_" .. season.name)
    local cutoff = 90 - checked(services.spells.count(character, school))
    local first_tier = 1
    while first_tier < #season.tiers and services.random.native_int(0, 99) >= cutoff do
        first_tier = first_tier + 1
    end

    -- Once a tier is selected, an empty pool advances without another tier roll.
    for tier = first_tier, #season.tiers do
        local pool = {}
        for index, spell in ipairs(season.tiers[tier]) do
            pool[index] = id("spell", spell)
        end
        local choice = checked(services.progression.grant_random_missing(character, "spell", pool))
        if choice.granted then
            if character.subtype == "avatar" then
                local message = services.translate("Your research bears fruit!  You learn the %s glamour.")
                services.messages.add(services.format(message, { choice.name }), "neutral")
            end
            store(character, glamour_cost, number(character, glamour_cost) + number(character, glamour_cost_step))
            return
        end
    end
    if character.subtype == "avatar" then
        services.messages.add(season.done(), "mixed")
    end
end

for _, season in ipairs(seasons) do
    local handler = "finish_changeling_glamour_" .. season.name:lower()
    ccb.runtime.handler(handler, function(activity)
        learn_glamour(activity.character, season)
    end, 1)
    content.add(content.ActivityType {
        id = "ACT_CHANGELING_RESEARCH_SEASONAL_MAGIC_" .. season.name,
        verb = daydreaming,
        based_on = "time",
        activity_level = 2,
        can_resume = false,
    }:on_finish(handler))
end
