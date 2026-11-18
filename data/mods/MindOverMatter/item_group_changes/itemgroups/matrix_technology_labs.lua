local content = require("ccb").content

do
    local group = content.ItemGroup { id = "psi_lab", kind = "distribution" }
    group:entry {
        item = "water_clean",
        charges = { 1, -1 },
        sealed = false,
        container = "bottle_plastic",
        probability = 150,
    }
    group:group("bleach_jug_part", 20)
    group:entry { item = "ether", charges = { 100, -1 }, probability = 50 }
    group:entry { item = "chem_aluminium_powder", container = "flask_glass", probability = 25 }
    group:group("zincpowder_glass_flask_part", 25)
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:group("wallets_phavian", 3)
    group:group("distribution_matrix_dust", 80)
    group:group("chem_lab", 30)
    group:entry { item = "laptop", charges = { 0, 500 }, probability = 10 }
    group:entry { item = "eink_tablet_pc", charges = { 0, 100 }, probability = 20 }
    group:item("memory_card_unread", 5)
    group:item("file", 50)
    group:item("camera_pro", 20)
    group:item("deck_of_cards", 15)
    group:item("magic_8_ball", 10)
    group:group("psi_testing_materials", 50)
    group:item("apron_plastic", 30)
    group:item("apron_cotton", 10)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "contacts", count = { 6, 6 }, probability = 20 }
    group:group("clothing_glasses", 20)
    group:item("coat_lab", 20)
    group:item("gloves_medical", 20)
    group:item("badge_doctor", 2)
    group:item("lanyard", 5)
    group:item("chemistry_set", 4)
    group:entry { item = "salt_water", charges = { 1, -1 }, probability = 20 }
    group:item("usb_drive", 15)
    group:item("wrapped_rad_badge", 10)
    group:entry {
        item = "usb_drive",
        contents = {
            { item = "software_useless" },
        },
        probability = 15,
    }
    group:entry {
        item = "usb_drive",
        contents = {
            { item = "software_electronics_reference" },
        },
        probability = 10,
    }
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:entry { item = "rad_monitor", charges = { 0, 50 }, probability = 2 }
    group:entry { item = "chem_sulphuric_acid", container = "bottle_glass", probability = 20 }
    group:entry { item = "chem_muriatic_acid", container = "bottle_glass", probability = 15 }
    group:entry { item = "chem_nitric_acid", container = "bottle_glass", probability = 15 }
    group:group("dist_electronoetic_batteries", 25)
    group:entry { item = "denat_alcohol", charges = { 250, -1 }, probability = 10 }
    group:entry { item = "methed_alcohol", charges = { 250, -1 }, probability = 10 }
    group:item("mortar_pestle", 20)
    group:item("blindfold", 10)
    group:item("syringe", 12)
    group:item("matrix_crystal_drained", 15)
    group:group("dist_matrix_crystals", 5)
    group:group("dist_matrix_tools", 15)
    group:item("manual_meditation", 20)
    group:item("manual_meditation_int", 12)
    group:item("manual_psionics_advan", 4)
    group:item("phavian_report_psionic_drain", 3)
    group:group("psionic_recipes_beginner", 5)
    group:group("psionic_recipes_tools", 5)
    group:group("psionic_recipes_medicine", 2)
    group:group("psionic_recipes_powers", 2)
    group:group("psionic_recipes_advanced", 1)
    group:group("dist_matrix_translocation_items", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psi_lab_no_recipes", kind = "distribution" }
    group:entry {
        item = "water_clean",
        charges = { 1, -1 },
        sealed = false,
        container = "bottle_plastic",
        probability = 150,
    }
    group:group("bleach_jug_part", 20)
    group:entry { item = "ether", charges = { 100, -1 }, probability = 50 }
    group:entry { item = "chem_aluminium_powder", container = "flask_glass", probability = 25 }
    group:entry { item = "chem_zinc_powder", container = "flask_glass", probability = 25 }
    group:group("adderall_bottle_plastic_pill_prescription_1_10", 10)
    group:group("wallets_phavian", 3)
    group:group("distribution_matrix_dust", 80)
    group:group("chem_lab", 30)
    group:entry { item = "laptop", charges = { 0, 500 }, probability = 10 }
    group:entry { item = "eink_tablet_pc", charges = { 0, 100 }, probability = 20 }
    group:item("memory_card_unread", 5)
    group:item("file", 50)
    group:item("camera_pro", 20)
    group:item("deck_of_cards", 15)
    group:item("magic_8_ball", 10)
    group:group("psi_testing_materials", 50)
    group:item("chemistry_set", 4)
    group:item("apron_plastic", 30)
    group:item("apron_cotton", 10)
    group:entry { item = "mask_filter", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "contacts", count = { 6, 6 }, probability = 20 }
    group:group("clothing_glasses", 20)
    group:item("coat_lab", 20)
    group:item("gloves_medical", 20)
    group:item("badge_doctor", 2)
    group:item("lanyard", 5)
    group:entry { item = "salt_water", charges = { 1, -1 }, probability = 20 }
    group:item("usb_drive", 15)
    group:item("wrapped_rad_badge", 10)
    group:entry {
        item = "usb_drive",
        contents = {
            { item = "software_useless" },
        },
        probability = 15,
    }
    group:entry {
        item = "usb_drive",
        contents = {
            { item = "software_electronics_reference" },
        },
        probability = 10,
    }
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 8 }
    group:entry { item = "rad_monitor", charges = { 0, 50 }, probability = 2 }
    group:entry { item = "chem_sulphuric_acid", container = "bottle_glass", probability = 20 }
    group:entry { item = "chem_muriatic_acid", container = "bottle_glass", probability = 15 }
    group:entry { item = "chem_nitric_acid", container = "bottle_glass", probability = 15 }
    group:group("dist_electronoetic_batteries", 25)
    group:entry { item = "denat_alcohol", charges = { 250, -1 }, probability = 10 }
    group:entry { item = "methed_alcohol", charges = { 250, -1 }, probability = 10 }
    group:item("mortar_pestle", 20)
    group:item("blindfold", 10)
    group:item("syringe", 12)
    group:item("matrix_crystal_drained", 15)
    group:group("dist_matrix_tools", 15)
    group:group("dist_matrix_translocation_items", 2)
    content.add(group)
end
