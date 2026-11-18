local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "afs_mealgrub_medium_simple",
    result = "afs_mealgrub_medium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "BLIND_HARD", "ALLOW_ROTTEN", "NUTRIENT_OVERRIDE" },
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 }
        })
    :component_any({
            { id = "meal_bone", count = 2 },
            { id = "meal_chitin_piece", count = 1 }
        })
    :component_any({
            { id = "fertilizer_liquid", count = 1 },
            { id = "fertilizer_commercial", count = 1 }
        })
    :component("any_fat", 2, true)
    :quality("BOIL", 1, 1)
    :quality("CHEM", 2, 1)
    :quality("CUT", 2, 1)
    :book("afs_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "brew_afs_mealgrub_broth_simple",
    result = "brew_afs_mealgrub_broth",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
    flags = { "BLIND_HARD" },
}
    :component("afs_mealgrub_spores", 1)
    :component("afs_mealgrub_medium", 5)
    :book("afs_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "afs_mealgrubs_simple",
    result = "afs_mealgrubs",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 }
        })
    :component("afs_mealgrub_jelly", 5)
    :book("afs_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "afs_battery_charger",
    result = "afs_battery_charger",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("afs_energy_storage_2", 1)
    :component("afs_energy_storage_1", 2)
    :component("afs_circuitry_2", 1)
    :component("scrap", 5)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 2)
    :learn_automatically("electronics", 2)
)

content.add(content.Recipe {
    id = "afs_survival_heater",
    result = "afs_survival_heater",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("afs_heat_1", 3)
    :component("afs_circuitry_2", 1)
    :component_any({
            { id = "element", count = 12 },
            { id = "crude_heating_element", count = 18 }
        })
    :component("sheet_metal", 2)
    :component("cable", 5)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 4)
    :learn_automatically("electronics", 3)
)

content.add(content.Recipe {
    id = "afs_tripod_light",
    result = "afs_tripod_light",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("afs_circuitry_1", 2)
    :component("lightstrip_inactive", 3)
    :component("pipe", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
)

content.add(content.Recipe {
    id = "afs_survival_battery",
    result = "afs_survival_battery",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("afs_energy_storage_2", 3)
    :component("afs_energy_storage_1", 10)
    :component("afs_circuitry_1", 1)
    :component("sheet_metal", 2)
    :component("cable", 7)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requires_skill("fabrication", 3)
    :learn_automatically("electronics", 3)
)

content.add(content.Recipe {
    id = "bio_power_storage",
    result = "bio_power_storage",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("afs_energy_storage_3", 2)
    :component("afs_material_1", 6)
    :component("plut_cell", 1)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_augs", 5)
    :book("recipe_lab_elec", 5)
)

content.add(content.Recipe {
    id = "bio_power_storage_mkII",
    result = "bio_power_storage_mkII",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 10,
}
    :component("afs_energy_storage_4", 2)
    :component("afs_material_1", 6)
    :component("plut_cell", 2)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 8)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_batteries",
    result = "bio_batteries",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_energy_storage_1", 2)
    :component("afs_circuitry_2", 2)
    :component("afs_material_2", 6)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_ups",
    result = "bio_ups",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("afs_energy_storage_4", 1)
    :component("afs_circuitry_2", 1)
    :component("afs_material_2", 6)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :book("recipe_lab_elec", 5)
)

content.add(content.Recipe {
    id = "bio_evap",
    result = "bio_evap",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_biomaterial_4", 1)
    :component("afs_neural_io_1", 2)
    :component("afs_circuitry_2", 1)
    :component("afs_material_2", 6)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 60)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_flashlight",
    result = "bio_flashlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("afs_neural_io_1", 1)
    :component("afs_circuitry_1", 1)
    :component("afs_material_1", 6)
    :component("burnt_out_bionic", 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_water_extractor",
    result = "bio_water_extractor",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_biomaterial_4", 1)
    :component("afs_neural_io_1", 2)
    :component("afs_circuitry_2", 1)
    :component("afs_material_2", 6)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 60)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 5)
)

content.add(content.Recipe {
    id = "bio_climate",
    result = "bio_climate",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("afs_circuitry_3", 2)
    :component("afs_cloth_4", 4)
    :component("afs_neural_io_3", 1)
    :component("afs_material_3", 6)
    :component("afs_material_2", 6)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 60)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 8)
)

content.add(content.Recipe {
    id = "bio_emp_armgun",
    result = "bio_emp_armgun",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_circuitry_3", 2)
    :component("afs_material_4", 1)
    :component("afs_energy_storage_3", 2)
    :component("afs_material_3", 8)
    :component("afs_neural_io_3", 1)
    :component("afs_magnet_4", 1)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 100)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 5)
)

