local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bionics_civilian", kind = "distribution" }
    group:entry {
        distribution = {
            { item = "bio_power_storage", probability = 90 },
            { item = "bio_power_storage_mkII", probability = 10 },
        },
    }
    group:entry {
        distribution = {
            { item = "bio_alarm", probability = 20 },
            { item = "bio_flashlight", probability = 30 },
            { item = "bio_jointservo", probability = 15 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "bio_ar", probability = 25 },
            { item = "bio_soporific", probability = 20 },
            { item = "bio_sunglasses", probability = 25 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "bio_ethanol", probability = 50 },
            { item = "bio_fuel_cell_gasoline", probability = 50 },
            { item = "bio_torsionratchet", probability = 200 },
            { item = "bio_mana_to_bionic_power", probability = 25 },
            { item = "bio_fuel_cell_blood", probability = 5 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "bio_tools", probability = 15 },
            { item = "bio_electrokit", probability = 15 },
            { item = "bio_magnet", probability = 15 },
            { item = "bio_syringe", probability = 3 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { item = "bio_speed", probability = 50 },
                    { item = "bio_hydraulics", probability = 50 },
                },
                probability = 1,
            },
            { item = "bio_dex_enhancer", probability = 30 },
            { item = "bio_int_enhancer", probability = 40 },
            { item = "bio_memory", probability = 35 },
            { item = "bio_eye_enhancer", probability = 40 },
            { item = "bio_str_enhancer", probability = 30 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "bio_blood_anal", probability = 20 },
            { item = "bio_ears", probability = 20 },
            { item = "bio_eye_optic", probability = 20 },
            { item = "bio_membrane", probability = 15 },
            { item = "bio_meteorologist", probability = 5 },
            { item = "bio_night_vision", probability = 4 },
            { item = "bio_ground_sonar", probability = 2 },
            { item = "bio_infrared", probability = 8 },
            { item = "bio_see_wizards_eyes", probability = 8 },
        },
        probability = 35,
    }
    group:entry {
        distribution = {
            { item = "bio_climate", probability = 15 },
            { item = "bio_geiger", probability = 10 },
            { item = "bio_digestion", probability = 15 },
            { item = "bio_evap", probability = 20 },
            { item = "bio_fingerhack", probability = 10 },
            { item = "bio_gills", probability = 10 },
            { item = "bio_purifier", probability = 20 },
            { item = "bio_recycler", probability = 8 },
            { item = "bio_electrokit", probability = 10 },
        },
        probability = 10,
    }
    content.add(group)
end

