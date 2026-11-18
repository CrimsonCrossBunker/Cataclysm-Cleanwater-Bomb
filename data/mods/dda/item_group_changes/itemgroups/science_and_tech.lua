local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mutagenic_field_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "iv_mutagen_elfa", probability = 2 },
            { item = "iv_mutagen_alpha", probability = 2 },
            { item = "iv_mutagen_raptor", probability = 2 },
            { item = "iv_mutagen_medical", probability = 2 },
            { item = "iv_mutagen_chimera", probability = 2 },
            { item = "iv_mutagen_plant", probability = 2 },
            { item = "iv_mutagen_insect", probability = 2 },
            { item = "iv_mutagen_spider", probability = 2 },
            { item = "iv_mutagen_snail", probability = 2 },
            { item = "iv_mutagen_batrachian", probability = 2 },
            { item = "iv_mutagen_fish", probability = 2 },
            { item = "iv_mutagen_slime", probability = 2 },
            { item = "iv_mutagen_rat", probability = 2 },
            { item = "iv_mutagen_chiropteran", probability = 2 },
            { item = "iv_mutagen_beast", probability = 2 },
            { item = "iv_mutagen_cattle", probability = 2 },
            { item = "iv_mutagen_cephalopod", probability = 2 },
            { item = "iv_mutagen_bird", probability = 2 },
            { item = "iv_mutagen_lizard", probability = 2 },
            { item = "iv_mutagen_troglobite", probability = 2 },
            { item = "iv_mutagen_ursine", probability = 2 },
            { item = "iv_mutagen_feline", probability = 2 },
            { item = "iv_mutagen_lupine", probability = 2 },
            { item = "iv_mutagen_mouse", probability = 2 },
            { item = "iv_mutagen_rabbit", probability = 2 },
            { item = "iv_mutagen_crustacean", probability = 2 },
            { item = "iv_purifier", probability = 2 },
        },
    }
    group:entry { item = "iv_mutagen", count = { 1, 1 } }
    group:entry { item = "mutagen_chelator", count = { 1, 2 }, probability = 80 }
    group:entry { item = "syringe", count = { 2, 2 } }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagen_catalyst_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "iv_mutagen", count = { 5, 5 } }
    group:entry { item = "mutagen_chelator", count = { 3, 3 } }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagen_primer_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "iv_mutagen_elfa", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_alpha", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_raptor", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_medical", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_chimera", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_plant", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_insect", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_spider", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_snail", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_batrachian", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_fish", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_slime", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_rat", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_chiropteran", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_beast", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_cattle", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_cephalopod", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_bird", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_lizard", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_troglobite", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_ursine", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_feline", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_lupine", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_mouse", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_rabbit", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_crustacean", count = { 4, 5 }, probability = 2 },
            { item = "iv_purifier", count = { 4, 5 }, probability = 2 },
        },
    }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:entry { item = "mutagen_chelator", count = { 1, 2 }, probability = 80 }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagen_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "mutagen_elfa", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_alpha", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_raptor", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_medical", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_chimera", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_plant", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_insect", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_spider", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_snail", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_batrachian", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_fish", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_slime", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_rat", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_chiropteran", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_beast", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_cattle", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_cephalopod", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_bird", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_lizard", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_troglobite", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_ursine", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_feline", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_lupine", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_rabbit", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_crustacean", count = { 7, 11 }, probability = 2 },
        },
    }
    group:entry { item = "mutagen_chelator", count = { 1, 1 }, probability = 50 }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "schematics", kind = "distribution" }
    group:item("schematics_nursebot", 10)
    group:item("schematics_grocerybot", 20)
    group:item("schematics_secubot", 50)
    group:item("schematics_skitterbot", 50)
    group:item("schematics_hazmatbot", 50)
    group:item("schematics_sciencebot", 10)
    group:item("schematics_dispatch", 25)
    group:item("schematics_dispatch_military", 20)
    group:item("schematics_antimateriel", 20)
    group:item("schematics_searchlight", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "chem_lab", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:group("supplies_reagents_lab", 60)
    group:entry { item = "ether", charges = { 100, -1 }, probability = 5 }
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:item("adv_chemistry", 4)
    group:item("decoy_elfa", 6)
    group:item("file", 10)
    group:item("recipe_raptor", 1)
    group:item("recipe_alpha", 1)
    group:item("recipe_chimera", 2)
    group:item("recipe_medicalmut", 2)
    group:item("recipe_serum", 4)
    group:item("recipe_creepy", 4)
    group:item("recipe_animal", 4)
    group:item("recipe_maiar", 4)
    group:item("recipe_labchem", 6)
    group:entry { item = "chem_benzene", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_toluene", charges = { 1, -1 }, probability = 5 }
    group:entry { item = "chem_ferric_chloride", count = { 1, -1 }, probability = 25 }
    group:entry { item = "water_clean", charges = { 1, -1 }, sealed = false, container = "bottle_plastic", probability = 90 }
    group:entry { item = "salt_water", charges = { 1, -1 }, probability = 20 }
    group:group("bleach_jug_part", 20)
    group:entry { item = "ammonia_liquid", charges = { 6, -1 }, probability = 50 }
    group:entry { item = "chem_washing_soda", charges = { 1, -1 }, probability = 20 }
    group:entry { item = "chem_baking_soda", charges = { 1, -1 }, probability = 5 }
    group:item("chem_calcium_chloride", 5)
    group:item("panacea", 8)
    group:group("glue_weak_domestic", 15)
    group:group("glue_strong_domestic", 15)
    group:item("bottle_glass", 10)
    group:item("syringe", 8)
    group:item("adrenaline_injector", 4)
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 20 }
    group:item("hotplate_induction", 10)
    group:entry {
        collection = {
            { item = "ref_lighter_butane" },
            { item = "butane_can", charges = { 200, 400 } },
        },
        probability = 5,
    }
    group:entry {
        group = "used_usb_drives",
        contents = {
            { item = "software_medical" },
        },
        probability = 10,
    }
    group:item("funnel", 50)
    group:item("jar_glass_sealed", 20)
    group:item("jar_3l_glass_sealed", 15)
    group:item("apron_plastic", 20)
    group:item("apron_cotton", 2)
    group:item("apron_leather", 2)
    group:group("pur_tablets_bottle_plastic_small_1_50", 5)
    group:group("lye_powder_bottle_part", 10)
    group:group("oxy_powder_bottle_part", 12)
    group:group("magnesiumpowder_small_bag_part", 12)
    group:entry { item = "tin", charges = { 50, 100 }, probability = 12 }
    group:item("chemistry_set", 5)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:group("charcoal_bag_part", 10)
    group:item("briefcase", 5)
    group:item("thermometer", 3)
    group:item("hygrometer", 3)
    group:item("barometer", 3)
    group:group("chem_sulphur_bottle_plastic_small_100_inf", 10)
    group:item("chem_aluminium_powder", 10)
    group:item("chem_hexamine", 10)
    group:group("saltpeter_canvas_bag_part", 15)
    group:entry { item = "chem_nitric_acid", charges = { 1, -1 }, probability = 15 }
    group:entry { item = "chem_muriatic_acid", charges = { 1, -1 }, probability = 20 }
    group:group("potassiumchloride_small_bottle_part", 5)
    group:entry { item = "chem_potassium_hydroxide", charges = { 100, -1 }, probability = 10 }
    group:entry { item = "chem_zinc_oxide", charges = { 100, -1 }, probability = 10 }
    group:group("chromiumoxide_small_bottle_part", 10)
    group:group("zincpowder_small_bottle_part", 10)
    group:group("manganesedioxide_small_bottle_part", 10)
    group:group("chem_citric_acid_bottle_glass_100_inf", 16)
    group:entry { item = "denat_alcohol", charges = { 250, -1 }, probability = 6 }
    group:entry { item = "methed_alcohol", charges = { 250, -1 }, probability = 4 }
    group:group("redphosphorus_small_bottle_part", 10)
    group:group("whitephosphorus_small_bottle_part", 10)
    group:item("acetic_anhydride", 8)
    group:item("iodine_crystal", 12)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teleport", kind = "distribution" }
    group:item("screwdriver", 40)
    group:item("screwdriver_set", 40)
    group:item("wrench", 30)
    group:item("pliers", 20)
    group:item("jumpsuit", 20)
    group:item("mask_dust", 65)
    group:item("wrapped_rad_badge", 15)
    group:item("glasses_safety", 5)
    group:item("goggles_chem", 35)
    group:item("goggles_welding", 70)
    group:item("textbook_atomic_lab", 7)
    group:item("recipe_lab_elec", 15)
    group:entry {
        group = "used_usb_drives",
        contents = {
            { item = "software_electronics_reference" },
        },
        probability = 2,
    }
    group:group("new_usb_drives", 5)
    group:item("recipe_lab_cvd", 8)
    group:item("teleporter", 10)
    group:group("antiparasitic_bottle_plastic_pill_prescription_1_10", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "surgery", kind = "distribution" }
    group:item("blood", 20)
    group:group("saline_bottle_random", 20)
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 5)
    group:group("prussian_blue_bottle_plastic_pill_supplement_1_10", 5)
    group:item("autoclave", 5)
    group:entry { item = "bandages", count = { 1, 3 }, probability = 50 }
    group:group("adhesive_bandages_box_used", 20)
    group:group("cotton_ball_bag_used", 50)
    group:group("cotton_ball_bag_full", 50)
    group:item("scalpel", 48)
    group:item("syringe", 8)
    group:item("pouch_autoclave", 15)
    group:item("adrenaline_injector", 2)
    group:item("gloves_medical", 70)
    group:item("stethoscope", 30)
    group:item("mask_dust", 65)
    group:item("towel", 40)
    group:item("vacutainer", 10)
    group:entry {
        item = "cotton_patchwork",
        flags = {
            "FILTHY",
        },
        probability = 1,
    }
    group:entry { item = "disinfectant", charges = { 1, 10 }, probability = 35 }
    group:item("medical_gauze", 10)
    group:group("medical_tape_roll_part", 45)
    group:item("jar_glass_sealed", 20)
    group:item("jar_3l_glass_sealed", 15)
    group:entry { item = "oxygen_tank", charges = { 0, 24 }, probability = 50 }
    group:entry { item = "smoxygen_tank", charges = { 0, 12 }, probability = 25 }
    group:group("bfipowder_bottle_plastic_5_60", 15)
    group:group("quikclot_bag_plastic_1_6", 10)
    group:item("anesthetic", 20)
    group:entry { item = "rocuronium", count = { 2, 8 }, probability = 10 }
    group:entry { item = "anesthetic_kit", charges = { 0, -1 }, probability = 10 }
    content.add(group)
end
