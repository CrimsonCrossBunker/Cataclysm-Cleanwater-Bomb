local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "pebble",
    result = "pebble",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
    result_multiplier = 10,
}
    :component_any({
            { id = "rock", count = 1 },
            { id = "rock_flaking_any", count = 1, requirement = true }
        })
    :quality("HAMMER", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "pebble_clay",
    result = "pebble_clay",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "fake_clay_kiln", charges = 10 },
            { id = "kiln", charges = 10 },
            { id = "surface_heat", charges = 10, requirement = true }
        })
    :component("any_water", 1, true)
    :component("clay_lump", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "marble",
    result = "marble",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 25)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "test_tube", count = 2 }
        })
    :book("glassblowing_book", 4)
    :proficiency("prof_glassblowing")
    :result_charges(25)
)

content.add(content.Recipe {
    id = "bearing",
    result = "bearing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "weights", count = 34, requirement = true },
            { id = "steel_chunk_any", count = 2, requirement = true }
        })
    :requirement("forging_standard", 2)
    :requires_skill("gun", 4)
    :book("textbook_fabrication", 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "wood_atlatl_spear",
    result = "wood_atlatl_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "bronze_atlatl_spear",
    result = "bronze_atlatl_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("bronze_tiny", 2, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :requires_skill("survival", 1)
    :book("textbook_mesoam", 5)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "steel_atlatl_spear",
    result = "steel_atlatl_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 2, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requires_skill("survival", 1)
    :book("textbook_mesoam", 5)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "blun_lead_shot",
    result = "blun_lead_shot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 20)
    :component("lead", 24)
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "blun_shot",
    result = "blun_shot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 20)
    :component_any({
            { id = "bb", count = 24 },
            { id = "clockworks", count = 1 },
            { id = "pebble", count = 16 },
            { id = "bearing", count = 16 }
        })
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "blun_shot_using_big_scrap",
    result = "blun_shot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    name = content.text("%s using big scrap"),
}
    :component("chem_black_powder", 20)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 8, requirement = true },
            { id = "copper", count = 16 }
        })
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "blun_slug_using_lead",
    result = "blun_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    name = content.text("%s using lead"),
}
    :component("chem_black_powder", 20)
    :component("lead", 24)
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requirement("surface_heat", 2)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "blun_flechette",
    result = "blun_flechette",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("chem_black_powder", 20)
    :component_any({
            { id = "nails", count = 8, requirement = true },
            { id = "combatnail", count = 8 }
        })
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("gun", 1)
    :book("recipe_bullets", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_handloading")
)

