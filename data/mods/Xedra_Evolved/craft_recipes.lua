local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "extra_str_aspirin",
    result = "extra_str_aspirin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_ethanol", 1)
    :component("aspirin", 1)
    :component("faewild", 1)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 1)
    :book("alchemy_recipe_extra_str_aspirin", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(20)
)

content.add(content.Recipe {
    id = "small_blessing_brigit",
    result = "small_blessing_brigit",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("water_clean", 1)
    :component("corpse_ash", 1)
    :component("poppy_bud", 1)
    :component("royal_jelly", 1)
    :quality("CHEM", 2, 1)
    :requires_skill("cooking", 1)
    :book("alchemy_recipe_small_blessing_brigit", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "blackout_rage_drink",
    result = "blackout_rage_drink",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("energy_drink", 3)
    :component_any({
            { id = "vodka", count = 3 },
            { id = "tequila", count = 3 }
        })
    :component("lotus_blossom", 1)
    :book("alchemy_recipe_blackout_rage_drink", 3)
    :batch_discount(50, 4)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "sixdust",
    result = "sixdust",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
    result_multiplier = 20,
}
    :tool_charges("surface_heat", 50, true)
    :tool_charges("electrolysis_kit", 200)
    :tool("chem_sulphuric_acid", 1)
    :tool("chem_muriatic_acid", 1)
    :tool("chem_antimony_trichloride", 1)
    :tool("chem_ferric_chloride", 1)
    :tool("silver_small", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_ethanol", 46)
    :component("salt_water", 4)
    :component("chem_benzene", 90)
    :component_any({
            { id = "disinfectant", count = 20 },
            { id = "oxy_powder", count = 100 }
        })
    :component("bleach", 5)
    :component("wyld_candy", 2)
    :quality("CHEM", 2, 1)
    :book("alchemy_recipe_sixdust", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "prophets_lsd",
    result = "prophets_lsd",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 50, true)
    :tool_charges("electrolysis_kit", 200)
    :tool("chem_sulphuric_acid", 1)
    :tool("chem_muriatic_acid", 1)
    :tool("chem_antimony_trichloride", 1)
    :tool("chem_ferric_chloride", 1)
    :tool("silver_small", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_ethanol", 46)
    :component("lsd", 4)
    :component("fae_meat", 1)
    :component("chem_benzene", 90)
    :component("oxy_powder", 100)
    :component("scrap_dreamdross", 5)
    :component("lotus_blossom", 2)
    :quality("CHEM", 2, 1)
    :book("alchemy_recipe_prophets_lsd", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "truckers_stamina_pills",
    result = "truckers_stamina_pills",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_ethanol", 1)
    :component("scrap_dreamdross", 3)
    :component("truckstop_viagra", 10)
    :component("faewild", 10)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 1)
    :book("alchemy_recipe_truckers_stamina_pills", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "charm_of_marzanna",
    result = "charm_of_marzanna",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :tool_charges("surface_heat", 50, true)
    :component("silver_necklace", 1)
    :component("scrap_dreamdross", 5)
    :component("water_clean", 1)
    :component("chem_ethanol", 100)
    :component("charcoal", 50)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_charm_of_marzanna", 2)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "dream_bezoar",
    result = "dream_bezoar",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("bezoar", 1)
    :component("mugwort", 3)
    :component("water_clean", 1)
    :component("chem_ethanol", 100)
    :component("lotus_blossom", 1)
    :quality("CHEM", 2, 1)
    :requires_skill("deduction", 1)
    :book("mag_deduction_tabloid", 2)
    :book("mag_deduction", 1)
)

content.add(content.Recipe {
    id = "spiritshow_dust",
    result = "spiritshow_dust",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("faewild", 1)
    :component("scrap_dreamdross", 2)
    :component("bone", 1)
    :component("corpse_ash", 1)
    :requires_skill("deduction", 2)
    :book("alchemy_recipe_spiritshow_dust", 2)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "nether_snare",
    result = "nether_snare",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("paint_brush", 1)
    :tool_charges("paint", 1, true)
    :component("scrap_dreamdross", 3)
    :component("mutant_blood", 1)
    :component("silver_small", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_nether_snare", 3)
)

content.add(content.Recipe {
    id = "feline_periapta",
    result = "feline_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("feline_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_feline_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "lupine_periapta",
    result = "lupine_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("lupine_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_lupine_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "väinämöinens_kantele_imitation",
    result = "väinämöinens_kantele_imitation",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 402000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("luthier_toolset", 1)
    :component("kantele", 1)
    :component("scrap_dreamdross", 5)
    :component("fish_sample", 3)
    :requires_skill("deduction", 3)
    :book("alchemy_recipe_väinämöinens_kantele_imitation", 3)
    :proficiency("prof_luthier_basic", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "cephalopod_periapta",
    result = "cephalopod_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("cephalopod_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_cephalopod_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "butterfly_periapta",
    result = "butterfly_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("insect_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_butterfly_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "scorpion_periapta",
    result = "scorpion_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("insect_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_scorpion_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "spider_periapta",
    result = "spider_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("spider_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_spider_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "plant_periapta",
    result = "plant_periapta",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool("metal_file", 1)
    :component("gold_necklace", 1)
    :component("scrap_dreamdross", 3)
    :component("plant_sample", 1)
    :component("diamond", 1)
    :requires_skill("deduction", 1)
    :book("alchemy_recipe_plant_periapta", 3)
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "life_extension_potion",
    result = "life_extension_potion",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_sulphur", 1)
    :component("chem_manganese_dioxide", 1)
    :component("xe_elder_ginseng", 1)
    :component("water", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 4)
    :book("alchemy_recipe_life_extension_potion", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "gender_potion",
    result = "gender_potion",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "testosterone", count = 5 },
            { id = "estrogen", count = 10 },
            { id = "birth_control", count = 30 }
        })
    :component("protein_powder", 30)
    :component("royal_jelly", 2)
    :component("water", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "xe_alchemy_powder_of_revelation",
    result = "xe_alchemy_powder_of_revelation",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    flags = { "SECRET" },
}
    :tool_charges("water_boiling_heat", 120, true)
    :component("clay_lump", 1)
    :component_any({
            { id = "edible_blood", count = 6, requirement = true },
            { id = "blank_blood", count = 1 }
        })
    :component("water_clean", 5)
    :component("corpse_ash", 2)
    :quality("BOIL", 1, 1)
    :requires_skill("deduction", 4)
    :book("alchemy_recipe_powder_of_revelation", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

content.add(content.Recipe {
    id = "potion_dex",
    result = "potion_dex",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_sulphur", 1)
    :component("chem_manganese_dioxide", 1)
    :component_any({
            { id = "feline_sample", count = 1 },
            { id = "lupine_sample", count = 1 },
            { id = "batrachian_sample", count = 1 }
        })
    :component("water", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 4)
    :book("alchemy_recipe_potion_dex", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "potion_strength",
    result = "potion_strength",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_sulphur", 1)
    :component("chem_manganese_dioxide", 1)
    :component_any({
            { id = "cattle_sample", count = 1 },
            { id = "ursine_sample", count = 1 },
            { id = "beast_sample", count = 1 }
        })
    :component("water", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 4)
    :book("alchemy_recipe_potion_strength", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "hares_leap_potion",
    result = "hares_leap_potion",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_sulphur", 1)
    :component("chem_manganese_dioxide", 1)
    :component_any({
            { id = "batrachian_sample", count = 1 },
            { id = "rabbit_sample", count = 1 }
        })
    :component("water", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 4)
    :book("alchemy_recipe_hares_leap_potion", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "doll_imbuement",
    result = "doll_imbuement",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool("mirror", 1)
    :tool("mortar_pestle", 1)
    :component("blood", 1)
    :component("fae_blood", 1)
    :component("homullus_sample", 5)
    :component("faewild", 5)
    :component("scrap_dreamdross", 5)
    :requires_skill("deduction", 5)
    :book("alchemy_recipe_doll_imbuement", 7)
)

content.add(content.Recipe {
    id = "plant_imbuement",
    result = "plant_imbuement",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool("bowl_wood", 1)
    :tool("mortar_pestle", 1)
    :component("blood", 1)
    :component("fae_blood", 1)
    :component("arvore_sample", 5)
    :component("faewild", 5)
    :component("scrap_dreamdross", 5)
    :component_any({
            { id = "leaves", count = 10 },
            { id = "young_leaves", count = 10 },
            { id = "grape_leaves", count = 10 }
        })
    :requires_skill("deduction", 5)
    :book("alchemy_recipe_plant_imbuement", 7)
)

content.add(content.Recipe {
    id = "fire_imbuement",
    result = "fire_imbuement",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool("fire", 1)
    :tool("mortar_pestle", 1)
    :component("blood", 1)
    :component("fae_blood", 1)
    :component("salamander_sample", 5)
    :component("faewild", 5)
    :component("scrap_dreamdross", 5)
    :component_any({
            { id = "ash", count = 5 },
            { id = "corpse_ash", count = 5 }
        })
    :requires_skill("deduction", 5)
    :book("alchemy_recipe_fire_imbuement", 7)
)

content.add(content.Recipe {
    id = "moon_tear_chain_link_fabrication",
    result = "moon_tear_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("moon_tear_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(150)
)

content.add(content.Recipe {
    id = "moon_tears_fasteners",
    result = "moon_tears_fasteners",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("hotcut", 1)
    :component("moon_tear_ingot", 1)
    :component("scrap_dreamdross", 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "moon_tear_wire",
    result = "moon_tear_wire",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
}
    :component("moon_tear_ingot", 1)
    :requirement("blacksmithing_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
)

content.add(content.Recipe {
    id = "moon_tear_wire_wire_draw_machine",
    result = "moon_tear_wire",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
}
    :tool("tongs", 1)
    :tool("hotcut", 1)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("moon_tear_ingot", 1)
    :quality("ANVIL", 3, 1)
    :quality("FEY_HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
)

content.add(content.Recipe {
    id = "moon_tear_ingot",
    result = "moon_tear_ingot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("casting_mold", 1)
    :component("scrap_moon_tears", 140)
    :requirement("forging_standard", 1)
    :requirement("fey_smithing_tools", 1)
    :book("book_moons_tears_ingot", 2)
)

-- moon's tears recipes based on the hardened steel line of recipes.  They require the moon's tears
-- proficiency instead of case hardening
content.add(content.Recipe {
    id = "moons_tears_knife_baselard",
    result = "moons_tears_knife_baselard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2340000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    flags = { "SECRET" },
}
    :tool("casting_mold", 1)
    :component("cordage_short", 2, true)
    :component("moon_tear_ingot", 1)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component("adhesive", 2, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "moons_tears_broadsword",
    result = "moons_tears_broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :tool("casting_mold", 1)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "moons_tears_arming_sword",
    result = "moons_tears_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :tool("casting_mold", 1)
    :component("leather", 2)
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "moons_tears_mace",
    result = "moons_tears_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :component("moon_tear_ingot", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
    :proficiency("prof_moonstearssmithing")
)

content.add(content.Recipe {
    id = "moons_tears_scimitar",
    result = "moons_tears_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :component("leather", 2)
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "moons_tears_estoc",
    result = "moons_tears_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7260000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :component("leather", 4)
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_moonstearssmithing")
)

content.add(content.Recipe {
    id = "moons_tears_spear",
    result = "moons_tears_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :component("spear_shaft", 1)
    :component("moon_tear_ingot", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "moons_tears_battleaxe",
    result = "moons_tears_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
    flags = { "SECRET" },
}
    :tool_any({
            { id = "hotcut_any", charges = 1, requirement = true },
            { id = "drift", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_moonstearssmithing")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "moons_tears_katana",
    result = "moons_tears_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
    flags = { "SECRET" },
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("moon_tear_ingot", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("fey_smithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_moonstearssmithing")
)

content.add(content.Recipe {
    id = "tanning_glimmer_pelt_modern",
    result = "tanning_glimmer_pelt",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component_any({
            { id = "lye_powder", count = 10 },
            { id = "aspirin", count = 10 }
        })
    :component("cured_glimmer_pelt", 6)
    :quality("CHEM", 1, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 3)
    :book("textbook_survival", 6)
    :book("textbook_chemistry", 4)
    :book("modern_tanner", 4)
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "tanning_glimmer_pelt_primitive",
    result = "tanning_glimmer_pelt",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component("tanning_agent", 1, true)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 },
            { id = "salt", count = 10 }
        })
    :component("edible_tallow", 2, true)
    :component("cured_glimmer_pelt", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("chemistry", 2)
    :book("textbook_survival", 6)
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "cold_iron_ingot",
    result = "cold_iron_ingot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    flags = { "SECRET" },
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("wax", 1)
    :component("lamp_oil", 5)
    :component_any({
            { id = "scrap_dreamdross", count = 1 },
            { id = "holy_symbol", count = 2 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("alchemy_recipe_cold_iron_ingot", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "cold_iron_warhammer",
    result = "cold_iron_warhammer",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool("drift", 1)
    :component("cold_iron_ingot", 4)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "cold_iron_arming_sword",
    result = "cold_iron_arming_sword",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool("tongs", 1)
    :tool("hotcut", 1)
    :component("cold_iron_ingot", 2)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("tailoring_leather_patchwork_simple", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "cold_iron_battleaxe",
    result = "cold_iron_battleaxe",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
    flags = { "SECRET" },
}
    :tool_any({
            { id = "hotcut", count = 1 },
            { id = "drift", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("cold_iron_ingot", 4)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :proficiency("prof_metalworking", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
    :proficiency("prof_blacksmithing", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
    :proficiency("prof_bladesmith", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "cold_iron_knife",
    result = "cold_iron_knife",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 2340000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    flags = { "SECRET" },
}
    :tool_any({
            { id = "tongs", count = 1 },
            { id = "metalworking_tongs", count = 1 }
        })
    :tool("casting_mold", 1)
    :component("cordage_short", 2, true)
    :component("cold_iron_ingot", 1)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component("adhesive", 2, true)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "blood_of_saints",
    result = "blood_of_saints",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("small_relic", 2)
    :component_any({
            { id = "bleach", count = 2 },
            { id = "oxy_powder", count = 200 }
        })
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "lye_powder", count = 100 }
        })
    :component("mercury", 1)
    :component("silver_small", 3)
    :component("gold_small", 1)
    :requirement("mutagen_production_standard", 25)
    :requires_skill("deduction", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "dreamforged_nail",
    result = "dreamforged_nail",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "scrap_dreamdross", count = 100 },
            { id = "dreamdross_lump", count = 10 }
        })
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_ballistic_plate",
    result = "dreamforged_ballistic_plate",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
)

content.add(content.Recipe {
    id = "dreamforged_ballistic_plate_small",
    result = "dreamforged_ballistic_plate_small",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 1800000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
)

content.add(content.Recipe {
    id = "dreamforged_helmet_berserker",
    result = "dreamforged_helmet_berserker",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 9000000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_armguard_plate_berserk",
    result = "dreamforged_armguard_plate_berserk",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 10440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 3)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_boots_berserk",
    result = "dreamforged_boots_berserk",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 9720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 3)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_fullhelmet_arcane",
    result = "dreamforged_fullhelmet_arcane",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 11880000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 3)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_armguard_plate_gunslinger",
    result = "dreamforged_armguard_plate_gunslinger",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 19440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 3)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_armor")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "223_casing_from_dreamdross",
    result = "223_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

-- Scrap dreamdross is 5 grams.  Charges is based on the difference between that 5 grams and the weight of a
-- given casing.  Note for later, all casings should be learned from a single Dreamsmith encounter or there
-- should be a research project and after completion all are learned.
content.add(content.Recipe {
    id = "22_casing_from_dreamdross",
    result = "22_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "3006_casing_from_dreamdross",
    result = "3006_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "123ln_casing_from_dreamdross",
    result = "123ln_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "33_naval_casing_from_dreamdross",
    result = "33_naval_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 16)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "270win_casing_from_dreamdross",
    result = "270win_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "303_casing_from_dreamdross",
    result = "303_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "300_casing_from_dreamdross",
    result = "300_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "308_casing_from_dreamdross",
    result = "308_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "762_51_casing_from_dreamdross",
    result = "762_51_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "32_casing_from_dreamdross",
    result = "32_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "38_casing_from_dreamdross",
    result = "38_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "38super_casing_from_dreamdross",
    result = "38super_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "40_casing_from_dreamdross",
    result = "40_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "10mm_casing_from_dreamdross",
    result = "10mm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "44_casing_from_dreamdross",
    result = "44_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "454_casing_from_dreamdross",
    result = "454_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(45, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "45_casing_from_dreamdross",
    result = "45_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "45colt_casing_from_dreamdross",
    result = "45colt_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "4570_casing_from_dreamdross",
    result = "4570_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "50beowulf_casing_from_dreamdross",
    result = "50beowulf_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 5500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "450_casing_from_dreamdross",
    result = "450_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 5500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "500_casing_from_dreamdross",
    result = "500_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :component("500_casing", 1)
    :requires_skill("gun", 5)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "50_casing_from_dreamdross",
    result = "50_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :component("50_casing", 1)
    :requires_skill("gun", 5)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "338lapua_casing_from_dreamdross",
    result = "338lapua_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :component("338lapua_casing", 1)
    :requires_skill("gun", 5)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "545_casing_from_dreamdross",
    result = "545_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "57mm_casing_from_dreamdross",
    result = "57mm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "458wm_casing_from_dreamdross",
    result = "458wm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 1)
    :component("458wm_casing", 1)
    :requires_skill("gun", 5)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(60)
)

content.add(content.Recipe {
    id = "762R_casing_from_dreamdross",
    result = "762R_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "762_casing_from_dreamdross",
    result = "762_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "762_25_casing_from_dreamdross",
    result = "762_25_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "9mm_casing_from_dreamdross",
    result = "9mm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "357sig_casing_from_dreamdross",
    result = "357sig_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "357mag_casing_from_dreamdross",
    result = "357mag_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "9x18mm_casing_from_dreamdross",
    result = "9x18mm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "9x21mm_casing_from_dreamdross",
    result = "9x21mm_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "380_casing_from_dreamdross",
    result = "380_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(9)
)

content.add(content.Recipe {
    id = "300blk_casing_from_dreamdross",
    result = "300blk_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "30carbine_casing_from_dreamdross",
    result = "30carbine_casing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CASINGS",
    duration_moves = 7500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :proficiency("prof_dreamsmithing")
    :batch_discount(30, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dreamforged_hacksaw",
    result = "dreamforged_hacksaw",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1080000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("dreamdross_lump", 5)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_hammer",
    result = "dreamforged_hammer",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("dreamdross_lump", 7)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_halligan",
    result = "dreamforged_halligan",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("dreamdross_lump", 11)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_pliers_locking",
    result = "dreamforged_pliers_locking",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1800000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("dreamdross_lump", 5)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_pickaxe",
    result = "dreamforged_pickaxe",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 6)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_picklocks",
    result = "dreamforged_picklocks",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 2520000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("dreamdross_lump", 2)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_scalpel",
    result = "dreamforged_scalpel",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1800000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 6)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_e_tool",
    result = "dreamforged_e_tool",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_ax",
    result = "dreamforged_ax",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 4)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_bed_of_restful_repose",
    result = "dreamforged_bed_of_restful_repose",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 9)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "xedra_dreamsmith_time_trap",
    result = "xedra_dreamsmith_time_trap",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "xedra_dreamsmith_time_watch",
    result = "xedra_dreamsmith_time_watch",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 8640000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 24)
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamdross_bo",
    result = "dreamdross_bo",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 1440000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component_any({
            { id = "dreamdross_lump", count = 2 },
            { id = "scrap_dreamdross", count = 20 }
        })
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "plank_long", count = 1 },
            { id = "long_pole", count = 1 }
        })
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamdross_knife",
    result = "dreamdross_knife",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component_any({
            { id = "dreamdross_lump", count = 2 },
            { id = "scrap_dreamdross", count = 20 }
        })
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_large", count = 1 }
        })
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamdross_club",
    result = "dreamdross_club",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 1080000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "dreamdross_lump", count = 2 },
            { id = "scrap_dreamdross", count = 20 }
        })
    :component_any({
            { id = "hammer", count = 1 },
            { id = "pipe", count = 1 },
            { id = "rebar", count = 1 }
        })
    :proficiency("prof_dreamsmithing")
)

content.add(content.Recipe {
    id = "dreamforged_longbow",
    result = "dreamforged_longbow",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
)

content.add(content.Recipe {
    id = "arrow_dreamforged",
    result = "arrow_dreamforged",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 18000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
)

content.add(content.Recipe {
    id = "dreamforged_crossbow",
    result = "dreamforged_crossbow",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
)

content.add(content.Recipe {
    id = "bolt_dreamforged",
    result = "bolt_dreamforged",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 18000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
)

-- TODO: proficiency for conditional powered items
content.add(content.Recipe {
    id = "dreamforged_knuckle_berserk",
    result = "dreamforged_knuckle_berserk",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 9360000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 4)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_glaive_healing",
    result = "dreamforged_glaive_healing",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 12960000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 6)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_tsurugi_speed",
    result = "dreamforged_tsurugi_speed",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 9000000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 2)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "dreamforged_q_staff_exp",
    result = "dreamforged_q_staff_exp",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 9720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("forged_dreamstuff_ingot", 6)
    :quality("DREAM_HAMMER", 1, 1)
    :proficiency("prof_dreamsmithing")
    :proficiency("prof_dreamsmithing_weapon")
    :proficiency("prof_dreamsmithing_peak")
)

content.add(content.Recipe {
    id = "mutagen_earthkin",
    result = "mutagen_earthkin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "arvore_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :component_any({
            { id = "arvore_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("earthkin_tablet", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "mutagen_plantkin",
    result = "mutagen_plantkin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("plantkin_parchment", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "mutagen_flamekin",
    result = "mutagen_flamekin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "arvore_sample", count = 1 }
        })
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "arvore_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("flametouched_parchment", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "mutagen_waterkin",
    result = "mutagen_waterkin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "arvore_sample", count = 1 },
            { id = "ierde_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :component_any({
            { id = "arvore_sample", count = 1 },
            { id = "ierde_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("waterkin_tablet", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "mutagen_dollkin",
    result = "mutagen_dollkin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "arvore_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "arvore_sample", count = 1 },
            { id = "sylph_sample", count = 1 },
            { id = "salamander_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("dollkin_tablet", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "mutagen_airkin",
    result = "mutagen_airkin",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("water", 3)
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "salamander_sample", count = 1 },
            { id = "arvore_sample", count = 1 }
        })
    :component_any({
            { id = "ierde_sample", count = 1 },
            { id = "undine_sample", count = 1 },
            { id = "homullus_sample", count = 1 },
            { id = "salamander_sample", count = 1 },
            { id = "arvore_sample", count = 1 }
        })
    :quality("SACRIFICE", 1, 1)
    :book("sylph_parchment", 0)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "elemental_mana_draught",
    result = "elemental_mana_draught",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 10, true)
    :tool("mortar_pestle", 1)
    :component("water", 1)
    :component("material_soil", 1)
    :component("scrap_dreamdross", 6)
    :quality("SACRIFICE", 1, 1)
    :book("sylph_parchment", 0)
    :book("dollkin_tablet", 0)
    :book("plantkin_parchment", 0)
    :book("waterkin_tablet", 0)
    :book("flametouched_parchment", 0)
    :book("earthkin_tablet", 0)
    :batch_discount(80, 20)
)

-- General rule is gossamer clothing takes 50% longer to make than equivalent cotton clothing.
content.add(content.Recipe {
    id = "tunic_gossamer",
    result = "tunic_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 408000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 8)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "sleeveless_tunic_gossamer",
    result = "sleeveless_tunic_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("tunic_gossamer", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "doublet_gossamer",
    result = "doublet_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 7,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 38)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "dress_gossamer",
    result = "dress_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1890000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 120000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 20)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "gown_gossamer",
    result = "gown_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 30)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
)

content.add(content.Recipe {
    id = "cloak_gossamer",
    result = "cloak_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 7,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 34)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
)

content.add(content.Recipe {
    id = "jacket_light_gossamer",
    result = "jacket_light_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 7,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 35)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "robe_wizard_gossamer",
    result = "robe_wizard_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :requirement("tailoring_cotton_patchwork", 42)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
)

content.add(content.Recipe {
    id = "gloves_light_gossamer",
    result = "gloves_light_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 210000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 4)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "loincloth_gossamer",
    result = "loincloth_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
    flags = { "SECRET" },
}
    :requirement("cordage_short", 1)
    :requirement("tailoring_gossamer_patchwork", 2)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "pants_gossamer",
    result = "pants_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 20)
    :requirement("fastener_small", 3)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "pants_no_pocket_gossamer",
    result = "pants_no_pocket_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 210000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 18)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "skirt_gossamer",
    result = "skirt_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 7)
    :requirement("fastener_small", 1)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "skirt_long_gossamer",
    result = "skirt_long_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 10)
    :requirement("fastener_small", 1)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "socks_gossamer",
    result = "socks_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 1)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "stockings_gossamer",
    result = "stockings_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 3)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "slippers_gossamer",
    result = "slippers_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
    flags = { "SECRET" },
}
    :requirement("tailoring_gossamer_patchwork", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
)

content.add(content.Recipe {
    id = "sheet_gossamer_patchwork",
    result = "sheet_gossamer_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("gossamer_patchwork", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "gambeson_hood_gossamer",
    result = "gambeson_hood_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("sheet", 1)
    :component("gambeson_batting_gossamer", 2)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 30)
    :requirement("fastener_small", 2)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "gambeson_pants_gossamer",
    result = "gambeson_pants_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("sheet", 4)
    :component("gambeson_batting_gossamer", 21)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 100)
    :requirement("fastener_small", 5)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- basically just anything you can fit inside some sheets as stuffing to make a gambeson more cheaply
content.add(content.Recipe {
    id = "gambeson_batting_gossamer",
    result = "gambeson_batting_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    flags = { "SECRET" },
    result_multiplier = 4,
}
    :component_any({
            { id = "scrap_gossamer", count = 200 },
            { id = "gossamer_patchwork", count = 40 },
            { id = "sheet_gossamer_patchwork", count = 40 }
        })
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_shade_arms",
    result = "gracken_shade_arms",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 2)
    :component("sinew", 5)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_strong_arms",
    result = "gracken_strong_arms",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("sinew", 40)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_long_arms",
    result = "gracken_long_arms",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("grappler_sinew", 1)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_shade_hands",
    result = "gracken_shade_hands",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 2)
    :component_any({
            { id = "mutant_meat", count = 2 },
            { id = "meat_tainted", count = 2 },
            { id = "meat", count = 2 }
        })
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_sharp_nails",
    result = "gracken_sharp_nails",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component_any({
            { id = "bone", count = 2 },
            { id = "bone_tainted", count = 2 }
        })
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_dextrous_hands",
    result = "gracken_dextrous_hands",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("grappler_sinew", 1)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_carnivorous_stomach",
    result = "gracken_carnivorous_stomach",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component_any({
            { id = "carnivore_stomach", count = 2 },
            { id = "small_carnivore_stomach", count = 4 }
        })
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_herbivorous_stomach",
    result = "gracken_herbivorous_stomach",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component_any({
            { id = "herbivore_stomach", count = 2 },
            { id = "small_herbivore_stomach", count = 4 }
        })
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_omnivorous_stomach",
    result = "gracken_omnivorous_stomach",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component_any({
            { id = "omnivore_stomach", count = 2 },
            { id = "small_omnivore_stomach", count = 4 }
        })
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_shade_legs",
    result = "gracken_shade_legs",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("bone_any", 2, true)
    :component("sinew", 4)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_short_legs",
    result = "gracken_short_legs",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("bone_any", 2, true)
    :component("underdeveloped_sinew", 4)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "gracken_long_legs",
    result = "gracken_long_legs",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_GRACKEN",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 1)
    :component("scrap_shadowstuff", 1)
    :component("bone_any", 2, true)
    :component("runner_sinew", 4)
    :quality("SEW", 1, 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "helmet_inventor",
    result = "helmet_inventor",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component_any({
            { id = "headgear", count = 1 },
            { id = "helmet_army", count = 1 },
            { id = "tac_fullhelmet", count = 1 },
            { id = "tac_helmet", count = 1 },
            { id = "firehelmet", count = 1 },
            { id = "helmet_ball", count = 1 },
            { id = "helmet_football", count = 1 }
        })
    :component("magnetron", 1)
    :component("copper_wire", 2)
    :component("power_supply", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_backpack",
    result = "inventor_backpack",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :tool_charges("vac_pump", 300)
    :component_any({
            { id = "molle_medium_rucksack", count = 1 },
            { id = "molle_large_rucksack", count = 1 }
        })
    :component("scrap_aluminum", 30)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 60)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_leg_weight",
    result = "inventor_leg_weight",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 12)
    :component_any({
            { id = "tool_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "seatbelt", count = 1 }
        })
    :component("magnetron", 2)
    :component("power_supply", 4)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 60)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_jump_boots",
    result = "inventor_jump_boots",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component_any({
            { id = "boots_combat", count = 1 },
            { id = "boots_hiking", count = 1 }
        })
    :component("cable", 4)
    :component("spring_plate", 2)
    :component("e_scrap", 2)
    :component("power_supply", 4)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 40)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "aura_force",
    result = "aura_force",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("scrap_aluminum", 35)
    :component_any({
            { id = "tool_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "seatbelt", count = 1 }
        })
    :component("fuse", 4)
    :component("cable", 50)
    :component("e_scrap", 1)
    :component("antenna", 3)
    :component("power_supply", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 7)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "vision_halo",
    result = "vision_halo",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("scrap_aluminum", 30)
    :component("cable", 4)
    :component("e_scrap", 2)
    :component("power_supply", 1)
    :component("ai_module", 1)
    :component("RAM", 1)
    :component("processor", 1)
    :component("camera_pro", 3)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 7)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_elec_semiconductors", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_elec_integrated_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_carry_hands",
    result = "inventor_carry_hands",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("pipe", 6)
    :component("spring_small", 6)
    :component("scrap", 10)
    :component("rope_30", 2)
    :component("gloves_cut_resistant", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 70)
    :requires_skill("fabrication", 3)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_fists",
    result = "inventor_fists",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("pipe", 7)
    :component("scrap_aluminum", 100)
    :component("scrap", 20)
    :component("sheet_metal_small", 10)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 220)
    :requires_skill("fabrication", 3)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_fists_plus",
    result = "inventor_fists_plus",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("inventor_fists", 1)
    :component("compressor", 1)
    :component("scrap", 22)
    :component("sheet_metal_small", 9)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 80)
    :requires_skill("fabrication", 3)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_electric_fist",
    result = "inventor_electric_fist",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("cable", 4)
    :component("scrap_aluminum", 50)
    :component("e_scrap", 2)
    :component("power_supply", 4)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "wolf_mask",
    result = "wolf_mask",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("cable", 4)
    :component("scrap_aluminum", 10)
    :component("e_scrap", 5)
    :component("power_supply", 4)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "magnetic_holster",
    result = "magnetic_holster",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("cable", 40)
    :component("scrap_aluminum", 20)
    :component("e_scrap", 2)
    :component("power_supply", 4)
    :component("magnetron", 1)
    :component("inventor_light_cell", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("electronics", 3)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

-- The laptop is used to create the AI and the welding supplies are here to build the robot.
content.add(content.Recipe {
    id = "crafting_assistant",
    result = "crafting_assistant",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ROBOTS",
    duration_moves = 7920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 10,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 400)
    :tool("software_math", 1)
    :tool("software_electronics_reference", 1)
    :component("scrap_aluminum", 500)
    :component("cable", 67)
    :component("motor_micro", 10)
    :component("pipe", 6)
    :component("scrap", 50)
    :component("nuts_bolts", 25)
    :component("e_scrap", 15)
    :component("power_supply", 6)
    :component("ai_module_advanced", 1)
    :component("RAM", 10)
    :component("processor", 10)
    :component("camera_pro", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("AI_TOOL", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 200)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "xedra_inventor_damage_reversal_device",
    result = "xedra_inventor_damage_reversal_device",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ARMOR",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 10,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 50)
    :component("cable", 40)
    :component("teleporter", 2)
    :component("e_scrap", 2)
    :component("power_supply", 4)
    :component("magnetron", 1)
    :component("processor", 8)
    :component("kevlar_patch", 4)
    :component("pocketwatch", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("AI_TOOL", 1, 1)
    :requirement("soldering_standard", 50)
    :requirement("welding_standard", 25)
    :requires_skill("electronics", 8)
    :requires_skill("fabrication", 6)
    :requires_skill("computer", 8)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bot_sniperbot",
    result = "bot_sniperbot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ROBOTS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("inventor_sniper", 1)
    :component("scrap_aluminum", 400)
    :component("cable", 67)
    :component("e_scrap", 3)
    :component("lens", 5)
    :component("motor_micro", 8)
    :component("power_supply", 12)
    :component("processor", 26)
    :component("RAM", 12)
    :component("scrap", 5)
    :component("nuts_bolts", 25)
    :component("inventor_heavy_cell", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 200)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bot_shotgunbot",
    result = "bot_shotgunbot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ROBOTS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("inventor_shotgun", 1)
    :component("scrap_aluminum", 400)
    :component("cable", 67)
    :component("e_scrap", 3)
    :component("lens", 5)
    :component("motor_micro", 8)
    :component("power_supply", 12)
    :component("processor", 26)
    :component("RAM", 12)
    :component("scrap", 5)
    :component("nuts_bolts", 25)
    :component("inventor_heavy_cell", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 200)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bot_meleebot",
    result = "bot_meleebot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ROBOTS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("blade", 3)
    :component("scrap_aluminum", 400)
    :component("cable", 67)
    :component("e_scrap", 3)
    :component("lens", 5)
    :component("motor_micro", 8)
    :component("power_supply", 12)
    :component("processor", 26)
    :component("RAM", 12)
    :component("scrap", 5)
    :component("nuts_bolts", 25)
    :component("inventor_heavy_cell", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 200)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bot_bitebot",
    result = "bot_bitebot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ROBOTS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("spring_medium", 4)
    :component("beartrap", 1)
    :component("scrap_aluminum", 400)
    :component("cable", 67)
    :component("e_scrap", 3)
    :component("lens", 5)
    :component("motor_micro", 8)
    :component("power_supply", 12)
    :component("processor", 26)
    :component("RAM", 12)
    :component("scrap", 5)
    :component("nuts_bolts", 25)
    :component("inventor_heavy_cell", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 200)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bio_inventor_mana_kj_penalty_switch",
    result = "bio_inventor_mana_kj_penalty_switch",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_BIONICS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("plastic_chunk", 15)
    :component("scrap_aluminum", 100)
    :component("copper_wire", 21)
    :component("power_supply", 4)
    :component("e_scrap", 3)
    :component("obsidian_rock", 5)
    :component("kreck_loot_star_stone", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 25)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bio_inventor_calorie_storage",
    result = "bio_inventor_calorie_storage",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_BIONICS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("plastic_chunk", 15)
    :component("scrap_aluminum", 100)
    :component("copper_wire", 12)
    :component("power_supply", 2)
    :component("e_scrap", 10)
    :component("magnet", 10)
    :component("magnetron", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 25)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bio_inventor_creative_fuel",
    result = "bio_inventor_creative_fuel",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_BIONICS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("plastic_chunk", 15)
    :component("scrap_aluminum", 100)
    :component("copper_wire", 7)
    :component("power_supply", 5)
    :component("lens_small", 4)
    :component("mirror", 3)
    :component("chunk_caco3", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 25)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "bio_inventor_book_burn_boost",
    result = "bio_inventor_book_burn_boost",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_BIONICS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("plastic_chunk", 15)
    :component("scrap_aluminum", 100)
    :component("copper_wire", 17)
    :component("power_supply", 5)
    :component("e_scrap", 2)
    :component("heater_gun", 1)
    :component("memory_module", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 25)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "rip_ticket",
    result = "rip_ticket",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_any({
            { id = "pen", charges = 25 },
            { id = "black_pen", charges = 25 },
            { id = "blue_pen", charges = 25 },
            { id = "red_pen", charges = 25 },
            { id = "green_pen", charges = 25 },
            { id = "pencil", charges = 25 },
            { id = "permanent_marker", charges = 25 },
            { id = "survival_marker", charges = 25 }
        })
    :component_any({
            { id = "money_one", count = 1 },
            { id = "money_two", count = 1 },
            { id = "money_five", count = 1 },
            { id = "money_ten", count = 1 },
            { id = "money_twenty", count = 1 },
            { id = "money_fifty", count = 1 },
            { id = "money_hundred", count = 1 }
        })
)

content.add(content.Recipe {
    id = "cosmic_dagwood",
    result = "cosmic_dagwood",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CONSUMABLES",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 23, true)
    :tool("waffleiron", 1)
    :component("brown_bread", 4)
    :component("poultry", 2)
    :component("batter", 1, true)
    :component_any({
            { id = "hb_beer", count = 1 },
            { id = "beer", count = 1 }
        })
    :component_any({
            { id = "sauce_red", count = 2 },
            { id = "can_tomato", count = 1 },
            { id = "tomato", count = 1 }
        })
    :component_any({
            { id = "chilly-p", count = 2 },
            { id = "chili_pepper", count = 1 },
            { id = "rehydrated_chili", count = 1 }
        })
    :component("chocolate", 1)
    :component_any({
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 6 }
        })
    :component("sugar_fried", 2)
    :component("cinnamon", 2)
    :component("chem_acetic_acid", 1)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("honey_mustard", 4)
    :component("barbecue_sauce", 6)
    :component("cheese_hard", 3)
    :component("gold_small", 3)
    :component("silver_small", 3)
    :component("splinter", 1)
    :component_any({
            { id = "strawberries", count = 1 },
            { id = "cherries", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("cooking", 5)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

content.add(content.Recipe {
    id = "inventor_warp_grenade",
    result = "inventor_warp_grenade",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 8,
    flags = { "SECRET" },
}
    :component("power_supply", 2)
    :component("teleporter", 1)
    :component("scrap", 5)
    :component("scrap_aluminum", 5)
    :component("sheet_metal_small", 10)
    :component("cable", 34)
    :component("grenade", 1)
    :component("lens_small", 1)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 60)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 6)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

-- Very strong coffee, caffeine and components for the synthesis of caffeine.
content.add(content.Recipe {
    id = "inventor_coffee",
    result = "inventor_coffee",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CONSUMABLES",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("water_boiling_heat", 4, true)
    :tool("coffeemaker", 1)
    :component("atomic_coffee", 2)
    :component("caffeine", 2)
    :component_any({
            { id = "lye_powder", count = 1 },
            { id = "chem_potassium_hydroxide", count = 5 }
        })
    :component("feces_bird", 1)
    :component("chem_methanol", 1)
    :quality("CHEM", 3, 1)
    :quality("COOK", 2, 1)
    :quality("DISTILL", 2, 1)
    :quality("STRAIN", 2, 1)
    :requires_skill("cooking", 4)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "portable_dark_age",
    result = "portable_dark_age",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("cable", 1)
    :component("scrap_aluminum", 5)
    :component("e_scrap", 2)
    :component("power_supply", 4)
    :component("magnetron", 4)
    :component("inventor_medium_cell", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("electronics", 3)
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

-- natural abilities of inventor makes him never fail his class crafts, but some profs are still required
content.add(content.Recipe {
    id = "battery_gun",
    result = "battery_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 2)
    :component("pipe_fittings", 1)
    :component("cable", 7)
    :component("element", 1)
    :component("scrap", 5)
    :component("duct_tape", 25)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("fabrication", 2)
    :proficiency("prof_elec_soldering", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "ray_gun",
    result = "ray_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 5)
    :component("pipe_fittings", 3)
    :component("cable", 17)
    :component("element", 3)
    :component("lens_small", 1)
    :component("scrap", 5)
    :component("nuts_bolts", 5)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 30)
    :requires_skill("fabrication", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "ray_rifle",
    result = "ray_rifle",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 8)
    :component("pipe_fittings", 5)
    :component("cable", 50)
    :component("element", 6)
    :component("lens", 2)
    :component("scrap", 15)
    :component("nuts_bolts", 20)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 25)
    :requirement("welding_standard", 40)
    :requires_skill("fabrication", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "death_ray",
    result = "death_ray",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 9,
    flags = { "SECRET" },
}
    :component("pipe", 7)
    :component("pipe_fittings", 6)
    :component("cable", 34)
    :component("element", 3)
    :component("lens", 1)
    :component("scrap", 5)
    :component("nuts_bolts", 7)
    :component("circuit", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 60)
    :requires_skill("fabrication", 7)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bio_launcher",
    result = "bio_launcher",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component_any({
            { id = "30gal_drum", count = 1 },
            { id = "55gal_drum", count = 1 }
        })
    :component("pipe", 1)
    :component("e_scrap", 3)
    :component("scrap", 10)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 140)
    :requires_skill("electronics", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "bio_warhead",
    result = "bio_warhead",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("chem_compositionb", 300)
    :component("cable", 7)
    :component_any({
            { id = "blood", count = 1 },
            { id = "animal_blood", count = 1 },
            { id = "mutant_blood", count = 1 },
            { id = "blood_tainted", count = 1 }
        })
    :component("fuse", 1)
    :component("scrap", 2)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 30)
    :requires_skill("firstaid", 6)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "ion_gun",
    result = "ion_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("magnetron", 1)
    :component("pipe", 5)
    :component("antenna", 3)
    :component("cable", 9)
    :component("circuit", 1)
    :component("scrap", 5)
    :component("duct_tape", 15)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_elec_circuits", { time_multiplier = 2, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_sniper",
    result = "inventor_sniper",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component_any({
            { id = "ar10", count = 1 },
            { id = "fn_fal_semi", count = 1 },
            { id = "hk417_13", count = 1 },
            { id = "m14ebr", count = 1 },
            { id = "M24", count = 1 },
            { id = "ak308", count = 1 },
            { id = "scar_h", count = 1 }
        })
    :component_any({
            { id = "ar10", count = 1 },
            { id = "fn_fal_semi", count = 1 },
            { id = "hk417_13", count = 1 },
            { id = "m14ebr", count = 1 },
            { id = "M24", count = 1 },
            { id = "ak308", count = 1 },
            { id = "scar_h", count = 1 }
        })
    :component("pipe", 15)
    :component("scrap", 20)
    :component("nuts_bolts", 15)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_shotgun",
    result = "inventor_shotgun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component_any({
            { id = "mossberg_500", count = 1 },
            { id = "mossberg_590", count = 1 },
            { id = "mossberg_930", count = 1 },
            { id = "remington_870", count = 1 },
            { id = "remington_870_express", count = 1 },
            { id = "ksg", count = 1 },
            { id = "saiga_12", count = 1 },
            { id = "tavor_12", count = 1 },
            { id = "winchester_1897", count = 1 }
        })
    :component("pipe", 35)
    :component("scrap", 28)
    :component("nuts_bolts", 60)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "accelerator_gun",
    result = "accelerator_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 25)
    :component("scrap", 20)
    :component("nuts_bolts", 15)
    :component("processor", 1)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 35)
    :component("plastic_chunk", 10)
    :component("cable", 67)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 50)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_plasticworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_glauncher",
    result = "inventor_glauncher",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("inventor_welder", 1)
    :component("pipe", 5)
    :component("scrap", 5)
    :component("nuts_bolts", 5)
    :component("processor", 1)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 2)
    :component("e_scrap", 10)
    :component("cable", 67)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 80)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_glauncher_fire",
    result = "inventor_glauncher_fire",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 5)
    :component("processor", 1)
    :component("circuit", 2)
    :component("power_supply", 3)
    :component("amplifier", 2)
    :component("e_scrap", 5)
    :component("cable", 17)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_glauncher_elec",
    result = "inventor_glauncher_elec",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 5)
    :component("processor", 1)
    :component("circuit", 2)
    :component("power_supply", 1)
    :component("amplifier", 1)
    :component("e_scrap", 5)
    :component("cable", 84)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_glauncher_direct",
    result = "inventor_glauncher_direct",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 5)
    :component("processor", 1)
    :component("circuit", 2)
    :component("power_supply", 5)
    :component("amplifier", 5)
    :component("e_scrap", 5)
    :component("cable", 17)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_grenade_noise_expl",
    result = "inventor_grenade_noise_expl",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 198000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "heavy_plus_battery_cell", count = 1 },
            { id = "inventor_heavy_cell", count = 1 }
        })
    :component("plastic_chunk", 25)
    :component("scrap", 20)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 5)
    :component("cable", 34)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_plasticworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_grenade_noise_emp",
    result = "inventor_grenade_noise_emp",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 198000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "heavy_plus_battery_cell", count = 1 },
            { id = "inventor_heavy_cell", count = 1 }
        })
    :component("plastic_chunk", 25)
    :component("scrap", 20)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 5)
    :component("cable", 167)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_plasticworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_grenade_noise_fire",
    result = "inventor_grenade_noise_fire",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 198000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "heavy_plus_battery_cell", count = 1 },
            { id = "inventor_heavy_cell", count = 1 }
        })
    :component("plastic_chunk", 25)
    :component("scrap", 20)
    :component("power_supply", 4)
    :component("amplifier", 5)
    :component("e_scrap", 5)
    :component("cable", 34)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_electromagnetics", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_plasticworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "sonic_gun",
    result = "sonic_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 3960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 5)
    :component("scrap", 26)
    :component("nuts_bolts", 5)
    :component("processor", 1)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 2)
    :component("e_scrap", 10)
    :component("cable", 67)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "heater_gun",
    result = "heater_gun",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("heater_tool", 1)
    :component("pipe", 20)
    :component("scrap", 26)
    :component("nuts_bolts", 5)
    :component("processor", 1)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 2)
    :component("e_scrap", 10)
    :component("cable", 67)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 40)
    :requires_skill("electronics", 5)
    :requires_skill("fabrication", 5)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_pistol",
    result = "inventor_pistol",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("pipe", 9)
    :component("scrap", 36)
    :component("nuts_bolts", 10)
    :component("duct_tape", 40)
    :quality("SAW_M_FINE", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requires_skill("fabrication", 5)
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "trinket_damage",
    result = "trinket_damage",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("amplifier", 1)
    :component("cable", 34)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "trinket_range",
    result = "trinket_range",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("amplifier", 1)
    :component("cable", 34)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "trinket_sound",
    result = "trinket_sound",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("amplifier", 1)
    :component("cable", 34)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "choke_wideshot",
    result = "choke_wideshot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("sheet_metal_small", 1)
    :component("amplifier", 1)
    :component("cable", 34)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "mod_inv_pistol_booster",
    result = "mod_inv_pistol_booster",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 3)
    :component("scrap", 5)
    :component("duct_tape", 20)
    :component("plastic_chunk", 5)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "mod_inv_pistol_double_tap",
    result = "mod_inv_pistol_double_tap",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("pipe", 3)
    :component("scrap", 5)
    :component("duct_tape", 20)
    :component("plastic_chunk", 5)
    :component("circuit", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("fabrication", 4)
    :proficiency("prof_elec_soldering", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_metalworking", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
    :proficiency("prof_gunsmithing_improv", { time_multiplier = 3, skill_penalty = 0, learning_time_multiplier = 0.3 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_close_range",
    result = "inventor_lasmod_close_range",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_long_range",
    result = "inventor_lasmod_long_range",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_capasitor",
    result = "inventor_lasmod_capasitor",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_mega_capasitor",
    result = "inventor_lasmod_mega_capasitor",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_energy_safe",
    result = "inventor_lasmod_energy_safe",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_adv_cooler",
    result = "inventor_lasmod_adv_cooler",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_adv_adv_cooler",
    result = "inventor_lasmod_adv_adv_cooler",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("inventor_lasmod_adv_cooler", 1)
    :component("scrap", 3)
    :component("cable", 27)
    :component("plastic_chunk", 3)
    :component("circuit", 1)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 10)
    :component("duct_tape", 5)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_recuperator",
    result = "inventor_lasmod_recuperator",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("scrap", 3)
    :component("cable", 40)
    :component("plastic_chunk", 2)
    :component("amplifier", 2)
    :component("e_scrap", 11)
    :component("duct_tape", 15)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_mega_everything",
    result = "inventor_lasmod_mega_everything",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("inventor_lasmod_mega_capasitor", 1)
    :component("scrap", 5)
    :component("cable", 10)
    :component("circuit", 2)
    :component("power_supply", 4)
    :component("amplifier", 1)
    :component("e_scrap", 25)
    :component("duct_tape", 30)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_radiator",
    result = "inventor_lasmod_radiator",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("scrap", 6)
    :component("cable", 27)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 2)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_chonky_radiator",
    result = "inventor_lasmod_chonky_radiator",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("scrap", 14)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_spooky_heat_sink",
    result = "inventor_lasmod_spooky_heat_sink",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("scrap", 4)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("e_scrap", 3)
    :component("duct_tape", 30)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_lasmod_more_capacitors",
    result = "inventor_lasmod_more_capacitors",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("circuit", 3)
    :component("power_supply", 4)
    :component("amplifier", 2)
    :component("e_scrap", 15)
    :component("duct_tape", 20)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mace_magic",
    result = "mace_magic",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("magnetron", 1)
    :component("pipe", 3)
    :component("scrap", 25)
    :component("duct_tape", 25)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 60)
    :requires_skill("electronics", 4)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "combatsaw_spear_off",
    result = "combatsaw_spear_off",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component_any({
            { id = "chainsaw_off", count = 1 },
            { id = "elec_chainsaw_off", count = 1 }
        })
    :component("pipe", 9)
    :component("scrap", 25)
    :component("duct_tape", 25)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 160)
    :requires_skill("electronics", 4)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "megachette",
    result = "megachette",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component("sheet_metal", 1)
    :component("pipe", 1)
    :component("scrap", 25)
    :component("duct_tape", 25)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 30)
    :requires_skill("fabrication", 3)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "binary_sword",
    result = "binary_sword",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("sheet_metal", 1)
    :component("pipe", 1)
    :component("steel_lump_any", 2, true)
    :component("scrap", 25)
    :component("thread_kevlar", 25)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 45)
    :requires_skill("fabrication", 6)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_plasma_axe_off",
    result = "inventor_plasma_axe_off",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "material_aluminium_ingot", count = 6 },
            { id = "scrap_aluminum", count = 72 }
        })
    :component("duct_tape", 25)
    :component("heater_tool", 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("GRIND", 1, 1)
    :requirement("welding_standard", 45)
    :requires_skill("fabrication", 6)
    :proficiency("prof_metalworking", { time_multiplier = 2, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_light_minus_cell",
    result = "inventor_light_minus_cell",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("light_minus_disposable_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 7)
    :component("plastic_chunk", 10)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_light_cell",
    result = "inventor_light_cell",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("light_battery_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 14)
    :component("plastic_chunk", 10)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_medium_cell",
    result = "inventor_medium_cell",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("medium_battery_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 20)
    :component("plastic_chunk", 10)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_heavy_cell",
    result = "inventor_heavy_cell",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("heavy_plus_battery_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 27)
    :component("plastic_chunk", 10)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_welder",
    result = "inventor_welder",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("power_supply", 6)
    :component("scrap", 2)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("magnetron", 2)
    :component("lens_small", 1)
    :component("amplifier", 1)
    :component("duct_tape", 60)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "heater_tool",
    result = "heater_tool",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("power_supply", 3)
    :component("scrap_aluminum", 15)
    :component("cable", 27)
    :component("magnetron", 1)
    :component("amplifier", 2)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "stunning_qr_trap",
    result = "stunning_qr_trap",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool("paint_brush", 1)
    :tool_charges("paint", 1, true)
    :component("light_battery_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 2)
    :component("scrap_dreamdross", 4)
    :component("plastic_chunk", 2)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "stunning_arg_trap",
    result = "stunning_arg_trap",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :tool("paint_brush", 1)
    :tool_charges("paint", 1, true)
    :component("light_battery_cell", 1)
    :component("power_supply", 1)
    :component("scrap", 3)
    :component("cable", 2)
    :component("scrap_dreamdross", 4)
    :component("plastic_chunk", 2)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("computer", 3)
    :proficiency("prof_plasticworking", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "software_AI",
    result = "software_AI",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 8640000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "BLIND_EASY", "SECRET" },
    container = "usb_drive",
}
    :tool_charges("laptop", 30)
    :tool("software_math", 1)
    :tool("software_electronics_reference", 1)
    :component("usb_drive", 1)
    :requires_skill("computer", 6)
)

content.add(content.Recipe {
    id = "software_math_inventor",
    result = "software_math",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 5040000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "BLIND_EASY", "SECRET" },
    container = "usb_drive",
}
    :tool_charges("laptop", 30)
    :component("usb_drive", 1)
    :requires_skill("computer", 3)
)

content.add(content.Recipe {
    id = "software_electronics_reference_inventor",
    result = "software_electronics_reference",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 7200000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "BLIND_EASY", "SECRET" },
    container = "usb_drive",
}
    :tool_charges("laptop", 30)
    :tool("software_math", 1)
    :component("usb_drive", 1)
    :requires_skill("computer", 5)
)

content.add(content.Recipe {
    id = "nre_recorder_inventor",
    result = "nre_recorder",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 30)
    :component("power_supply", 2)
    :component("scrap", 20)
    :component("scrap_aluminum", 10)
    :component("cable", 27)
    :component("plastic_chunk", 5)
    :component("magnetron", 2)
    :component("processor", 1)
    :component("lens_small", 1)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 60)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 6)
    :requires_skill("computer", 2)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xedra_inventor_time_pierce_tool_inventor",
    result = "xedra_inventor_time_pierce_tool",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 10,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 200)
    :component("power_supply", 8)
    :component("teleporter", 1)
    :component("spike", 1)
    :component("magnetron", 4)
    :component("scrap", 20)
    :component("cable", 27)
    :component("scrap_aluminum", 10)
    :component("processor", 1)
    :component("lens_small", 4)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("AI_TOOL", 1, 1)
    :requirement("soldering_standard", 60)
    :requirement("welding_standard", 30)
    :requires_skill("electronics", 6)
    :requires_skill("computer", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_portal_closer",
    result = "inventor_portal_closer",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 5760000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 10,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 100)
    :component("anvil", 2)
    :component("teleporter", 2)
    :component("pipe", 32)
    :component("power_supply", 10)
    :component("motor_micro", 10)
    :component("scrap", 100)
    :component("cable", 134)
    :component("magnetron", 2)
    :component("processor", 2)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("AI_TOOL", 1, 1)
    :requirement("soldering_standard", 100)
    :requirement("welding_standard", 50)
    :requires_skill("electronics", 6)
    :requires_skill("fabrication", 6)
    :requires_skill("computer", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "teleporter_inventor",
    result = "teleporter",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 8,
    flags = { "SECRET" },
}
    :tool_charges("laptop", 50)
    :component("power_supply", 1)
    :component("diamond", 1)
    :component("scrap", 5)
    :component("cable", 4)
    :component("lens_small", 1)
    :component("processor", 1)
    :component("inventor_medium_cell", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("AI_TOOL", 1, 1)
    :requirement("soldering_standard", 50)
    :requirement("welding_standard", 25)
    :requires_skill("electronics", 4)
    :requires_skill("computer", 4)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "inventor_water_purifier",
    result = "inventor_water_purifier",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("water_purifier", 1)
    :component("condensor_coil", 3)
    :component("evaporator_coil", 3)
    :component("hose", 1)
    :component("tonic_water", 2)
    :component("water_mineral", 2)
    :component("water_murky", 2)
    :component("jar_glass_sealed", 2)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 30)
    :requirement("welding_standard", 15)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

-- Intended to work on any non-ThirstTrouncer liquid whose name includes "water".
content.add(content.Recipe {
    id = "water_thirsttrouncer",
    result = "water_thirsttrouncer",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CONSUMABLES",
    duration_moves = 900,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "survival",
}
    :tool_charges("inventor_water_purifier", 22)
    :component_any({
            { id = "water", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "water_murky", count = 1 },
            { id = "sweet_water", count = 1 },
            { id = "tonic_water", count = 1 },
            { id = "soapy_water", count = 1 },
            { id = "water_spring", count = 1 },
            { id = "water_sewage", count = 1 },
            { id = "water_mineral", count = 1 },
            { id = "coconut_water", count = 1 },
            { id = "sparkling", count = 1 },
            { id = "sparkling_peach", count = 1 },
            { id = "sparkling_pomegranate", count = 1 }
        })
)

content.add(content.Recipe {
    id = "inventor_oxygen_jelly_machine",
    result = "inventor_oxygen_jelly_machine",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 2520000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("pressure_cooker", 1)
    :component("motor_small", 1)
    :component("compressor", 5)
    :component("hose", 1)
    :component("power_supply", 1)
    :component("pipe_fittings", 2)
    :component("pipe", 2)
    :component("plastic_chunk", 10)
    :component("cable", 17)
    :component("pressure_tank", 1)
    :component("pump_complex", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 40)
    :requirement("welding_standard", 20)
    :requires_skill("electronics", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "oxygen_jelly_quick",
    result = "oxygen_jelly_quick",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CONSUMABLES",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "survival",
}
    :tool_charges("inventor_oxygen_jelly_machine", 240)
)

content.add(content.Recipe {
    id = "oxygen_jelly_long",
    result = "oxygen_jelly_long",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_CONSUMABLES",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "survival",
}
    :tool_charges("inventor_oxygen_jelly_machine", 240)
)

content.add(content.Recipe {
    id = "inventor_gaming_rig",
    result = "inventor_gaming_rig",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_TOOLS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("processor", 6)
    :component_any({
            { id = "pillow", count = 1 },
            { id = "down_pillow", count = 1 },
            { id = "makeshift_pillow", count = 1 }
        })
    :component("duct_tape", 30)
    :component_any({
            { id = "portable_game", count = 1 },
            { id = "game_watch", count = 1 }
        })
    :component("mp3", 1)
    :component("chunk_rubber", 4)
    :component("scrap", 10)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 5)
    :requires_skill("electronics", 3)
    :requires_skill("computer", 3)
    :proficiency("prof_welding_basic", { time_multiplier = 3, skill_penalty = 0 })
    :proficiency("prof_welding", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "cthonic_poultice",
    result = "cthonic_poultice",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 2, true)
    :component("material_soil", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "scrap_dreamdross", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("earthkin_tablet", 0)
)

content.add(content.Recipe {
    id = "verdant_poultice",
    result = "verdant_poultice",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 2, true)
    :component("veggy_green", 3, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "scrap_dreamdross", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("plantkin_parchment", 0)
)

content.add(content.Recipe {
    id = "cerulean_poultice",
    result = "cerulean_poultice",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 2, true)
    :component("eggs_roe", 2, true)
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "scrap_dreamdross", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("waterkin_tablet", 0)
)

content.add(content.Recipe {
    id = "charred_sacrifice",
    result = "charred_sacrifice",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 40, true)
    :component("meat_raw_steak", 2, true)
    :component_any({
            { id = "seasoning_salt", count = 1 },
            { id = "scrap_dreamdross", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("flametouched_parchment", 0)
)

content.add(content.Recipe {
    id = "doll_repair_paste",
    result = "doll_repair_paste",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool("paint_brush", 1)
    :tool_charges("surface_heat", 10, true)
    :component("glue_strong", 5)
    :component("scrap_dreamdross", 1)
    :quality("COOK", 2, 1)
    :requirement("paint", 2)
    :book("dollkin_tablet", 0)
)

content.add(content.Recipe {
    id = "ethereal_draught",
    result = "ethereal_draught",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :component("any_bread", 2, true)
    :component_any({
            { id = "honey_bottled", count = 1 },
            { id = "scrap_dreamdross", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("sylph_parchment", 0)
)

content.add(content.Recipe {
    id = "dreamdross_lump",
    result = "dreamdross_lump",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("scrap_dreamdross", 10)
    :quality("DREAM_HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "forged_dreamstuff_ingot",
    result = "forged_dreamstuff_ingot",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "scrap_dreamdross", count = 100 },
            { id = "dreamdross_lump", count = 10 }
        })
    :quality("DREAM_HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "concentrated_underhill_essence",
    result = "concentrated_underhill_essence",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool("lump_cast_iron", 1)
    :tool_any({
            { id = "steel_lump", count = 1 },
            { id = "budget_steel_lump", count = 1 },
            { id = "lc_steel_lump", count = 1 },
            { id = "mc_steel_lump", count = 1 },
            { id = "hc_steel_lump", count = 1 },
            { id = "ch_steel_lump", count = 1 },
            { id = "qt_steel_lump", count = 1 }
        })
    :component_any({
            { id = "fae_organs", count = 4 },
            { id = "fae_fur", count = 7 },
            { id = "fae_meat", count = 7 },
            { id = "fae_meat_scrap", count = 50 },
            { id = "fae_blood", count = 20 }
        })
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dream_drainer_catalyst",
    result = "dream_drainer_catalyst",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("fae_blood", 4)
    :component("wyld_candy", 20)
    :component("lotus_blossom", 15)
    :component("scrap_dreamdross", 35)
)

content.add(content.Recipe {
    id = "revenant_effigy",
    result = "revenant_effigy",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "jabberwock_heart", count = 1 },
            { id = "flesh_golem_heart", count = 1 },
            { id = "triffid_heart_chunk", count = 1 }
        })
    :component("glass_shard", 105)
    :component("silver_small", 100)
    :component("faewild", 35)
    :component("skull_march_lord", 1)
    :component("fae_meat", 80)
    :component("bone_any", 50, true)
    :quality("SEW", 3, 1)
)

content.add(content.Recipe {
    id = "laptop",
    result = "laptop",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_MISC",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 0,
}
    :component("laptop_xedra", 1)
)

content.add(content.Recipe {
    id = "2x4_from treesung logs",
    result = "2x4",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 8,
}
    :component("log_treesung", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("splinter", 10)
)

content.add(content.Recipe {
    id = "mixed_alcohol_strong_from_water",
    result = "mixed_alcohol_strong",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :result_charges(7)
)

-- Requires three times as much water as the base recipe and no other ingredients.
content.add(content.Recipe {
    id = "lamp_oil_from_water",
    result = "lamp_oil",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 3,
    flags = { "SECRET" },
}
    :component_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :result_charges(1800)
    :byproduct("diesel", 24)
)

content.add(content.Recipe {
    id = "salt_water_from_water",
    result = "salt_water",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
)

content.add(content.Recipe {
    id = "water_from_salt_water",
    result = "water",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component("salt_water", 1)
)

content.add(content.Recipe {
    id = "water_clean_from_water",
    result = "water_clean",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component("water", 1)
)

content.add(content.Recipe {
    id = "water_from_water_clean",
    result = "water",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "water_from_liquid",
    result = "water",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "deduction",
    flags = { "BLIND_EASY", "SECRET" },
}
    :component_any({
            { id = "hard_liquor", count = 1, requirement = true },
            { id = "cheap_wine", count = 1, requirement = true },
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
)

content.add(content.Recipe {
    id = "cured_glimmer_pelt",
    result = "cured_glimmer_pelt",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "salt", count = 2 }
        })
    :component("fae_fur", 1)
    :quality("CUT", 2, 1)
    :requires_skill("chemistry", 1)
)

content.add(content.Recipe {
    id = "blood_treatment",
    result = "blood_treatment",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 30, true)
    :component("mercury", 1)
    :component("garlic_clove", 4)
    :component("blood", 3)
    :component("silver_small", 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("CHEM", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("cooking", 2)
    :book("grimy_recipe", 1)
    :batch_discount(65, 4)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "anathema_blood_catalyst_unready",
    result = "anathema_blood_catalyst_unready",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("vampire_blood", 10)
    :component_any({
            { id = "blood_acid", count = 10 },
            { id = "blood_mi-go", count = 10 },
            { id = "blood_tainted", count = 10 },
            { id = "blood_acid_plant", count = 10 },
            { id = "blood_acid_insect", count = 10 },
            { id = "blood_acid_underground", count = 10 }
        })
    :component_any({
            { id = "formic_acid", count = 3 },
            { id = "chem_acetic_acid", count = 3 },
            { id = "chem_nitric_acid", count = 3 },
            { id = "chem_sulphuric_acid", count = 3 },
            { id = "chem_muriatic_acid", count = 3 }
        })
    :component_any({
            { id = "venom_bee", count = 6 },
            { id = "venom_wasp", count = 6 },
            { id = "venom_paralytic", count = 6 },
            { id = "conc_venom", count = 3 },
            { id = "conc_paralytic", count = 3 }
        })
    :component_any({
            { id = "nicotine_liquid", count = 100 },
            { id = "datura_seed", count = 10 },
            { id = "chem_toluene", count = 50 },
            { id = "leech_flower", count = 5 }
        })
    :requires_skill("cooking", 2)
)
