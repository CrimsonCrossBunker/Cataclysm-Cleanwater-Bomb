local content = require("ccb").content

do
    -- Very high value alien artifacts: high quality weapons, combat tools or supplies.
    local group = content.ItemGroup { id = "alienciv_artifact_5", kind = "distribution" }
    group:item("afs_hardlight_longbow", 1)
    group:entry { item = "alien_battery", charges = { 4500, 4500 }, probability = 10 }
    group:group("afs_espertech_tinctures", 1)
    content.add(group)
end

do
    -- This isn't alien tech per se (though it is derived from it), but we'll put it here for now
    local group = content.ItemGroup { id = "afs_espertech_tinctures", kind = "distribution" }
    group:item("afs_espertech_gain_esper_powers_geist", 1)
    group:item("afs_espertech_gain_esper_powers_spark", 1)
    group:item("afs_espertech_gain_esper_powers_sybil", 1)
    group:item("afs_espertech_gain_esper_powers_whisper", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arcology_vitamin_shop", kind = "distribution" }
    group:item("cream_prot_cold", 25)
    group:item("cream_greater_prot_cold", 5)
    group:item("homeopathic_pills", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "astronaut_mre_full_pack", kind = "collection" }
    group:entry {
        item = "afs_mre_package",
        sealed = true,
        contents = {
            { group = "astronaut_mre_contents" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "astronaut_mre_contents", kind = "collection" }
    group:entry { group = "mre_entrees", count = { 2, 2 }, sealed = true, container = "mre_bag_small" }
    group:entry { item = "heatpack", count = { 2, 2 } }
    group:entry { item = "crackers", count = { 0, 2 }, sealed = true, wrapper = "mre_bag_small", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bionics_reaver", kind = "distribution" }
    group:item("bio_microgen", 3)
    group:item("bio_power_storage", 10)
    group:item("bio_batteries", 10)
    group:item("bio_metabolics", 10)
    group:item("bio_ethanol", 10)
    group:item("bio_ups", 10)
    group:item("bio_torsionratchet", 10)
    group:item("bio_ears", 10)
    group:item("bio_sunglasses", 10)
    group:item("bio_eye_optic", 10)
    group:item("bio_eye_enhancer", 10)
    group:item("bio_dex_enhancer", 10)
    group:item("bio_str_enhancer", 10)
    group:item("bio_night_vision", 10)
    group:item("bio_infrared", 10)
    group:item("bio_recycler", 10)
    group:item("bio_digestion", 10)
    group:item("bio_evap", 10)
    group:item("bio_water_extractor", 10)
    group:item("bio_carbon", 10)
    group:item("bio_targeting", 10)
    group:item("bio_ground_sonar", 10)
    group:item("bio_face_mask", 10)
    group:item("bio_scent_mask", 10)
    group:item("bio_cloak", 10)
    group:item("bio_synaptic_regen", 12)
    group:item("afs_bio_deck", 10)
    group:item("bio_lockpick", 10)
    group:item("bio_blood_anal", 10)
    group:item("bio_geiger", 10)
    group:item("bio_radscrubber", 10)
    group:item("bio_laser", 10)
    group:item("bio_emp", 10)
    group:item("bio_flashbang", 10)
    group:item("bio_blade", 2)
    group:item("bio_speed", 2)
    group:item("bio_adrenaline", 10)
    group:item("bio_watch", 10)
    group:item("bio_meteorologist", 10)
    group:item("bio_cable", 10)
    group:item("bio_weight", 10)
    group:item("bio_jointservo", 10)
    group:item("bio_shotgun", 10)
    group:item("bio_recoil", 10)
    group:item("bio_shield_weak", 10)
    group:item("afs_bio_chemical_enhancement_rig", 10)
    group:item("bio_shield_weak", 10)
    group:item("afs_bio_skullgun", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_bionics_power", kind = "distribution" }
    group:item("bio_power_storage_mkII", 2)
    group:item("bio_power_storage", 24)
    group:item("bio_betavoltaic", 5)
    group:item("bio_microgen", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_bionic_toolkit", kind = "distribution" }
    group:item("afs_complete_bionic_toolkit", 1)
    group:item("bionic_maintenance_toolkit", 14)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bionics_subs", kind = "distribution" }
    group:item("afs_bio_missiles", 10)
    group:item("afs_bio_dopamine_stimulators", 15)
    content.add(group)
end

do
    -- Scavenged pieces of armor.  Should mostly spawn low to mid quality armor.
    local group = content.ItemGroup { id = "afs_survivor_armor", kind = "collection" }
    group:entry {
        distribution = {
            { group = "afs_basic_armor", probability = 50 },
            { group = "afs_common_armor", probability = 5 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_basic_armor", kind = "distribution" }
    group:group("afs_plastic_armor_g", 10)
    group:group("afs_armor_spaceship_crew_g", 5)
    group:group("afs_scrap_armor_g", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_armor", kind = "distribution" }
    group:group("afs_carbide_raider_armor_g", 10)
    group:group("afs_armor_military_infantry_g", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_plastic_armor_g", kind = "collection" }
    group:group("afs_hard_hat", 90)
    group:item("legguard_hard", 40)
    group:item("armguard_hard", 40)
    group:item("chestguard_hard", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_scrap_armor_g", kind = "collection" }
    group:item("helmet_scrap", 70)
    group:item("legguard_scrap", 40)
    group:item("boots_scrap", 40)
    group:item("armguard_scrap", 40)
    group:item("cuirass_scrap", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_armor_spaceship_crew_g", kind = "collection" }
    group:item("nanomesh_vest", 70)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_armor_military_infantry_g", kind = "collection" }
    group:entry {
        distribution = {
            { item = "afs_military_vest", probability = 20 },
            { item = "afs_military_vestxl", probability = 1 },
        },
    }
    group:entry {
        distribution = {
            { item = "tac_fullhelmet_uicas", probability = 20 },
            { item = "tac_helmet_uicas", probability = 1 },
        },
        probability = 40,
    }
    group:item("afs_military_cloak", 40)
    group:item("afs_backpack_shieldgen", 1)
    content.add(group)
end

do
    -- please add the rest of the carbide gear when its added.
    local group = content.ItemGroup { id = "afs_carbide_raider_armor_g", kind = "collection" }
    group:item("helmet_full_carbide", 70)
    group:item("legguard_scrap", 40)
    group:item("boots_scrap", 40)
    group:item("armguard_scrap", 40)
    group:item("cuirass_lightplate", 90)
    content.add(group)
end

do
    -- If specific aftershock police armor is added please add to this group. Until then it refers to civilian armors.
    local group = content.ItemGroup { id = "afs_police_armor", kind = "collection" }
    group:group("afs_armor_spaceship_crew_g", 60)
    group:group("civilian_body_armor", 40)
    content.add(group)
end

do
    -- Clothes for working in toxic environments.
    local group = content.ItemGroup { id = "afs_civilian_hazard_outfit", kind = "collection" }
    group:group("afs_colonist_hazard_accessories", 50)
    group:group("afs_colonist_outfit_underwear")
    group:item("afs_hazard_suit")
    group:group("afs_hard_hat", 15)
    group:group("afs_colonist_shirt", 10)
    content.add(group)
end

do
    -- Clothes for the future blue collar worker.  Just steal costumes from Alien.
    local group = content.ItemGroup { id = "afs_colonist_outfit", kind = "collection" }
    group:group("afs_colonist_hazard_accessories", 10)
    group:group("afs_colonist_outfit_underwear")
    group:group("afs_hard_hat", 15)
    group:group("afs_colonist_scarf", 50)
    group:group("afs_colonist_gloves", 70)
    group:group("afs_colonist_coats", 60)
    group:group("afs_colonist_shirt")
    group:group("afs_colonist_pants")
    group:group("afs_colonist_shoes")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_outfit_underwear", kind = "distribution" }
    group:entry {
        distribution = {
            { group = "male_underwear", probability = 10 },
            { item = "union_suit", probability = 90 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { group = "female_underwear" },
            { group = "accesories_personal_womens", probability = 85 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- unisex scarfs and fabric coverings
    local group = content.ItemGroup { id = "afs_colonist_scarf", kind = "distribution" }
    group:item("bandana", 20)
    group:item("balclava", 50, "black")
    group:item("headscarf", 10)
    group:item("afs_work_tie", 10)
    group:item("scarf_fur", 1)
    group:item("scarf", 80)
    group:item("scarf_long", 40)
    group:item("long_knit_scarf", 1)
    group:item("knit_scarf", 10)
    group:item("keffiyeh", 10)
    group:item("mask_ski", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_gloves", kind = "distribution" }
    group:item("gloves_light", 15)
    group:item("gloves_leather", 1)
    group:item("gloves_wool", 1)
    group:item("gloves_winter", 20)
    group:item("gloves_liner", 15)
    group:item("mittens", 2)
    group:item("thermal_gloves", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_coats", kind = "distribution" }
    group:item("trenchcoat", 5)
    group:item("coat_winter", 20)
    group:item("afs_leather_jacket", 5)
    group:item("afs_bolero", 2)
    group:item("afs_cyberpunk_bomber", 5)
    group:item("afs_hi_vis_jacket", 80)
    group:item("afs_hi_vis_vest", 50)
    group:item("afs_company_jacket", 80)
    group:item("afs_supervisor_jacket", 20)
    group:item("coat_rain", 10)
    group:item("folding_poncho", 30)
    group:item("vest", 30)
    group:item("nanomesh_vest", 10)
    group:item("jacket_windbreaker", 50)
    group:item("ski_jacket", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_shirt", kind = "distribution" }
    group:item("longshirt", 70)
    group:item("sweatshirt", 50)
    group:item("tank_top", 80)
    group:item("tshirt", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_pants", kind = "distribution" }
    group:item("technician_pants_gray", 90)
    group:item("pants_cargo", 70)
    group:item("pants_ski", 25)
    group:item("jumpsuit", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_shoes", kind = "distribution" }
    group:item("boots", 80)
    group:item("boots_hiking", 50)
    group:item("boots_steel", 50)
    group:item("sneakers_steel", 35)
    group:item("boots_combat", 45)
    group:item("boots_winter", 30)
    group:item("knee_high_boots", 3)
    group:item("motorbike_boots", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_hazard_accessories", kind = "collection" }
    group:item("afs_wrist_computer")
    group:entry { item = "mask_gas", charges = { 50, 100 }, probability = 20 }
    group:item("rad_monitor", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_colonist_bags", kind = "distribution" }
    group:item("backpack", 38)
    group:item("backpack_hiking", 3)
    group:item("petpack", 1)
    group:item("backpack_tactical_large", 1)
    group:item("travelpack", 5)
    group:item("purse", 40)
    group:item("mbag", 20)
    group:item("slingpack", 8)
    group:item("rucksack", 20)
    group:item("leg_bag", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exosuits_civ", kind = "distribution" }
    group:group("afs_exosuit_light_worker", 60)
    group:group("afs_exosuit_worker", 30)
    group:group("afs_exosuit_security", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exo_civ_modules", kind = "distribution" }
    group:group("afs_exo_basic_power")
    group:group("afs_power_tools")
    group:group("afs_exo_basic_accessories")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exo_underlayer_civ", kind = "distribution" }
    group:item("afs_exo_standard_underlayer", 75)
    group:item("afs_exo_hazard_underlayer", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exo_basic_power", kind = "distribution" }
    group:entry { item = "exo_back_battery_rechargable", charges = { 200, 300 }, probability = 75 }
    group:entry { item = "exo_back_gasoline", charges = { 200, 300 }, probability = 50 }
    group:entry { item = "exo_aux_power", charges = { 50, 100 }, probability = 25 }
    group:entry { item = "exo_small_aux_power", charges = { 50, 100 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exo_advanced_power", kind = "distribution" }
    group:entry { item = "exo_back_battery_rechargable", charges = { 200, 300 }, probability = 50 }
    group:entry { item = "exo_back_fuelcell", charges = { 200, 300 }, probability = 75 }
    group:item("exo_asrg", 10)
    group:entry { item = "exo_aux_power", count = { 0, 1 }, charges = { 50, 100 }, probability = 25 }
    group:entry { item = "exo_small_aux_power", charges = { 50, 100 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_power_tools", kind = "distribution" }
    group:item("heavy_drill", 50)
    group:item("exosuit_plasma_torch", 75)
    group:item("exosuit_power_cutter", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exo_basic_accessories", kind = "collection" }
    group:item("exo_carry", 50)
    group:entry { item = "exo_small_carry", count = { 0, 2 }, probability = 75 }
    group:item("exo_flashlight", 75)
    group:item("exo_imager", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exosuit_light_worker", kind = "collection" }
    group:item("modular_exosuit_light")
    group:item("afs_exo_standard_underlayer", 90)
    group:item("exo_helmet_plastic", 90)
    group:item("exo_torso_plastic", 90)
    group:item("exo_arm_plastic", 90)
    group:item("exo_leg_plastic", 90)
    group:group("afs_exo_basic_power", 75)
    group:group("afs_exo_basic_accessories", 50)
    group:group("afs_exo_basic_accessories", 50)
    group:group("afs_power_tools", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exosuit_worker", kind = "collection" }
    group:item("modular_exosuit")
    group:item("afs_exo_standard_underlayer", 90)
    group:item("exo_helmet_plastic", 90)
    group:item("exo_torso_plastic", 90)
    group:item("exo_arm_plastic", 90)
    group:item("exo_leg_plastic", 90)
    group:group("afs_exo_basic_power", 75)
    group:group("afs_exo_basic_accessories", 75)
    group:group("afs_exo_basic_accessories", 75)
    group:group("afs_power_tools", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exosuit_security", kind = "collection" }
    group:item("afs_exo_combat_underlayer", 75)
    group:item("afs_exo_standard_underlayer", 25)
    group:item("afs_exo_hazard_underlayer", 10)
    group:item("exo_helmet_steel", 90)
    group:item("exo_torso_steel", 90)
    group:item("exo_arm_steel", 90)
    group:item("exo_leg_steel", 90)
    group:item("exo_sonic_unit", 60)
    group:item("exo_microwave_cannon", 60)
    group:entry { item = "afs_cartridge", count = { 0, 4 }, charges = { 50, 100 }, probability = 95 }
    group:group("afs_exo_basic_power", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_exosuit_military", kind = "collection" }
    group:item("modular_exosuit", 5)
    group:item("afs_exo_combat_underlayer", 75)
    group:item("afs_exo_hazard_underlayer", 25)
    group:item("exo_helmet_vcc", 90)
    group:item("exo_torso_vcc", 90)
    group:item("exo_arm_vcc", 90)
    group:item("exo_leg_vcc", 90)
    group:item("exo_electrolaser", 15)
    group:entry { item = "exo_flame_thrower", charges = { 100, 1500 }, probability = 50 }
    group:entry { item = "afs_cartridge", count = { 2, 6 }, charges = { 50, 100 }, probability = 95 }
    group:group("afs_exo_advanced_power", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_experimental_combat_gear", kind = "distribution" }
    group:item("afs_recall_rig", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_pals_pieces", kind = "distribution" }
    group:item("afs_grenade_pouch", 10)
    group:entry {
        item = "canteen_pouch",
        contents = {
            { item = "canteen" },
        },
        probability = 10,
    }
    group:item("tool_pouch", 10)
    group:item("afs_triple_stacker_pouch", 10)
    group:item("tactical_shotshell_pouch", 10)
    group:item("gas_mask_pouch", 10)
    group:item("belt_loop_medium", 10)
    group:item("holster", 10)
    group:item("sheath", 10)
    group:item("ifak_pouch", 10)
    group:item("afs_ammo_satchel", 10)
    group:item("XL_holster", 10)
    group:item("side_double_holster", 10)
    group:item("belt_loop_large", 10)
    group:item("nylon_quiver", 1)
    content.add(group)
end

do
    -- A group for any advanced civilian piece of clothing
    local group = content.ItemGroup { id = "afs_wintersuit_civilian_advanced", kind = "distribution" }
    group:group("afs_wintersuit_science_advanced", 2)
    group:group("afs_wintersuit_generic_advanced", 2)
    content.add(group)
end

do
    -- A group for any generic-flavour advanced civilian piece of clothing
    local group = content.ItemGroup { id = "afs_wintersuit_generic_advanced", kind = "distribution" }
    group:group("afs_frontier_cryo_g", 20)
    group:group("afs_cryopod_g", 1)
    content.add(group)
end

do
    -- A group for any generic-flavour basic civillian EVA gear
    local group = content.ItemGroup { id = "afs_wintersuit_generic_basic", kind = "distribution" }
    group:group("afs_frontier_cryo_g", 20)
    content.add(group)
end

do
    -- A group for any generic-flavor combat EVA Gear
    local group = content.ItemGroup { id = "afs_wintersuit_generic_combat", kind = "distribution" }
    group:group("afs_combat_gryo_g", 80)
    content.add(group)
end

do
    -- A group for any police-flavour advanced civilian piece of clothing
    local group = content.ItemGroup { id = "afs_wintersuit_police_advanced", kind = "distribution" }
    group:group("afs_wintersuit_generic_combat", 2)
    content.add(group)
end

do
    -- A group for any science-flavour advanced civilian piece of clothing
    local group = content.ItemGroup { id = "afs_wintersuit_science_advanced", kind = "distribution" }
    group:group("afs_magellan_g", 2)
    content.add(group)
end

do
    -- The matching frontier-cryosuit set. Includes suit, mask and possible future accessories
    local group = content.ItemGroup { id = "afs_frontier_cryo_g", kind = "collection" }
    group:item("afs_frontier_cryo")
    group:item("afs_frontier_cryomask", 90)
    group:entry { item = "afs_heavy_suit_battery_cell", count = { 1, 2 }, charges = { 0, 1000 }, probability = 25 }
    content.add(group)
end

do
    -- The matching uplift set. Includes suit, mask and possible future accessories
    local group = content.ItemGroup { id = "afs_frontier_xl_cryo_g", kind = "collection" }
    group:item("afs_frontier_cryo_xl")
    group:item("afs_frontier_cryomask_xl", 90)
    group:entry { item = "afs_heavy_suit_battery_cell", count = { 1, 2 }, charges = { 0, 1000 }, probability = 25 }
    content.add(group)
end

do
    -- The high tech outfit you get cryo-sepulted in
    local group = content.ItemGroup { id = "afs_cryopod_g", kind = "collection" }
    group:item("afs_cryopod_bodyglove")
    content.add(group)
end

do
    -- The matching Magellan Exosuit set. Includes suit, mask and possible future accessories
    local group = content.ItemGroup { id = "afs_magellan_g", kind = "collection" }
    group:item("afs_magellan_suit")
    group:item("afs_magellan_suit_helmet", 90)
    content.add(group)
end

do
    -- The matching combat-cryosuit set. Includes suit, mask and possible future accessories
    local group = content.ItemGroup { id = "afs_combat_gryo_g", kind = "collection" }
    group:item("afs_combat_cryo")
    group:entry { item = "afs_heavy_suit_battery_cell", count = { 1, 2 }, charges = { 0, 1000 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "farmlab_cryostorage", kind = "distribution" }
    group:item("yum_lichen", 10)
    group:item("moxie_biopsy", 10)
    group:item("afs_cryo_goop", 10)
    group:item("afs_cryo_egg", 5)
    group:item("afs_cryo_terraforming_moss", 2)
    group:item("afs_cryo_seedlings", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_cheap_food", kind = "distribution" }
    group:item("afs_h2o", 90)
    group:item("afs_food_cube", 50)
    group:item("afs_cee_wafers", 50)
    group:item("afs_beefsim", 50)
    group:item("afs_soup_27", 50)
    group:item("afs_caffex", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_cheap_drinks", kind = "distribution" }
    group:item("afs_h2o", 90)
    group:item("afs_calorie_water", 50)
    group:item("afs_sundew", 50)
    group:item("afs_caffex", 50)
    content.add(group)
end

do
    -- This group is for cupboard, drawer, or rack with spices.
    local group = content.ItemGroup { id = "afs_spices", kind = "collection" }
    group:entry { item = "salt", count = { 2, 4 }, wrapper = "afs_foil_bag", container = "null", probability = 15 }
    group:entry { item = "cinnamon", container = "afs_foil_bag", probability = 5 }
    group:entry { item = "chilly-p", container = "afs_foil_bag", probability = 15 }
    group:entry { item = "sugar", container = "afs_foil_bag", probability = 5 }
    group:entry { item = "artificial_sweetener", container = "afs_foil_bag", probability = 15 }
    group:entry { item = "curry_powder", container = "afs_foil_bag", probability = 25 }
    group:entry { item = "garlic_powder", container = "afs_foil_bag", probability = 25 }
    group:entry { item = "seasoning_salt", container = "afs_foil_bag", probability = 50 }
    group:group("ketchup_sealed_rng", 35)
    group:group("mustard_sealed_rng", 35)
    group:item("soysauce", 25)
    group:item("hot_sauce", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_dry_goods", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:entry { item = "instant_coffee", container = "afs_foil_bag", probability = 40 }
    group:entry { item = "flour", container = "afs_foil_bag", probability = 40 }
    group:entry { item = "yeast", container = "afs_foil_bag", probability = 50 }
    group:entry { item = "fruit_leather", container = "afs_foil_bag", probability = 15 }
    group:entry { item = "dry_beans", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "dry_lentils", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "dry_rice", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "gelatin_powder", container = "afs_foil_bag", probability = 40 }
    group:entry { item = "chem_agar", container = "afs_foil_bag", probability = 15 }
    group:entry { item = "gelatin_dessert_powder", container = "afs_foil_bag", probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_cafe_rack", kind = "collection" }
    group:item("afs_caffex", 5)
    group:entry { item = "instant_coffee", container = "afs_foil_bag", probability = 50 }
    group:entry { item = "sugar", container = "afs_foil_bag", probability = 40 }
    group:entry { item = "artificial_sweetener", container = "afs_foil_bag", probability = 40 }
    group:entry { item = "cinnamon", container = "afs_foil_bag", probability = 20 }
    content.add(group)
end

do
    -- Meals that require little to no preparation before eating.
    local group = content.ItemGroup { id = "afs_stored_meals", kind = "distribution" }
    group:group("afs_kibble_afs_foil_bag_2", 10)
    group:group("astronaut_mre_full_pack", 10)
    group:entry { group = "afs_cheap_food", count = { 2, 4 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_stored_meats", kind = "distribution" }
    group:entry { item = "meat", variant = "synth", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "fish", variant = "synth", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "fish", variant = "insect", container = "afs_foil_bag", probability = 10 }
    group:entry { item = "jerky", variant = "synth", container = "afs_foil_bag", probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_stored_veggies", kind = "distribution" }
    group:group("afs_kelp_afs_foil_bag_9", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_ruined_food", kind = "distribution" }
    group:group("afs_ruined_food_can_food_2", 10)
    group:group("afs_ruined_food_afs_foil_bag_5", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_mealgrub_procesing", kind = "collection" }
    group:entry { item = "afs_mealgrub_jelly", count = { 5, 20 } }
    group:entry { group = "afs_mealgrubs_afs_foil_bag_5", count = { 5, 25 }, probability = 15 }
    group:entry { group = "afs_mealgrubs_afs_foil_bag_5", count = { 5, 25 }, probability = 5 }
    group:entry { item = "water", charges = { 20, 40 }, container = "jerrycan", probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_kibble_afs_foil_bag_2", kind = "collection", container = "afs_foil_bag" }
    group:entry { item = "afs_kibble", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_kelp_afs_foil_bag_9", kind = "collection", container = "afs_foil_bag" }
    group:entry { item = "kelp_sugar", count = { 9, 9 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_ruined_food_can_food_2", kind = "collection", container = "can_food" }
    group:entry { item = "afs_ruined_food", count = { 2, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_ruined_food_afs_foil_bag_5", kind = "collection", container = "afs_foil_bag" }
    group:entry { item = "afs_ruined_food", count = { 5, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_mealgrubs_afs_foil_bag_5", kind = "collection", container = "afs_foil_bag" }
    group:entry { item = "afs_mealgrubs", count = { 5, 5 }, container = "null" }
    content.add(group)
end

do
    -- For use in a commercial settings but secured such as in safes. Offers more reward for greater risk/effort involved in obtaining. Shouldn't give any super special or highly valuable genetech.
    local group = content.ItemGroup { id = "afs_genetech_commerical_safe", kind = "collection" }
    group:entry { item = "afs_gene_disp", count = { 3, 7 } }
    group:entry { item = "afs_gene_template", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_genetech_commercial_shelf", kind = "collection" }
    group:entry { item = "afs_gene_disp_low_tier", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_weapons_rare", kind = "distribution" }
    group:item("emp_gun", 3)
    group:item("laser_rifle", 5)
    group:item("v29", 7)
    group:item("afs_hydraulic_gauntlet", 3)
    group:item("afs_energy_saber_off", 3)
    group:item("afs_hardlight_longbow", 2)
    group:item("grenade_cryo", 12)
    group:item("afs_freeze_gauntlet", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_lab_mechanics_books", kind = "distribution" }
    group:item("manual_mechanics", 6)
    group:item("textbook_mechanics", 3)
    group:item("textbook_biodiesel", 3)
    group:item("mag_fieldrepair", 4)
    group:item("book_icef", 4)
    group:item("recipes_resistance", 2)
    group:item("schematics_nano_forge", 12)
    group:item("schematics_diamond_press", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_gardener_worn", kind = "collection" }
    group:item("boots_combat")
    group:item("briefs")
    group:item("socks")
    group:item("polo_shirt")
    group:item("pants_cargo")
    group:item("kevlar")
    group:item("leather_pouch")
    group:item("balclava", 75, "black")
    group:item("bootsheath")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_gardener_carried", kind = "collection" }
    group:entry { group = "hardware", count = { 1, 2 } }
    group:entry { group = "snacks", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_gardener_wield", kind = "collection" }
    group:item("machete")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_gardener_misc", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 5, 30 }, probability = 30 }
    group:entry { group = "forage_spring", count = { 10, 30 }, probability = 30 }
    group:entry { group = "fresh_produce", count = { 4, 8 }, probability = 80 }
    group:entry { group = "tools_home", count = { 1, 3 }, probability = 80 }
    group:entry { group = "tools_construction", count = { 1, 3 }, probability = 30 }
    group:entry { group = "tools_carpentry", count = { 1, 3 }, probability = 30 }
    group:entry { group = "tools_earthworking", count = { 1, 3 }, probability = 30 }
    group:entry { group = "supplies_hardware", count = { 1, 3 }, probability = 20 }
    group:entry { group = "forage_summer", count = { 1, 3 }, probability = 20 }
    group:item("tool_belt", 15)
    group:item("dump_pouch", 5)
    group:item("ragpouch", 15)
    group:item("leather_pouch", 15)
    group:item("quiver", 15)
    group:item("quiver_large", 5)
    group:item("crowbar", 25)
    group:item("machete", 25)
    group:item("ax", 25)
    group:item("arrow_metal", 25)
    group:item("bolt_steel", 10)
    content.add(group)
end

do
    -- Guns commonly carried by gangers and underworld types.
    local group = content.ItemGroup { id = "guns_ganger", kind = "distribution" }
    group:group("guns_pistol_common")
    group:group("guns_cop", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cryo_lab_drops", kind = "collection" }
    group:item("recipes_cryolab", 5)
    group:item("recipes_resistance", 4)
    group:item("recipe_unusual_ammos", 4)
    group:item("bio_cold_absorber", 2)
    group:item("afs_freeze_gauntlet", 6)
    group:entry { group = "afs_scrapgroup", count = { 1, 3 }, probability = 30 }
    group:entry { group = "exoticplants", count = { 1, 3 }, probability = 30 }
    group:entry { group = "science", count = { 1, 3 }, probability = 30 }
    group:entry { group = "afs_exo_basic_accessories", count = { 1, 1 }, probability = 15 }
    group:item("jumpsuit_pocketless", 100, "orange")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "beehive", kind = "collection" }
    group:entry { item = "honeycomb", count = { 2, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "exoticplants", kind = "distribution" }
    group:item("seed_pineapple", 20)
    group:item("seed_melon", 20)
    group:item("seed_bananas", 20)
    group:item("seed_orange", 20)
    group:item("seed_lemon", 20)
    group:item("seed_coconut", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "seabased_death_drop", kind = "collection" }
    group:item("combat_wetsuit_cecalia", 20)
    group:item("wetsuit_cecalia", 70)
    group:item("trident", 70)
    group:item("dive_bag")
    content.add(group)
end

do
    -- Sidearm and appropriate holster or sheath for soldiers or other paramilitary forces.
    local group = content.ItemGroup { id = "gear_afs_sidearm", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "PR24-retracted", probability = 20 },
            {
                collection = {
                    { item = "knife_rm42" },
                    { item = "sheath" },
                },
                probability = 30,
            },
            {
                collection = {
                    { item = "afs_10mm_caseless_FMJ" },
                    { item = "afs_84k_20mag" },
                },
                probability = 60,
            },
            {
                collection = {
                    { item = "afs_seyfert_84K" },
                    { item = "holster" },
                },
                probability = 50,
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_escapepod_shootout_corpse",
        kind = "collection",
        container = "corpse",
        overflow = "spill",
    }
    group:group("afs_escapepod_shootout")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_mess_hall", kind = "collection" }
    group:item("plastic_fork")
    group:item("plastic_spoon")
    group:item("plastic_knife")
    group:item("mess_tray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_todd_howard", kind = "collection" }
    group:item("skull_human")
    content.add(group)
end

do
    -- Industrial amounts of mostly useless consumer goods
    local group = content.ItemGroup { id = "afs_useless_cargo", kind = "distribution" }
    group:entry { item = "afs_glass_device", count = { 100, 200 } }
    group:entry { item = "afs_glass_AR_device", count = { 100, 200 } }
    group:entry { item = "afs_company_jacket", count = { 100, 200 } }
    group:entry { item = "technician_pants_gray", count = { 100, 200 } }
    group:entry { item = "boots_winter", count = { 100, 200 } }
    group:entry { item = "instant_coffee", count = { 100, 200 }, container = "afs_foil_bag" }
    group:entry { item = "artificial_sweetener", count = { 100, 200 }, container = "afs_foil_bag" }
    group:entry { item = "instant_coffee", count = { 100, 200 }, container = "afs_foil_bag" }
    group:entry { item = "syringe", count = { 100, 200 } }
    group:entry { item = "pliers", count = { 100, 200 } }
    group:entry { item = "goggles_welding", count = { 100, 200 } }
    group:entry { item = "jumper_cable", count = { 100, 200 } }
    group:entry { item = "magnifying_glass", count = { 100, 200 } }
    group:entry { item = "shovel", count = { 100, 200 } }
    group:entry { item = "chunk_rubber", count = { 100, 200 } }
    group:entry { item = "nail", count = { 100, 200 } }
    group:entry { item = "bubblewrap", count = { 100, 200 } }
    group:entry { item = "soap", count = { 100, 200 } }
    group:entry { item = "cu_pipe", count = { 100, 200 } }
    group:entry { item = "stapler", count = { 100, 200 } }
    group:entry { item = "canister_empty", count = { 100, 200 } }
    group:entry { item = "spring", count = { 100, 200 } }
    group:entry { item = "material_soil", count = { 100, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_consumer_vr", kind = "distribution" }
    group:item("afs_glass_device")
    group:item("afs_glass_AR_device")
    content.add(group)
end

do
    -- Refers directly to the existing evidence group but we can add whatever we want to layer on top of that.
    local group = content.ItemGroup { id = "afs_police_evidence_locker", kind = "distribution" }
    group:group("cop_evidence")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_coffee_containers", kind = "distribution" }
    group:item("ceramic_mug", 50)
    group:item("thermos", 50)
    content.add(group)
end

do
    -- A rather complete one tile kitchen. Should spawn cooking implements and kitchen objects.
    local group = content.ItemGroup { id = "afs_kitchenette", kind = "collection" }
    group:item("hotplate_induction", 85)
    group:group("SUS_appliances_cupboard", 30)
    group:group("SUS_knife_drawer", 20)
    group:group("SUS_utensils", 20)
    group:group("SUS_dishes", 20)
    group:group("SUS_cookware", 20)
    group:group("SUS_kitchen_sink", 30)
    group:group("SUS_coffee_cupboard", 2)
    content.add(group)
end

do
    -- A rather complete one tile kitchen. Should spawn cooking implements and kitchen objects.
    local group = content.ItemGroup { id = "afs_your_ship_kitchen", kind = "collection" }
    group:group("SUS_appliances_cupboard", 30)
    group:group("SUS_knife_drawer", 20)
    group:group("SUS_utensils")
    group:group("SUS_dishes")
    group:group("SUS_cookware")
    group:group("SUS_coffee_cupboard")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_your_ship_fridge", kind = "collection" }
    group:entry { group = "afs_spices", count = { 3, 5 }, probability = 90 }
    group:entry { group = "afs_dry_goods", count = { 8, 10 }, probability = 90 }
    group:entry { group = "afs_stored_meals", count = { 6, 7 }, probability = 90 }
    group:entry { group = "afs_stored_meats", count = { 6, 8 }, probability = 50 }
    group:entry { group = "afs_stored_veggies", count = { 6, 10 }, probability = 50 }
    content.add(group)
end

do
    -- A cabinet, rack or equivalent storing food from before the discontinuity.  Should only contain nonperishable food and spawn in ruins.
    local group = content.ItemGroup { id = "afs_old_food_storage", kind = "collection" }
    group:entry { group = "afs_cheap_food", count = { 1, 5 }, probability = 10 }
    group:entry { group = "afs_spices", count = { 3, 5 }, probability = 20 }
    group:entry { group = "afs_dry_goods", count = { 1, 2 }, probability = 10 }
    group:entry { group = "afs_stored_meals", count = { 1, 7 }, probability = 10 }
    group:entry { group = "afs_stored_meats", count = { 1, 2 }, probability = 5 }
    group:entry { group = "afs_stored_veggies", count = { 1, 2 }, probability = 10 }
    group:entry { group = "afs_ruined_food", count = { 1, 7 }, probability = 50 }
    content.add(group)
end

do
    -- A fridge or equivalent storing drinks from before the discontinuity. Should only contain nonperishable food and spawn in ruins.
    local group = content.ItemGroup { id = "afs_old_beverage_storage", kind = "collection" }
    group:entry { group = "afs_cheap_drinks", count = { 1, 5 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_messy_sofa", kind = "distribution" }
    group:group("soda_in_small_container", 560)
    group:group("writing_utensils", 20)
    group:item("bag_plastic", 20)
    group:item("emer_blanket", 20)
    group:item("water_clean", 90)
    group:item("wrapper_foil", 20)
    group:item("cup_foil", 1)
    group:item("teddy_bear", 7)
    group:item("blanket", 20)
    group:item("pillow", 20)
    content.add(group)
end

do
    -- The corpse of someone who managed to survive the Discontinuity for a while. Can spawn common weapons and misc gear.
    local group = content.ItemGroup { id = "afs_dead_survivor", kind = "collection", container = "afs_corpse_old" }
    group:entry {
        distribution = {
            { item = "afs_tattered_garment", probability = 90 },
            {
                collection = {
                    { group = "underwear" },
                    { group = "afs_wintersuit_generic_advanced" },
                },
                probability = 10,
            },
        },
    }
    group:group("afs_survivor_weapon_set", 80)
    group:entry { item = "afs_heavy_suit_battery_cell", count = { 1, 2 }, charges = { 100, 1000 }, probability = 80 }
    group:group("afs_tools_scavenging", 30)
    group:entry { group = "tools_survival", count = { 1, 3 }, probability = 80 }
    group:entry { group = "afs_cheap_food", count = { 2, 6 }, probability = 30 }
    group:group("afs_survivor_armor", 30)
    group:group("afs_any_hand_grenade", 1)
    content.add(group)
end

do
    -- Someone who died concurrently with the Discontinuity or very shortly after.  No survival gear.
    local group = content.ItemGroup { id = "afs_ancient_corpse", kind = "collection" }
    group:entry {
        distribution = {
            { item = "afs_corpse_old", probability = 70 },
            {
                collection = {
                    { item = "bone_human", count = { 5, 8 } },
                    { item = "skull_human", probability = 95 },
                },
                probability = 30,
            },
        },
    }
    group:item("afs_tattered_garment", 90)
    group:item("afs_glass_AR_device", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_survivor_weapon_set", kind = "distribution" }
    group:group("afs_any_makeshift_gun", 5)
    group:group("afs_any_ballistic_s_gun", 10)
    group:group("afs_any_laser_s_gun", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_imaginifer_police", kind = "collection" }
    group:item("afs_shotgun", 100, "military")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_imaginifer_stealth", kind = "collection" }
    group:item("wasp_gun")
    group:item("afs_triple_stacker_pouch")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_imaginifer", kind = "collection" }
    group:item("afs_sr77", 100, "military")
    group:item("afs_triple_stacker_pouch")
    group:entry { item = "bot_wraitheon_kaburaya", count = { 1, 2 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_old_imaginifer_laser", kind = "collection" }
    group:group("afs_any_laser_mag", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dead_old_imaginifer", kind = "collection" }
    group:group("afs_any_laser_mag", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_ifak", kind = "collection", container = "ifak_pouch" }
    group:group("medical_tape_roll_part")
    group:item("tourniquet_upper")
    group:group("quikclot_bag_plastic_5")
    group:entry { item = "bandages", count = { 9, 9 } }
    group:entry { item = "medical_gauze", count = { 3, 3 } }
    group:item("afs_medigel")
    group:item("afs_painkiller")
    group:item("afs_stimpack")
    group:item("syringe")
    group:item("gloves_medical")
    group:item("scissors_medical")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "augustmoon_shop_money", kind = "collection", with_ammo = 100 }
    group:entry { item = "UICA_10000d", count = { 5, 5 } }
    group:entry { item = "UICA_1000d", count = { 5, 5 } }
    group:entry { item = "UICA_100d", count = { 20, 20 } }
    group:entry { item = "UICA_10d", count = { 10, 10 } }
    group:entry { item = "UICA_50d", count = { 10, 10 } }
    group:entry { item = "UICA_1d", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_quartermaster_money", kind = "collection", with_ammo = 100 }
    group:entry { item = "UICA_1000d", count = { 8, 8 } }
    group:entry { item = "UICA_100d", count = { 15, 15 } }
    group:entry { item = "UICA_50d", count = { 20, 20 } }
    group:entry { item = "UICA_10d", count = { 20, 20 } }
    group:entry { item = "UICA_1d", count = { 10, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_banknotes", kind = "distribution" }
    group:item("UICA_1000d", 1)
    group:item("UICA_100d", 5)
    group:item("UICA_10d", 10)
    group:item("UICA_50d", 7)
    group:item("UICA_1d", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_cash_safe", kind = "distribution" }
    group:entry { group = "afs_banknotes", count = { 33, 55 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_register_full", kind = "distribution", container = "cash_register" }
    group:entry { group = "afs_banknotes", count = { 5, 33 } }
    content.add(group)
end

do
    -- If aftershock adds its own lore correct survivor notes this could be a place to put one
    local group = content.ItemGroup { id = "afs_register_looted", kind = "distribution", container = "cash_register" }
    group:entry { group = "afs_banknotes", count = { 1, 2 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_register_random", kind = "distribution" }
    group:group("afs_register_full", 45)
    group:group("afs_register_looted", 55)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_template_10mm_smart", kind = "distribution" }
    group:item("afs_10mm_smart", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_template_bio1", kind = "distribution" }
    group:entry { item = "afs_mealgrub_medium", container = "null", probability = 10 }
    group:entry { item = "afs_mealgrub_spores", container = "null", probability = 10 }
    group:entry { item = "afs_medigel", container = "null", probability = 10 }
    group:entry { item = "afs_painkiller", container = "null", probability = 10 }
    group:entry { item = "afs_stimpack", container = "null", probability = 10 }
    group:entry { item = "afs_synth_blood", container = "null", probability = 10 }
    group:entry { item = "cream_prot_cold", container = "null", probability = 10 }
    group:entry { item = "quikclot", container = "null", probability = 10 }
    group:entry { item = "morphine", container = "null", probability = 10 }
    group:entry { item = "antiparasitic", container = "null", probability = 10 }
    group:entry { item = "antibiotics", container = "null", probability = 10 }
    group:entry { item = "strong_antibiotic", container = "null", probability = 10 }
    group:entry { item = "antifungal", container = "null", probability = 10 }
    group:entry { item = "weak_antibiotic", container = "null", probability = 10 }
    group:entry { item = "birth_control", container = "null", probability = 10 }
    group:entry { item = "aspirin", container = "null", probability = 10 }
    group:entry { item = "metaprolol", container = "null", probability = 10 }
    group:entry { item = "melatonin_tablet", container = "null", probability = 10 }
    group:entry { item = "caffeine", container = "null", probability = 10 }
    group:entry { item = "diazepam", container = "null", probability = 10 }
    group:entry { item = "antihistamine", container = "null", probability = 10 }
    group:entry { item = "prophylactic_antivenom", container = "null", probability = 10 }
    group:entry { item = "prozac", container = "null", probability = 10 }
    group:entry { item = "bfipowder", container = "null", probability = 10 }
    group:entry { item = "estrogen", container = "null", probability = 10 }
    group:entry { item = "testosterone", container = "null", probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_template_bio1_expendable", kind = "distribution" }
    group:item("afs_cryo_goop", 10)
    group:item("afs_enzime_replicator", 1)
    group:item("afs_cryo_seedlings", 10)
    group:item("afs_cryo_terraforming_moss", 10)
    group:entry { group = "afs_template_bio1", container = "null", probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nuclear_waste", kind = "collection" }
    group:entry { item = "nuclear_waste", count = { 10, 10 }, wrapper = "hazardous_waste_drum" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nuclear_reactor", kind = "collection" }
    group:entry { item = "nuclear_waste", count = { 5, 10 } }
    group:entry { item = "nuclear_fuel", count = { 1, 10 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "reactor_gear", kind = "collection" }
    group:item("hazmat_suit", 33)
    group:item("prussian_blue", 33)
    group:item("rad_monitor", 33)
    group:item("iodine", 33)
    group:item("flashlight", 33)
    group:group("full_1st_aid", 15)
    group:item("geiger_off", 15)
    content.add(group)
end

do
    -- Old and mostly broken industrial bots, its meant to spawn in recharging stations, so it only places a single bot.
    local group = content.ItemGroup { id = "old_industrial_bot_storage", kind = "distribution" }
    group:item("bot_light_hack", 10)
    group:item("broken_hazmatbot", 60)
    group:item("broken_utilibot_const", 120)
    content.add(group)
end

do
    -- Small Consumer and commercial grade robots that can (probably) fit in the reinforced display cases.
    local group = content.ItemGroup { id = "domestic_bot_storage", kind = "distribution" }
    group:item("bot_light_hack", 20)
    group:item("bot_skitterbot_rat", 10)
    group:item("bot_eyebot_heater", 5)
    group:item("bot_skitterbot_hunter", 5)
    content.add(group)
end

do
    -- TODO: Apparently these items are all being migrated currently. Police Robots found in enforcer stations and departments.
    local group = content.ItemGroup { id = "afs_police_bot_storage", kind = "distribution" }
    group:item("afs_bot_riotbot", 5)
    group:item("afs_bot_copbot", 15)
    group:item("afs_bot_eyebot", 20)
    group:item("broken_afs_riotbot", 10)
    group:item("broken_afs_copbot", 70)
    group:item("broken_afs_eyebot")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "supplies_xenoreagents_lab", kind = "distribution" }
    group:item("yum_lichen", 10)
    group:group("afs_biomedical_scrapgroup", 10)
    group:group("afs_advanced_biomaterial_scrapgroup", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bio_templates_lab", kind = "distribution" }
    group:item("afs_template_bio1_expendable", 10)
    group:item("afs_template_bio1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_machinery_maintenance_scrapgroup", kind = "distribution" }
    group:group("afs_basic_material_scrapgroup", 30)
    group:group("afs_common_material_scrapgroup", 30)
    group:group("afs_common_heat_scrapgroup", 10)
    group:group("afs_common_magnet_scrapgroup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_robotics_scrapgroup", kind = "distribution" }
    group:group("afs_common_material_scrapgroup", 30)
    group:group("afs_common_circuitry_scrapgroup", 10)
    group:group("afs_common_energy_storage_scrapgroup", 20)
    group:group("afs_common_heat_scrapgroup", 10)
    group:group("afs_common_magnet_scrapgroup", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_biomedical_scrapgroup", kind = "distribution" }
    group:group("afs_common_biomaterial_scrapgroup", 60)
    group:group("afs_common_neural_io_scrapgroup", 35)
    group:group("afs_basic_material_scrapgroup", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_biomaterial_scrapgroup", kind = "distribution" }
    group:item("afs_biomaterial_1", 70)
    group:item("afs_biomaterial_2", 20)
    group:item("afs_biomaterial_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_biomaterial_scrapgroup", kind = "distribution" }
    group:item("afs_biomaterial_3", 70)
    group:item("afs_biomaterial_4", 25)
    group:item("afs_biomaterial_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_circuitry_scrapgroup", kind = "distribution" }
    group:item("afs_circuitry_1", 70)
    group:item("afs_circuitry_2", 20)
    group:item("afs_circuitry_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_circuitry_scrapgroup", kind = "distribution" }
    group:item("afs_circuitry_3", 70)
    group:item("afs_circuitry_4", 25)
    group:item("afs_circuitry_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_energy_storage_scrapgroup", kind = "distribution" }
    group:item("afs_energy_storage_1", 70)
    group:item("afs_energy_storage_2", 30)
    group:item("afs_energy_storage_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_energy_storage_scrapgroup", kind = "distribution" }
    group:item("afs_energy_storage_3", 70)
    group:item("afs_energy_storage_4", 25)
    group:item("afs_energy_storage_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_heat_scrapgroup", kind = "distribution" }
    group:item("afs_heat_1", 70)
    group:item("afs_heat_2_salvage", 20)
    group:item("afs_heat_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_heat_scrapgroup", kind = "distribution" }
    group:item("afs_heat_3", 70)
    group:item("afs_heat_4", 25)
    group:item("afs_heat_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_magnet_scrapgroup", kind = "distribution" }
    group:item("afs_magnet_1", 70)
    group:item("afs_magnet_2", 30)
    group:item("afs_magnet_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_magnet_scrapgroup", kind = "distribution" }
    group:item("afs_magnet_3", 70)
    group:item("afs_magnet_4", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_basic_material_scrapgroup", kind = "distribution" }
    group:item("afs_material_1", 90)
    group:item("afs_material_2", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_material_scrapgroup", kind = "distribution" }
    group:item("afs_material_1", 70)
    group:item("afs_material_2", 20)
    group:item("afs_material_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_material_scrapgroup", kind = "distribution" }
    group:item("afs_material_3", 70)
    group:item("afs_material_4", 25)
    group:item("afs_material_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_common_neural_io_scrapgroup", kind = "distribution" }
    group:item("afs_neural_io_1", 70)
    group:item("afs_neural_io_2", 20)
    group:item("afs_neural_io_3", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_neural_io_scrapgroup", kind = "distribution" }
    group:item("afs_neural_io_3", 70)
    group:item("afs_neural_io_4", 25)
    group:item("afs_neural_io_5", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_advanced_optics_scrapgroup", kind = "distribution" }
    group:item("afs_optics_3", 70)
    group:item("afs_optics_4", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_scrapgroup", kind = "distribution" }
    group:item("afs_biomaterial_1", 40)
    group:item("afs_biomaterial_2", 20)
    group:item("afs_biomaterial_3", 10)
    group:item("afs_biomaterial_4", 3)
    group:item("afs_circuitry_1", 25)
    group:item("afs_circuitry_2", 14)
    group:item("afs_circuitry_3", 6)
    group:item("afs_energy_storage_1", 30)
    group:item("afs_energy_storage_2", 19)
    group:item("afs_energy_storage_3", 2)
    group:item("afs_magnet_1", 18)
    group:item("afs_material_1")
    group:item("afs_material_2", 40)
    group:item("afs_material_3", 20)
    group:item("afs_neural_io_1", 65)
    group:item("afs_neural_io_2", 10)
    group:item("plut_cell", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_laserlab_scrap", kind = "distribution" }
    group:item("afs_optics_2", 40)
    group:item("afs_optics_3", 10)
    group:item("afs_doping_agent", 50)
    content.add(group)
end

do
    -- General civilian goods weighted for rarity
    local group = content.ItemGroup { id = "afs_crate_civ_rand", kind = "distribution" }
    group:group("afs_crate_food", 4)
    group:group("afs_crate_clothing", 2)
    group:group("afs_crate_medical", 1)
    group:entry { group = "afs_civilian_armory", count = { 2, 5 }, probability = 1 }
    content.add(group)
end

do
    -- Preserved food shipped in from off world.
    local group = content.ItemGroup { id = "afs_crate_food", kind = "collection" }
    group:entry { group = "afs_stored_meals", count = { 3, 8 }, probability = 50 }
    group:entry { group = "afs_dry_goods", count = { 3, 5 } }
    content.add(group)
end

do
    -- Multiple sets of clothing goods. Increased likelihood of a bag due the difficulty of getting into a crate in the first place.
    local group = content.ItemGroup { id = "afs_crate_clothing", kind = "collection" }
    group:entry { group = "afs_colonist_outfit", count = { 3, 6 } }
    group:entry { group = "afs_colonist_bags", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    -- Civilian Grade Medical supplies with a low chance of rare medical goods.
    local group = content.ItemGroup { id = "afs_crate_medical", kind = "collection" }
    group:entry { group = "drugs_pharmacy", count = { 3, 6 } }
    group:entry { item = "afs_synth_blood", count = { 1, 3 }, probability = 30 }
    group:entry { item = "afs_medigel", count = { 1, 3 }, probability = 60 }
    content.add(group)
end

do
    -- Robotics scrap with a much higher quantity due to the challenge of getting into the crate.
    local group = content.ItemGroup { id = "afs_crate_robotics", kind = "collection" }
    group:entry { group = "afs_robotics_scrapgroup", count = { 5, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "generated_ruin_data", kind = "distribution" }
    group:item("ruin_data_0", 40)
    group:item("ruin_data", 30)
    group:item("ruin_data_encrypted", 20)
    group:item("ruin_data_collapse", 10)
    group:item("ruin_data_decryption_keys", 5)
    group:item("ruin_data_space_currents", 5)
    group:item("ruin_data_holo", 2)
    group:item("ruin_data_geoengineering", 2)
    group:item("ruin_data_mercurial_id", 1)
    group:item("afs_gene_template_combat_brute", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_escapepod_ration_bag_plastic_4", kind = "collection", container = "bag_plastic" }
    group:entry { item = "afs_escapepod_ration", count = { 4, 4 }, container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_hard_hat", kind = "collection" }
    group:item("hat_hard")
    group:item("attachable_ear_muffs", 50)
    group:item("nape_protector", 20)
    group:item("sun_shield", 30)
    content.add(group)
end

do
    -- tools used for fixing robots.
    local group = content.ItemGroup { id = "afs_tools_robot_maintenance", kind = "distribution" }
    group:group("afs_robotics_scrapgroup", 7)
    group:group("afs_tools_circuitry_materials", 3)
    group:item("glasses_safety", 5)
    group:group("afs_tools_electric_repair", 10)
    group:group("afs_tools_welding", 5)
    group:item("vac_mold", 5)
    group:group("tools_toolbox", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_tools_circuitry_materials", kind = "collection" }
    group:group("afs_common_circuitry_scrapgroup", 30)
    group:group("afs_common_energy_storage_scrapgroup", 10)
    group:group("afs_common_material_scrapgroup", 10)
    group:item("breadboard", 5)
    group:group("solder_wire_spool_part", 10)
    group:item("circuit", 30)
    group:item("e_scrap", 30)
    group:item("cable", 50)
    content.add(group)
end

do
    -- Solar panels, power banks, RTGs and more.
    local group = content.ItemGroup { id = "afs_tools_portable_power", kind = "distribution" }
    group:item("folding_solar_panel_v2", 20)
    group:item("UPS_OFF", 30)
    group:item("afs_cRTG", 10)
    content.add(group)
end

do
    -- Keeps your solar panels, lights and well everything going.
    local group = content.ItemGroup { id = "afs_tools_electric_repair", kind = "distribution" }
    group:item("screwdriver_set", 20)
    group:group("glue_strong_domestic", 30)
    group:item("pliers", 10)
    group:item("multitool", 20)
    group:item("voltmeter", 20)
    group:item("multimeter", 20)
    group:item("jumper_cable", 10)
    group:item("hd_tow_cable", 5)
    group:item("recharge_station", 10)
    group:item("magnifying_glass", 10)
    group:item("gloves_work", 10)
    group:group("ammo_any_batteries_full", 20)
    group:group("tools_lighting_industrial", 10)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 10 }
    group:group("writing_utensils", 10)
    group:item("soldering_iron", 30)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 30 }
    group:group("solder_wire_spool_part", 30)
    group:entry { group = "duct_tape_roll_part", count = { 1, 2 }, probability = 30 }
    content.add(group)
end

do
    -- Plumbing tools, still mostly mundane.
    local group = content.ItemGroup { id = "afs_tools_plumbing", kind = "collection" }
    group:entry {
        distribution = {
            { item = "wrench", probability = 70 },
            { item = "wrench_large", probability = 20 },
            { item = "wrench_48", probability = 10 },
        },
        probability = 60,
    }
    group:entry {
        distribution = {
            { item = "crowbar", probability = 20 },
            { item = "claw_bar", probability = 10 },
            { item = "hammer_sledge", probability = 20 },
            { item = "hammer_sledge_short", probability = 20 },
            { item = "hammer_sledge_engineer", probability = 20 },
            { item = "hammer_sledge_heavy", probability = 10 },
        },
        probability = 30,
    }
    group:item("pliers", 50)
    group:item("bucket", 10)
    group:item("bucket_5gal", 10)
    group:item("clamp", 10)
    group:item("sandpaper", 90)
    group:item("bench_vise", 15)
    content.add(group)
end

do
    -- Fixes up rovers, shuttlecraft, aerocraft and more. (Group stubed created for someone more knowledgable to fill)
    local group = content.ItemGroup { id = "afs_tools_vehicle_repair", kind = "distribution" }
    group:group("afs_tools_structural_repair", 40)
    group:group("afs_tools_electric_repair", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_welding_paste_tube", kind = "distribution" }
    group:entry { item = "afs_welding_paste", count = { 280, 280 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_tools_welding_consumable", kind = "distribution" }
    group:entry {
        item = "squeeze_tube",
        count = { 1, 2 },
        contents = {
            { group = "afs_welding_paste_tube" },
        },
        probability = 90,
    }
    group:entry { item = "welding_rod_steel", count = { 1000, 1600 }, probability = 90 }
    group:entry { item = "welding_rod_alloy", count = { 1000, 1600 }, probability = 40 }
    group:entry { item = "welding_wire_steel", count = { 1000, 1600 }, probability = 90 }
    group:entry { item = "welding_wire_alloy", count = { 1000, 1600 }, probability = 40 }
    group:entry { item = "brazing_rod_bronze", count = { 500, 1500 }, probability = 80 }
    group:entry { item = "brazing_rod_alloy", count = { 400, 1200 }, probability = 30 }
    content.add(group)
end

do
    -- tools used by legitimate and illegitimate programmers.
    local group = content.ItemGroup { id = "afs_tools_programing", kind = "distribution" }
    group:entry { item = "laptop", charges = { 0, 500 }, probability = 50 }
    group:entry { item = "electrohack", charges = { 0, 500 }, probability = 5 }
    group:entry { item = "control_laptop", charges = { 0, 500 }, probability = 2 }
    group:item("afs_wrist_computer", 20)
    content.add(group)
end

do
    -- specialized tools used specifcally by cyber security specialists. Currently difers to the programming group but if advanced hacking tools get made they should be placed here.
    local group = content.ItemGroup { id = "afs_police_hacker_gear", kind = "collection" }
    group:group("afs_tools_programing", 60)
    group:group("afs_consumer_vr", 20)
    content.add(group)
end

do
    -- General use tools that fit in small pockets.
    local group = content.ItemGroup { id = "afs_tools_pocket", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "pockknife", probability = 50 },
            { item = "knife_folding", probability = 30 },
            { item = "knife_swissarmy", probability = 10 },
            { item = "switchblade", probability = 10 },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { item = "lighter", charges = { 0, 100 } },
            { item = "ref_lighter", charges = { 0, 50 }, probability = 40 },
            { item = "matches", charges = { 0, 20 }, probability = 20 },
        },
        probability = 5,
    }
    group:item("multitool", 5)
    group:item("screwdriver_set", 15)
    group:item("pliers", 5)
    group:group("glue_weak_domestic", 5)
    group:group("glue_strong_domestic", 5)
    group:entry { group = "duct_tape_roll_part", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_bay_rack", kind = "distribution" }
    group:group("vehicle_bay_tools", 50)
    group:group("vehicle_bay_mats", 50)
    content.add(group)
end

do
    -- Mechanic's tools, still mostly mundane.
    local group = content.ItemGroup { id = "vehicle_bay_tools", kind = "collection" }
    group:group("tools_toolbox", 5)
    group:group("afs_hard_hat", 5)
    group:group("afs_tools_welding", 5)
    group:group("afs_tools_welding_consumable", 10)
    group:entry { group = "tools_common_small", count = { 2, 4 }, probability = 20 }
    group:item("screwdriver_set", 20)
    group:item("pliers", 5)
    group:item("multitool", 5)
    group:item("gloves_work", 5)
    group:item("glasses_safety", 5)
    group:item("goggles_welding", 5)
    group:item("polisher", 20)
    group:item("angle_grinder", 20)
    group:item("thread_cutting_set", 5)
    group:item("hand_pump", 5)
    group:item("jumper_cable", 10)
    group:item("extension_cable", 15)
    group:item("hd_tow_cable", 5)
    group:item("clamp", 5)
    group:item("clamp", 5)
    group:item("metal_file", 10)
    group:item("hacksaw", 5)
    content.add(group)
end

do
    -- lightweight tools used for finding and getting into places where you don't belong.
    local group = content.ItemGroup { id = "afs_tools_scavenging", kind = "distribution" }
    group:item("electrohack")
    group:entry {
        collection = {
            { item = "afs_jetpack", probability = 50 },
            { item = "ammonia_liquid", count = { 1, 2 } },
        },
        probability = 10,
    }
    group:item("afs_imager", 30)
    group:item("afs_motion_sensor", 30)
    group:item("UPS_OFF", 20)
    group:item("grapnel", 20)
    group:entry {
        distribution = {
            { item = "geiger_off", probability = 2 },
            { item = "rad_monitor", probability = 1 },
        },
        probability = 10,
    }
    group:entry {
        distribution = {
            { item = "scrap_axe", probability = 5 },
            { item = "boarding_axe", probability = 1 },
        },
        probability = 10,
    }
    group:item("emf_detector", 50)
    group:item("tskbem_master_keycard", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vehicle_bay_mats", kind = "collection" }
    group:group("afs_vehicle_wheels", 5)
    group:group("afs_vehicle_utilities", 5)
    group:group("afs_vehicle_seating", 5)
    group:group("afs_vehicle_motors", 5)
    group:group("afs_vehicle_lights", 5)
    group:group("afs_vehicle_frames", 5)
    group:group("afs_vehicle_controls", 5)
    group:group("afs_vehicle_cargo", 5)
    group:group("afs_vehicle_batteries", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_wheels", kind = "distribution" }
    group:entry { item = "wheel_mount_light", count = { 1, 2 }, probability = 50 }
    group:entry { item = "wheel_mount_medium", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_mount_heavy", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_motorbike", count = { 1, 2 }, probability = 50 }
    group:entry { item = "wheel", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_wide_or", count = { 1, 4 }, probability = 50 }
    group:entry { item = "wheel_wide", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_utilities", kind = "distribution" }
    group:item("recharge_station", 50)
    group:item("cantilever_medium", 50)
    group:item("battery_charger", 50)
    group:entry { item = "heattank", count = { 1, 7 }, probability = 60 }
    group:entry { item = "workbench", count = { 1, 3 }, probability = 70 }
    group:entry { item = "solar_panel", count = { 3, 12 }, probability = 70 }
    group:entry { item = "reinforced_solar_panel", count = { 1, 2 }, probability = 20 }
    group:entry { item = "solar_panel_v2", count = { 2, 7 }, probability = 20 }
    group:entry { item = "beeper", count = { 1, 6 }, probability = 20 }
    group:entry { item = "stereo", count = { 1, 6 }, probability = 20 }
    group:entry { item = "v_motorcycle_kickstand_item", count = { 1, 8 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_seating", kind = "distribution" }
    group:entry { item = "seat", count = { 3, 8 }, probability = 60 }
    group:entry { item = "seat_bench", count = { 3, 8 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_motors", kind = "distribution" }
    group:item("motor", 30)
    group:item("motor_enhanced", 10)
    group:item("motor_super", 5)
    group:item("motor_large", 40)
    group:item("motor_small", 20)
    group:item("motor_tiny", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_lights", kind = "distribution" }
    group:entry { item = "car_headlight", count = { 5, 12 }, probability = 60 }
    group:entry { item = "motorcycle_headlight", count = { 3, 7 }, probability = 50 }
    group:entry { item = "headlight_reinforced", count = { 1, 3 }, probability = 20 }
    group:entry { item = "floodlight", count = { 1, 3 }, probability = 10 }
    group:entry { item = "directed_floodlight", count = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_frames", kind = "distribution" }
    group:entry { item = "xlframe", count = { 2, 8 }, probability = 40 }
    group:entry { item = "frame", count = { 7, 18 }, probability = 60 }
    group:entry { item = "hdframe", count = { 3, 15 }, probability = 30 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_controls", kind = "distribution" }
    group:item("camera_control", 20)
    group:entry { item = "omnicamera", count = { 3, 7 }, probability = 20 }
    group:entry { item = "omnicamera_reinforced", count = { 1, 4 }, probability = 10 }
    group:entry { item = "vehicle_controls", count = { 3, 8 }, probability = 60 }
    group:entry { item = "vehicle_dashboard", count = { 3, 7 }, probability = 40 }
    group:entry { item = "electronics_controls", count = { 2, 5 }, probability = 40 }
    group:item("turret_controls", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_cargo", kind = "distribution" }
    group:entry { item = "cargo_lock", count = { 3, 7 }, probability = 30 }
    group:entry { item = "cargo_rack", count = { 3, 8 }, probability = 40 }
    group:entry { item = "cargo_aisle", count = { 3, 7 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vehicle_batteries", kind = "distribution", with_ammo = 100 }
    group:item("large_storage_battery", 10)
    group:entry { item = "storage_battery", count = { 1, 4 }, probability = 30 }
    group:entry { item = "medium_storage_battery", count = { 3, 8 }, probability = 40 }
    group:entry { item = "small_storage_battery", count = { 5, 15 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vending_false_meals", kind = "collection" }
    group:entry { group = "afs_vending_false_meal_items", count = { 5, 20 } }
    group:entry { group = "afs_vending_false_meal_items", count = { 5, 25 }, probability = 66 }
    group:entry { group = "afs_vending_false_meal_items", count = { 5, 25 }, probability = 20 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vending_energy_ammo", kind = "collection" }
    group:entry { group = "afs_civilian_laser_mag", count = { 5, 10 }, probability = 66 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vending_ballistic_ammo", kind = "collection" }
    group:entry { group = "afs_civilian_ballistic_s_ammo", count = { 5, 20 }, container = "box_small_metal" }
    group:entry { group = "afs_civilian_ballistic_m_ammo", count = { 5, 20 }, container = "box_small_metal" }
    group:entry { group = "afs_civilian_ballistic_h_ammo", count = { 5, 20 }, container = "ammunition_can_30", probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vending_medicine", kind = "collection" }
    group:entry { group = "drugs_pharmacy", count = { 5, 20 } }
    group:entry { group = "drugs_soldier", count = { 5, 25 }, probability = 40 }
    group:entry { group = "drugs_soldier", count = { 5, 25 }, probability = 40 }
    group:entry { item = "afs_synth_blood", count = { 1, 5 }, probability = 40 }
    group:entry { group = "afs_ifak", count = { 1, 2 }, probability = 40 }
    group:entry { group = "harddrugs", count = { 5, 25 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_vending_false_meal_items", kind = "distribution" }
    group:item("afs_h2o", 90)
    group:item("afs_sundew", 50)
    group:item("afs_food_to_go", 50)
    group:item("afs_calorie_pill", 10)
    group:item("afs_food_cube", 50)
    group:item("afs_cee_wafers", 50)
    group:item("afs_beefsim", 50)
    group:item("afs_soup_27", 50)
    group:item("afs_caffex", 50)
    group:item("afs_loop_fruit", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "plut_cell_vending", kind = "collection" }
    group:item("plut_cell", 80)
    group:entry { item = "plut_cell", count = { 0, 1 }, probability = 20 }
    group:entry { item = "plut_cell", count = { 2, 5 }, probability = 3 }
    content.add(group)
end

do
    -- A group for EVERY human made weapon in Aftershock.  Make sure to expand as necessary
    local group = content.ItemGroup { id = "afs_general_armory", kind = "distribution" }
    group:group("afs_energy_weapon_armory", 3)
    group:group("afs_ballistic_armory", 3)
    group:group("afs_grenade_armory", 1)
    content.add(group)
end

do
    -- For ruins open to the elements, replaces some weapons with broken versions.
    local group = content.ItemGroup { id = "afs_ruin_armory", kind = "distribution" }
    group:group("afs_general_armory", 2)
    group:entry {
        distribution = {
            { item = "afs_ruined_laser_pistol", damage = { 2, 4 }, probability = 10 },
            { item = "afs_ruined_laser_rifle", damage = { 2, 4 }, probability = 10 },
            { item = "afs_ruined_rifle", damage = { 2, 4 }, probability = 15 },
            { item = "afs_ruined_magazine", damage = { 2, 4 }, probability = 5 },
        },
        probability = 3,
    }
    content.add(group)
end

do
    -- A group for Aftershock gun vendors.
    local group = content.ItemGroup { id = "afs_civilian_armory", kind = "distribution" }
    group:group("afs_civilian_energy_weapon_armory", 3)
    group:group("afs_civilian_ballistic_armory", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_grenade_armory", kind = "distribution" }
    group:group("afs_any_hand_grenade", 3)
    group:group("afs_any_mine", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_energy_weapon_armory", kind = "distribution" }
    group:group("afs_any_energy_gun", 3)
    group:group("afs_any_energy_mag", 2)
    group:group("gunmod_energy", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_ballistic_armory", kind = "distribution" }
    group:group("afs_any_ballistic_gun", 6)
    group:group("afs_any_ballistic_mag", 2)
    group:group("afs_any_ballistic_ammo", 4)
    group:group("afs_shotgun_gunmod", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_energy_weapon_armory", kind = "distribution" }
    group:group("afs_civilian_energy_gun", 3)
    group:group("afs_civilian_energy_mag", 2)
    group:group("gunmod_energy", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_ballistic_armory", kind = "distribution" }
    group:group("afs_civilian_ballistic_gun", 6)
    group:group("afs_any_ballistic_mag", 2)
    group:group("afs_any_civilian_ballistic_ammo", 4)
    group:group("afs_shotgun_gunmod", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_wraitheon_carsh_site_cache", kind = "distribution" }
    group:group("afs_wraitheon_smart_rifle_cache", 5)
    group:group("afs_wraitheon_vahagn_cache", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_wraitheon_smart_rifle_cache", kind = "collection" }
    group:item("afs_wa2519")
    group:entry { item = "afs_25mm_smart", count = { 150, 250 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_wraitheon_vahagn_cache", kind = "collection" }
    group:item("afs_vahagn_smartgun")
    group:entry { item = "afs_vahagn_smartgun_mag", count = { 2, 2 } }
    group:entry { item = "afs_7.50mm_smart", count = { 750, 1500 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_guntrader_military_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_25mm_apfsds", 10)
    group:item("afs_25mm_frag", 10)
    group:item("shot_flechette", 20)
    group:item("3x35dart", 10)
    group:item("3x35toxic", 2)
    group:item("afs_shot_he", 20)
    group:item("afs_4g_plasma", 20)
    group:item("afs_20g_plasma", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_augustmoon_guntrader_military_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_Accipitermg", 20)
    group:group("afs_gun_trader_rectifier", 1)
    group:item("afs_gibrifle", 40)
    group:item("afs_heavy_tactical_laser", 5)
    group:item("afs_pam-41", 10)
    group:item("wasp_gun", 10)
    group:item("afs_magnadrive_230k", 5)
    group:item("afs_marsec_t72", 2)
    group:item("afs_sr77", 10)
    group:item("afs_gibs_shotgun", 20)
    group:item("afs_raketa_shotgun", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_gun_trader_rectifier", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:entry { item = "afs_antitank_railgun", count = { 1, 1 } }
    group:entry { item = "afs_30x200mm", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_military_locker", kind = "distribution" }
    group:group("afs_uica_weapon_locker")
    group:group("afs_uica_armor_locker")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_weapon_locker", kind = "collection" }
    group:entry { group = "afs_uica_guns", count = { 1, 4 }, probability = 70 }
    group:entry { group = "afs_any_hand_grenade", count = { 1, 5 }, probability = 40 }
    group:entry { group = "afs_uicia_mags", count = { 1, 3 }, probability = 40 }
    group:entry { group = "afs_uicia_ammo", count = { 3, 6 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uicia_ammo", kind = "distribution" }
    group:entry { item = "afs_7.50mm_caseless", count = { 2, 4 } }
    group:entry { item = "afs_10mm_caseless_JHP", count = { 1, 3 } }
    group:entry { item = "shot_00", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_your_ship_armory", kind = "collection", with_ammo = 100, with_magazine = 100 }
    group:entry { item = "afs_gibrifle", count = { 2, 2 } }
    group:entry { item = "afs_shotgun", count = { 1, 1 } }
    group:entry { item = "shot_00", count = { 10, 10 } }
    group:entry { item = "afs_UICASTA30", count = { 4, 4 } }
    group:entry { item = "afs_cartridge", count = { 3, 3 } }
    group:entry { item = "afs_7.50mm_caseless", count = { 4, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_armor_locker", kind = "collection" }
    group:group("afs_wintersuit_generic_combat", 60)
    group:item("afs_military_vest", 60)
    group:group("afs_uica_armor_locker_helmets", 60)
    group:item("afs_military_cloak", 30)
    group:item("afs_ilbe", 30)
    group:item("holster", 20)
    group:item("sheath", 20)
    group:item("afs_triple_stacker_pouch", 10)
    group:item("afs_grenade_pouch", 10)
    group:item("afs_ammo_satchel", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_armor_locker_helmets", kind = "distribution" }
    group:item("tac_fullhelmet_uicas")
    group:item("tac_helmet_uicas")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civillian_gun_case", kind = "distribution" }
    group:group("afs_civilian_ballistic_gun", 40)
    group:group("afs_civilian_energy_gun", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_police_armory", kind = "distribution" }
    group:group("afs_civilian_armory", 3)
    group:item("tazer", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_police_anti_robot_armory", kind = "collection" }
    group:group("afs_swat_emp", 3)
    group:group("afs_civilian_laser_mag", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_ballistic_gun", kind = "distribution" }
    group:group("afs_any_ballistic_s_gun", 10)
    group:group("afs_any_ballistic_m_gun", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_ballistic_gun", kind = "distribution" }
    group:group("afs_civilian_ballistic_s_gun", 10)
    group:group("afs_civilian_ballistic_m_gun", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_s_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_seyfert_84K", 40)
    group:item("afs_marsec_4", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_m_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_Accipitermg", 20)
    group:item("afs_gibrifle", 40)
    group:item("afs_shotgun", 15)
    group:item("afs_sr77", 10)
    group:item("afs_25mm_goa", 5)
    group:item("afs_marsec_t72", 2)
    group:item("afs_drotik_shotpistol", 5)
    group:item("afs_shotgun_magnastorm", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_h_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_gibs_shotgun", 10)
    group:item("afs_raketa_shotgun", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_ballistic_mag", kind = "distribution" }
    group:group("afs_any_ballistic_s_mag", 10)
    group:group("afs_any_ballistic_m_mag", 10)
    group:group("afs_any_ballistic_h_mag", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_s_mag",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_84k_20mag", 40)
    group:item("afs_marsec_14mag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_m_mag",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_UICASTA30", 40)
    group:item("afs_UICASTA100drum", 5)
    group:item("afs_shot_speedloader8", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_h_mag",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_25mm_mag", 20)
    group:item("afs_raketa30mag", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_ballistic_ammo", kind = "distribution" }
    group:group("afs_any_ballistic_s_ammo", 10)
    group:group("afs_any_ballistic_m_ammo", 10)
    group:group("afs_any_ballistic_h_ammo", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_civilian_ballistic_ammo", kind = "distribution" }
    group:group("afs_civilian_ballistic_s_ammo", 10)
    group:group("afs_civilian_ballistic_m_ammo", 10)
    group:group("afs_civilian_ballistic_h_ammo", 2)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_s_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_10mm_caseless_FMJ", 20)
    group:item("afs_10mm_caseless_JHP", 40)
    group:item("afs_7.50mm_caseless", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_m_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_7.50mm_caseless", 40)
    group:item("shot_00", 40)
    group:item("shot_slug", 25)
    group:item("shot_beanbag", 10)
    group:item("shot_flechette", 5)
    group:item("afs_shot_he", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_any_ballistic_h_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_25mm_shot", 40)
    group:item("afs_25mm_apfsds", 5)
    group:item("afs_25mm_frag", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_shotgun_gunmod", kind = "distribution" }
    group:item("afs_magnetic_choke", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_ballistic_s_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_seyfert_84K", 40)
    group:item("afs_marsec_4", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_ballistic_m_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_shotgun", 15)
    group:item("afs_25mm_goa", 5)
    group:item("afs_drotik_shotpistol", 5)
    group:item("afs_shotgun_magnastorm", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_ballistic_s_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_10mm_caseless_FMJ", 20)
    group:item("afs_10mm_caseless_JHP", 40)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_ballistic_m_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_7.50mm_caseless", 10)
    group:item("afs_7.50mm_rp", 40)
    group:item("shot_00", 5)
    group:item("shot_slug", 5)
    group:item("shot_beanbag", 5)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_ballistic_h_ammo",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_25mm_shot", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_energy_gun", kind = "distribution" }
    group:group("afs_any_laser_gun", 12)
    group:group("afs_any_plasma_gun", 5)
    group:group("afs_any_voltaic_gun", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_laser_gun", kind = "distribution" }
    group:group("afs_any_laser_s_gun", 10)
    group:group("afs_any_laser_h_gun", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_laser_h_gun", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_heavy_tactical_laser", 40)
    group:group("afs_explosive_pumped_laser_s", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_explosive_pumped_laser_s", kind = "collection" }
    group:item("afs_explosive_pumped_laser")
    group:entry { item = "afs_82mm_flashbulb", count = { 2, 9 }, probability = 90 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_plasma_gun", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_pam-41", 30)
    group:item("afs_magnadrive_230k", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_energy_mag", kind = "distribution" }
    group:group("afs_any_laser_mag", 10)
    group:group("afs_any_plasma_mag", 5)
    group:group("afs_any_voltaic_mag", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_laser_mag", kind = "distribution", with_ammo = 100 }
    group:item("afs_bootleg_cartridge", 80)
    group:item("afs_compact_cartridge", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_plasma_mag", kind = "distribution", with_ammo = 100 }
    group:item("afs_4g_plasma", 30)
    group:item("afs_20g_plasma", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_voltaic_gun", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_electro_anomaly_rifle", 1)
    group:item("afs_voltaic_pistol", 90)
    group:item("afs_archangel_enr", 9)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_voltaic_mag", kind = "distribution", with_ammo = 100 }
    group:item("afs_voltaic_cartridge", 30)
    content.add(group)
end

do
    -- Plasma isn't sold to civilians
    local group = content.ItemGroup { id = "afs_civilian_energy_gun", kind = "distribution" }
    group:group("afs_civilian_laser_gun", 12)
    group:group("afs_civilian_voltaic_gun", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_laser_gun", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_v29", 40)
    group:item("afs_av22", 60)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "afs_civilian_voltaic_gun",
        kind = "distribution",
        with_ammo = 100,
        with_magazine = 100,
    }
    group:item("afs_voltaic_pistol", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_civilian_energy_mag", kind = "distribution" }
    group:group("afs_civilian_laser_mag", 10)
    group:group("afs_any_voltaic_mag", 3)
    content.add(group)
end

do
    -- Anti-Robot weapons for police force
    local group = content.ItemGroup { id = "afs_swat_emp", kind = "distribution" }
    group:item("afs_xm34", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_hand_grenade", kind = "distribution" }
    group:entry { item = "afs_electroshock_grenade_1", count = { 1, 3 } }
    group:entry { item = "grenade_cryo", count = { 1, 3 } }
    group:entry { item = "grenade", count = { 1, 3 } }
    group:entry { item = "afs_HE_grenade", count = { 1, 3 } }
    group:entry { item = "afs_toxic_grenade", count = { 1, 3 } }
    group:entry { item = "grenade_inc", count = { 1, 3 } }
    group:entry { item = "smokebomb", count = { 1, 3 } }
    group:entry { item = "scrambler", count = { 1, 3 } }
    group:entry { item = "grenade_emp", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_mine", kind = "distribution" }
    group:entry { item = "bot_shock_mine", count = { 3, 5 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_anti_robot_grenades", kind = "distribution" }
    group:entry { item = "afs_electroshock_grenade_1", count = { 1, 3 } }
    group:entry { item = "scrambler", count = { 1, 3 } }
    group:entry { item = "grenade_emp", count = { 1, 3 } }
    content.add(group)
end

do
    -- Self made 'guns' for the post-Discontinuity scavenger.  These vary quite a lot between them and ammo might be rare, so we spawn them together with some.
    local group = content.ItemGroup { id = "afs_any_makeshift_gun", kind = "distribution" }
    group:group("afs_scrapbow_s", 5)
    group:group("afs_scrapcrossbow_s", 5)
    group:group("afs_plasma_torch_gun_s", 5)
    group:item("makeshift_scrambler", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_scrapbow_s", kind = "collection" }
    group:item("scrapbow")
    group:group("afs_arrows", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_scrapcrossbow_s", kind = "collection" }
    group:item("scrapcrossbow")
    group:group("afs_bolts", 90)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_plasma_torch_gun_s", kind = "collection" }
    group:item("afs_plasma_torch_gun")
    group:item("afs_40g_plasma_civ", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_arrows", kind = "distribution" }
    group:item("arrow_nano", 5)
    group:item("arrow_cf", 10)
    group:item("arrow_metal_sharpened_fletched", 40)
    group:item("arrow_metal", 20)
    group:item("arrow_metal_bodkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_bolts", kind = "distribution" }
    group:item("bolt_cf", 10)
    group:item("bolt_metal", 40)
    group:item("bolt_steel", 20)
    group:item("bolt_steel_bodkin", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_UICASTA30", kind = "distribution" }
    group:item("afs_UICASTA30", 40)
    content.add(group)
end

do
    -- We could spawn clothes based on character selection, but that would require a lot of work.  Lets just say PC's taste is very specific.
    local group = content.ItemGroup { id = "afs_your_ship_clothing", kind = "collection" }
    group:entry {
        item = "afs_leather_jacket",
        count = { 5, 5 },
        flags = {
            "FIT",
        },
    }
    group:entry {
        item = "longshirt",
        count = { 12, 12 },
        flags = {
            "FIT",
        },
    }
    group:entry {
        item = "pants",
        count = { 8, 8 },
        flags = {
            "FIT",
        },
    }
    group:entry {
        group = "socks_unisex",
        flags = {
            "FIT",
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_mealgrub_precursor", kind = "collection" }
    group:entry { item = "afs_mealgrub_spores", count = { 1, 6 } }
    group:entry { item = "afs_mealgrub_medium", count = { 23, 6 }, probability = 80 }
    group:entry { item = "afs_mealgrub_medium", count = { 2, 6 }, probability = 33 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_escapepod_shootout", kind = "collection" }
    group:entry { item = "afs_seyfert_84K", charges = { 15, 19 }, ammo = { item = "afs_10mm_caseless_FMJ" } }
    group:item("corpse")
    group:group("afs_plastic_armor_g", 33)
    group:group("afs_carbide_raider_armor_g", 10)
    group:group("mil_armor", 10)
    group:group("afs_colonist_shirt")
    group:group("afs_colonist_pants")
    group:group("afs_colonist_shoes")
    group:group("drugs_soldier", 25)
    content.add(group)
end

do
    -- Survival kit for survival in terrestrial planets.  List based on the gear found on lifeboats.
    local group = content.ItemGroup {
        id = "afs_escape_pod_suppliesII",
        kind = "collection",
        container = "afs_landfall_kit_2",
        overflow = "spill",
    }
    group:item("knife_folding")
    group:item("flint_steel")
    group:item("whistle_multitool")
    group:entry { item = "water_clean", count = { 3, 3 }, container = "bottle_twoliter" }
    group:entry { group = "afs_escapepod_ration_bag_plastic_4", count = { 3, 3 } }
    group:entry { item = "cream_prot_cold", count = { 3, 3 } }
    group:entry { item = "flashlight", charges = { 150, 150 } }
    group:item("water_purifier")
    group:entry {
        item = "medium_battery_cell",
        charges = { 600, 600 },
        container = "multi_cooker",
        ammo = { item = "battery" },
    }
    group:item("rope_6")
    group:entry { item = "emer_blanket", count = { 2, 2 } }
    group:item("afs_radiobeacon")
    group:entry { item = "afs_landfall_gun", container = "back_holster" }
    group:entry { item = "afs_7.50mm_rp", charges = { 18, 18 } }
    group:item("afs_landfall_kit_2_instructions")
    content.add(group)
end

do
    -- Emergency Firefighting and repair tools for inside an habitat or spaceship. Can get as specialized as needed.
    local group = content.ItemGroup { id = "afs_tools_space_emergency", kind = "collection" }
    group:entry {
        distribution = {
            { item = "extinguisher", charges = { 75, 100 }, probability = 35 },
            { item = "throw_extinguisher", count = { 3, 5 }, probability = 75 },
        },
    }
    group:entry {
        item = "rebreather",
        charges = { 60, 60 },
        ammo = { item = "rebreather_filler_soda_lime" },
        probability = 75,
    }
    group:entry {
        distribution = {
            { item = "fire_ax", probability = 20 },
            { item = "crash_axe", probability = 80 },
        },
        probability = 30,
    }
    group:entry {
        collection = {
            { item = "afs_foamgun" },
            { item = "afs_foam_tank", charges = { 30, 30 }, ammo = { item = "afs_foamcrete" } },
        },
        probability = 10,
    }
    group:entry { item = "afs_oxygen_candle", count = { 2, 4 }, probability = 75 }
    group:entry {
        distribution = {
            { group = "full_ifak" },
            { group = "used_ifak" },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- Fixes up spaceships, habitats and probably more.
    local group = content.ItemGroup { id = "afs_tools_structural_repair", kind = "distribution" }
    group:entry {
        distribution = {
            { group = "afs_tools_welding", probability = 30 },
            {
                collection = {
                    { item = "afs_foamgun", count = { 1, 2 } },
                    {
                        item = "afs_foam_tank",
                        count = { 1, 2 },
                        charges = { 30, 30 },
                        ammo = { item = "afs_foamcrete" },
                    },
                },
                probability = 20,
            },
            {
                collection = {
                    { item = "plastic_sheet", count = { 3, 6 } },
                    { group = "duct_tape_roll_part", count = { 1, 5 } },
                },
                probability = 50,
            },
        },
        probability = 70,
    }
    group:group("tools_toolbox", 5)
    group:group("afs_tools_plumbing", 15)
    group:item("afs_imager", 10)
    content.add(group)
end

do
    -- tools used for sci-fi and not sci-fi welding.
    local group = content.ItemGroup { id = "afs_tools_welding", kind = "collection", with_ammo = 75 }
    group:entry {
        distribution = {
            { item = "welder", probability = 20 },
            {
                item = "squeeze_tube",
                count = { 1, 2 },
                contents = {
                    { group = "afs_welding_paste_tube" },
                },
                probability = 20,
            },
            { item = "welder", probability = 20 },
            {
                collection = {
                    { item = "oxy_torch", count = { 1, 2 } },
                    { item = "tinyweldtank", count = { 1, 3 } },
                    { item = "weldtank", count = { 1, 2 }, probability = 50 },
                },
                probability = 20,
            },
            {
                collection = {
                    {
                        item = "afs_40g_plasma_civ",
                        count = { 1, 2 },
                        charges = { 16, 40 },
                        ammo = { item = "afs_shydrogen" },
                    },
                    { item = "afs_plasma_torch", count = { 1, 2 }, probability = 50 },
                },
                probability = 40,
            },
        },
        probability = 30,
    }
    group:entry { group = "afs_tools_welding_consumable", count = { 1, 2 }, probability = 10 }
    group:item("polisher", 20)
    group:item("angle_grinder", 20)
    group:item("clamp", 10)
    group:item("metal_file", 10)
    group:item("hacksaw", 5)
    group:item("saw", 5)
    group:item("bow_saw", 5)
    group:item("sandpaper", 10)
    group:item("goggles_welding", 30)
    content.add(group)
end

do
    -- tools used by large farms
    local group = content.ItemGroup { id = "afs_tools_agricultural_hazardous", kind = "distribution" }
    group:entry {
        collection = {
            { item = "afs_foamgun" },
            { item = "afs_foam_tank", count = { 1, 2 }, charges = { 30, 30 }, ammo = { item = "afs_foamtoxic" } },
            { item = "prophylactic_antivenom", count = { 5, 5 }, probability = 1 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uica_guns", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_marsec_t72")
    group:entry { item = "afs_sr77", variant = "military", ammo = { item = "afs_7.50mm_caseless" } }
    group:entry { item = "afs_shotgun", variant = "military", ammo = { item = "shot_00" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_uicia_mags", kind = "distribution" }
    group:entry { item = "afs_sr77_45mag", count = { 1, 3 }, charges = { 45, 45 }, ammo = { item = "afs_7.50mm_caseless" } }
    group:entry {
        item = "afs_marsec_14mag",
        count = { 2, 5 },
        charges = { 14, 14 },
        ammo = { item = "afs_10mm_caseless_JHP" },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_laser_s_gun", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("afs_v29", 40)
    group:item("afs_av22", 60)
    group:entry {
        item = "afs_archeotech_laspistol",
        charges = { 15000, 15000 },
        ammo = { item = "afs_battery_plus" },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "afs_any_laser_mag", kind = "distribution", with_ammo = 100 }
    group:item("afs_cartridge", 10)
    group:item("afs_bootleg_cartridge", 80)
    group:item("afs_compact_cartridge", 10)
    group:entry {
        item = "afs_archeotech_cartridge",
        charges = { 15000, 15000 },
        ammo = { item = "afs_battery_plus" },
        probability = 1,
    }
    content.add(group)
end