content.add(content.Recipe {
    id = "napalm",
    result = "napalm",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "gasoline", count = 125 },
            { id = "diesel", count = 125 },
            { id = "biodiesel", count = 125 }
        })
    :component("plastic_chunk", 4)
    :component("bleach", 250)
    :component("oxy_powder", 15)
    :component("lye_powder", 15)
    :quality("CHEM", 2, 1)
    :book("textbook_gaswarfare", 8)
    :book("textbook_anarch", 7, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("recipe_labchem", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(250)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_lye_and_rosin",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component("lye_powder", 7)
    :component("rosin", 13)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(70, 5)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_lye_alcohol_tallow",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 222000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component("lye_powder", 7)
    :component_any({
            { id = "chem_ethanol", count = 25 },
            { id = "disinfectant", count = 1 }
        })
    :component("any_tallow", 5, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(70, 5)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_lye_alcohol_tallow_substitute",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 222000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component("lye_powder", 14)
    :component_any({
            { id = "chem_ethanol", count = 25 },
            { id = "disinfectant", count = 1 }
        })
    :component_any({
            { id = "cooking_oil", count = 10 },
            { id = "any_butter", count = 16, requirement = true }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(70, 5)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_alcohol_soap",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component_any({
            { id = "chem_ethanol", count = 14 },
            { id = "disinfectant", count = 1 }
        })
    :component_any({
            { id = "soap", count = 12 },
            { id = "soap_flakes", count = 32 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(70, 5)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_wax",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 4, true)
    :component_any({
            { id = "gasoline", count = 1000 },
            { id = "avgas", count = 1000 }
        })
    :component_any({
            { id = "wax", count = 1 },
            { id = "wax_paraffin", count = 1 }
        })
    :component_any({
            { id = "soap", count = 12 },
            { id = "soap_flakes", count = 32 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(50, 5)
    :result_charges(1000)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_blood",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component("any_blood", 2, true)
    :component_any({
            { id = "salt", count = 3 },
            { id = "coffee_raw", count = 1 },
            { id = "tea_bag", count = 2 },
            { id = "tea_raw", count = 2 },
            { id = "tea_green_raw", count = 2 },
            { id = "tea_green_bag", count = 2 },
            { id = "sugar", count = 3 },
            { id = "material_limestone", count = 3 },
            { id = "chem_caco3", count = 50 },
            { id = "chem_baking_soda", count = 15 }
        })
    :quality("CONTAIN", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("improvised_munition_handbook", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(80, 3)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "gelled_gasoline_from_styrofoam",
    result = "gelled_gasoline",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :component_any({
            { id = "gasoline", count = 500 },
            { id = "avgas", count = 500 }
        })
    :component("material_styrofoam_chunk", 60)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :batch_discount(70, 5)
    :result_charges(500)
)

content.add(content.Recipe {
    id = "flamethrower_fuel",
    result = "flamethrower_fuel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component("gasoline", 125)
    :component_any({
            { id = "diesel", count = 125 },
            { id = "biodiesel", count = 125 }
        })
    :quality("CONTAIN", 1, 1)
    :book("textbook_gaswarfare", 2)
    :book("textbook_anarch", 2, { name = content.text("Stuff THE MAN doesn't want you to know") })
    :book("manual_launcher", 2)
    :proficiency("prof_intro_chemistry")
    :batch_discount(80, 5)
    :result_charges(250)
)

-- At least basic knowledge on chemical handling safety is required.
content.add(content.Recipe {
    id = "spiked_rocket",
    result = "spiked_rocket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "oxy_torch", charges = 6 },
            { id = "welder", charges = 30 },
            { id = "welding_kit", charges = 30 },
            { id = "welder_crude", charges = 45 },
            { id = "integrated_welder", charges = 45 }
        })
    :tool_any({
            { id = "hotplate", charges = 50 },
            { id = "integrated_welder", charges = 50 }
        })
    :component("pipe", 2)
    :component("spike", 1)
    :component_any({
            { id = "tool_rocket_candy", count = 3 },
            { id = "chem_rocket_fuel", count = 15 }
        })
    :component("scrap", 3)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :book("manual_launcher", 4)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

-- At least basic knowledge on chemical handling safety is required.
content.add(content.Recipe {
    id = "explosive_hm_rocket",
    result = "explosive_hm_rocket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "hotplate", charges = 50 },
            { id = "integrated_welder", charges = 50 }
        })
    :component("pipe", 2)
    :component_any({
            { id = "gunpowder", count = 300 },
            { id = "chem_black_powder", count = 300 }
        })
    :component_any({
            { id = "tool_rocket_candy", count = 2 },
            { id = "chem_rocket_fuel", count = 10 }
        })
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :book("manual_launcher", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_handloading")
    :result_charges(1)
)

-- At least basic knowledge on chemical handling safety is required.
content.add(content.Recipe {
    id = "incendiary_hm_rocket",
    result = "incendiary_hm_rocket",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "hotplate", charges = 50 },
            { id = "integrated_welder", charges = 50 }
        })
    :component("pipe", 2)
    :component("chem_thermite", 50)
    :component("plastic_chunk", 5)
    :component_any({
            { id = "tool_rocket_candy", count = 2 },
            { id = "chem_rocket_fuel", count = 10 }
        })
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :book("manual_launcher", 6)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "gas_fungicidal",
    result = "gas_fungicidal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "fungicide", count = 50 },
            { id = "triffid_fungicide", count = 1 }
        })
    :component("chem_sulphur", 150)
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 2)
    :book("textbook_gaswarfare", 4)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "gas_insecticidal",
    result = "gas_insecticidal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 5, true)
    :component("insecticide", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 2)
    :book("textbook_gaswarfare", 4)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "gas_chloramine",
    result = "gas_chloramine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :component("bleach", 125)
    :component("ammonia_hydroxide", 1)
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 2)
    :book("textbook_gaswarfare", 3)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 3)
    :book("recipe_labchem", 3)
    :book("textbook_anarch", 3)
    :proficiency("prof_intro_chemistry")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "tinder",
    result = "tinder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("soft %s"),
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "splinter", count = 2 },
            { id = "pinecone", count = 2 },
            { id = "pine_bough", count = 1 },
            { id = "cotton_patchwork", count = 1 },
            { id = "paper", count = 5 },
            { id = "cardboard", count = 1 },
            { id = "rolling_paper", count = 30 },
            { id = "wrapper", count = 5 },
            { id = "withered", count = 2 },
            { id = "cattail_stalk", count = 1 },
            { id = "birchbark", count = 1 },
            { id = "willowbark", count = 1 },
            { id = "straw_pile", count = 1 }
        })
    :quality("CUT", 2, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "tinder_softer",
    result = "tinder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("softer %s"),
}
    :component_any({
            { id = "splinter", count = 2 },
            { id = "pinecone", count = 2 },
            { id = "withered", count = 2 },
            { id = "cattail_stalk", count = 1 }
        })
    :quality("CUT", 1, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "tinder_softest",
    result = "tinder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("softest %s"),
}
    :component_any({
            { id = "pine_bough", count = 1 },
            { id = "cotton_patchwork", count = 1 },
            { id = "paper", count = 5 },
            { id = "cardboard", count = 1 },
            { id = "rolling_paper", count = 30 },
            { id = "wrapper", count = 5 },
            { id = "straw_pile", count = 1 }
        })
    :result_charges(50)
)