do
    -- items carried by a XEDRA research thaumaturge prior to zombification.  Magical trinkets, reagents, etc.
    local group = content.ItemGroup { id = "mon_zombie_research_thaumaturge_death_drops", kind = "collection" }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "lab_torso_research_thaumaturge", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry {
        collection = {
            { group = "potions_common", probability = 50 },
            { group = "potions_uncommon", probability = 20 },
            { group = "enchanted_rings_common", probability = 20 },
            { group = "enchanted_wands_lesser", probability = 20 },
            { group = "magical_reagents", count = { 1, 5 }, probability = 80 },
            { group = "textbooks", probability = 25 },
            { group = "lab_files_generic", probability = 15 },
            { item = "crystallized_mana", charges = { 1, 5 }, probability = 35 },
        },
    }
    group:entry { group = "wallets_science", damage = { 1, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_animist_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:entry { group = "magical_reagents", count = { 1, 5 }, probability = 33 }
    group:group("group_potion_fruits", 20)
    group:group("enchanted_combat_items", 25)
    group:group("animist_items", 10)
    group:item("bone", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_druid_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:entry { group = "magical_reagents", count = { 1, 5 }, probability = 33 }
    group:group("group_potion_fruits", 20)
    group:group("enchanted_combat_items", 25)
    group:group("druid_items", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_earthshaper_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:entry { group = "magical_reagents", count = { 1, 5 }, probability = 33 }
    group:group("enchanted_combat_items", 25)
    group:group("earthshaper_items", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_magus_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:entry { group = "magical_reagents", count = { 1, 5 }, probability = 33 }
    group:group("enchanted_combat_items", 25)
    group:group("magus_items", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_stormshaper_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:entry { group = "magical_reagents", count = { 1, 5 }, probability = 33 }
    group:group("enchanted_combat_items", 25)
    group:group("stormshaper_items", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_feral_technomancer_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 80 },
            { group = "enchanted_rings_uncommon", probability = 20 },
        },
        probability = 4,
    }
    group:entry {
        distribution = {
            { item = "robe_wizard", probability = 50 },
            { item = "robe", probability = 50 },
        },
        probability = 20,
    }
    group:entry { item = "crystallized_mana", charges = { 1, 5 }, probability = 20 }
    group:group("default_zombie_clothes")
    group:group("enchanted_combat_items", 25)
    group:group("technomancer_items", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_ravenfolk_death_drops", kind = "collection" }
    group:entry { group = "default_ravenfolk_clothes", damage = { 1, 4 } }
    group:entry { group = "ravenfolk_jewelry", count = { 0, 4 } }
    group:entry { group = "default_zombie_items", count = { 1, 3 }, probability = 50 }
    group:group("wallets", 50)
    group:item("denarius", 5)
    content.add(group)
end

do
    -- Being cold-blooded and having scales, lizardfolk don't wear many clothes.
    local group = content.ItemGroup { id = "feral_lizardfolk_death_drops", kind = "collection" }
    group:entry {
        group = "small_bags",
        damage = { 1, 4 },
        contents = {
            { group = "default_zombie_items_bags_small" },
        },
        probability = 50,
    }
    group:entry { group = "default_zombie_items", count = { 1, 3 }, probability = 50 }
    group:item("denarius", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goblin_warrior_death_drops", kind = "collection" }
    group:entry { group = "feral_goblin_death_drops", damage = { 1, 4 } }
    group:entry { group = "goblin_armor_drops", damage = { 1, 4 } }
    group:entry { item = "cudgel", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goblin_slinger_death_drops", kind = "collection" }
    group:entry { group = "feral_goblin_death_drops", damage = { 1, 4 } }
    group:entry { group = "goblin_armor_drops", damage = { 1, 4 } }
    group:entry { item = "sling", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goblin_chieftan_death_drops", kind = "collection" }
    group:entry { group = "feral_goblin_death_drops", damage = { 1, 4 } }
    group:entry { group = "goblin_armor_drops", damage = { 1, 4 } }
    group:entry { group = "goblin_chieftan_weapon_drops", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goblin_bugbear_death_drops", kind = "collection" }
    group:entry { group = "bugbear_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_weapon_drops", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "goblin_bugbear_stalker_death_drops", kind = "collection" }
    group:entry { group = "bugbear_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_stalker_weapon_drops", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bugbear_clothing_drops", kind = "collection" }
    group:item("loincloth_fur", 75)
    group:item("footrags_fur", 25)
    group:item("gloves_wraps_fur", 25)
    group:item("bellywrap_fur", 10)
    group:item("chestwrap_fur", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orc_warrior_death_drops", kind = "collection" }
    group:entry { group = "orc_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:entry { group = "orc_warrior_weapon_drops", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orc_archer_death_drops", kind = "collection" }
    group:entry { group = "orc_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:entry { group = "orc_archer_melee_weapon_drops", damage = { 1, 4 }, probability = 50 }
    group:entry { group = "orc_archer_ranged_weapon_drops", damage = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orc_blood_warrior_death_drops", kind = "collection" }
    group:entry { group = "orc_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:entry { group = "orc_blood_warrior_weapon_drops", damage = { 1, 4 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "orc_blood_mage_death_drops", kind = "collection" }
    group:entry { group = "orc_armor_drops", damage = { 1, 4 } }
    group:entry { group = "bugbear_clothing_drops", damage = { 1, 4 } }
    group:group("magic_plants_common", 10)
    group:group("magic_plants_uncommon", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mossling_drops", kind = "collection" }
    group:entry { item = "mossling_fur", count = { 1, 10 }, probability = 50 }
    group:entry { item = "stick", count = { 1, 2 }, probability = 50 }
    group:entry { item = "leaves", count = { 8, 16 }, probability = 95 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dryad_drops", kind = "collection" }
    group:entry { item = "dryad_bark", count = { 1, 6 }, probability = 50 }
    group:entry { item = "splinter", count = { 20, 40 }, probability = 85 }
    group:entry { item = "stick", count = { 2, 4 }, probability = 90 }
    group:entry { item = "leaves", count = { 10, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brackenwight_drops", kind = "collection" }
    group:entry { item = "bracken_eye", count = { 1, 3 }, probability = 50 }
    group:entry { item = "stick", count = { 1, 2 }, probability = 90 }
    group:entry { item = "leaves", count = { 2, 4 } }
    group:entry { item = "withered", count = { 10, 40 }, probability = 75 }
    group:entry { item = "veggy", count = { 10, 40 }, probability = 75 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gnome_drops", kind = "collection" }
    group:entry { item = "gnome_eye", count = { 1, 2 }, probability = 50 }
    group:entry { item = "rock", count = { 10, 30 }, probability = 85 }
    group:entry { item = "pebble", count = { 40, 90 }, probability = 85 }
    group:entry { item = "rock_flaking", count = { 3, 6 }, probability = 85 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "balrog_drops", kind = "collection" }
    group:entry { item = "fading_embers_active", count = { 1, 1 } }
    content.add(group)
end

do
    -- All the items the librarian will buy but won't sell back to you.
    local group = content.ItemGroup { id = "forge_lord_ardelia_loved_items", kind = "collection" }
    group:item("beech_nuts")
    content.add(group)
end

do
    -- All the items Helen and her crew will accept as payment but won't sell back to you.
    local group = content.ItemGroup { id = "forge_lord_pirate_treasure", kind = "collection" }
    group:group("gold_treasure")
    group:group("silver_treasure")
    group:group("platinum_treasure")
    group:group("misc_treasure")
    group:group("gemstones")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "silver_treasure", kind = "collection" }
    group:item("silver_small")
    group:group("cufflinks_silver")
    group:group("tiaras_silver")
    group:group("pendant_necklaces_silver")
    group:group("earrings_silver")
    group:group("rings_silver")
    group:group("bracelets_silver")
    group:item("silver_anklet")
    group:item("silver_medal")
    group:item("silver_hairpin")
    group:item("silver_locket")
    group:item("silver_watch")
    group:item("silver_hair_beads")
    group:item("silver_lip_ring_loop")
    group:item("silver_lip_ring_stud")
    group:item("silver_nose_ring_loop")
    group:item("silver_nose_ring_stud")
    group:item("silver_toe_ring")
    group:item("1l_silver")
    group:item("5l_silver")
    group:item("10l_silver")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "gold_treasure", kind = "collection" }
    group:item("gold_small")
    group:group("cufflinks_gold")
    group:group("tiaras_gold")
    group:group("pendant_necklaces_gold")
    group:group("earrings_gold")
    group:group("rings_gold")
    group:group("bracelets_gold")
    group:item("gold_anklet")
    group:item("gold_medal")
    group:item("gold_hairpin")
    group:item("gold_locket")
    group:item("gold_watch")
    group:item("gold_hair_beads")
    group:item("gold_lip_ring_loop")
    group:item("gold_lip_ring_stud")
    group:item("gold_nose_ring_loop")
    group:item("gold_nose_ring_stud")
    group:item("gold_toe_ring")
    group:item("chalice")
    group:item("crown_golden_survivor")
    group:item("crown_golden")
    group:item("1l_gold")
    group:item("5l_gold")
    group:item("10l_gold")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "platinum_treasure", kind = "collection" }
    group:item("platinum_small")
    group:group("cufflinks_platinum")
    group:group("tiaras_platinum")
    group:group("pendant_necklaces_platinum")
    group:group("earrings_platinum")
    group:group("rings_platinum")
    group:group("bracelets_platinum")
    group:item("platinum_hairpin")
    group:item("platinum_locket")
    group:item("platinum_watch")
    group:item("1l_platinum")
    group:item("5l_platinum")
    group:item("10l_platinum")
    content.add(group)
end

do
    -- mithril ingot is explicitly not here because it's sold by Helen
    local group = content.ItemGroup { id = "orichalcum_and_mithril_treasure", kind = "collection" }
    group:item("orichalcum_sliver")
    group:item("orichalcum_lump")
    group:item("orichalcum_ingot")
    group:item("mithril_lump")
    group:item("longsword_mithril")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "misc_treasure", kind = "collection" }
    group:group("dental_grills")
    group:item("hc_steel_facemask")
    group:item("qt_steel_facemask")
    group:item("lc_steel_facemask")
    group:item("ring_signet")
    group:item("ring_purity")
    group:item("ring_engagement")
    group:item("ring_wedding")
    group:item("cufflinks")
    group:item("cufflinks_intricate")
    group:item("diamond_ring")
    group:item("diamond_dental_grill")
    group:item("jade_brooch")
    group:item("sf_watch")
    group:item("pocketwatch")
    group:item("tieclip")
    group:item("pearl_collar")
    group:item("diamond")
    group:item("holy_symbol")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_technomancer_CBM_harvest_power", kind = "collection" }
    group:group("feral_technomancer_CBM_harvest_charging_tools", 25)
    group:entry {
        distribution = {
            { item = "bio_power_storage", probability = 90 },
            { item = "bio_power_storage_mkII", probability = 10 },
        },
        probability = 50,
    }
    group:item("bio_power_storage", 20)
    group:item("burnt_out_bionic", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_technomancer_CBM_harvest_charging_tools", kind = "distribution" }
    group:item("bio_ethanol", 50)
    group:item("bio_fuel_cell_gasoline", 50)
    group:item("bio_mana_to_bionic_power", 25)
    group:item("bio_fuel_cell_blood", 5)
    group:item("bio_torsionratchet", 200)
    content.add(group)
end

do
    -- Nothing combat-oriented, this was a civilian
    local group = content.ItemGroup { id = "feral_technomancer_CBM_harvest", kind = "collection" }
    group:entry {
        distribution = {
            { item = "bio_alarm", probability = 20 },
            { item = "bio_flashlight", probability = 30 },
            { item = "bio_geiger", probability = 10 },
            { item = "bio_jointservo", probability = 15 },
            { item = "bio_lockpick", probability = 30 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 60 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "bio_tools", probability = 15 },
            { item = "bio_electrokit", probability = 15 },
            { item = "bio_magnet", probability = 15 },
            { item = "bio_soporific", probability = 20 },
            { item = "bio_sunglasses", probability = 25 },
            { item = "bio_syringe", probability = 10 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 50 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements" },
            { group = "feral_technomancer_CBM_harvest_sensors", probability = 60 },
            { group = "Zomborg_CBM_harvest_expensive_utilities", probability = 1 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements", probability = 30 },
            { group = "feral_technomancer_CBM_harvest_sensors", probability = 60 },
            { group = "Zomborg_CBM_harvest_expensive_utilities", probability = 1 },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_high_technomancer_CBM_harvest_power", kind = "collection" }
    group:group("feral_technomancer_CBM_harvest_charging_tools", 25)
    group:entry {
        distribution = {
            { item = "bio_power_storage", probability = 75 },
            { item = "bio_power_storage_mkII", probability = 25 },
        },
        probability = 50,
    }
    group:item("bio_power_storage", 20)
    group:item("burnt_out_bionic", 30)
    content.add(group)
end

do
    -- Nothing combat-oriented, this was a civilian
    local group = content.ItemGroup { id = "feral_high_technomancer_CBM_harvest", kind = "collection" }
    group:entry {
        distribution = {
            { item = "bio_alarm", probability = 20 },
            { item = "bio_flashlight", probability = 30 },
            { item = "bio_geiger", probability = 10 },
            { item = "bio_jointservo", probability = 15 },
            { item = "bio_lockpick", probability = 30 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 30 },
        },
        probability = 90,
    }
    group:entry {
        distribution = {
            { item = "bio_tools", probability = 15 },
            { item = "bio_electrokit", probability = 15 },
            { item = "bio_magnet", probability = 15 },
            { item = "bio_soporific", probability = 20 },
            { item = "bio_sunglasses", probability = 25 },
            { item = "bio_syringe", probability = 10 },
            { item = "bio_tattoo_led", probability = 40 },
            { item = "burnt_out_bionic", probability = 30 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements", probability = 50 },
            { group = "feral_technomancer_CBM_harvest_sensors", probability = 20 },
            { group = "Zomborg_CBM_harvest_expensive_utilities", probability = 1 },
        },
        probability = 30,
    }
    group:entry {
        distribution = {
            { group = "Zomborg_CBM_harvest_stat_enhancements", probability = 30 },
            { group = "feral_technomancer_CBM_harvest_sensors", probability = 60 },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_technomancer_CBM_harvest_sensors", kind = "distribution" }
    group:item("bio_blood_anal", 20)
    group:item("bio_ears", 20)
    group:item("bio_eye_optic", 20)
    group:item("bio_membrane", 15)
    group:item("bio_meteorologist", 10)
    group:item("bio_night_vision", 5)
    group:item("bio_ground_sonar", 2)
    group:item("bio_see_wizards_eyes", 5)
    group:item("bio_infrared", 8)
    content.add(group)
end

do
    -- puts all the dragon books in one group, so it's easy to add more later
    local group = content.ItemGroup { id = "dragon_books", kind = "distribution" }
    group:item("black_dragons", 10)
    group:item("black_dragons_historical", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellcraft_books", kind = "distribution" }
    group:item("spellcraft_theory_basic", 70)
    group:item("spellcraft_theory", 30)
    group:item("caster_boosts_info", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magiclysm_joke_scrolls", kind = "distribution" }
    group:item("null", 16)
    group:item("summon_scroll_smudged", 2)
    group:item("spell_scroll_tornskin", 2)
    group:item("spell_scroll_stormshaper_cloak_of_frog", 2)
    group:item("spell_scroll_animist_magic_fissile", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_shop_books", kind = "distribution" }
    group:group("spellbook_loot_1", 60)
    group:group("spell_scroll_tier_0", 80)
    group:group("spell_scroll_tier_1", 60)
    group:group("spell_scroll_tier_2", 30)
    group:group("magic_recipe_basic", 50)
    group:group("magic_recipe_advanced", 20)
    group:group("spellcraft_books", 40)
    group:item("alchemy_master", 12)
    group:entry {
        distribution = {
            { group = "spellbook_restricted_loot_1", probability = 60 },
            { group = "spell_scroll_restricted_tier_0", probability = 80 },
            { group = "spell_scroll_restricted_tier_1", probability = 60 },
            { group = "spell_scroll_restricted_tier_2", probability = 30 },
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_shop_beginner_books", kind = "collection" }
    group:group("spellbook_tier_0")
    group:group("spellbook_tier_0", 80)
    group:group("spellbook_tier_0", 60)
    group:group("spellbook_tier_0", 20)
    group:item("spellcraft_theory_basic", 10)
    group:item("caster_boosts_info", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_shop_wands", kind = "distribution" }
    group:entry { item = "wand_magic_missile_minor", charges = { 12, 34 }, probability = 35 }
    group:entry { item = "wand_fireball_minor", charges = { 3, 24 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_plants_common", kind = "distribution" }
    group:item("olieribos", 10)
    group:item("whiskflower", 30)
    group:group("magic_plants_uncommon", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_plants_uncommon", kind = "distribution" }
    group:item("kampuch", 6)
    group:item("glowing_mushroom", 20)
    group:item("horn_moss_capsule", 10)
    group:item("wood_barnacle", 10)
    group:item("dragon_nail", 10)
    group:item("moly_tuber", 10)
    group:item("fern_flower", 10)
    group:item("funnelcap_chunk", 10)
    group:group("magic_plants_rare", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_plants_rare", kind = "distribution" }
    group:item("platonic_flower", 10)
    group:item("moonflowers", 10)
    group:item("golden_reed_stalk", 5)
    group:item("sojourners_flower", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "potions_common", kind = "distribution" }
    group:item("mana_potion_lesser", 90)
    group:item("mana_potion", 5)
    group:item("mana_potion_greater", 1)
    group:item("flask_illumination", 10)
    group:item("flask_rebreather", 10)
    group:group("potions_uncommon", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "potions_uncommon", kind = "distribution" }
    group:item("cats_grace_potion", 10)
    group:item("ogres_strength_potion", 10)
    group:item("eagles_sight_potion", 10)
    group:item("foxs_cunning_potion", 10)
    group:item("flask_resistance", 10)
    group:item("flask_max_mana", 10)
    group:item("flask_fireball", 10)
    group:item("flask_spear", 10)
    group:item("flask_shadow_field", 10)
    group:group("potions_rare", 2)
    group:group("potions_illegal", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "potions_illegal", kind = "distribution" }
    group:item("flask_confusion", 10)
    group:item("flask_teleport", 10)
    group:item("flask_invisibility", 10)
    group:item("flask_charm", 10)
    group:item("flask_mood", 10)
    group:item("flask_toxin", 10)
    group:item("flask_venom", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_shop_potions", kind = "distribution" }
    group:group("potions_common", 80)
    group:group("potions_uncommon", 30)
    group:group("potions_rare", 5)
    group:group("alchemy_items", 30)
    group:group("magical_reagents", 20)
    group:entry { item = "crystallized_mana", charges = { 1, 10 }, probability = 55 }
    group:entry { item = "small_mana_crystal", charges = { 5, 50 }, probability = 40 }
    content.add(group)
end

do
    -- Alchemy items originating from monsters, for Pirate Lord shop.
    local group = content.ItemGroup { id = "alchemy_monster_loot", kind = "distribution" }
    group:item("owlbear_stone", 10)
    group:entry { item = "stone_shell", count = { 1, 3 }, probability = 10 }
    group:item("egg_owlbear_rock", 5)
    group:item("glow_light_off", 1)
    group:item("bulette_plate", 10)
    group:item("cauldron_orichalcum", 7)
    group:item("mithril_ingot", 2)
    group:entry { item = "bulette_pearl", count = { 1, 2 }, probability = 8 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "alchemy_items", kind = "distribution" }
    group:item("owlbear_stone", 10)
    group:entry { item = "stone_shell", count = { 1, 3 }, probability = 10 }
    group:item("egg_owlbear_rock", 5)
    group:item("glow_light_off", 1)
    group:item("bulette_plate", 10)
    group:item("cauldron_orichalcum", 7)
    group:item("mithril_ingot", 2)
    group:entry { item = "bulette_pearl", count = { 1, 2 }, probability = 8 }
    group:group("magic_plants_common", 6)
    group:group("magic_plants_uncommon", 3)
    group:group("magic_plants_rare", 1)
    content.add(group)
end

do
    -- Stuff you would find in an average wizard's workshop or other place where someone stores magical goodies.
    local group = content.ItemGroup { id = "magic_tools_and_loot", kind = "collection" }
    group:group("tools_common", 60)
    group:group("jewelry_safe", 10)
    group:group("jewelry_front", 8)
    group:entry { group = "potions_common", count = { 1, 3 }, probability = 15 }
    group:entry { group = "potions_uncommon", count = { 1, 2 }, probability = 7 }
    group:group("potions_rare", 3)
    group:group("potions_illegal", 1)
    group:entry { group = "magical_reagents", count = { 1, 3 }, probability = 45 }
    group:entry {
        distribution = {
            { group = "enchanted_wands_lesser", probability = 15 },
            { group = "spellbook_loot_1", count = { 1, 3 }, probability = 35 },
            { group = "enchanted_rings_common", probability = 20 },
            { group = "enchanted_rings_uncommon", probability = 5 },
            { group = "enchanted_combat_items", probability = 10 },
            { group = "enchanted_arrows", probability = 5 },
            { group = "enchanted_belts", probability = 2 },
            { group = "enchanted_misc", probability = 1 },
        },
        probability = 15,
    }
    group:entry { item = "bone_human", count = { 1, 5 }, probability = 60 }
    group:entry { item = "denarius", count = { 2, 5 }, probability = 40 }
    group:item("cauldron_orichalcum", 10)
    group:group("tools_toolbox", 20)
    group:entry { group = "magic_plants_common", count = { 1, 14 }, probability = 40 }
    group:entry { group = "magic_plants_uncommon", count = { 1, 8 }, probability = 20 }
    group:entry { group = "magic_plants_rare", count = { 1, 4 }, probability = 5 }
    content.add(group)
end

do
    -- Magical items for a troll lair.  Mostly consumables
    local group = content.ItemGroup { id = "stone_troll_lair_treasure", kind = "distribution" }
    group:group("potions_common", 80)
    group:group("potions_uncommon", 20)
    group:group("enchanted_wands_lesser", 50)
    group:entry { group = "magic_shop_books", count = { 1, 3 }, probability = 35 }
    group:group("enchanted_rings_common", 20)
    group:group("enchanted_rings_uncommon", 5)
    group:group("enchanted_combat_items", 10)
    group:group("enchanted_belts", 2)
    group:group("magical_reagents", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "demon_spider_lair_treasure", kind = "distribution" }
    group:group("potions_common", 20)
    group:group("potions_uncommon", 20)
    group:group("potions_rare", 10)
    group:group("potions_illegal", 10)
    group:group("enchanted_wands_lesser", 15)
    group:entry { group = "spellbook_loot_1", count = { 1, 3 }, probability = 35 }
    group:group("enchanted_rings_common", 20)
    group:group("enchanted_rings_uncommon", 5)
    group:item("mring_fire_protection", 3)
    group:group("enchanted_combat_items", 10)
    group:group("enchanted_belts", 2)
    group:group("magical_reagents", 8)
    group:entry { item = "denarius", count = { 11, 67 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_shop_clothes", kind = "distribution" }
    group:item("cloak", 3)
    group:item("cloak_wool", 5)
    group:item("jedi_cloak", 3)
    group:item("robe", 5)
    group:item("tophat", 5)
    group:item("leathersandals", 6)
    group:item("bookstrap", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "parabolan_armor", kind = "distribution" }
    group:item("gambeson_parabolan", 10)
    group:item("gambeson_parabolan_thinsleeved", 5)
    group:item("gambeson_parabolan_vest", 5)
    group:item("gambeson_pants_parabolan", 3)
    group:item("gambeson_gloves_parabolan", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wisp_death", kind = "distribution" }
    group:item("glow_dust", 1)
    content.add(group)
end

do
    -- Stuff you would find in someone's basement closet.
    local group = content.ItemGroup { id = "basement_utility_closet", kind = "distribution" }
    group:group("tools_common", 60)
    group:group("paint", 20)
    group:group("supplies_fuel", 35)
    group:group("tools_toolbox", 10)
    group:item("mop")
    group:item("broom")
    group:item("battery_car", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_CBM", kind = "distribution" }
    group:item("bio_fuel_cell_blood", 25)
    group:item("bio_mana_to_bionic_power", 25)
    group:item("bio_see_wizards_eyes", 25)
    group:item("bio_ley_energy_blaster", 10)
    group:item("bio_sneeze_beam", 10)
    content.add(group)
end

do
    -- Stuff you would find in any dragon lair, gold, jewelry, etc.
    local group = content.ItemGroup { id = "lair_loot_generic", kind = "distribution" }
    group:group("jewelry_safe", 30)
    group:group("jewelry_front", 8)
    group:entry { item = "bone_human", count = { 1, 5 }, probability = 60 }
    group:entry { item = "denarius", count = { 7, 32 }, probability = 40 }
    content.add(group)
end

do
    -- Stuff you would find in any dragon deeper lair level.  Gold, jewelry, weapons etc.  Should require a bit of a fight or risk to access.
    local group = content.ItemGroup { id = "lair_black_dragon", kind = "distribution" }
    group:entry { item = "bone_human", count = { 1, 5 }, probability = 30 }
    group:entry { item = "dragon_black_scale", count = { 12, 56 } }
    group:group("archery", 1)
    group:group("jewelry_safe", 2)
    group:group("jewelry_front", 2)
    group:group("corpses", 20)
    group:entry { group = "remains_human_generic", count = { 1, 2 }, probability = 5 }
    group:entry { group = "archery_ammo", count = { 1, 4 }, probability = 2 }
    group:entry { group = "medieval", count = { 1, 2 }, probability = 1 }
    group:entry { group = "medieval", count = { 1, 2 }, probability = 1 }
    group:group("magical_reagents", 2)
    group:group("enchanted_combat_items", 1)
    group:entry { item = "denarius", count = { 17, 53 }, probability = 40 }
    content.add(group)
end

do
    -- Stuff you would find in any dragon treasure room or from a boss fight.  Should require exceptional risk to access.  Includes lower tier group, plus the best magic items.
    local group = content.ItemGroup { id = "lair_black_dragon_treasure", kind = "distribution" }
    group:entry { group = "lair_loot_generic", count = { 2, 6 }, probability = 80 }
    group:group("enchanted_tokens_weapon", 30)
    group:group("enchanted_arrows", 20)
    group:group("enchanted_rings_common", 40)
    group:group("enchanted_rings_uncommon", 30)
    group:group("enchanted_rings_unusual", 20)
    group:group("enchanted_rings_rare", 10)
    group:group("enchanted_melee_weapons_plus1", 30)
    group:group("enchanted_melee_weapons_plus2", 10)
    group:group("enchanted_wands_minor", 40)
    group:group("enchanted_wands_lesser", 20)
    group:group("enchanted_wands_greater", 10)
    group:group("enchanted_masks", 10)
    group:group("enchanted_bracers_lesser", 20)
    group:group("enchanted_bracers_greater", 10)
    group:group("enchanted_boots", 15)
    group:group("enchanted_bracelets", 15)
    group:group("enchanted_belts", 15)
    group:group("spellbook_loot_2", 20)
    group:group("enchanted_misc", 5)
    group:group("enchanted_cloaks_rare", 10)
    group:group("items_of_elvenkind", 5)
    group:entry { item = "denarius", count = { 27, 98 }, probability = 40 }
    content.add(group)
end

do
    -- all enchanted miscellaneous items
    local group = content.ItemGroup { id = "enchanted_misc", kind = "distribution" }
    group:item("golemcore", 10)
    group:item("heat_cube")
    group:item("mkey_opening")
    group:item("mtorch_everburning")
    group:item("mcandle_everburning")
    group:item("mflask_hip_whiskey")
    group:entry { item = "mtailors_kit", charges = { 3, 24 } }
    group:item("mteapot", 40)
    group:entry { item = "mspider_box", charges = { 3, 24 } }
    group:item("cauldron_demon_chitin", 20)
    group:item("fridge_holding_1", 12)
    group:item("bag_holding_1", 8)
    group:item("bag_holding_2", 2)
    group:item("bag_holding_3", 1)
    group:item("cauldron_orichalcum")
    group:entry { item = "bleed_staff_minor", charges = { 1, 5 }, probability = 8 }
    group:entry { item = "grim_reaper_scythe", charges = { 1, 3 }, probability = 2 }
    content.add(group)
end

do
    -- all the melee weapon tokens
    local group = content.ItemGroup { id = "enchanted_tokens_weapon", kind = "collection" }
    group:item("mtoken_longsword", 10)
    group:item("mtoken_arming_sword", 10)
    group:item("mtoken_broadsword", 10)
    group:item("mtoken_battleaxe", 10)
    group:item("mtoken_pike", 10)
    group:item("mtoken_mace", 10)
    group:item("mtoken_q_staff", 10)
    content.add(group)
end

do
    -- all the tool tokens
    local group = content.ItemGroup { id = "enchanted_tokens_tool", kind = "collection" }
    group:item("mtoken_hammer", 20)
    group:item("mtoken_screwdriver_set", 30)
    group:item("mtoken_crowbar", 20)
    content.add(group)
end

do
    -- all the common enchanted rings
    local group = content.ItemGroup { id = "enchanted_rings_common", kind = "collection" }
    group:item("mring_blades_lesser", 5)
    group:item("mring_strength_1", 10)
    group:item("mring_dexterity_1", 10)
    group:item("mring_intelligence_1", 10)
    group:item("mring_perception_1", 10)
    group:item("mring_speed_3", 10)
    group:item("mring_protection_2", 10)
    group:item("mring_wizardry_minor", 5)
    content.add(group)
end

do
    -- all the uncommon enchanted rings
    local group = content.ItemGroup { id = "enchanted_rings_uncommon", kind = "collection" }
    group:item("mring_strength_2", 10)
    group:item("mring_dexterity_2", 10)
    group:item("mring_intelligence_2", 10)
    group:item("mring_dodge_bonus_1", 10)
    group:item("mring_perception_2", 10)
    group:item("mring_speed_5", 10)
    group:item("mring_protection_4", 10)
    group:item("storage_ring_lesser", 10)
    group:item("mring_wizardry_lesser", 5)
    content.add(group)
end

do
    -- all the unusual enchanted rings
    local group = content.ItemGroup { id = "enchanted_rings_unusual", kind = "collection" }
    group:item("mring_strength_3", 10)
    group:item("mring_dexterity_3", 10)
    group:item("mring_dodge_bonus_2", 10)
    group:item("mring_intelligence_3", 10)
    group:item("mring_perception_3", 10)
    group:item("mring_speed_7", 10)
    group:item("mring_protection_6", 10)
    group:item("storage_ring_greater", 10)
    group:item("mring_fire_protection", 10)
    group:item("mring_sustenance", 10)
    group:item("mring_wizardry_moderate", 5)
    content.add(group)
end

do
    -- all the rare enchanted rings.  High end loot for boss fights, treasure rooms, etc.
    local group = content.ItemGroup { id = "enchanted_rings_rare", kind = "collection" }
    group:item("mring_strength_4", 10)
    group:item("mring_dexterity_4", 10)
    group:item("mring_intelligence_4", 10)
    group:item("mring_perception_4", 10)
    group:item("mring_speed_10", 10)
    group:item("mring_protection_8", 10)
    group:item("mring_flying", 10)
    group:item("mring_wizardry_greater", 5)
    content.add(group)
end

do
    -- minor enchanted wands
    local group = content.ItemGroup { id = "enchanted_wands_minor", kind = "collection" }
    group:entry { item = "wand_magic_missile_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_fireball_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_mana_beam_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_point_flare_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_minor", charges = { 3, 20 }, probability = 20 }
    group:entry { item = "wand_disp_cone_cold_minor", charges = { 3, 20 }, probability = 20 }
    content.add(group)
end

do
    -- disposable wands only
    local group = content.ItemGroup { id = "enchanted_wands_disposable_combat", kind = "distribution" }
    group:group("enchanted_wands_disposable_minor_combat")
    group:group("enchanted_wands_disposable_lesser_combat", 50)
    group:group("enchanted_wands_disposable_greater_combat", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "enchanted_wands_disposable_minor_combat", kind = "distribution" }
    group:entry { item = "wand_disp_magic_missile_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_fireball_minor", charges = { 3, 24 }, probability = 5 }
    group:entry { item = "wand_disp_mana_beam_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_point_flare_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_cone_cold_minor", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_knock_minor", charges = { 3, 24 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "enchanted_wands_disposable_lesser_combat", kind = "distribution" }
    group:entry { item = "wand_disp_magic_missile_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_fireball_lesser", charges = { 3, 24 }, probability = 5 }
    group:entry { item = "wand_disp_mana_beam_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_point_flare_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_cone_cold_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_knock_lesser", charges = { 3, 24 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "enchanted_wands_disposable_greater_combat", kind = "distribution" }
    group:entry { item = "wand_disp_magic_missile_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_fireball_greater", charges = { 3, 24 }, probability = 5 }
    group:entry { item = "wand_disp_mana_beam_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_point_flare_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_cone_cold_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_knock_greater", charges = { 3, 24 }, probability = 10 }
    content.add(group)
end

do
    -- enchanted arrows in various quantities
    local group = content.ItemGroup { id = "enchanted_arrows", kind = "distribution" }
    group:entry { item = "arrow_druid_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_stormshaper_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_earthshaper_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_kelvinist_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_biomancer_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_technomancer_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_magus_crafted", count = { 2, 20 }, probability = 10 }
    group:entry { item = "arrow_animist_crafted", count = { 2, 20 }, probability = 10 }
    content.add(group)
end

do
    -- lesser enchanted wands
    local group = content.ItemGroup { id = "enchanted_wands_lesser", kind = "collection" }
    group:entry { item = "wand_magic_missile_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_fireball_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_mana_beam_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_point_flare_lesser", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_lesser", charges = { 3, 20 }, probability = 20 }
    group:entry { item = "wand_disp_cone_cold_lesser", charges = { 3, 20 }, probability = 20 }
    content.add(group)
end

do
    -- rare enchanted wands.  High end loot for boss fights, treasure rooms, etc.
    local group = content.ItemGroup { id = "enchanted_wands_greater", kind = "collection" }
    group:entry { item = "wand_magic_missile_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_fireball_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_mana_beam_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_point_flare_greater", charges = { 3, 24 }, probability = 10 }
    group:entry { item = "wand_disp_hoaryblast_greater", charges = { 3, 20 }, probability = 20 }
    group:entry { item = "wand_disp_cone_cold_greater", charges = { 3, 20 }, probability = 20 }
    content.add(group)
end

do
    -- all enchanted masks.  High end loot for boss fights, treasure rooms, etc.
    local group = content.ItemGroup { id = "enchanted_masks", kind = "collection" }
    group:item("mmask_disappearance", 5)
    group:item("mmask_vision", 10)
    content.add(group)
end

do
    -- lesser enchanted bracers
    local group = content.ItemGroup { id = "enchanted_bracers_lesser", kind = "collection" }
    group:item("mbracer_defense_lesser", 10)
    group:item("mbracer_lightning_lesser", 10)
    group:item("mbracer_archery", 5)
    content.add(group)
end

do
    -- greater enchanted bracers
    local group = content.ItemGroup { id = "enchanted_bracers_greater", kind = "collection" }
    group:item("mbracer_blinding_strike", 10)
    group:item("mbracer_defense_greater", 10)
    group:item("mbracer_lightning_greater", 10)
    content.add(group)
end

do
    -- all enchanted bracelets
    local group = content.ItemGroup { id = "enchanted_bracelets", kind = "collection" }
    group:item("missile_volley_bracelet", 5)
    group:item("gorgon_bracelet", 5)
    group:item("disorientation_bracelet", 5)
    group:item("super_hot_bracelet", 5)
    content.add(group)
end

do
    -- all enchanted boots
    local group = content.ItemGroup { id = "enchanted_boots", kind = "collection" }
    group:item("mboots_haste", 10)
    group:item("mboots_sevenleague", 10)
    group:item("mboots_escape", 10)
    group:item("mboots_freerunner", 10)
    group:item("mboots_grounding", 10)
    content.add(group)
end

do
    -- all enchanted belts
    local group = content.ItemGroup { id = "enchanted_belts", kind = "collection" }
    group:item("magi_staff_minor", 10)
    group:item("wizard_hat", 20)
    group:item("mbelt_haste", 5)
    group:item("mbelt_thor", 1)
    group:item("mbelt_pockets_lesser", 10)
    group:item("mbelt_pockets_greater", 5)
    group:item("mbelt_weaponry", 10)
    group:item("mbelt_technomancer_toolbelt", 5)
    group:item("mbelt_iron_whip", 5)
    group:item("quiver_of_holding_plus_one", 5)
    group:item("quiver_of_holding_plus_two", 1)
    content.add(group)
end

do
    -- all enchanted necklaces
    local group = content.ItemGroup { id = "enchanted_necklaces", kind = "collection" }
    group:item("periapt_health", 20)
    group:item("periapt_proof_against_poison", 10)
    group:item("periapt_wound_closure", 5)
    content.add(group)
end

do
    -- plus 1 enchanted melee weapons
    local group = content.ItemGroup { id = "enchanted_melee_weapons_plus1", kind = "distribution" }
    group:item("cudgel_plus_one", 10)
    group:item("q_staff_plus_one", 10)
    group:item("i_staff_plus_one", 10)
    group:item("longsword_plus_one", 5)
    group:item("warhammer_plus_one", 8)
    group:item("spear_steel_plus_one", 8)
    group:item("qiang_plus_one", 8)
    group:item("halberd_plus_one", 8)
    group:item("glaive_plus_one", 8)
    group:item("naginata_plus_one", 5)
    group:item("mace_plus_one", 5)
    group:item("morningstar_plus_one", 5)
    group:item("jian_plus_one", 5)
    group:item("scimitar_plus_one", 5)
    group:item("estoc_plus_one", 5)
    group:item("arming_sword_plus_one", 5)
    group:item("broadsword_plus_one", 5)
    group:item("battleaxe_plus_one", 5)
    group:item("cavalry_sabre_plus_one", 5)
    group:item("cutlass_plus_one", 5)
    group:item("katana_plus_one", 5)
    group:item("knife_combat_plus_one", 8)
    group:item("knife_rambo_plus_one", 5)
    group:item("knife_trench_plus_one", 5)
    group:item("kris_plus_one", 5)
    group:item("kukri_plus_one", 5)
    group:item("nodachi_plus_one", 5)
    group:item("pike_plus_one", 5)
    group:item("rapier_plus_one", 5)
    group:item("tanto_plus_one", 5)
    group:item("wakizashi_plus_one", 5)
    group:item("zweihander_plus_one", 5)
    group:item("khopesh_plus_one", 5)
    group:item("sword_xiphos_plus_one", 5)
    group:item("dao_plus_one", 5)
    group:item("lucerne_plus_one", 5)
    group:item("cestus_plus_one", 5)
    group:item("flaming_fist_plus_one", 5)
    group:item("gunblade", 5)
    content.add(group)
end

do
    -- plus 2 enchanted melee weapons.  High end loot for boss fights, treasure rooms, etc.
    local group = content.ItemGroup { id = "enchanted_melee_weapons_plus2", kind = "distribution" }
    group:item("cudgel_plus_two", 10)
    group:item("q_staff_plus_two", 10)
    group:item("i_staff_plus_two", 10)
    group:item("longsword_plus_two", 5)
    group:item("warhammer_plus_two", 8)
    group:item("spear_steel_plus_two", 8)
    group:item("qiang_plus_two", 8)
    group:item("halberd_plus_two", 8)
    group:item("glaive_plus_two", 8)
    group:item("naginata_plus_two", 5)
    group:item("mace_plus_two", 5)
    group:item("morningstar_plus_two", 5)
    group:item("jian_plus_two", 5)
    group:item("scimitar_plus_two", 5)
    group:item("estoc_plus_two", 5)
    group:item("arming_sword_plus_two", 5)
    group:item("broadsword_plus_two", 5)
    group:item("battleaxe_plus_two", 5)
    group:item("cavalry_sabre_plus_two", 5)
    group:item("cutlass_plus_two", 5)
    group:item("katana_plus_two", 5)
    group:item("knife_combat_plus_two", 8)
    group:item("knife_rambo_plus_two", 5)
    group:item("knife_trench_plus_two", 5)
    group:item("kris_plus_two", 5)
    group:item("kukri_plus_two", 5)
    group:item("nodachi_plus_two", 5)
    group:item("pike_plus_two", 5)
    group:item("rapier_plus_two", 5)
    group:item("tanto_plus_two", 5)
    group:item("wakizashi_plus_two", 5)
    group:item("zweihander_plus_two", 5)
    group:item("khopesh_plus_two", 5)
    group:item("sword_xiphos_plus_two", 5)
    group:item("lucerne_plus_two", 5)
    group:item("cestus_plus_two", 5)
    group:item("flaming_fist_plus_two", 5)
    group:item("dao_plus_two", 5)
    content.add(group)
end

do
    -- A distribution of small magical items for general loot areas like desks, shelves, personal items.
    local group = content.ItemGroup { id = "enchanted_small_items", kind = "distribution" }
    group:group("enchanted_tokens_tool", 30)
    group:group("enchanted_tokens_weapon", 3)
    group:group("enchanted_rings_common", 20)
    group:group("enchanted_rings_uncommon", 5)
    group:group("enchanted_wands_minor", 10)
    group:group("enchanted_masks", 2)
    group:group("enchanted_necklaces", 10)
    group:group("magic_shop_potions", 40)
    group:group("spellbook_loot_1", 30)
    group:group("magic_CBM", 2)
    group:item("lair_map", 20)
    group:item("retreat_map", 30)
    group:entry { item = "crystallized_mana", charges = { 1, 10 }, probability = 50 }
    group:entry { item = "small_mana_crystal", charges = { 5, 50 }, probability = 40 }
    group:item("magic_knife_bag", 10)
    content.add(group)
end

do
    -- A distribution of wearable magical items for  loot areas like dressers, wardrobes, coat racks.
    local group = content.ItemGroup { id = "enchanted_worn_items", kind = "distribution" }
    group:group("enchanted_bracers_lesser", 25)
    group:group("enchanted_bracelets", 25)
    group:group("enchanted_boots", 7)
    group:group("enchanted_belts", 7)
    group:item("wolfshead_cufflinks", 1)
    group:item("parabolan_breeches", 30)
    group:item("parabolan_blouse", 30)
    group:item("magic_knife_bag", 10)
    content.add(group)
end

do
    -- A distribution of magical items for combat loot.
    local group = content.ItemGroup { id = "enchanted_combat_items", kind = "distribution" }
    group:group("enchanted_worn_items", 15)
    group:group("enchanted_wands_disposable_combat", 10)
    group:entry {
        distribution = {
            { group = "enchanted_melee_weapons_plus1", probability = 95 },
            { group = "enchanted_melee_weapons_plus2", probability = 5 },
        },
        probability = 4,
    }
    group:group("enchanted_small_items", 1)
    content.add(group)
end

do
    -- A distribution of magical items for combat loot.
    local group = content.ItemGroup { id = "enchanted_combat_items_non_wearable", kind = "distribution" }
    group:group("enchanted_wands_disposable_combat", 10)
    group:entry {
        distribution = {
            { group = "enchanted_melee_weapons_plus1", probability = 95 },
            { group = "enchanted_melee_weapons_plus2", probability = 5 },
        },
        probability = 4,
    }
    group:group("enchanted_small_items", 1)
    content.add(group)
end

do
    -- A distribution of rare magical items treasure rooms.
    local group = content.ItemGroup { id = "boss_treasure_items", kind = "distribution" }
    group:group("enchanted_combat_items", 40)
    group:group("enchanted_misc", 50)
    group:group("enchanted_rings_unusual", 20)
    group:group("enchanted_rings_rare", 30)
    group:group("enchanted_wands_greater", 30)
    group:group("enchanted_wands_lesser", 20)
    group:group("enchanted_cloaks_rare", 10)
    content.add(group)
end

do
    -- A distribution of magical items for stormshaper themed spaces.
    local group = content.ItemGroup { id = "stormshaper_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "stormshaper_spells_tier_0" },
            { group = "stormshaper_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "stormshaper_spells_tier_1" },
            { group = "stormshaper_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "stormshaper_spells_tier_2" },
            { group = "stormshaper_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "stormshaper_spells_tier_3", probability = 50 },
            { group = "stormshaper_spellbooks_tier_3", probability = 5 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for magus themed spaces.
    local group = content.ItemGroup { id = "magus_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "magus_spells_tier_0" },
            { group = "magus_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "magus_spells_tier_1" },
            { group = "magus_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "magus_spells_tier_2" },
            { group = "magus_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "magus_spells_tier_3", probability = 50 },
            { group = "magus_spellbooks_tier_3", probability = 5 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for animist themed spaces.
    local group = content.ItemGroup { id = "animist_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "animist_spells_tier_0" },
            { group = "animist_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "animist_spells_tier_1" },
            { group = "animist_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "animist_spells_tier_2" },
            { group = "animist_spellbooks_tier_2", probability = 5 },
            { group = "animist_dolls", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "animist_spells_tier_3" },
            { group = "animist_spellbooks_tier_3", probability = 5 },
            {
                distribution = {
                    { item = "bleed_staff_minor", probability = 5 },
                    { item = "grim_reaper_scythe", charges = { 1, 3 }, probability = 10 },
                },
                probability = 5,
            },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for kelvinist themed spaces.
    local group = content.ItemGroup { id = "kelvinist_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "kelvinist_spells_tier_0" },
            { group = "kelvinist_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "kelvinist_spells_tier_1" },
            { group = "kelvinist_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "kelvinist_spells_tier_2" },
            { group = "kelvinist_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "kelvinist_spells_tier_3" },
            { group = "kelvinist_spellbooks_tier_3", probability = 5 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for technomancer themed spaces.
    local group = content.ItemGroup { id = "technomancer_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "technomancer_spells_tier_0" },
            { group = "technomancer_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "technomancer_spells_tier_1" },
            { group = "technomancer_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "technomancer_spells_tier_2" },
            { group = "technomancer_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "technomancer_spells_tier_3" },
            { group = "technomancer_spellbooks_tier_3", probability = 5 },
        },
        probability = 5,
    }
    group:group("magic_CBM", 2)
    content.add(group)
end

do
    -- A distribution of magical items for earthshaper themed spaces.
    local group = content.ItemGroup { id = "earthshaper_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "earthshaper_spells_tier_0" },
            { group = "earthshaper_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "earthshaper_spells_tier_1" },
            { group = "earthshaper_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "earthshaper_spells_tier_2" },
            { group = "earthshaper_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "earthshaper_spells_tier_3" },
            { group = "earthshaper_spellbooks_tier_3", probability = 5 },
            { item = "golemcore", probability = 10 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for biomancer themed spaces.
    local group = content.ItemGroup { id = "biomancer_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "biomancer_spells_tier_0" },
            { group = "biomancer_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "biomancer_spells_tier_1" },
            { group = "biomancer_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "biomancer_spells_tier_2" },
            { group = "biomancer_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "biomancer_spells_tier_3" },
            { group = "biomancer_spellbooks_tier_3", probability = 5 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- A distribution of magical items for druid themed spaces.
    local group = content.ItemGroup { id = "druid_items", kind = "collection" }
    group:entry {
        distribution = {
            { group = "druid_spells_tier_0" },
            { group = "druid_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "druid_spells_tier_1" },
            { group = "druid_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "druid_spells_tier_2" },
            { group = "druid_spellbooks_tier_2", probability = 5 },
            { group = "items_of_elvenkind", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "druid_spells_tier_3" },
            { group = "druid_spellbooks_tier_3", probability = 5 },
            { group = "druid_shapeshifting_learn_books", probability = 5 },
        },
        probability = 5,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_shapeshifting_learn_books", kind = "distribution" }
    group:item("druid_shapeshifting_learn_book_bear", 1)
    group:item("druid_shapeshifting_learn_book_cougar", 1)
    group:item("druid_shapeshifting_learn_book_deer", 1)
    group:item("druid_shapeshifting_learn_book_raven", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_dolls", kind = "distribution" }
    group:item("animist_doll_skeleton", 10)
    group:item("animist_doll_zombie", 20)
    group:item("animist_doll_decayed_pouncer", 3)
    content.add(group)
end

do
    -- A distribution of magical items for classless themed spaces.
    local group = content.ItemGroup { id = "classless_items", kind = "collection" }
    group:group("enchanted_tokens_tool", 15)
    group:group("enchanted_tokens_weapon", 5)
    group:group("enchanted_arrows", 3)
    group:group("potions_common", 35)
    group:group("potions_uncommon", 20)
    group:group("potions_rare", 10)
    group:group("potions_illegal", 1)
    group:group("spellcraft_books", 10)
    group:entry {
        distribution = {
            { group = "enchanted_wands_lesser", probability = 15 },
            { group = "enchanted_combat_items", probability = 5 },
            { group = "enchanted_worn_items", probability = 2 },
        },
        probability = 15,
    }
    group:entry {
        distribution = {
            { group = "classless_spells_tier_0" },
            { group = "classless_spellbooks_tier_0", probability = 5 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "classless_spells_tier_1" },
            { group = "classless_spellbooks_tier_1", probability = 5 },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            { group = "classless_spells_tier_2" },
            { group = "classless_spellbooks_tier_2", probability = 5 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "classless_spells_tier_3" },
            { group = "classless_spellbooks_tier_3", probability = 5 },
            { item = "golemcore", probability = 10 },
        },
        probability = 5,
    }
    group:entry {
        distribution = {
            { group = "enchanted_rings_common", probability = 30 },
            { group = "enchanted_rings_uncommon", probability = 10 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "crystallized_mana_raw", probability = 1 },
            { item = "crystallized_mana", charges = { 1, 10 }, probability = 1 },
        },
        probability = 50,
    }
    group:item("copper_circlet", 10)
    group:item("cauldron_orichalcum", 1)
    group:entry { item = "small_mana_crystal", charges = { 5, 50 }, probability = 40 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "academy_lore", kind = "distribution" }
    group:item("retreat_map")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magic_basement_photo", kind = "distribution" }
    group:item("wizard_photo")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forest_tomb_spellbook", kind = "distribution" }
    group:item("summon_undead_spellbook")
    content.add(group)
end

do
    -- Things suitable for cooking something in (pot like objects, not spits)
    local group = content.ItemGroup { id = "cookpot", kind = "distribution" }
    group:item("waffleiron", 20)
    group:item("mess_tray", 20)
    group:item("sheet_metal", 20)
    group:item("alloy_plate", 1)
    group:item("basket", 10)
    group:item("mess_kit", 2)
    group:item("pot_makeshift")
    group:item("pot_makeshift_copper", 50)
    group:item("pressure_cooker", 5)
    group:item("pot", 45)
    group:item("clay_pot", 80)
    group:item("iron_pot", 45)
    group:item("pot_copper", 45)
    group:item("casserole", 45)
    group:item("stock_pot", 80)
    group:item("pot_canning", 60)
    content.add(group)
end

do
    -- fuel for a cookpot
    local group = content.ItemGroup { id = "wood_fuel", kind = "distribution" }
    group:entry { item = "charcoal", count = { 2, 5 }, charges = { 10, 50 }, container = "null", probability = 20 }
    group:entry { item = "log", count = { 1, 3 }, probability = 40 }
    group:entry { item = "2x4", count = { 4, 8 }, probability = 40 }
    content.add(group)
end

do
    -- the things that would be on the same tile as a cookpot, such as fuel and one pot.
    local group = content.ItemGroup { id = "goblin_cookpot", kind = "collection" }
    group:group("cookpot")
    group:group("wood_fuel", 80)
    content.add(group)
end

do
    -- the things that would be on the same tile as a magicians anvil, such as tools and one product.
    local group = content.ItemGroup { id = "magic_smith", kind = "collection" }
    group:group("enchanted_combat_items")
    group:entry { group = "tools_anvil", count = { 2, 5 }, probability = 80 }
    content.add(group)
end

do
    -- Tools commonly used by blacksmiths on top of an anvil
    local group = content.ItemGroup { id = "tools_anvil", kind = "distribution" }
    group:item("chisel", 90)
    group:item("crucible", 30)
    group:item("swage", 60)
    group:item("metalworking_tongs", 90)
    group:item("hammer", 90)
    group:item("sandpaper", 90)
    group:item("small_mana_crystal", 180)
    content.add(group)
end

do
    -- Items that can be traded for at the forge of wonders.
    local group = content.ItemGroup { id = "forge_vault_items", kind = "distribution" }
    group:group("enchanted_combat_items", 40)
    group:group("enchanted_misc", 50)
    group:group("enchanted_arrows", 15)
    group:group("enchanted_rings_unusual", 20)
    group:group("enchanted_rings_rare", 30)
    group:group("enchanted_wands_greater", 30)
    group:group("enchanted_wands_lesser", 20)
    group:group("enchanted_necklaces", 20)
    group:group("lair_black_dragon_treasure", 5)
    group:group("parabolan_armor", 10)
    group:group("enchanted_melee_weapons_plus2", 20)
    group:group("demon_spider_lair_treasure", 10)
    group:group("enchanted_cloaks_rare", 10)
    content.add(group)
end

do
    -- Clothing and gear for forgedwellers
    local group = content.ItemGroup { id = "forge_life", kind = "distribution" }
    group:item("apron_leather", 90)
    group:item("pants_leather", 80)
    group:item("leathersandals", 60)
    group:item("kilt_leather", 90)
    group:item("hammer", 90)
    group:item("armor_demonchitin", 1)
    group:item("armguard_demonchitin", 8)
    group:item("gauntlets_demonchitin", 14)
    content.add(group)
end

do
    -- Items that can be traded for at the forge of wonders.
    local group = content.ItemGroup { id = "forge_vault_money", kind = "distribution" }
    group:entry { item = "RobofacCoin", count = { 1, 3 }, probability = 40 }
    group:entry { item = "FMCNote", count = { 10, 36 }, probability = 50 }
    group:entry { item = "signed_chit", count = { 12, 39 }, probability = 20 }
    group:entry { item = "icon", count = { 1, 13 }, probability = 30 }
    group:entry { item = "gold_small", count = { 120, 390 }, probability = 20 }
    group:entry { item = "denarius", count = { 20, 90 }, probability = 20 }
    group:entry { item = "silver_small", count = { 68, 560 }, probability = 5 }
    content.add(group)
end

do
    -- all the elven items.
    local group = content.ItemGroup { id = "items_of_elvenkind", kind = "collection" }
    group:item("cloak_of_elvenkind", 10)
    group:item("boots_of_elvenkind", 10)
    group:item("bow_of_elvenkind", 1)
    content.add(group)
end

do
    -- all the rare enchanted cloaks.  High end loot for boss fights, treasure rooms, etc.
    local group = content.ItemGroup { id = "enchanted_cloaks_rare", kind = "collection" }
    group:item("wildshape_cloak_deer", 10)
    group:item("wildshape_cloak_fish", 10)
    group:item("wildshape_cloak_bear", 10)
    content.add(group)
end

do
    -- all the non-perishable things you can get from butchering magical creatures rated by rareness.  Not boss loot but rather for locations
    local group = content.ItemGroup { id = "organic_materials", kind = "collection" }
    group:entry { item = "demon_chitin_piece", count = { 10, 32 }, probability = 50 }
    group:entry { item = "demon_chitin_plate", count = { 1, 3 }, probability = 30 }
    group:item("demon_spider_fang", 20)
    group:item("owlbear_stone", 25)
    group:item("bulette_plate", 15)
    group:entry { item = "bulette_plate", count = { 2, 4 }, probability = 2 }
    group:item("bulette_pearl", 10)
    group:entry { item = "dragon_blood", count = { 1, 3 }, probability = 2 }
    group:entry { item = "black_dragon_tanned_hide", count = { 5, 10 }, probability = 5 }
    group:entry { item = "dragon_black_scale", count = { 12, 36 }, probability = 10 }
    group:entry { item = "glow_dust", count = { 4, 6 }, probability = 10 }
    group:item("stirge_proboscis", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_torso_research_thaumaturge", kind = "collection" }
    group:entry {
        distribution = {
            { item = "coat_lab", probability = 80 },
            { item = "coat_lab_plus_one", probability = 20 },
            { item = "coat_lab_plus_two", probability = 5 },
        },
        probability = 50,
    }
    group:item("coat_lab", 20)
    group:item("tshirt", 80)
    group:item("longshirt", 80)
    group:item("polo_shirt", 65)
    group:item("dress_shirt", 60)
    group:item("dress", 70)
    group:item("sweatshirt", 75)
    group:item("sweater", 75)
    group:item("turtleneck", 25)
    group:item("turtleneck_shirt", 25)
    group:item("hoodie", 65)
    group:item("jumpsuit", 20)
    group:item("badge_doctor", 10)
    group:item("hazmat_suit", 5)
    group:item("cleansuit", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "group_potion_fruits", kind = "collection" }
    group:item("potion_fruit_apple", 1)
    group:item("potion_fruit_peach", 1)
    group:item("potion_fruit_pear", 1)
    group:item("potion_fruit_blackberries", 1)
    group:item("potion_fruit_raspberries", 1)
    group:item("potion_fruit_strawberries", 1)
    group:item("potion_fruit_elderberries", 1)
    group:item("potion_fruit_blueberries", 1)
    group:item("potion_fruit_cranberries", 1)
    group:item("potion_fruit_huckleberries", 1)
    group:item("potion_fruit_wintergreen", 1)
    group:item("potion_fruit_cherry", 1)
    group:item("potion_fruit_apricot", 1)
    group:item("potion_fruit_grapes", 1)
    group:item("potion_fruit_mayapple", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "group_forge_warp_items", kind = "collection" }
    group:entry { item = "forge_warp_scroll", count = { 1, 3 } }
    content.add(group)
end

do
    -- copied from jewelry_accessories with ear and teeth jewelry removed, plus no wedding/engagement rings
    local group = content.ItemGroup { id = "ravenfolk_jewelry", kind = "distribution" }
    group:item("gold_ring", 30)
    group:item("gold_bracelet", 30)
    group:item("gold_necklace", 30)
    group:item("gold_locket", 20)
    group:item("gold_hairpin", 20)
    group:item("platinum_ring", 2)
    group:item("platinum_bracelet", 2)
    group:item("platinum_necklace", 2)
    group:item("platinum_locket", 1)
    group:item("platinum_hairpin", 1)
    group:item("silver_necklace", 40)
    group:item("silver_bracelet", 40)
    group:item("silver_ring", 40)
    group:item("silver_locket", 30)
    group:item("silver_hairpin", 30)
    group:item("copper_bracelet", 15)
    group:item("copper_ring", 15)
    group:item("copper_necklace", 15)
    group:item("cowrie_necklace", 15)
    group:item("copper_locket", 15)
    group:item("copper_hairpin", 10)
    group:item("ring_purity", 5)
    group:item("cufflinks", 25)
    group:item("cufflinks_intricate", 15)
    group:item("diamond_ring", 10)
    group:item("jade_brooch", 30)
    group:item("tieclip", 35)
    group:item("pearl_collar", 30)
    group:item("holy_symbol", 20)
    group:item("gold_anklet", 20)
    group:item("silver_anklet", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mana_leech_shackle_and_unlock_scroll", kind = "collection" }
    group:entry { item = "mana_leech_shackle_unlocked", count = { 3, 8 } }
    group:entry { item = "mana_leech_unlock_scroll", count = { 3, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "xedra_thaumaturgical_lab_secret_spells", kind = "distribution" }
    group:item("spell_scroll_biomancer_control_mutations", 1)
    group:item("spell_scroll_biomancer_remove_instability", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sometimes_bird_litter", kind = "distribution" }
    group:item("null", 3)
    group:entry { item = "feces_bird", count = { 4, 4 }, probability = 1 }
    content.add(group)
end

do
    -- All magical items that are accepted by the Forge of Wonders merchants.
    -- This is a common list for things that are accepted by multiple merchants.
    local group = content.ItemGroup { id = "forge_of_wonders_tradeables", kind = "collection" }
    group:group("magiclysm_joke_scrolls")
    group:group("magic_CBM")
    group:group("enchanted_rings_common")
    group:group("enchanted_rings_uncommon")
    group:group("enchanted_rings_rare")
    group:group("enchanted_rings_unusual")
    group:group("enchanted_combat_items")
    group:group("enchanted_misc")
    group:group("enchanted_masks")
    group:group("enchanted_worn_items")
    group:group("enchanted_bracers_greater")
    group:group("enchanted_cloaks_rare")
    group:group("items_of_elvenkind")
    group:group("enchanted_tokens_tool")
    group:group("enchanted_tokens_weapon")
    group:group("enchanted_melee_weapons_plus1")
    group:group("enchanted_melee_weapons_plus2")
    group:group("enchanted_wands_greater")
    group:group("enchanted_wands_lesser")
    group:group("enchanted_arrows")
    group:group("alchemy_monster_loot")
    group:item("dragon_blood")
    content.add(group)
end

do
    -- Lower tier recipes, many of which can be done with the alchemist rune.  Usually has at least one recipe requiring related school rune or rune weapon
    local group = content.ItemGroup { id = "magic_recipe_basic", kind = "distribution" }
    group:item("alchemy_basic", 30)
    group:item("necro_basic", 30)
    group:item("techno_basic", 30)
    group:item("enchantment_basic", 30)
    group:item("book_mythological", 10)
    group:item("history_botanical_enchantment", 20)
    group:item("journeyman_enchanting", 20)
    group:item("arcane_archer_companion", 15)
    group:item("cooking_poison", 15)
    group:item("metal_legends", 5)
    group:item("alchemy_mana_processing", 10)
    content.add(group)
end

do
    -- Higher tier recipes, where most school-related recipes require their rune or rune weapon.
    local group = content.ItemGroup { id = "magic_recipe_advanced", kind = "distribution" }
    group:item("magic_armormaking", 30)
    group:item("alchemy_illegal", 30)
    group:item("alchemy_master", 30)
    group:item("weapon_enchanting_guide", 30)
    group:item("mag_druid_items_master", 30)
    group:item("harnessing_hellfire", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_tier_0", kind = "distribution" }
    group:group("animist_spells_tier_0", 1)
    group:group("biomancer_spells_tier_0", 1)
    group:group("classless_spells_tier_0", 2)
    group:group("druid_spells_tier_0", 1)
    group:group("earthshaper_spells_tier_0", 1)
    group:group("kelvinist_spells_tier_0", 1)
    group:group("magus_spells_tier_0", 1)
    group:group("stormshaper_spells_tier_0", 1)
    group:group("technomancer_spells_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spells_tier_0", kind = "distribution" }
    group:group("animist_unrestricted_tier_0", 300)
    group:group("animist_restricted_tier_0", 25)
    group:group("animist_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_animist_sense_outsiders", 25)
    group:item("spell_scroll_animist_detect_wizards", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_bleed", 50)
    group:item("spell_scroll_disruption_bolt", 50)
    group:item("spell_scroll_summon_wisps", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_illegal_tier_0", kind = "distribution" }
    group:item("spell_scroll_summon_undead", 25)
    group:item("spell_scroll_necrotic_gaze", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spells_tier_0", kind = "distribution" }
    group:group("biomancer_unrestricted_tier_0", 300)
    group:group("biomancer_restricted_tier_0", 25)
    group:group("biomancer_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_light_healing", 35)
    group:item("spell_scroll_biomancer_cure_disease_minor", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_biomancer_paralytic_dart", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_illegal_tier_0", kind = "distribution" }
    group:item("spell_scroll_biomancer_visceral_projection", 40)
    group:item("spell_scroll_bio_acidicspray", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spells_tier_0", kind = "distribution" }
    group:group("classless_unrestricted_tier_0", 300)
    group:group("classless_restricted_tier_0", 25)
    group:group("classless_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_classless_watch_spell", 30)
    group:item("spell_scroll_classless_clean_clothing_and_self", 120)
    group:item("spell_scroll_classless_easy_sleep_spell", 75)
    group:item("spell_scroll_classless_restore_crystal_mana", 35)
    group:item("spell_scroll_blinding_flash", 50)
    group:item("spell_scroll_create_atomic_light", 50)
    group:item("spell_scroll_crystallize_mana", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_ethereal_grasp", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_illegal_tier_0", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spells_tier_0", kind = "distribution" }
    group:group("druid_unrestricted_tier_0", 300)
    group:group("druid_restricted_tier_0", 25)
    group:group("druid_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_druid_traverse_the_wilds", 35)
    group:item("spell_scroll_druid_anti_heat", 30)
    group:item("spell_scroll_seed_of_growth", 30)
    group:item("spell_scroll_summon_cats", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_druid_woodshaft", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_illegal_tier_0", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spells_tier_0", kind = "distribution" }
    group:group("earthshaper_unrestricted_tier_0", 300)
    group:group("earthshaper_restricted_tier_0", 25)
    group:group("earthshaper_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_earthshaper_turning_of_earth", 30)
    group:item("spell_scroll_earthshaper_boulder", 35)
    group:item("spell_scroll_earthshaper_remove_corpses", 20)
    group:item("spell_scroll_stonefist", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_pertifying_touch", 25)
    group:item("spell_scroll_eshaper_rockbolt", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_illegal_tier_0", kind = "distribution" }
    group:item("spell_scroll_eshaper_piercing_bolt", 40)
    group:item("spell_scroll_reactive_armor", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spells_tier_0", kind = "distribution" }
    group:group("kelvinist_unrestricted_tier_0", 300)
    group:group("kelvinist_restricted_tier_0", 25)
    group:group("kelvinist_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_kelvinist_heat_food", 30)
    group:item("spell_scroll_create_lighter", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_chilling_touch", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_illegal_tier_0", kind = "distribution" }
    group:item("spell_scroll_kelvinist_firebolt", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spells_tier_0", kind = "distribution" }
    group:group("magus_unrestricted_tier_0", 300)
    group:group("magus_restricted_tier_0", 25)
    group:group("magus_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_magus_light_target", 60)
    group:item("spell_scroll_magus_stop_attack_shield", 50)
    group:item("spell_scroll_magus_far_hand_pull", 50)
    group:item("spell_scroll_shadow_field", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_magic_missile", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_illegal_tier_0", kind = "distribution" }
    group:item("null", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spells_tier_0", kind = "distribution" }
    group:group("stormshaper_unrestricted_tier_0", 300)
    group:group("stormshaper_restricted_tier_0", 25)
    group:group("stormshaper_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_create_electric_lighter", 50)
    group:item("spell_scroll_electric_arts", 50)
    group:item("spell_scroll_stormshaper_wall_of_fog", 35)
    group:item("spell_scroll_stormshaper_loud_voice_spell", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_stormshaper_air_blast", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_illegal_tier_0", kind = "distribution" }
    group:item("null", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spells_tier_0", kind = "distribution" }
    group:group("technomancer_unrestricted_tier_0", 300)
    group:group("technomancer_restricted_tier_0", 25)
    group:group("technomancer_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_unrestricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_bless", 25)
    group:item("spell_scroll_technomancer_conjure_radio", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_restricted_tier_0", kind = "distribution" }
    group:item("spell_scroll_taze", 25)
    group:item("spell_scroll_x-ray", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_illegal_tier_0", kind = "distribution" }
    group:item("spell_scroll_laze", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_tier_1", kind = "distribution" }
    group:group("animist_spells_tier_1", 1)
    group:group("biomancer_spells_tier_1", 1)
    group:group("classless_spells_tier_1", 2)
    group:group("druid_spells_tier_1", 1)
    group:group("earthshaper_spells_tier_1", 1)
    group:group("kelvinist_spells_tier_1", 1)
    group:group("magus_spells_tier_1", 1)
    group:group("stormshaper_spells_tier_1", 1)
    group:group("technomancer_spells_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spells_tier_1", kind = "distribution" }
    group:group("animist_unrestricted_tier_1", 300)
    group:group("animist_restricted_tier_1", 25)
    group:group("animist_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_animist_vocalize", 30)
    group:item("spell_scroll_animist_detect_wizards", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_animist_summon_watcher", 30)
    group:item("spell_scroll_animist_luck_bone", 20)
    group:item("spell_scroll_animist_do_psionic_damage_to_head", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_illegal_tier_1", kind = "distribution" }
    group:item("spell_scroll_boneclub", 20)
    group:item("spell_scroll_necrotic_gaze", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spells_tier_1", kind = "distribution" }
    group:group("biomancer_unrestricted_tier_1", 300)
    group:group("biomancer_restricted_tier_1", 25)
    group:group("biomancer_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_pain_split", 25)
    group:item("spell_scroll_bio_grotesque", 40)
    group:item("spell_scroll_bio_fleshpouch", 30)
    group:item("spell_scroll_biomancer_get_more_blood", 20)
    group:item("spell_scroll_biomancer_coagulant_weave", 30)
    group:item("spell_scroll_biomancer_eat_tons_of_food", 30)
    group:item("spell_scroll_biomancer_swim_frog", 25)
    group:item("spell_scroll_biomancer_slow_bleeding", 30)
    group:item("spell_scroll_biomancer_pull_items_from_distance", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_caustic_aura", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_illegal_tier_1", kind = "distribution" }
    group:item("spell_scroll_biomancer_carrion_feast", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spells_tier_1", kind = "distribution" }
    group:group("classless_unrestricted_tier_1", 300)
    group:group("classless_restricted_tier_1", 25)
    group:group("classless_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_classless_dispel_magic", 45)
    group:item("spell_scroll_sound_bomb", 35)
    group:item("spell_scroll_protection_aura", 50)
    group:item("spell_scroll_thought_shield", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_restricted_tier_1", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_illegal_tier_1", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spells_tier_1", kind = "distribution" }
    group:group("druid_unrestricted_tier_1", 300)
    group:group("druid_restricted_tier_1", 25)
    group:group("druid_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_druid_veggrasp", 35)
    group:item("spell_scroll_druid_healing_herb", 35)
    group:item("spell_scroll_druid_bandage", 30)
    group:item("spell_scroll_druid_harvest_hunter", 40)
    group:item("spell_scroll_druid_summon_brambles", 30)
    group:item("spell_scroll_druid_disinfectant", 35)
    group:item("spell_scroll_druid_water_walking", 30)
    group:item("spell_scroll_druid_bearmantle", 25)
    group:item("spell_scroll_druid_breathing_underwater", 30)
    group:item("spell_scroll_druid_goodberry", 20)
    group:item("spell_scroll_purification_seed", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_druid_rootstrike", 40)
    group:item("spell_scroll_druid_naturebow1", 40)
    group:item("spell_scroll_druid_bramble_spear", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_illegal_tier_1", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spells_tier_1", kind = "distribution" }
    group:group("earthshaper_unrestricted_tier_1", 300)
    group:group("earthshaper_restricted_tier_1", 25)
    group:group("earthshaper_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_eshaper_spawn_tools", 40)
    group:item("spell_scroll_earthshaper_repair_metal_stone", 40)
    group:item("spell_scroll_earthshaper_fortitude_of_stone", 35)
    group:item("spell_scroll_earthshaper_danger_sense", 45)
    group:item("spell_scroll_earthshaper_stoneskin", 30)
    group:item("spell_scroll_earthshaper_pillar", 35)
    group:item("spell_scroll_earthshaper_harden_earth", 30)
    group:item("spell_scroll_move_earth", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_clairvoyance", 30)
    group:item("spell_scroll_seismic_stomp", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_illegal_tier_1", kind = "distribution" }
    group:item("spell_scroll_eshaper_shardspray", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spells_tier_1", kind = "distribution" }
    group:group("kelvinist_unrestricted_tier_1", 300)
    group:group("kelvinist_restricted_tier_1", 25)
    group:group("kelvinist_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_glide_ice", 25)
    group:item("spell_scroll_kelvinist_anti_cold", 30)
    group:item("spell_scroll_kelvinist_anti_heat", 30)
    group:item("spell_scroll_kelvinist_persuasion_spell", 20)
    group:item("spell_scroll_ice_shield", 25)
    group:item("spell_scroll_frost_armor", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_ice_spike", 50)
    group:item("spell_scroll_point_flare", 50)
    group:item("spell_scroll_flamesword", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_illegal_tier_1", kind = "distribution" }
    group:item("spell_scroll_frost_spray", 40)
    group:item("spell_scroll_burning_hands", 40)
    group:item("spell_scroll_flamebreath", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spells_tier_1", kind = "distribution" }
    group:group("magus_unrestricted_tier_1", 300)
    group:group("magus_restricted_tier_1", 25)
    group:group("magus_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_magus_slowfall", 40)
    group:item("spell_scroll_magus_spiderclimb", 40)
    group:item("spell_scroll_force_jar", 30)
    group:item("spell_scroll_shadow_field", 20)
    group:item("spell_scroll_impactsling", 20)
    group:item("spell_scroll_magus_mage_conjured_armor", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_phase_door", 50)
    group:item("spell_scroll_magus_mage_conjured_blade", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_illegal_tier_1", kind = "distribution" }
    group:item("null", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spells_tier_1", kind = "distribution" }
    group:group("stormshaper_unrestricted_tier_1", 300)
    group:group("stormshaper_restricted_tier_1", 25)
    group:group("stormshaper_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_windrun", 35)
    group:item("spell_scroll_stormshaper_cloak_of_fog", 50)
    group:item("spell_scroll_air_bubble", 35)
    group:item("spell_scroll_electric_eye", 35)
    group:item("spell_scroll_repelling_arc", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_windstrike", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_illegal_tier_1", kind = "distribution" }
    group:item("spell_scroll_jolt", 50)
    group:item("spell_scroll_lightning_bolt", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spells_tier_1", kind = "distribution" }
    group:group("technomancer_unrestricted_tier_1", 300)
    group:group("technomancer_restricted_tier_1", 25)
    group:group("technomancer_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_unrestricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_technomancer_welder", 35)
    group:item("spell_scroll_synaptic_stimulation", 35)
    group:item("spell_scroll_technomancer_gain_electronics_computer_spell", 35)
    group:item("spell_scroll_technomancer_far_sight", 25)
    group:item("spell_scroll_technomancer_pain_ignore", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_restricted_tier_1", kind = "distribution" }
    group:item("spell_scroll_knock", 30)
    group:item("spell_scroll_quantum_tunnel_lesser", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_illegal_tier_1", kind = "distribution" }
    group:item("null", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_tier_2", kind = "distribution" }
    group:group("animist_spells_tier_2", 1)
    group:group("biomancer_spells_tier_2", 1)
    group:group("classless_spells_tier_2", 2)
    group:group("druid_spells_tier_2", 1)
    group:group("earthshaper_spells_tier_2", 1)
    group:group("kelvinist_spells_tier_2", 1)
    group:group("magus_spells_tier_2", 1)
    group:group("stormshaper_spells_tier_2", 1)
    group:group("technomancer_spells_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spells_tier_2", kind = "distribution" }
    group:group("animist_unrestricted_tier_2", 300)
    group:group("animist_restricted_tier_2", 25)
    group:group("animist_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_animist_see_invisibility", 15)
    group:item("spell_scroll_animist_slow_food_rotting_spell", 25)
    group:item("spell_scroll_recover_pain", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_smite", 40)
    group:item("spell_scroll_dominate", 50)
    group:item("spell_scroll_animist_add_evasion_spell", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_devour", 25)
    group:item("spell_scroll_convert", 40)
    group:item("spell_scroll_summon_undead_swarm", 35)
    group:item("spell_scroll_life_detonation", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spells_tier_2", kind = "distribution" }
    group:group("biomancer_unrestricted_tier_2", 300)
    group:group("biomancer_restricted_tier_2", 25)
    group:group("biomancer_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_biomancer_lashing_tentacles", 50)
    group:item("spell_scroll_biomancer_caustic_blood", 20)
    group:item("spell_scroll_biomancer_scalpel_fingers", 30)
    group:item("spell_scroll_biomancer_giant_growth", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_bio_bonespear", 20)
    group:item("spell_scroll_vicious_tentacle", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_biomancer_baleful_polymorph", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spells_tier_2", kind = "distribution" }
    group:group("classless_unrestricted_tier_2", 300)
    group:group("classless_restricted_tier_2", 25)
    group:group("classless_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_dark_sight", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_restricted_tier_2", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_megablast", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spells_tier_2", kind = "distribution" }
    group:group("druid_unrestricted_tier_2", 300)
    group:group("druid_restricted_tier_2", 25)
    group:group("druid_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_natures_commune", 50)
    group:item("spell_scroll_druid_healing", 25)
    group:item("spell_scroll_druid_wood_living_tree_spell", 40)
    group:item("spell_scroll_recover_sleepiness", 25)
    group:item("spell_scroll_druidic_regrowth", 20)
    group:item("spell_scroll_druid_whisper_leaves", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_summon_wolf", 40)
    group:item("spell_scroll_feralform", 40)
    group:item("spell_scroll_druid_summon_tanglevine", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_illegal_tier_2", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spells_tier_2", kind = "distribution" }
    group:group("earthshaper_unrestricted_tier_2", 300)
    group:group("earthshaper_restricted_tier_2", 25)
    group:group("earthshaper_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_eshaper_melee_damage", 30)
    group:item("spell_scroll_eshaper_crystal_wrap", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_recover_stamina", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_eshaper_shardstorm", 50)
    group:item("spell_scroll_eshaper_impalement", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spells_tier_2", kind = "distribution" }
    group:group("kelvinist_unrestricted_tier_2", 300)
    group:group("kelvinist_restricted_tier_2", 25)
    group:group("kelvinist_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_kelvinist_extinguish_fire_spell", 25)
    group:item("spell_scroll_kelvinist_summon_freezer_spell", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_restricted_tier_2", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_fireball", 50)
    group:item("spell_scroll_cone_cold", 50)
    group:item("spell_scroll_hoary_blast", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spells_tier_2", kind = "distribution" }
    group:group("magus_unrestricted_tier_2", 300)
    group:group("magus_restricted_tier_2", 25)
    group:group("magus_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_magus_ranged_increase", 35)
    group:item("spell_scroll_magus_push_nearby_enemies_back", 50)
    group:item("spell_scroll_magus_slow", 40)
    group:item("spell_scroll_magus_teleport_mark", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_magus_mana_bolt", 50)
    group:item("spell_scroll_magus_mana_beam", 50)
    group:item("spell_scroll_magus_escape", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_gravity_well", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spells_tier_2", kind = "distribution" }
    group:group("stormshaper_unrestricted_tier_2", 300)
    group:group("stormshaper_restricted_tier_2", 25)
    group:group("stormshaper_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_stormfist", 35)
    group:item("spell_scroll_stormshaper_heart_of_hurricane", 30)
    group:item("spell_scroll_air_bubble", 35)
    group:item("spell_scroll_electric_eye", 35)
    group:item("spell_scroll_repelling_arc", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_storm_hammer", 35)
    group:item("spell_scroll_shocking_dash", 40)
    group:item("spell_scroll_electric_waves", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_lightning_blast", 50)
    group:item("spell_scroll_stormshaper_ionization", 40)
    group:item("spell_scroll_storm_superconductor", 40)
    group:item("spell_scroll_summon_teravolt", 40)
    group:item("spell_scroll_storm_shipwrecker", 30)
    group:item("spell_scroll_explosive_decompression", 30)
    group:item("spell_scroll_toxtricity", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spells_tier_2", kind = "distribution" }
    group:group("technomancer_unrestricted_tier_2", 300)
    group:group("technomancer_restricted_tier_2", 25)
    group:group("technomancer_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_unrestricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_recover_bionic_power", 25)
    group:item("spell_scroll_summon_floating_disk", 35)
    group:item("spell_scroll_mirror_image", 15)
    group:item("spell_scroll_technomancer_recharge_vehicle", 25)
    group:item("spell_scroll_technomancer_create_ups_connection", 20)
    group:item("spell_scroll_technomancer_conjure_ups", 30)
    group:item("spell_scroll_technomancer_dexterity_buff_spell", 35)
    group:item("spell_scroll_technomancer_perception_buff_spell", 35)
    group:item("spell_scroll_technomancer_strength_buff_spell", 35)
    group:item("spell_scroll_technomancer_intelligence_buff_spell", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_restricted_tier_2", kind = "distribution" }
    group:item("spell_scroll_invisibility", 40)
    group:item("spell_scroll_holographic_transposition", 20)
    group:item("spell_scroll_improved_knock", 30)
    group:item("spell_scroll_technomancer_robot_shutdown", 25)
    group:item("spell_scroll_knifeshot", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_illegal_tier_2", kind = "distribution" }
    group:item("spell_scroll_animated_blade", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_tier_3", kind = "distribution" }
    group:group("animist_spells_tier_3", 1)
    group:group("biomancer_spells_tier_3", 1)
    group:group("classless_spells_tier_3", 2)
    group:group("druid_spells_tier_3", 1)
    group:group("earthshaper_spells_tier_3", 1)
    group:group("kelvinist_spells_tier_3", 1)
    group:group("magus_spells_tier_3", 1)
    group:group("stormshaper_spells_tier_3", 1)
    group:group("technomancer_spells_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spells_tier_3", kind = "distribution" }
    group:group("animist_unrestricted_tier_3", 300)
    group:group("animist_restricted_tier_3", 25)
    group:group("animist_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_restricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_animist_mass_hiding_aoe", 40)
    group:item("spell_scroll_animist_spirit_walking", 25)
    group:item("spell_scroll_banishment_lesser", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_illegal_tier_3", kind = "distribution" }
    group:item("spell_scroll_rupture", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spells_tier_3", kind = "distribution" }
    group:group("biomancer_unrestricted_tier_3", 300)
    group:group("biomancer_restricted_tier_3", 25)
    group:group("biomancer_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_biomancer_hyper_regeneration", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_restricted_tier_3", kind = "distribution" }
    group:item("null", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_illegal_tier_3", kind = "distribution" }
    group:item("null", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spells_tier_3", kind = "distribution" }
    group:group("classless_unrestricted_tier_3", 300)
    group:group("classless_restricted_tier_3", 25)
    group:group("classless_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_classless_disjunction", 45)
    group:item("spell_scroll_obfuscated_body", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_restricted_tier_3", kind = "distribution" }
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_illegal_tier_3", kind = "distribution" }
    group:item("null", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spells_tier_3", kind = "distribution" }
    group:group("druid_unrestricted_tier_3", 300)
    group:group("druid_restricted_tier_3", 25)
    group:group("druid_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_druidic_healing", 50)
    group:item("spell_scroll_druid_beguile_savage_beast", 35)
    group:item("spell_scroll_druid_renew_forest_spell", 15)
    group:item("spell_scroll_druid_thornskin", 25)
    group:item("spell_scroll_druid_create_temporary_spring", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_restricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_druid_turn_tree_into_treant", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_illegal_tier_3", kind = "distribution" }
    group:item("spell_scroll_cause_rot", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spells_tier_3", kind = "distribution" }
    group:group("earthshaper_unrestricted_tier_3", 300)
    group:group("earthshaper_restricted_tier_3", 25)
    group:group("earthshaper_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_earthshaper_sleep_in_earth", 20)
    group:item("spell_scroll_earthshaper_granite_aegis", 15)
    group:item("spell_scroll_earthshaper_reveal_world_map", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_restricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_shape_of_dust", 35)
    group:item("spell_scroll_earthshaper_diggable_teleport", 30)
    group:item("spell_scroll_summon_eshaper_golem", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_illegal_tier_3", kind = "distribution" }
    group:item("spell_scroll_eshaper_shardstorm", 50)
    group:item("spell_scroll_eshaper_impalement", 45)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spells_tier_3", kind = "distribution" }
    group:group("kelvinist_unrestricted_tier_3", 300)
    group:group("kelvinist_restricted_tier_3", 25)
    group:group("kelvinist_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_freezing_touch", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_restricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_kelvinist_no_emotion_spell", 50)
    group:item("spell_scroll_nova_flare", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_illegal_tier_3", kind = "distribution" }
    group:item("spell_scroll_kelvinist_set_everyone_on_fire", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spells_tier_3", kind = "distribution" }
    group:group("magus_unrestricted_tier_3", 300)
    group:group("magus_restricted_tier_3", 25)
    group:group("magus_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_magus_haste", 35)
    group:item("spell_scroll_magus_permanent_light", 25)
    group:item("spell_scroll_magus_cannot_move_attack_or_damage_target", 15)
    group:item("spell_scroll_magus_diamond_imbuement", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_restricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_magus_word_of_recall", 50)
    group:item("spell_scroll_focused_bolt", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_illegal_tier_3", kind = "distribution" }
    group:item("spell_scroll_magus_mana_blast", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spells_tier_3", kind = "distribution" }
    group:group("stormshaper_unrestricted_tier_3", 300)
    group:group("stormshaper_restricted_tier_3", 25)
    group:group("stormshaper_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_restricted_tier_3", kind = "distribution" }
    group:item("null", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_illegal_tier_3", kind = "distribution" }
    group:item("lightning_storm_scroll", 50)
    group:item("spell_scroll_vacuum_decompression", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spells_tier_3", kind = "distribution" }
    group:group("technomancer_unrestricted_tier_3", 300)
    group:group("technomancer_restricted_tier_3", 25)
    group:group("technomancer_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_unrestricted_tier_3", kind = "distribution" }
    group:item("spell_scroll_summon_magic_motorcycle", 25)
    group:item("spell_scroll_technomancer_arete_buff_spell", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_restricted_tier_3", kind = "distribution" }
    group:item("bio_sneeze_beam", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_illegal_tier_3", kind = "distribution" }
    group:item("null", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_restricted_tier_0", kind = "distribution" }
    group:group("animist_restricted_tier_0", 10)
    group:group("animist_illegal_tier_0", 1)
    group:group("biomancer_restricted_tier_0", 10)
    group:group("biomancer_illegal_tier_0", 1)
    group:group("classless_restricted_tier_0", 20)
    group:group("classless_illegal_tier_0", 2)
    group:group("druid_restricted_tier_0", 10)
    group:group("druid_illegal_tier_0", 1)
    group:group("earthshaper_restricted_tier_0", 10)
    group:group("earthshaper_illegal_tier_0", 1)
    group:group("kelvinist_restricted_tier_0", 10)
    group:group("kelvinist_illegal_tier_0", 1)
    group:group("magus_restricted_tier_0", 10)
    group:group("magus_illegal_tier_0", 1)
    group:group("stormshaper_restricted_tier_0", 10)
    group:group("stormshaper_illegal_tier_0", 1)
    group:group("technomancer_restricted_tier_0", 10)
    group:group("technomancer_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_restricted_tier_1", kind = "distribution" }
    group:group("animist_restricted_tier_1", 10)
    group:group("animist_illegal_tier_1", 1)
    group:group("biomancer_restricted_tier_1", 10)
    group:group("biomancer_illegal_tier_1", 1)
    group:group("classless_restricted_tier_1", 20)
    group:group("classless_illegal_tier_1", 2)
    group:group("druid_restricted_tier_1", 10)
    group:group("druid_illegal_tier_1", 1)
    group:group("earthshaper_restricted_tier_1", 10)
    group:group("earthshaper_illegal_tier_1", 1)
    group:group("kelvinist_restricted_tier_1", 10)
    group:group("kelvinist_illegal_tier_1", 1)
    group:group("magus_restricted_tier_1", 10)
    group:group("magus_illegal_tier_1", 1)
    group:group("stormshaper_restricted_tier_1", 10)
    group:group("stormshaper_illegal_tier_1", 1)
    group:group("technomancer_restricted_tier_1", 10)
    group:group("technomancer_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_restricted_tier_2", kind = "distribution" }
    group:group("animist_restricted_tier_2", 10)
    group:group("animist_illegal_tier_2", 1)
    group:group("biomancer_restricted_tier_2", 10)
    group:group("biomancer_illegal_tier_2", 1)
    group:group("classless_restricted_tier_2", 20)
    group:group("classless_illegal_tier_2", 2)
    group:group("druid_restricted_tier_2", 10)
    group:group("druid_illegal_tier_2", 1)
    group:group("earthshaper_restricted_tier_2", 10)
    group:group("earthshaper_illegal_tier_2", 1)
    group:group("kelvinist_restricted_tier_2", 10)
    group:group("kelvinist_illegal_tier_2", 1)
    group:group("magus_restricted_tier_2", 10)
    group:group("magus_illegal_tier_2", 1)
    group:group("stormshaper_restricted_tier_2", 10)
    group:group("stormshaper_illegal_tier_2", 1)
    group:group("technomancer_restricted_tier_2", 10)
    group:group("technomancer_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spell_scroll_restricted_tier_3", kind = "distribution" }
    group:group("animist_restricted_tier_3", 10)
    group:group("animist_illegal_tier_3", 1)
    group:group("biomancer_restricted_tier_3", 10)
    group:group("biomancer_illegal_tier_3", 1)
    group:group("classless_restricted_tier_3", 20)
    group:group("classless_illegal_tier_3", 2)
    group:group("druid_restricted_tier_3", 10)
    group:group("druid_illegal_tier_3", 1)
    group:group("earthshaper_restricted_tier_3", 10)
    group:group("earthshaper_illegal_tier_3", 1)
    group:group("kelvinist_restricted_tier_3", 10)
    group:group("kelvinist_illegal_tier_3", 1)
    group:group("magus_restricted_tier_3", 10)
    group:group("magus_illegal_tier_3", 1)
    group:group("stormshaper_restricted_tier_3", 10)
    group:group("stormshaper_illegal_tier_3", 1)
    group:group("technomancer_restricted_tier_3", 10)
    group:group("technomancer_illegal_tier_3", 1)
    content.add(group)
end

do
    -- These are spellbooks that a beginner would have, or scrolls that would have this tier or one tier higher of spells.
    local group = content.ItemGroup { id = "spellbook_tier_0", kind = "distribution" }
    group:group("spellbook_unrestricted_tier_0", 300)
    group:group("spellbook_restricted_tier_0", 25)
    group:group("spellbook_illegal_tier_0", 1)
    content.add(group)
end

do
    -- Make sure to also add spellbooks to the school-based legality itemgroups below, which are used in school itemgroups
    local group = content.ItemGroup { id = "spellbook_unrestricted_tier_0", kind = "distribution" }
    group:item("wizard_beginner", 30)
    group:item("novice_stormshaper_book", 30)
    group:item("book_lazy_magic", 30)
    group:item("camping_time_spellbook", 30)
    group:item("magic_history_tech_spellbook", 30)
    group:item("magic_healing_home_spellbook", 30)
    group:item("eshaper_spellbook_tool", 30)
    group:item("stormshaper_electric_immune_spellbook", 30)
    group:item("avoid_all_temperatures_spellbook", 30)
    group:item("summon_cats_spellbook", 30)
    group:item("freshen_up_spellbook", 30)
    group:item("post_apocalypse_guide_spellbook", 30)
    group:item("earthshaper_landscaping_spellbook", 30)
    group:item("crystallize_mana_economy_spellbook", 30)
    group:item("magical_gardening_spellbook", 30)
    group:item("sense_outsiders_spellbook", 30)
    group:item("windrunning_spellbook", 30)
    group:item("stone_powers_spellbook", 30)
    group:item("staying_clean_spellbook", 30)
    group:item("druid_healing_power_spellbook", 30)
    group:item("biomancy_fasting_spellbook", 30)
    group:item("anti_magic_dispel_spellbook", 30)
    group:item("easy_sleeping_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_tier_0", kind = "distribution" }
    group:item("techno_idiots", 30)
    group:item("animist_summon_wisps_spellbook", 30)
    group:item("special_effects_spellbook", 30)
    group:item("bypass_portals_spellbook", 30)
    group:item("hologram_and_teleport_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_illegal_tier_0", kind = "distribution" }
    group:item("messed_up_spells_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_tier_1", kind = "distribution" }
    group:group("spellbook_unrestricted_tier_1", 300)
    group:group("spellbook_restricted_tier_1", 25)
    group:group("spellbook_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_unrestricted_tier_1", kind = "distribution" }
    group:item("wizard_utility", 30)
    group:item("priest_beginner", 30)
    group:item("basic_pyromancy_expurgated", 30)
    group:item("stat_up_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_tier_1", kind = "distribution" }
    group:item("priest_advanced", 30)
    group:item("prepper_spellbook", 30)
    group:item("techno_fundamentals", 30)
    group:item("basic_pyromancy", 30)
    group:item("tome_of_wind", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_illegal_tier_1", kind = "distribution" }
    group:item("tome_of_storms", 30)
    group:item("pirate_spellbook", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_tier_2", kind = "distribution" }
    group:group("spellbook_unrestricted_tier_2", 300)
    group:group("spellbook_restricted_tier_2", 25)
    group:group("spellbook_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_unrestricted_tier_2", kind = "distribution" }
    group:item("druid_spellbook", 30)
    group:item("techno_electrical_work", 25)
    group:item("farmer_spellbook", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_tier_2", kind = "distribution" }
    group:item("biomancer_spellbook", 30)
    group:item("eshaper_spellbook_melee", 20)
    group:item("animist_spirits", 30)
    group:item("wizard_advanced", 20)
    group:item("magic_movement_book", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_illegal_tier_2", kind = "distribution" }
    group:item("winter_grasp", 30)
    group:item("pyro", 30)
    group:item("eshaper_spellbook", 30)
    group:item("techno_em", 30)
    group:item("bioelectricity", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_tier_3", kind = "distribution" }
    group:group("spellbook_unrestricted_tier_3", 300)
    group:group("spellbook_restricted_tier_3", 25)
    group:group("spellbook_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_unrestricted_tier_3", kind = "distribution" }
    group:item("recovery_spellbook", 30)
    group:item("plant_spellbook_expurgated", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_tier_3", kind = "distribution" }
    group:item("magus_spellbook", 30)
    group:item("magus_spellbook_move", 30)
    group:item("translocate_spellbook", 20)
    group:item("light_manipulation_spellbook", 15)
    group:item("plant_spellbook", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_illegal_tier_3", kind = "distribution" }
    group:item("animist_shadows", 30)
    group:item("forbidden_tome", 25)
    group:item("tome_electric", 25)
    group:item("necronomicon", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_illegal_tier_0", kind = "distribution" }
    group:group("spellbook_restricted_tier_0", 10)
    group:group("spellbook_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_illegal_tier_1", kind = "distribution" }
    group:group("spellbook_restricted_tier_1", 10)
    group:group("spellbook_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_illegal_tier_2", kind = "distribution" }
    group:group("spellbook_restricted_tier_2", 10)
    group:group("spellbook_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_illegal_tier_3", kind = "distribution" }
    group:group("spellbook_restricted_tier_3", 10)
    group:group("spellbook_illegal_tier_3", 1)
    content.add(group)
end

do
    -- For dividing up books, place a book in a school if the spellbook is of substantial interest to that school.  This involves a bit of judgement--a spellbook that has 5 animist spells and 1 druid spells shouldn't be in the druid list, but a spellbook that has 3 animist spells and 3 druid spells should be in both lists. Books with a completely even split of multiple schools (1 animist, 1 druid, 1 kelvinist, 1 magus, etc) should be in classless only
    local group = content.ItemGroup { id = "animist_spellbooks_tier_0", kind = "distribution" }
    group:group("animist_spellbooks_unrestricted_tier_0", 300)
    group:group("animist_spellbooks_restricted_tier_0", 25)
    group:group("animist_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("sense_outsiders_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("animist_summon_wisps_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_tier_1", kind = "distribution" }
    group:group("animist_spellbooks_unrestricted_tier_1", 300)
    group:group("animist_spellbooks_restricted_tier_1", 25)
    group:group("animist_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("priest_advanced", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_tier_2", kind = "distribution" }
    group:group("animist_spellbooks_unrestricted_tier_2", 300)
    group:group("animist_spellbooks_restricted_tier_2", 25)
    group:group("animist_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("animist_spirits", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_tier_3", kind = "distribution" }
    group:group("animist_spellbooks_unrestricted_tier_3", 300)
    group:group("animist_spellbooks_restricted_tier_3", 25)
    group:group("animist_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "animist_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("animist_shadows", 30)
    group:item("forbidden_tome", 25)
    group:item("necronomicon", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_tier_0", kind = "distribution" }
    group:group("biomancer_spellbooks_unrestricted_tier_0", 300)
    group:group("biomancer_spellbooks_restricted_tier_0", 25)
    group:group("biomancer_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("magic_healing_home_spellbook", 30)
    group:item("biomancy_fasting_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_tier_1", kind = "distribution" }
    group:group("biomancer_spellbooks_unrestricted_tier_1", 300)
    group:group("biomancer_spellbooks_restricted_tier_1", 25)
    group:group("biomancer_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("priest_beginner", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_tier_2", kind = "distribution" }
    group:group("biomancer_spellbooks_unrestricted_tier_2", 300)
    group:group("biomancer_spellbooks_restricted_tier_2", 25)
    group:group("biomancer_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("priest_beginner", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("biomancer_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_tier_3", kind = "distribution" }
    group:group("biomancer_spellbooks_unrestricted_tier_3", 300)
    group:group("biomancer_spellbooks_restricted_tier_3", 25)
    group:group("biomancer_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biomancer_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("necronomicon", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_tier_0", kind = "distribution" }
    group:group("classless_spellbooks_unrestricted_tier_0", 300)
    group:group("classless_spellbooks_restricted_tier_0", 25)
    group:group("classless_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("wizard_beginner", 30)
    group:item("book_lazy_magic", 30)
    group:item("camping_time_spellbook", 30)
    group:item("magic_history_tech_spellbook", 30)
    group:item("freshen_up_spellbook", 30)
    group:item("post_apocalypse_guide_spellbook", 30)
    group:item("crystallize_mana_economy_spellbook", 30)
    group:item("staying_clean_spellbook", 30)
    group:item("anti_magic_dispel_spellbook", 30)
    group:item("easy_sleeping_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("special_effects_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("messed_up_spells_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_tier_1", kind = "distribution" }
    group:group("classless_spellbooks_unrestricted_tier_1", 300)
    group:group("classless_spellbooks_restricted_tier_1", 25)
    group:group("classless_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("wizard_utility", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_tier_2", kind = "distribution" }
    group:group("classless_spellbooks_unrestricted_tier_2", 300)
    group:group("classless_spellbooks_restricted_tier_2", 25)
    group:group("classless_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("wizard_advanced", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_tier_3", kind = "distribution" }
    group:group("classless_spellbooks_unrestricted_tier_3", 300)
    group:group("classless_spellbooks_restricted_tier_3", 25)
    group:group("classless_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("recovery_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("translocate_spellbook", 20)
    group:item("light_manipulation_spellbook", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "classless_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_tier_0", kind = "distribution" }
    group:group("druid_spellbooks_unrestricted_tier_0", 300)
    group:group("druid_spellbooks_restricted_tier_0", 25)
    group:group("druid_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("camping_time_spellbook", 30)
    group:item("magic_healing_home_spellbook", 30)
    group:item("summon_cats_spellbook", 30)
    group:item("magical_gardening_spellbook", 30)
    group:item("druid_healing_power_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("messed_up_spells_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_tier_1", kind = "distribution" }
    group:group("druid_spellbooks_unrestricted_tier_1", 300)
    group:group("druid_spellbooks_restricted_tier_1", 25)
    group:group("druid_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("prepper_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_tier_2", kind = "distribution" }
    group:group("druid_spellbooks_unrestricted_tier_2", 300)
    group:group("druid_spellbooks_restricted_tier_2", 25)
    group:group("druid_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("druid_spellbook", 30)
    group:item("farmer_spellbook", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_tier_3", kind = "distribution" }
    group:group("druid_spellbooks_unrestricted_tier_3", 300)
    group:group("druid_spellbooks_restricted_tier_3", 25)
    group:group("druid_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("plant_spellbook_expurgated", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("plant_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_tier_0", kind = "distribution" }
    group:group("earthshaper_spellbooks_unrestricted_tier_0", 300)
    group:group("earthshaper_spellbooks_restricted_tier_0", 25)
    group:group("earthshaper_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("eshaper_spellbook_tool", 30)
    group:item("earthshaper_landscaping_spellbook", 30)
    group:item("magical_gardening_spellbook", 30)
    group:item("stone_powers_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_tier_1", kind = "distribution" }
    group:group("earthshaper_spellbooks_unrestricted_tier_1", 300)
    group:group("earthshaper_spellbooks_restricted_tier_1", 25)
    group:group("earthshaper_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_tier_2", kind = "distribution" }
    group:group("earthshaper_spellbooks_unrestricted_tier_2", 300)
    group:group("earthshaper_spellbooks_restricted_tier_2", 25)
    group:group("earthshaper_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("farmer_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("eshaper_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_tier_3", kind = "distribution" }
    group:group("earthshaper_spellbooks_unrestricted_tier_3", 300)
    group:group("earthshaper_spellbooks_restricted_tier_3", 25)
    group:group("earthshaper_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "earthshaper_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_tier_0", kind = "distribution" }
    group:group("kelvinist_spellbooks_unrestricted_tier_0", 300)
    group:group("kelvinist_spellbooks_restricted_tier_0", 25)
    group:group("kelvinist_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("avoid_all_temperatures_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_tier_1", kind = "distribution" }
    group:group("kelvinist_spellbooks_unrestricted_tier_1", 300)
    group:group("kelvinist_spellbooks_restricted_tier_1", 25)
    group:group("kelvinist_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("basic_pyromancy_expurgated", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("prepper_spellbook", 30)
    group:item("basic_pyromancy", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("basic_pyromancy_expurgated", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_tier_2", kind = "distribution" }
    group:group("kelvinist_spellbooks_unrestricted_tier_2", 300)
    group:group("kelvinist_spellbooks_restricted_tier_2", 25)
    group:group("kelvinist_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("winter_grasp", 30)
    group:item("pyro", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_tier_3", kind = "distribution" }
    group:group("kelvinist_spellbooks_unrestricted_tier_3", 300)
    group:group("kelvinist_spellbooks_restricted_tier_3", 25)
    group:group("kelvinist_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kelvinist_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_tier_0", kind = "distribution" }
    group:group("magus_spellbooks_unrestricted_tier_0", 300)
    group:group("magus_spellbooks_restricted_tier_0", 25)
    group:group("magus_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("staying_clean_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_tier_1", kind = "distribution" }
    group:group("magus_spellbooks_unrestricted_tier_1", 300)
    group:group("magus_spellbooks_restricted_tier_1", 25)
    group:group("magus_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("wizard_utility", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("wizard_beginner_old", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_tier_2", kind = "distribution" }
    group:group("magus_spellbooks_unrestricted_tier_2", 300)
    group:group("magus_spellbooks_restricted_tier_2", 25)
    group:group("magus_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("staying_clean_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("magic_movement_book", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_tier_3", kind = "distribution" }
    group:group("magus_spellbooks_unrestricted_tier_3", 300)
    group:group("magus_spellbooks_restricted_tier_3", 25)
    group:group("magus_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("magus_spellbook", 30)
    group:item("magus_spellbook_move", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "magus_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_tier_0", kind = "distribution" }
    group:group("stormshaper_spellbooks_unrestricted_tier_0", 300)
    group:group("stormshaper_spellbooks_restricted_tier_0", 25)
    group:group("stormshaper_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("novice_stormshaper_book", 30)
    group:item("stormshaper_electric_immune_spellbook", 30)
    group:item("windrunning_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_tier_1", kind = "distribution" }
    group:group("stormshaper_spellbooks_unrestricted_tier_1", 300)
    group:group("stormshaper_spellbooks_restricted_tier_1", 25)
    group:group("stormshaper_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("tome_of_wind", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("tome_of_storms", 30)
    group:item("pirate_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_tier_2", kind = "distribution" }
    group:group("stormshaper_spellbooks_unrestricted_tier_2", 300)
    group:group("stormshaper_spellbooks_restricted_tier_2", 25)
    group:group("stormshaper_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("techno_electrical_work", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("techno_electrical_work", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("bioelectricity", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_tier_3", kind = "distribution" }
    group:group("stormshaper_spellbooks_unrestricted_tier_3", 300)
    group:group("stormshaper_spellbooks_restricted_tier_3", 25)
    group:group("stormshaper_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stormshaper_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("tome_electric", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_tier_0", kind = "distribution" }
    group:group("technomancer_spellbooks_unrestricted_tier_0", 300)
    group:group("technomancer_spellbooks_restricted_tier_0", 25)
    group:group("technomancer_spellbooks_illegal_tier_0", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_unrestricted_tier_0", kind = "distribution" }
    group:item("magic_history_tech_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_restricted_tier_0", kind = "distribution" }
    group:item("techno_idiots", 30)
    group:item("bypass_portals_spellbook", 30)
    group:item("hologram_and_teleport_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_illegal_tier_0", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_tier_1", kind = "distribution" }
    group:group("technomancer_spellbooks_unrestricted_tier_1", 300)
    group:group("technomancer_spellbooks_restricted_tier_1", 25)
    group:group("technomancer_spellbooks_illegal_tier_1", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_unrestricted_tier_1", kind = "distribution" }
    group:item("stat_up_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_restricted_tier_1", kind = "distribution" }
    group:item("priest_advanced", 30)
    group:item("techno_fundamentals", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_illegal_tier_1", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_tier_2", kind = "distribution" }
    group:group("technomancer_spellbooks_unrestricted_tier_2", 300)
    group:group("technomancer_spellbooks_restricted_tier_2", 25)
    group:group("technomancer_spellbooks_illegal_tier_2", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_unrestricted_tier_2", kind = "distribution" }
    group:item("techno_electrical_work", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_restricted_tier_2", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_illegal_tier_2", kind = "distribution" }
    group:item("techno_em", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_tier_3", kind = "distribution" }
    group:group("technomancer_spellbooks_unrestricted_tier_3", 300)
    group:group("technomancer_spellbooks_restricted_tier_3", 25)
    group:group("technomancer_spellbooks_illegal_tier_3", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_unrestricted_tier_3", kind = "distribution" }
    group:item("recovery_spellbook", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_restricted_tier_3", kind = "distribution" }
    group:item("light_manipulation_spellbook", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "technomancer_spellbooks_illegal_tier_3", kind = "distribution" }
    group:item("null", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "druid_restricted_loot", kind = "distribution" }
    group:entry {
        distribution = {
            {
                distribution = {
                    { group = "druid_restricted_tier_0", probability = 10 },
                    { group = "druid_spellbooks_restricted_tier_0", probability = 1 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { group = "druid_illegal_tier_0", probability = 10 },
                    { group = "druid_spellbooks_illegal_tier_0", probability = 1 },
                },
                probability = 1,
            },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { group = "druid_restricted_tier_1", probability = 10 },
                    { group = "druid_spellbooks_restricted_tier_1", probability = 1 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { group = "druid_illegal_tier_1", probability = 10 },
                    { group = "druid_spellbooks_illegal_tier_1", probability = 1 },
                },
                probability = 1,
            },
        },
        probability = 55,
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { group = "druid_restricted_tier_2", probability = 10 },
                    { group = "druid_spellbooks_restricted_tier_2", probability = 1 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { group = "druid_illegal_tier_2", probability = 10 },
                    { group = "druid_spellbooks_illegal_tier_2", probability = 1 },
                },
                probability = 1,
            },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            {
                distribution = {
                    { group = "druid_restricted_tier_3", probability = 10 },
                    { group = "druid_spellbooks_restricted_tier_3", probability = 1 },
                },
                probability = 10,
            },
            {
                distribution = {
                    { group = "druid_illegal_tier_3", probability = 10 },
                    { group = "druid_spellbooks_illegal_tier_3", probability = 1 },
                },
                probability = 1,
            },
        },
        probability = 5,
    }
    content.add(group)
end

do
    -- the difference between tiers and loot are that loot should be easy to
    -- drop into an itemgroup or mapgen without having multiple entries for higher tier spellbooks.
    -- and loot tiers will not always have the lower tier spellbook tiers.
    local group = content.ItemGroup { id = "spellbook_loot_0", kind = "distribution" }
    group:group("spellbook_tier_0", 60)
    group:group("spellbook_tier_1", 30)
    group:group("spellbook_tier_2", 9)
    group:group("spellbook_tier_3", 1)
    group:group("spell_scroll_tier_0", 300)
    group:group("spell_scroll_tier_1")
    content.add(group)
end

do
    -- like spellbook loot, but for restricted or illegal spells
    local group = content.ItemGroup { id = "spellbook_restricted_loot_0", kind = "distribution" }
    group:group("spellbook_restricted_illegal_tier_0", 60)
    group:group("spellbook_restricted_illegal_tier_1", 30)
    group:group("spellbook_restricted_illegal_tier_2", 9)
    group:group("spellbook_restricted_illegal_tier_3", 1)
    group:group("spell_scroll_restricted_tier_0", 300)
    group:group("spell_scroll_restricted_tier_1")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_loot_1", kind = "distribution" }
    group:group("spellbook_tier_0", 30)
    group:group("spellbook_tier_1", 50)
    group:group("spellbook_tier_2", 18)
    group:group("spellbook_tier_3", 2)
    group:group("spellbook_mana_upgrades", 1)
    group:group("spell_scroll_tier_1", 300)
    group:group("spell_scroll_tier_2")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_loot_1", kind = "distribution" }
    group:group("spellbook_restricted_illegal_tier_0", 30)
    group:group("spellbook_restricted_illegal_tier_1", 50)
    group:group("spellbook_restricted_illegal_tier_2", 18)
    group:group("spellbook_restricted_illegal_tier_3", 2)
    group:group("spell_scroll_restricted_tier_1", 300)
    group:group("spell_scroll_restricted_tier_2")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_loot_2", kind = "distribution" }
    group:group("spellbook_tier_0", 5)
    group:group("spellbook_tier_1", 30)
    group:group("spellbook_tier_2", 50)
    group:group("spellbook_tier_3", 15)
    group:group("spellbook_mana_upgrades", 8)
    group:group("spell_scroll_tier_2", 300)
    group:group("spell_scroll_tier_3")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "spellbook_restricted_loot_2", kind = "distribution" }
    group:group("spellbook_restricted_illegal_tier_0", 5)
    group:group("spellbook_restricted_illegal_tier_1", 30)
    group:group("spellbook_restricted_illegal_tier_2", 50)
    group:group("spellbook_restricted_illegal_tier_3", 15)
    group:group("spell_scroll_restricted_tier_2", 300)
    group:group("spell_scroll_restricted_tier_3")
    content.add(group)
end

do
    -- Contains the books with spells that upgrade mana traits
    local group = content.ItemGroup { id = "spellbook_mana_upgrades", kind = "distribution" }
    group:item("first_circle_mana_amount_upgrade_spellbook", 200)
    group:item("second_circle_mana_amount_upgrade_spellbook", 50)
    group:item("first_circle_mana_regen_upgrade_spellbook", 200)
    group:item("second_circle_mana_regen_upgrade_spellbook", 50)
    group:item("first_circle_mana_mult_upgrade_spellbook", 200)
    group:item("second_circle_mana_mult_upgrade_spellbook", 50)
    group:item("all_first_circle_upgrades_spellbook", 50)
    content.add(group)
end
