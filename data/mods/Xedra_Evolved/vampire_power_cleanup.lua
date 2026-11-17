local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local dream_traits = {
    "DREAMER",
    "DREAMSMITH",
    "EATER",
    "INVENTOR",
}

local research_recipes = {
    "inventor_research_energy_1",
    "inventor_research_energy_2",
    "inventor_research_energy_3",
    "inventor_research_base_2",
    "inventor_research_base_3",
    "inventor_research_ai_1",
    "inventor_research_dimension_1",
    "dreamsmith_research",
}

local other_dream_recipes = {
    "trinket_damage",
    "trinket_range",
    "trinket_sound",
    "choke_wideshot",
    "mod_inv_pistol_booster",
    "mod_inv_pistol_double_tap",
    "stunning_qr_trap",
    "stunning_arg_trap",
    "inventor_light_minus_cell",
    "inventor_light_cell",
    "inventor_medium_cell",
    "inventor_heavy_cell",
    "inventor_lasmod_mega_capasitor",
    "inventor_lasmod_adv_adv_cooler",
    "inventor_lasmod_recuperator",
    "inventor_lasmod_mega_everything",
    "inventor_lasmod_more_capacitors",
    "inventor_lasmod_close_range",
    "inventor_lasmod_long_range",
    "inventor_lasmod_capasitor",
    "inventor_lasmod_energy_safe",
    "inventor_lasmod_adv_cooler",
    "inventor_lasmod_radiator",
    "inventor_lasmod_chonky_radiator",
    "inventor_lasmod_spooky_heat_sink",
    "dreamdross_lump",
    "forged_dreamstuff_ingot",
    "dreamforged_nail",
    "software_math_inventor",
    "software_electronics_reference_inventor",
    "nre_recorder_inventor",
    "teleporter_inventor",
}

local function forget_recipes(character, recipes)
    for _, name in ipairs(recipes) do
        value(services.recipes.forget(character, id("recipe", name)))
    end
end

local function remove_dream_magic(character)
    for _, trait in ipairs(dream_traits) do
        value(services.mutations.erase(character, id("mutation", trait)))
    end
    value(services.mutations.mutate_towards(character, id("mutation", "DREAMLESS"), nil, false))

    local category = id("crafting_category", "CC_XEDRA")
    value(services.recipes.forget_category(character, category, "CSC_XEDRA_ARMOR"))
    forget_recipes(character, research_recipes)
    value(services.recipes.forget_category(character, category, "CSC_XEDRA_ROBOTS"))
    value(services.recipes.forget_category(character, category, "CSC_XEDRA_TOOLS"))
    value(services.recipes.forget_category(character, category, "CSC_XEDRA_WEAPONS"))
    forget_recipes(character, other_dream_recipes)
end

local werewolf_traits = {
    "NATIVE_SHAPESHIFTER",
    "WEREWOLF_ANIMAL_FORM",
    "WEREWOLF_HYBRID_FORM",
    "WEREWOLF_SPELLS",
    "WEREWOLF_MANA_TRAIT",
    "WEREWOLF_SMELL_NEARBY_ENEMIES",
    "WEREWOLF_NO_SCENT",
    "WEREWOLF_ILLUMINATE_TARGET",
    "WEREWOLF_FRIEND_TO_ANIMALS",
    "WEREWOLF_SMASH_TERRAIN",
    "WEREWOLF_CLIMB_IN_WOLF_FORM",
    "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
    "WEREWOLF_SENSE_SPIRITS_AND_ALIENS_ACTIVE",
    "WEREWOLF_STUN_MACHINE",
    "WEREWOLF_EXTRA_WEAKPOINT_HITS",
    "WEREWOLF_FAR_JUMP",
    "WEREWOLF_CAMOUFLAGE_COAT",
    "WEREWOLF_PARTIAL_SHIFT",
    "WEREWOLF_SILVER_CLAWS",
    "WEREWOLF_SILVER_CLAWS_ACTIVE",
    "WEREWOLF_MANA_BONUS_AFTER_KILL",
    "WEREWOLF_STRENGTH_BONUS",
    "WEREWOLF_BATTLE_FURY",
    "WEREWOLF_CURE_OUTSIDE_EFFECTS",
    "WEREWOLF_SUPER_FAST_REGENERATION",
    "WEREWOLF_SUMMON_FOG",
    "WEREWOLF_MOON_ARMOR",
    "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
    "WEREWOLF_PRIMAL_FORM_TRAITS",
    "WEREWOLF_CLOSE_TEAR_IN_REALITY",
    "WEREWOLF_WALK_THROUGH_WALLS",
    "WEREWOLF_SUMMON_SHADOW_PACK",
}

