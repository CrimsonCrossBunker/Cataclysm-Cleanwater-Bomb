local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "crystalline_potions",
        name = ccb.content.text("crystalline elixirs"),
        description = ccb.content.text("Recipes for mixing refined matrix crystal into water."),
        category = "CC_PSIONIC",
        subcategory = "CSC_PSIONIC_MEDICAL",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("matrix_crystal_biokin_dust_potion", true)
    group:recipe("matrix_crystal_clair_dust_potion", true)
    group:recipe("matrix_crystal_electrokin_dust_potion", true)
    group:recipe("matrix_crystal_photokin_dust_potion", true)
    group:recipe("matrix_crystal_pyrokin_dust_potion", true)
    group:recipe("matrix_crystal_telekin_dust_potion", true)
    group:recipe("matrix_crystal_telepath_dust_potion", true)
    group:recipe("matrix_crystal_teleport_dust_potion", true)
    group:recipe("matrix_crystal_vitakin_dust_potion", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "irradiated_food",
        name = ccb.content.text("irradiated food"),
        description = ccb.content.text("Recipes for irradiating food through photokinesis."),
        category = "CC_PSIONIC",
        subcategory = "CSC_PSIONIC_FOOD",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("irradiated_rose_hips", true)
    group:recipe("irradiated_elderberries", true)
    group:recipe("irradiated_mulberries", true)
    group:recipe("irradiated_huckleberries", true)
    group:recipe("irradiated_raspberries", true)
    group:recipe("irradiated_strawberries", true)
    group:recipe("irradiated_blueberries", true)
    group:recipe("irradiated_apple", true)
    group:recipe("irradiated_banana", true)
    group:recipe("irradiated_orange", true)
    group:recipe("irradiated_lemon", true)
    group:recipe("irradiated_grapefruit", true)
    group:recipe("irradiated_pear", true)
    group:recipe("irradiated_cherries", true)
    group:recipe("irradiated_plums", true)
    group:recipe("irradiated_grapes", true)
    group:recipe("irradiated_pineapple", true)
    group:recipe("irradiated_peach", true)
    group:recipe("irradiated_watermelon", true)
    group:recipe("irradiated_melon", true)
    group:recipe("irradiated_blackberries", true)
    group:recipe("irradiated_mango", true)
    group:recipe("irradiated_pomegranate", true)
    group:recipe("irradiated_papaya", true)
    group:recipe("irradiated_guayaba", true)
    group:recipe("irradiated_maracuya", true)
    group:recipe("irradiated_kiwi", true)
    group:recipe("irradiated_lulo", true)
    group:recipe("irradiated_plantain", true)
    group:recipe("irradiated_apricot", true)
    group:recipe("irradiated_lettuce", true)
    group:recipe("irradiated_cabbage", true)
    group:recipe("irradiated_tomato", true)
    group:recipe("irradiated_broccoli", true)
    group:recipe("irradiated_zucchini", true)
    group:recipe("irradiated_onion", true)
    group:recipe("irradiated_carrot", true)
    group:recipe("irradiated_corn", true)
    group:recipe("irradiated_pumpkin", true)
    group:recipe("irradiated_potato", true)
    group:recipe("irradiated_cucumber", true)
    group:recipe("irradiated_celery", true)
    group:recipe("irradiated_rhubarb", true)
    group:recipe("irradiated_eggplant", true)
    content.add(group)
end

-- Random time to unlock new power is 2 hours + hours equal to the Difficulty +/- 20% each way
do
    local group = content.NestedRecipeCategory {
        id = "biokinetic_practice",
        name = ccb.content.text("contemplation: biokinesis"),
        description = ccb.content.text("Recipes related to practicing biokinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_biokin_physical_enhance", true)
    group:recipe("practice_biokin_overcome_pain", true)
    group:recipe("practice_biokin_breathe_skin", true)
    group:recipe("practice_biokin_flexibility", true)
    group:recipe("practice_biokin_dash", true)
    group:recipe("practice_biokin_climate_control", true)
    group:recipe("practice_biokin_enhance_mobility", true)
    group:recipe("practice_biokin_armor_skin", true)
    group:recipe("practice_biokin_adrenaline", true)
    group:recipe("practice_biokin_hammerhand", true)
    group:recipe("practice_biokin_reflex_enhance", true)
    group:recipe("practice_biokin_sealed_system", true)
    group:recipe("practice_biokin_metabolism_enhance", true)
    group:recipe("practice_biokin_vitaminosis", true)
    group:recipe("practice_biokin_guided_evolution", true)
    group:recipe("practice_biokin_combat_dance", true)
    group:recipe("practice_biokin_perfected_motion", true)
    group:recipe("practice_biokin_hurricane_blows", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "clairsentient_practice",
        name = ccb.content.text("contemplation: clairsentience"),
        description = ccb.content.text("Recipes related to practicing clairsentience."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_clair_better_senses", true)
    group:recipe("practice_clair_danger_sense", true)
    group:recipe("practice_clair_speed_reading", true)
    group:recipe("practice_clair_night_vision", true)
    group:recipe("practice_clair_aura_sight", true)
    group:recipe("practice_clair_sense_rads", true)
    group:recipe("practice_clair_spot_weakness", true)
    group:recipe("practice_clair_ranged_enhance", true)
    group:recipe("practice_clair_examine_item", true)
    group:recipe("practice_clair_sense_hostile_creatures", true)
    group:recipe("practice_clair_voyance", true)
    group:recipe("practice_clair_dodge_power", true)
    group:recipe("practice_clair_craft_bonus", true)
    group:recipe("practice_clair_see_map", true)
    group:recipe("practice_clair_perfect_shot", true)
    group:recipe("practice_clair_clear_sight", true)
    group:recipe("practice_clair_astral_projection", true)
    group:recipe("practice_clair_group_tactics", true)
    group:recipe("practice_clair_omniscience", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "electrokinesis_practice",
        name = ccb.content.text("contemplation: electrokinesis"),
        description = ccb.content.text("Recipes related to practicing electrokinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_electrokinetic_see_electric", true)
    group:recipe("practice_electrokinetic_shock_touch", true)
    group:recipe("practice_electrokinetic_zap_enemies", true)
    group:recipe("practice_electrokinetic_melee_attacks", true)
    group:recipe("practice_electrokinetic_personal_battery", true)
    group:recipe("practice_electrokinetic_paralysis", true)
    group:recipe("practice_electrokinetic_hacking_interface", true)
    group:recipe("practice_electrokinetic_reduce_pain", true)
    group:recipe("practice_electrokinetic_lightning_bolt", true)
    group:recipe("practice_electrokinetic_recharge_vehicle", true)
    group:recipe("practice_electrokinetic_speed_boost", true)
    group:recipe("practice_electrokinetic_pain_immune", true)
    group:recipe("practice_electrokinetic_robot_interface", true)
    group:recipe("practice_electrokinetic_kill_robot", true)
    group:recipe("practice_electrokinetic_lightning_aura", true)
    group:recipe("practice_electrokinetic_lightning_blast", true)
    group:recipe("practice_electrokinetic_revive", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "photokinesis_practice",
        name = ccb.content.text("contemplation: photokinesis"),
        description = ccb.content.text("Recipes related to practicing photokinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_photokinetic_light_local", true)
    group:recipe("practice_photokinetic_create_light", true)
    group:recipe("practice_photokinetic_light_up_enemy", true)
    group:recipe("practice_photokinetic_snuff_light", true)
    group:recipe("practice_photokinetic_light_dodge", true)
    group:recipe("practice_photokinetic_light_beam", true)
    group:recipe("practice_photokinetic_camouflage", true)
    group:recipe("practice_photokinetic_rad_immunity", true)
    group:recipe("practice_photokinetic_light_arms", true)
    group:recipe("practice_photokinetic_hide_ugly", true)
    group:recipe("practice_photokinetic_flash_bang", true)
    group:recipe("practice_photokinetic_light_image", true)
    group:recipe("practice_photokinetic_radio", true)
    group:recipe("practice_photokinetic_sterilize_food", true)
    group:recipe("practice_photokinetic_stun_robots", true)
    group:recipe("practice_photokinetic_invisibility", true)
    group:recipe("practice_photokinetic_light_flash", true)
    group:recipe("practice_photokinetic_light_blinding_glare", true)
    group:recipe("practice_photokinetic_light_disintegrate", true)
    group:recipe("practice_photokinetic_light_army", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "psychic_knack_practice",
        name = ccb.content.text("contemplation: knacks"),
        description = ccb.content.text("Recipes related to practicing psychic knacks."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 10,
    }
    group:recipe("practice_biokin_flexibility_knack", true)
    group:recipe("practice_biokin_adrenaline_knack", true)
    group:recipe("practice_clair_better_senses_knack", true)
    group:recipe("practice_clair_danger_sense_knack", true)
    group:recipe("practice_clair_examine_item_knack", true)
    group:recipe("practice_clair_astral_projection_knack", true)
    group:recipe("practice_electrokinetic_see_electric_knack", true)
    group:recipe("practice_electrokinetic_pain_immune_knack", true)
    group:recipe("practice_electrokinetic_hacking_interface_knack", true)
    group:recipe("practice_photokinetic_camouflage_knack", true)
    group:recipe("practice_photokinetic_hide_ugly_knack", true)
    group:recipe("practice_photokinetic_radio_knack", true)
    group:recipe("practice_pyrokinetic_intensify_flames_knack", true)
    group:recipe("practice_pyrokinetic_flash_knack", true)
    group:recipe("practice_pyrokinetic_eruption_knack", true)
    group:recipe("practice_pyrokinetic_call_flames_knack", true)
    group:recipe("practice_pyrokinetic_cloak_knack", true)
    group:recipe("practice_pyrokinetic_flamethrower_knack", true)
    group:recipe("practice_pyrokinetic_aura_knack", true)
    group:recipe("practice_pyrokinetic_blast_knack", true)
    group:recipe("practice_telekinetic_pull_knack", true)
    group:recipe("practice_telekinetic_push_knack", true)
    group:recipe("practice_telekinetic_slam_down_knack", true)
    group:recipe("practice_telekinetic_wave_knack", true)
    group:recipe("practice_telekinetic_shield_knack", true)
    group:recipe("practice_telepathic_shield_knack", true)
    group:recipe("practice_telepathic_mind_sense_knack", true)
    group:recipe("practice_telepathic_morale_knack", true)
    group:recipe("practice_telepathic_blast_knack", true)
    group:recipe("practice_telepathic_mesmerize_knack", true)
    group:recipe("practice_telepathic_animal_mind_control_knack", true)
    group:recipe("practice_telepathic_invisibility_knack", true)
    group:recipe("practice_telepathic_blast_radius_knack", true)
    group:recipe("practice_vita_health_power_knack", true)
    group:recipe("practice_vita_concentrated_healing_knack", true)
    group:recipe("practice_vita_remove_poison_knack", true)
    group:recipe("practice_vita_cure_disease_knack", true)
    group:recipe("practice_vita_banish_illness_knack", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "pyrokinesis_practice",
        name = ccb.content.text("contemplation: pyrokinesis"),
        description = ccb.content.text("Recipes related to practicing pyrokinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_pyrokinetic_intensify_flames", true)
    group:recipe("practice_pyrokinetic_flash", true)
    group:recipe("practice_pyrokinetic_eruption", true)
    group:recipe("practice_pyrokinetic_cauterize", true)
    group:recipe("practice_pyrokinetic_call_flames", true)
    group:recipe("practice_pyrokinetic_quell_flames", true)
    group:recipe("practice_pyrokinetic_cloak", true)
    group:recipe("practice_pyrokinetic_thermogenesis", true)
    group:recipe("practice_pyrokinetic_lance", true)
    group:recipe("practice_pyrokinetic_flamethrower", true)
    group:recipe("practice_pyrokinetic_aura", true)
    group:recipe("practice_pyrokinetic_flame_immunity", true)
    group:recipe("practice_pyrokinetic_blast", true)
    group:recipe("practice_pyrokinetic_aoe_blast", true)
    group:recipe("practice_pyrokinetic_incineration", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "telekinesis_practice",
        name = ccb.content.text("contemplation: telekinesis"),
        description = ccb.content.text("Recipes related to practicing telekinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_telekinetic_pull", true)
    group:recipe("practice_telekinetic_push", true)
    group:recipe("practice_telekinetic_noise", true)
    group:recipe("practice_telekinetic_slam_down", true)
    group:recipe("practice_telekinetic_momentum", true)
    group:recipe("practice_telekinetic_slowfall", true)
    group:recipe("practice_telekinetic_wave", true)
    group:recipe("practice_telekinetic_water_walking", true)
    group:recipe("practice_telekinetic_lifting_field", true)
    group:recipe("practice_telekinetic_strength", true)
    group:recipe("practice_telekinetic_hammer", true)
    group:recipe("practice_telekinetic_vehicle_lift", true)
    group:recipe("practice_telekinetic_shield", true)
    group:recipe("practice_telekinetic_explosion", true)
    group:recipe("practice_telekinetic_levitation", true)
    group:recipe("practice_telekinetic_move_large_weight", true)
    group:recipe("practice_telekinetic_aegis", true)
    group:recipe("practice_telekinetic_earthshaker", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "telepathy_practice",
        name = ccb.content.text("contemplation: telepathy"),
        description = ccb.content.text("Recipes related to practicing telepathy."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_telepathic_concentration", true)
    group:recipe("practice_telepathic_shield", true)
    group:recipe("practice_telepathic_mind_sense", true)
    group:recipe("practice_telepathic_mesmerize", true)
    group:recipe("practice_telepathic_morale", true)
    group:recipe("practice_telepathic_beastmaster", true)
    group:recipe("practice_telepathic_blast", true)
    group:recipe("practice_telepathic_confusion", true)
    group:recipe("practice_telepathic_invisibility", true)
    group:recipe("practice_telepathic_fear", true)
    group:recipe("practice_telepathic_scream", true)
    group:recipe("practice_telepathic_beast_taming", true)
    group:recipe("practice_telepathic_mind_control", true)
    group:recipe("practice_telepathic_network", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "teleportation_practice",
        name = ccb.content.text("contemplation: teleportation"),
        description = ccb.content.text("Recipes related to practicing teleportation."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_teleport_blink", true)
    group:recipe("practice_teleport_slow", true)
    group:recipe("practice_teleport_phase", true)
    group:recipe("practice_teleport_stride", true)
    group:recipe("practice_teleport_item_apport", true)
    group:recipe("practice_teleport_transpose", true)
    group:recipe("practice_teleport_displacement", true)
    group:recipe("practice_teleport_reactive_displacement", true)
    group:recipe("practice_teleport_warped_strikes", true)
    group:recipe("practice_teleport_ephemeral_walk", true)
    group:recipe("practice_teleport_farstep", true)
    group:recipe("practice_teleport_collapse", true)
    group:recipe("practice_teleport_banish", true)
    group:recipe("practice_teleport_loci_establishment", true)
    group:recipe("practice_teleport_loci_technique", true)
    group:recipe("practice_teleport_gateway", true)
    group:recipe("practice_teleport_dilated_gateway", true)
    group:recipe("practice_teleport_relocation", true)
    group:recipe("practice_teleport_breach", true)
    group:recipe("practice_teleport_warper_combat", true)
    group:recipe("practice_teleport_reality_tear", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "vitakinesis_practice",
        name = ccb.content.text("contemplation: vitakinesis"),
        description = ccb.content.text("Recipes related to practicing vitakinesis."),
        category = "CC_PRACTICE",
        subcategory = "CSC_PRACTICE_METAPHYSICS",
        activity_level = 2,
        skill = "metaphysics",
        difficulty = 1,
    }
    group:recipe("practice_vita_health_power", true)
    group:recipe("practice_vita_slow_bleeding", true)
    group:recipe("practice_vita_concentrated_healing", true)
    group:recipe("practice_vita_stop_bleeding", true)
    group:recipe("practice_vita_healing_touch", true)
    group:recipe("practice_vita_remove_poison", true)
    group:recipe("practice_vita_hurt_touch", true)
    group:recipe("practice_vita_sleeping_trance", true)
    group:recipe("practice_vita_cure_disease", true)
    group:recipe("practice_vita_stop_infection", true)
    group:recipe("practice_vita_increased_hp", true)
    group:recipe("practice_vita_purge_rads", true)
    group:recipe("practice_vita_healing_trance", true)
    group:recipe("practice_vita_attack_touch", true)
    group:recipe("practice_vita_blood_purge", true)
    group:recipe("practice_vita_no_need_for_sleep", true)
    group:recipe("practice_vita_banish_illness", true)
    group:recipe("practice_vita_super_heal", true)
    group:recipe("practice_vita_limb_restore", true)
    group:recipe("practice_vita_degenerating_touch", true)
    group:recipe("practice_vita_return_from_death", true)
    content.add(group)
end