content.add(content.Recipe {
    id = "bio_syringe",
    result = "bio_syringe",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("afs_circuitry_1", 2)
    :component("syringe", 1)
    :component("plastic_chunk", 1)
    :component("afs_material_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 6)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_cold_absorber",
    result = "bio_cold_absorber",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_biomaterial_4", 6)
    :component("afs_material_3", 12)
    :component("afs_material_2", 2)
    :component("afs_circuitry_2", 2)
    :component("afs_neural_io_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 400)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipes_cryolab", 5)
)

content.add(content.Recipe {
    id = "bio_weight",
    result = "bio_weight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("afs_biomaterial_4", 10)
    :component("afs_circuitry_2", 5)
    :component("afs_scrap_titanium", 50)
    :component("afs_material_3", 10)
    :component("afs_neural_io_2", 10)
    :component("afs_neural_io_4", 4)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 400)
    :requires_skill("firstaid", 4)
    :requires_skill("mechanics", 3)
    :learn_by_disassembly("electronics", 6)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "bio_sunglasses",
    result = "bio_sunglasses",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("glass_tinted", 4)
    :component("afs_material_1", 3)
    :component("afs_neural_io_1", 1)
    :component("afs_circuitry_1", 1)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 4)
    :learn_by_disassembly("electronics", 6)
    :book("recipe_lab_elec", 5)
    :book("recipe_augs", 5)
)

content.add(content.Recipe {
    id = "afs_bio_missiles",
    result = "afs_bio_missiles",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("afs_material_3", 4)
    :component("afs_magnet_3", 1)
    :component("afs_neural_io_4", 1)
    :component("afs_circuitry_1", 1)
    :component("burnt_out_bionic", 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 40)
    :requires_skill("firstaid", 5)
    :requires_skill("launcher", 3)
    :learn_by_disassembly("electronics", 9)
    :book("recipe_lab_elec", 6)
)

content.add(content.Recipe {
    id = "bio_armor_head",
    result = "bio_armor_head",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component_any({
            { id = "alloy_sheet", count = 4 },
            { id = "alloy_plate", count = 1 }
        })
    :component("afs_material_3", 4)
    :component("afs_material_2", 2)
    :component("afs_neural_io_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 50)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 6)
)

content.add(content.Recipe {
    id = "bio_armor_arms",
    result = "bio_armor_arms",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component_any({
            { id = "alloy_sheet", count = 4 },
            { id = "alloy_plate", count = 1 }
        })
    :component("afs_material_3", 4)
    :component("afs_neural_io_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 50)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 6)
)

content.add(content.Recipe {
    id = "bio_armor_torso",
    result = "bio_armor_torso",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component_any({
            { id = "alloy_sheet", count = 4 },
            { id = "alloy_plate", count = 1 }
        })
    :component("afs_material_3", 4)
    :component("afs_neural_io_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 50)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 6)
)

content.add(content.Recipe {
    id = "bio_armor_legs",
    result = "bio_armor_legs",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component_any({
            { id = "alloy_sheet", count = 4 },
            { id = "alloy_plate", count = 1 }
        })
    :component("afs_material_3", 4)
    :component("afs_neural_io_2", 2)
    :component("burnt_out_bionic", 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("BIONIC_ASSEMBLY", 2, 1)
    :requirement("soldering_standard", 50)
    :requires_skill("firstaid", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 6)
)

content.add(content.Recipe {
    id = "cream_prot_cold",
    result = "cream_prot_cold",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 15, true)
    :component("afs_biomaterial_1", 8)
    :component("afs_biomaterial_2", 3)
    :component("afs_biomaterial_3", 1)
    :component_any({
            { id = "morphine", count = 5 },
            { id = "heroin", count = 2 }
        })
    :quality("CHEM", 3, 1)
    :book("recipes_resistance", 5)
)

content.add(content.Recipe {
    id = "cream_greater_prot_cold",
    result = "cream_greater_prot_cold",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 15, true)
    :component("afs_biomaterial_1", 8)
    :component("afs_biomaterial_2", 5)
    :component("afs_biomaterial_3", 2)
    :component_any({
            { id = "morphine", count = 8 },
            { id = "heroin", count = 3 }
        })
    :quality("CHEM", 3, 1)
    :book("recipes_resistance", 5)
)

content.add(content.Recipe {
    id = "UPS_off",
    result = "UPS_off",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("afs_energy_storage_3", 1)
    :component("afs_energy_storage_1", 2)
    :component("afs_circuitry_1", 1)
    :component("afs_material_1", 4)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 24)
    :learn_by_disassembly("electronics", 4)
    :book("advanced_electronics", 4)
    :book("recipe_lab_elec", 4)
    :book("textbook_anarch", 4)
)

content.add(content.Recipe {
    id = "afs_atomic_lamp",
    result = "afs_atomic_lamp",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("plastic_chunk", 2)
    :component("glue_strong", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("plut_cell", 2)
    :quality("SCREW", 1, 1)
    :book("recipe_caseless", 6)
    :book("textbook_atomic_lab", 3)
)

content.add(content.Recipe {
    id = "afs_atomic_light",
    result = "afs_atomic_light",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("plastic_chunk", 1)
    :component("glue_strong", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component("plut_cell", 1)
    :quality("SCREW", 1, 1)
    :book("recipe_caseless", 6)
    :book("textbook_atomic_lab", 3)
)

content.add(content.Recipe {
    id = "afs_atomic_headlamp",
    result = "afs_atomic_headlamp",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "afs_atomic_lamp", count = 1 },
            { id = "afs_atomic_lamp_off", count = 1 }
        })
    :component("glue_strong", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("tailoring_nylon_patchwork", 2)
)

content.add(content.Recipe {
    id = "inactive_frankenstein",
    result = "inactive_frankenstein",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_CBMS",
    duration_moves = 50000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :tool("toolset", 1)
    :component("afs_energy_storage_4", 6)
    :component("afs_biomaterial_3", 4)
    :component("living_brain_jar", 1)
    :component("humming_heart", 2)
    :component("bot_broken_cyborg", 1)
    :component("thread", 600)
    :component("chain", 2)
    :quality("SCREW_FINE", 1, 1)
    :quality("CUT_FINE", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("firstaid", 8)
    :learn_by_disassembly("electronics", 5)
    :book("cyrus'_notes", 7)
)

content.add(content.Recipe {
    id = "mutagen_mastodon",
    result = "mutagen_mastodon",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 10,
}
    :tool_charges("surface_heat", 30, true)
    :component("mutagen", 1)
    :component("afs_biomaterial_3", 3)
    :component_any({
            { id = "slime_scrap", count = 5 },
            { id = "afs_biomaterial_5", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 6)
    :book("recipe_uplift", 9)
)

content.add(content.Recipe {
    id = "iv_mutagen_mastodon",
    result = "iv_mutagen_mastodon",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 10,
}
    :tool_charges("surface_heat", 30, true)
    :component("mutagen", 3)
    :component("afs_biomaterial_3", 3)
    :component_any({
            { id = "mutagen_medical", count = 1 },
            { id = "afs_biomaterial_5", count = 1 }
        })
    :component("syringe", 1)
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 6)
    :book("recipe_uplift", 9)
)

content.add(content.Recipe {
    id = "mutagen_migo",
    result = "mutagen_migo",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 10,
}
    :tool_charges("surface_heat", 30, true)
    :component("mutagen", 1)
    :component("afs_biomaterial_3", 3)
    :component("resin_chunk", 5)
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 6)
    :book("millyficents_diary", 9)
)

content.add(content.Recipe {
    id = "iv_mutagen_migo",
    result = "iv_mutagen_migo",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 10,
}
    :tool_charges("surface_heat", 30, true)
    :component("mutagen_migo", 2)
    :component("afs_biomaterial_1", 4)
    :component("syringe", 1)
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 6)
    :book("millyficents_diary", 9)
)

content.replace(content.Recipe {
    id = "recharge_station",
    result = "recharge_station",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 50000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("power_supply", 2)
    :component("processor", 2)
    :component("scrap", 5)
    :component("cable", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 35)
    :learn_automatically("electronics", 2)
)

content.add(content.Recipe {
    id = "light_battery_cell",
    result = "light_battery_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 5000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 1,
}
    :component("chem_sulphuric_acid", 1)
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 1 }
        })
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :quality("SCREW", 1, 1)
    :requires_skill("fabrication", 2)
    :book("manual_electronics", 1)
    :book("mag_electronics", 1)
    :book("textbook_anarch", 1)
)

content.add(content.Recipe {
    id = "plut_cell_from_slurry",
    result = "plut_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 8,
}
    :component("canister_empty", 1)
    :component_any({
            { id = "plut_slurry", count = 10 },
            { id = "plut_slurry_dense", count = 5 }
        })
    :component("power_supply", 2)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("electronics", 4)
    :book("textbook_atomic_lab", 5)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "light_battery_cell_afs_plutonium_battery",
    result = "light_battery_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 1 }
        })
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :component("plut_cell", 1)
    :quality("SCREW", 1, 1)
    :book("textbook_atomic_lab", 3)
)

content.add(content.Recipe {
    id = "thermometer",
    result = "thermometer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 20000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("plastic_chunk", 1)
    :component("light_minus_battery_cell", 1)
    :component("cable", 2)
    :component("circuit", 1)
    :component("scrap", 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :book("mag_electronics", 3)
    :book("manual_electronics", 2)
)

content.add(content.Recipe {
    id = "afs_titanium_frame",
    result = "afs_titanium_frame",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 8000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("afs_scrap_titanium", 2)
    :requirement("welding_standard", 6)
)

content.add(content.Recipe {
    id = "afs_titanium_foldable_frame",
    result = "afs_titanium_foldable_frame",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "afs_scrap_titanium", count = 2 },
            { id = "afs_titanium_frame", count = 1 }
        })
    :requirement("welding_standard", 6)
)

-- Conversion of a normal smartphone into an atomic one by replacing the power supply.
content.add(content.Recipe {
    id = "afs_atomic_smartphone",
    result = "afs_atomic_smartphone",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 5,
}
    :component("plastic_chunk", 1)
    :component("processor", 1)
    :component("smart_phone", 1)
    :component("plut_cell", 1)
    :quality("SCREW", 1, 1)
    :book("recipe_caseless", 5)
    :book("textbook_atomic_lab", 4)
)

content.add(content.Recipe {
    id = "plut_cell_from_fuel",
    result = "plut_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 5000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 5,
}
    :tool_any({
            { id = "soldering_iron", charges = 50 },
            { id = "soldering_iron_portable", charges = 50 }
        })
    :component("nuclear_fuel", 2)
    :component("e_scrap", 5)
    :component("lead", 25)
    :component("plastic_chunk", 5)
    :component("scrap", 5)
    :component_any({
            { id = "can_drink", count = 5 },
            { id = "can_food", count = 5 },
            { id = "canister_empty", count = 5 }
        })
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :learn_automatically("electronics", 7)
    :book("textbook_atomic", 5)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "bot_tankbot",
    result = "bot_tankbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 450000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 9,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("tank_tread", 1)
    :component("tankbot_chassis", 1)
    :component("targeting_module", 1)
    :component("gun_module", 3)
    :component("flamethrower", 1)
    :component("tazer", 1)
    :component("modular_m4_carbine", 1)
    :component("power_supply", 20)
    :component("storage_battery", 1)
    :component("plut_cell", 4)
    :component("mil_plate", 2)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 30)
    :requirement("welding_standard", 20)
    :requires_skill("mechanics", 9)
    :requires_skill("computer", 8)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_tankbot", 9)
)

content.add(content.Recipe {
    id = "bot_tripod",
    result = "bot_tripod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 9,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("spidery_legs_big", 1)
    :component("tripod_chassis", 1)
    :component("targeting_module", 1)
    :component("gun_module", 1)
    :component("power_supply", 12)
    :component("storage_battery", 1)
    :component("flamethrower", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 10)
    :requires_skill("mechanics", 9)
    :requires_skill("computer", 8)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_tripod", 9)
)

content.add(content.Recipe {
    id = "bot_chickenbot",
    result = "bot_chickenbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 450000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 10,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("reverse_jointed_legs", 1)
    :component("chickenbot_chassis", 1)
    :component("targeting_module", 1)
    :component("gun_module", 3)
    :component("mark19", 1)
    :component("tazer", 1)
    :component("m249", 1)
    :component("power_supply", 20)
    :component("storage_battery", 1)
    :component("plut_cell", 4)
    :component("mil_plate", 2)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 30)
    :requirement("welding_standard", 20)
    :requires_skill("mechanics", 10)
    :requires_skill("computer", 9)
    :learn_by_disassembly("electronics", 9)
    :book("schematics_chickenbot", 10)
)

content.add(content.Recipe {
    id = "afs_scrap_titanium",
    result = "afs_scrap_titanium",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("afs_titanium_small", 400)
    :requirement("forging_standard", 1)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "afs_material_1",
    result = "afs_material_1",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("afs_titanium_small", 400)
    :requirement("forging_standard", 1)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "control_laptop",
    result = "control_laptop",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 7,
}
    :tool("software_hacking", 1)
    :component("laptop", 1)
    :component("receiver", 2)
    :component("e_scrap", 2)
    :component("antenna", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 14)
    :requires_skill("computer", 4)
    :book("recipe_lab_elec", 7)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_laserturret_xray",
    result = "bot_laserturret_xray",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("gun_module", 1)
    :component("targeting_module", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("laser_cannon_xray", 1)
    :component("medium_storage_battery", 1)
    :component("xray_laser_barrel", 3)
    :component("afs_energy_storage_3", 1)
    :component("robot_controls", 1)
    :component("turret_chassis", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 14)
    :requires_skill("mechanics", 8)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 9)
    :book("recipe_lab_elec", 8)
)

content.add(content.Recipe {
    id = "bot_utilibot_beehive_from_parts",
    result = "bot_utilibot_beehive",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 25000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "electronics",
    difficulty = 6,
}
    :tool_charges("electrohack", 20)
    :component("broken_utilibot", 1)
    :component("afs_energy_storage_4", 1)
    :component("metal_tank_little", 4)
    :component("sensor_module", 1)
    :component("motor_micro", 1)
    :component("robot_controls", 1)
    :component("afs_circuitry_2", 2)
    :component("afs_circuitry_3", 1)
    :component("afs_circuitry_1", 4)
    :component("afs_energy_storage_3", 1)
    :component("afs_material_1", 7)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 5)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 5)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_utilibot_beehive_repair",
    result = "bot_utilibot_beehive",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 25000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "electronics",
    difficulty = 6,
}
    :tool_charges("electrohack", 20)
    :component("broken_utilibot_beehive", 1)
    :component("afs_circuitry_1", 4)
    :component("afs_energy_storage_3", 1)
    :component("afs_material_1", 8)
    :component("robot_controls", 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 5)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 5)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

-- 50cm weld
content.add(content.Recipe {
    id = "bot_eyebot",
    result = "bot_eyebot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("ai_module", 1)
    :component("identification_module", 1)
    :component("pathfinding_module", 1)
    :component("sensor_module", 1)
    :component("small_storage_battery", 1)
    :component("RAM", 1)
    :component("processor", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("lens", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 3)
    :requirement("welding_standard", 50)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 4)
    :learn_by_disassembly("electronics", 5)
    :book("schematics_eyebot", 7)
)

content.add(content.Recipe {
    id = "bot_shock_mine",
    result = "bot_shock_mine",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("sensor_module", 1)
    :component("afs_material_1", 10)
    :component("scrap", 2)
    :component("power_supply", 1)
    :component("afs_energy_storage_3", 1)
    :component("canister_empty", 1)
    :component("cable", 20)
    :component("afs_heat_1", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 3)
    :learn_by_disassembly("electronics", 6)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_copbot",
    result = "bot_copbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 780000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("android_arms", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("tazer", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_copbot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_riotbot",
    result = "bot_riotbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("android_arms", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("canister_empty", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_riotbot", 7)
)

content.add(content.Recipe {
    id = "bot_manhack",
    result = "bot_manhack",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("spike", 2)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "nano_forge",
    result = "nano_forge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "welder", charges = 400 },
            { id = "welder_crude", charges = 600 },
            { id = "integrated_welder", charges = 600 },
            { id = "soldering_iron", charges = 600 },
            { id = "soldering_iron_portable", charges = 600 },
            { id = "oxy_torch", charges = 80 }
        })
    :component("afs_material_4", 8)
    :component("afs_material_2", 12)
    :component("cable", 14)
    :component("afs_magnet_3", 4)
    :component("afs_magnet_2", 12)
    :component("afs_circuitry_1", 20)
    :component("afs_magnet_3", 4)
    :component("ai_module_advanced", 1)
    :component("afs_circuitry_3", 1)
    :component("afs_energy_storage_1", 4)
    :component("afs_energy_storage_2", 3)
    :component("afs_energy_storage_3", 1)
    :component("afs_circuitry_2", 5)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :learn_by_disassembly("fabrication", 4)
    :book("schematics_nano_forge", 6)
    :book("recipes_cryolab", 9)
    :book("recipe_augs", 9)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "diamond_press",
    result = "diamond_press",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "welder", charges = 300 },
            { id = "welder_crude", charges = 450 },
            { id = "integrated_welder", charges = 450 },
            { id = "soldering_iron", charges = 450 },
            { id = "soldering_iron_portable", charges = 450 },
            { id = "oxy_torch", charges = 60 }
        })
    :component("afs_material_3", 8)
    :component("afs_material_2", 12)
    :component("afs_material_1", 28)
    :component("cable", 14)
    :component("afs_magnet_3", 8)
    :component("afs_magnet_2", 12)
    :component("afs_circuitry_1", 20)
    :component("afs_magnet_3", 4)
    :component("ai_module_basic", 1)
    :component("afs_circuitry_3", 1)
    :component("afs_energy_storage_1", 2)
    :component("afs_energy_storage_2", 2)
    :component("afs_energy_storage_3", 1)
    :component("afs_circuitry_2", 3)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :learn_by_disassembly("fabrication", 4)
    :book("schematics_diamond_press", 7)
    :book("recipes_cryolab", 9)
    :book("recipe_augs", 9)
    :proficiency("prof_metalworking")
)