local changeling_categories = {
    "FAIR_FOLK_COMMONER_BROWNIE",
    "FAIR_FOLK_COMMONER_POOKA",
    "FAIR_FOLK_COMMONER_SELKIE",
    "FAIR_FOLK_COMMONER_TROW",
    "FAIR_FOLK_NOBLE",
}

local changeling_spells = {
    "changeling_research_new_seasonal_spells",
    "changeling_gain_dreamsparks",
    "changeling_spring_summon_grass_field_spell",
    "changeling_spring_minor_restore_stamina_and_pain_spell",
    "changeling_spring_reduce_scent_spell",
    "changeling_spring_growing_plants_spell",
    "changeling_spring_prevent_bad_conditions_spell",
    "changeling_spring_summon_flower_warriors_spell",
    "changeling_spring_protective_plant_armor_spell",
    "changeling_spring_remove_fatigue_and_sleep_deprivation_spell",
    "changeling_spring_summon_rain_shower_spell",
    "changeling_spring_enchanted_butterfly_wings_spell",
    "changeling_spring_healing_increase_while_outside_spell",
    "changeling_spring_summon_smashing_plants_spell",
    "changeling_spring_fertilize_plant_aoe_spell",
    "changeling_spring_charm_control_target_spell",
    "changeling_summer_light_spell",
    "changeling_summer_light_fire_spell",
    "changeling_summer_sun_glasses_spell",
    "changeling_summer_fire_melee_damage_spell",
    "changeling_summer_jump_distance_spell",
    "changeling_summer_protect_from_hot_weather_spell",
    "changeling_summer_run_for_long_periods_spell",
    "changeling_summer_bonus_stamina_near_enemies_spell",
    "changeling_summer_slow_and_sweat_debuff_spell",
    "changeling_summer_lightning_bolt_from_storm_spell",
    "changeling_summer_create_thunderstorm_spell",
    "changeling_summer_ring_of_flames_spell",
    "changeling_summer_powerful_sunlight_spell",
    "changeling_autumn_scare_animals_spell",
    "changeling_autumn_touch_of_frailty_spell",
    "changeling_autumn_detect_magic_user_spell",
    "changeling_autumn_damage_plants_spell",
    "changeling_autumn_call_mists_spell",
    "changeling_autumn_protection_from_ranged_spell",
    "changeling_autumn_scare_humans_spell",
    "changeling_autumn_create_confusion_mist_spell",
    "changeling_autumn_plants_to_harvest_spell",
    "changeling_autumn_freeze_in_place_spell",
    "changeling_autumn_time_fells_mighty_warrior",
    "changeling_winter_walk_on_water_spell",
    "changeling_winter_freeze_target_in_place_spell",
    "changeling_winter_walk_in_silence",
    "changeling_winter_create_field_of_ice_spell",
    "changeling_winter_walk_on_the_snow",
    "changeling_winter_frozen_breath_spell",
    "changeling_winter_feign_death_spell",
    "changeling_winter_silence_spell",
    "changeling_winter_stop_bleeding_spell",
    "changeling_winter_blinding_spell",
    "changeling_winter_neutralize_morale_spell",
    "changeling_winter_see_craft_darkness_spell",
    "changeling_winter_hail_attack_spell",
    "changeling_winter_pure_area_darkness_spell",
    "changeling_winter_cut_off_fey_nature_spell",
}

local function remove_other_supernatural_powers(character)
    if character.subtype == "avatar"
        and (value(services.mutations.has_id_text(character, "WEREWOLF_SPELLS"))
            or value(services.mutations.has_id_text(character, "CHANGELING_MAGIC"))) then
        services.messages.add(ccb.services.translate("Your empowered blood consumes your nature and anything it granted you."), "mixed")
    end
    for _, trait in ipairs(werewolf_traits) do
        value(services.mutations.erase(character, id("mutation", trait)))
    end
    for _, category in ipairs(changeling_categories) do
        value(services.mutations.remove_category(character, id("mutation_category", category)))
    end
    for _, name in ipairs(changeling_spells) do
        local result = services.spells.forget(character, id("spell", name))
        if not result.ok and result.error.code ~= "not_known" then
            error(result.error.message)
        end
    end
end

return {
    remove_dream_magic = remove_dream_magic,
    remove_other_supernatural_powers = remove_other_supernatural_powers,
}
