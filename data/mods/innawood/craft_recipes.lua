local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "steel_lump_from ore",
    result = "steel_lump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("bloomery", 41)
    :component("iron_ore", 17)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metallurgy")
    :batch_discount(95, 2)
)

content.add(content.Recipe {
    id = "steel_chunk_from ore",
    result = "steel_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 4,
}
    :tool_charges("bloomery", 41)
    :component("iron_ore", 17)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metallurgy")
    :batch_discount(95, 2)
)

content.add(content.Recipe {
    id = "scrap_from ore",
    result = "scrap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 20,
}
    :tool_charges("bloomery", 41)
    :component("iron_ore", 17)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metallurgy")
    :batch_discount(95, 2)
    :result_charges(2)
)

-- Yield is just over 98% by weight, each output of copper is 5 weight.  Volume of output is massively
-- oversize however.
content.add(content.Recipe {
    id = "copper_native",
    result = "copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 1756,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "integrated_welder", charges = 10 }
        })
    :component("chunk_copper", 1)
    :batch_discount(90, 4)
    :byproduct("platinum_small", 21)
)

-- Reversed copper smelting recipe to make it easier to find the platinum recipe. Yield is about 0.5% by
-- weight, each output is 21 g entirely a guess as details on platinum occurence in native copper are scarce,
-- and this is only being retained as a legacy consideration
content.add(content.Recipe {
    id = "platinum_small_from copper ore",
    result = "platinum_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 21,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "integrated_welder", charges = 10 }
        })
    :component("chunk_copper", 1)
    :batch_discount(90, 4)
    :byproduct("copper", 1756)
)

-- Yield is just over 97% by weight, each output of silver is 5 weight.  Volume of output is massively
-- oversize however.
content.add(content.Recipe {
    id = "silver_small_native",
    result = "silver_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 2035,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "integrated_welder", charges = 10 }
        })
    :component("chunk_silver", 1)
    :batch_discount(90, 4)
)

-- Yield is just over 98% by weight, each output of gold is 19 g weight.  Volume of output is massively
-- oversize however.
content.add(content.Recipe {
    id = "gold_small_native",
    result = "gold_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 996,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "integrated_welder", charges = 10 }
        })
    :component("chunk_gold", 1)
    :batch_discount(90, 4)
)

--  Each output of aluminum_ingot is 250 weight, each scrap is 50 weight. Direct conversion of the mass of
-- the ore gives 10 ingots and 4 scrap for a yield of 100% by weight.
content.add(content.Recipe {
    id = "material_aluminium_ingot_native",
    result = "material_aluminium_ingot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    result_multiplier = 10,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "integrated_welder", charges = 10 }
        })
    :component("chunk_aluminum", 1)
    :batch_discount(90, 4)
    :byproduct("scrap_aluminum", 4)
)

-- Cassiterite has around 86% yield, one output is 2 grams.  Output volume is still oversize.
content.add(content.Recipe {
    id = "tin_smelt",
    result = "tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 2691,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chunk_cassiterite", 1)
    :requirement("forging_standard", 3)
    :book("recipe_bullets", 2)
    :book("textbook_fabrication", 2)
    :book("welding_book", 2)
    :batch_discount(90, 4)
)

-- Galena has around 86% yield of lead,  output weighing 5 grams.  Silver output is at 2% yield, output
-- weighing 5 grams.  Output volume is still oversize.
content.add(content.Recipe {
    id = "lead_smelt",
    result = "lead",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 1307,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chunk_galena", 1)
    :requirement("forging_standard", 3)
    :book("recipe_bullets", 2)
    :book("textbook_fabrication", 2)
    :book("welding_book", 2)
    :batch_discount(90, 4)
    :byproduct("silver_small", 30)
)

-- Hematite has around 70% yield of iron, total yield here is just over 69% at 3500 grams of steel.
-- Estimated 2% carbon content has minimal effect on these numbers.  Magnetite has around 80% yield, but
-- ironsand isn't pure magnetite.
content.add(content.Recipe {
    id = "steel_lump_smelt",
    result = "steel_lump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "chunk_hematite", count = 1 },
            { id = "chunk_magnetite", count = 1 }
        })
    :component_any({
            { id = "material_shrd_limestone", count = 1 },
            { id = "material_limestone", count = 10 }
        })
    :component_any({
            { id = "charcoal", count = 10 },
            { id = "coal_lump", count = 10 }
        })
    :requirement("forging_standard", 4)
    :book("textbook_armschina", 3)
    :book("textbook_fabrication", 3)
    :book("welding_book", 3)
    :batch_discount(90, 4)
    :byproduct("steel_chunk", 2)
)

-- Hematite has around 70% yield of iron, total yield here is just over 69% at 3500 grams of steel.
-- Estimated 2% carbon content has minimal effect on these numbers.  Magnetite has around 80% yield, but
-- ironsand isn't pure magnetite.
content.add(content.Recipe {
    id = "steel_chunk_smelt",
    result = "steel_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 15,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "chunk_hematite", count = 1 },
            { id = "chunk_magnetite", count = 1 }
        })
    :component_any({
            { id = "material_shrd_limestone", count = 1 },
            { id = "material_limestone", count = 10 }
        })
    :component_any({
            { id = "charcoal", count = 10 },
            { id = "coal_lump", count = 10 }
        })
    :requirement("forging_standard", 4)
    :book("textbook_armschina", 3)
    :book("textbook_fabrication", 3)
    :book("welding_book", 3)
    :batch_discount(90, 4)
)

-- Hematite has around 70% yield of iron, total yield here is just over 69% at 3500 grams of steel.
-- Estimated 2% carbon content has minimal effect on these numbers.  Magnetite has around 80% yield, but
-- ironsand isn't pure magnetite.
content.add(content.Recipe {
    id = "scrap_smelt",
    result = "scrap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 37,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "chunk_hematite", count = 1 },
            { id = "chunk_magnetite", count = 1 }
        })
    :component_any({
            { id = "material_shrd_limestone", count = 1 },
            { id = "material_limestone", count = 10 }
        })
    :component_any({
            { id = "charcoal", count = 10 },
            { id = "coal_lump", count = 10 }
        })
    :requirement("forging_standard", 4)
    :book("textbook_armschina", 3)
    :book("textbook_fabrication", 3)
    :book("welding_book", 3)
    :batch_discount(90, 4)
    :result_charges(2)
)

-- handwaves crushing cinnabar to avoid extra micro and recipe, added an extra hour to simulate crushing
content.add(content.Recipe {
    id = "mercury_smelt",
    result = "mercury",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 250)
    :component("chunk_cinnabar", 1)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("chemistry", 3)
    :batch_discount(20, 4)
    :result_charges(250)
)

content.replace(content.Recipe {
    id = "chem_ethanol",
    result = "chem_ethanol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 30, true)
    :tool("thermometer", 1)
    :component_any({
            { id = "mixed_alcohol_strong", count = 14 },
            { id = "mixed_alcohol_weak", count = 10 },
            { id = "wash_liquor", count = 42, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :result_charges(250)
    :byproduct("water_clean", 1)
)

content.add(content.Recipe {
    id = "chem_ethanol_slow_distill",
    result = "chem_ethanol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 60, true)
    :component_any({
            { id = "mixed_alcohol_strong", count = 14 },
            { id = "mixed_alcohol_weak", count = 10 },
            { id = "wash_liquor", count = 42, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :result_charges(250)
    :byproduct("water_clean", 1)
)

content.replace(content.Recipe {
    id = "methed_alcohol",
    result = "methed_alcohol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 60, true)
    :component("moonshine", 40)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 1, 1)
    :result_charges(250)
    :byproduct("water_clean", 1)
)

content.replace(content.Recipe {
    id = "biodiesel",
    result = "biodiesel",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 2520000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    flags = { "ALLOW_ROTTEN" },
    result_multiplier = 4,
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water_clean", count = 4 },
            { id = "water", count = 4 }
        })
    :component_any({
            { id = "chem_ethanol", count = 100 },
            { id = "chem_methanol", count = 100 },
            { id = "denat_alcohol", count = 100 },
            { id = "methed_alcohol", count = 100 }
        })
    :component("lye_powder", 8)
    :component_any({
            { id = "cooking_oil", count = 64 },
            { id = "edible_tallow", count = 20, requirement = true },
            { id = "tallow_tainted", count = 8 },
            { id = "any_fat", count = 160, requirement = true },
            { id = "lamp_oil", count = 1000 },
            { id = "motor_oil", count = 1000 }
        })
    :quality("CHEM", 2, 1)
    :batch_discount(99, 1)
    :result_charges(250)
    :byproduct("chem_glycerol", 4)
)

content.replace(content.Recipe {
    id = "glue_weak_as_rubber_cement",
    result = "glue_weak",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "chem_acetone", count = 1 },
            { id = "chem_chloroform", count = 250 },
            { id = "ammonia_liquid", count = 1 }
        })
    :component_any({
            { id = "chem_ethanol", count = 10 },
            { id = "denat_alcohol", count = 10 },
            { id = "methed_alcohol", count = 10 },
            { id = "chem_methanol", count = 10 }
        })
    :component_any({
            { id = "balloon", count = 2 },
            { id = "any_condom", count = 2, requirement = true },
            { id = "gloves_medical", count = 2 },
            { id = "chunk_rubber", count = 1 },
            { id = "latex", count = 2 },
            { id = "gum", count = 20 },
            { id = "sheet_neoprene", count = 11 },
            { id = "scrap_neoprene", count = 16 },
            { id = "neoprene", count = 1 }
        })
    :quality("CHEM", 1, 1)
    :result_charges(250)
)

content.add(content.Recipe {
    id = "glue_weak_as_rubber_cement_by_hand",
    result = "glue_weak",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :component_any({
            { id = "chem_acetone", count = 1 },
            { id = "chem_chloroform", count = 250 },
            { id = "ammonia_liquid", count = 1 }
        })
    :component_any({
            { id = "chem_ethanol", count = 10 },
            { id = "denat_alcohol", count = 10 },
            { id = "methed_alcohol", count = 10 },
            { id = "chem_methanol", count = 10 }
        })
    :component_any({
            { id = "balloon", count = 2 },
            { id = "any_condom", count = 2, requirement = true },
            { id = "gloves_medical", count = 2 },
            { id = "chunk_rubber", count = 1 },
            { id = "latex", count = 2 },
            { id = "gum", count = 20 },
            { id = "sheet_neoprene", count = 11 },
            { id = "scrap_neoprene", count = 16 },
            { id = "neoprene", count = 1 }
        })
    :quality("CHEM", 1, 1)
    :result_charges(250)
)

content.add(content.Recipe {
    id = "glue_strong",
    result = "glue_strong",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "bone_any", count = 20, requirement = true },
            { id = "skewer_bone", count = 1000 },
            { id = "cured_hide", count = 2 },
            { id = "pine_bough", count = 10 },
            { id = "raw_dandelion", count = 20 },
            { id = "biollante_bud", count = 1 },
            { id = "ant_egg", count = 1 },
            { id = "slime_scrap", count = 1 }
        })
    :quality("CHEM", 1, 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "battery_car_clay",
    result = "battery_car_clay",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 2,
    flags = { "FULL_MAGAZINE" },
}
    :component("scrap", 4)
    :component("lead", 3200)
    :component("chem_sulphuric_acid", 13)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component("clay_lump", 5)
    :quality("SCREW", 1, 1)
    :requirement("surface_heat", 10)
    :requirement("glazing", 2)
    :requirement("earthenware_firing", 120)
    :requires_skill("fabrication", 2)
    :requires_skill("chemistry", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "light_bulb",
    result = "light_bulb",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :component("scrap", 1)
    :component("charcoal", 1)
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "battery_clay_array",
    result = "battery_clay_array",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("battery_car_clay", 4)
    :component("makeshift_transformer", 2)
    :component("2x4", 6)
    :component("nails", 12, true)
    :component("cable", 2)
    :quality("HAMMER", 2, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "cattail_jelly",
    result = "cattail_jelly",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("cattail_stalk", 4)
    :quality("CUT", 2, 1)
    :result_charges(7)
    :byproduct("plant_fibre", 1)
)

content.replace(content.Recipe {
    id = "chem_muriatic_acid",
    result = "chem_muriatic_acid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component("salt", 210)
    :component("chem_sulphuric_acid", 1)
    :component("water_clean", 1)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
)

-- abstracted chloralkali process, followed by 'burning' resulting chlorine and hydrogen with electric arc as
-- uv source and crucible serving as reaction furnace, then dissolving resulting hydrogen chloride gas in
-- water
content.replace(content.Recipe {
    id = "chem_muriatic_acid_by_electrolysis",
    result = "chem_muriatic_acid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 500)
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welder_crude", charges = 150 }
        })
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("salt_water", 4)
    :component("water_clean", 1)
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :requires_skill("mechanics", 2)
    :batch_discount(50, 5)
    :byproduct("lye", 2)
)

-- another variation of chloralkali process, now used to produce bleach (sodium hypochlorite - or rather
-- rough, technical grade hypochlorite/hydroxide/chloride mix), note we will not be heating anything and that
-- the (mostly) electrochemical reaction easily scales in size, some hydrogen gas could be recoverable
-- (optional byproduct)
content.replace(content.Recipe {
    id = "bleach",
    result = "bleach",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 250)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :batch_discount(90, 4)
    :result_charges(2)
)

-- abstracting using chloralkali process (hot solution, unpartitioned cell) to produce sodium chlorate, then
-- perchlorate by anodic oxidation on platinum, then ammonia perchlorate by double decomposition from sodium
-- perchlorate and ammonium chloride; while we can't directly use bleach here but we do end up recovering
-- some brine
content.replace(content.Recipe {
    id = "oxy_powder",
    result = "oxy_powder",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 750)
    :tool_charges("surface_heat", 25, true)
    :tool("platinum_small", 1)
    :component_any({
            { id = "salt_water", count = 4 },
            { id = "saline", count = 20 }
        })
    :component("ammonia_liquid", 1)
    :component("chem_muriatic_acid", 1)
    :quality("CHEM", 2, 1)
    :quality("BOIL", 1, 1)
    :requires_skill("electronics", 2)
    :batch_discount(60, 4)
    :byproduct("salt_water", 2)
)

content.replace(content.Recipe {
    id = "latex",
    result = "latex",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :component("spurge", 20)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
)

-- This is not actually accurate; producing rubber from formic acid and latex generally takes around 12
-- hours. However, it will be better if we simply create some kind of curing rubber, and let it naturally
-- evolve into rubber chunks from there. Nobody has twelve hours to watch rubber form in a zombie apocalypse.
content.replace(content.Recipe {
    id = "chunk_rubber",
    result = "chunk_rubber",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :component("latex", 5)
    :component("formic_acid", 2)
)

-- Should likely come from an entomology text, or something similar, in the future; but still relatively
-- basic.
content.replace(content.Recipe {
    id = "formic_acid",
    result = "formic_acid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "wasp_sting", count = 1 },
            { id = "bee_sting", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
)

content.add(content.Recipe {
    id = "bandages_birchbark",
    result = "bandages_birchbark",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    flags = { "BLIND_EASY" },
}
    :component("birchbark", 1)
    :component("cordage_short", 1, true)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bandages_birchbark_adv",
    result = "bandages_birchbark_adv",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    flags = { "BLIND_EASY" },
}
    :component("bandages_birchbark", 3)
    :component_any({
            { id = "chem_glycerol", count = 4 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component_any({
            { id = "garlic_clove", count = 6 },
            { id = "garlic", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :batch_discount(60, 2)
    :result_charges(3)
)

content.replace(content.Recipe {
    id = "chem_acetone",
    result = "chem_acetone",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 30, true)
    :component("chem_acetic_acid", 3)
    :component_any({
            { id = "material_limestone", count = 54 },
            { id = "material_quicklime", count = 24 }
        })
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "bandages_makeshift_from sheets",
    result = "bandages_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 6200,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 8,
}
    :component_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 }
        })
    :quality("CUT", 2, 1)
)

-- chloralkali process, same as with bleach except we won't be washing gases
-- This is a copy of the DDA recipe, with autolearn added.
content.replace(content.Recipe {
    id = "lye_by_electrolysis",
    result = "lye",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 250)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
)

content.replace(content.Recipe {
    id = "poppy_sleep",
    result = "poppy_sleep",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.replace(content.Recipe {
    id = "poppy_pain",
    result = "poppy_pain",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.replace(content.Recipe {
    id = "poppysyrup",
    result = "poppysyrup",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(5)
)

content.add(content.Recipe {
    id = "nail_from_bronze",
    result = "nail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.replace(content.Recipe {
    id = "wooden_post_long",
    result = "wooden_post_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    result_multiplier = 4,
}
    :component("wood_beam", 1)
    :quality("SAW_W", 2, 1)
)

content.replace(content.Recipe {
    id = "material_quicklime",
    result = "material_quicklime",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 250 },
            { id = "oxy_torch", charges = 50 }
        })
    :component("material_limestone", 50)
    :requires_skill("chemistry", 2)
    :batch_discount(75, 4)
    :result_charges(20)
)

content.replace(content.Recipe {
    id = "material_cement",
    result = "material_cement",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 250 },
            { id = "oxy_torch", charges = 50 }
        })
    :component("material_quicklime", 50)
    :component_any({
            { id = "material_sand", count = 50 },
            { id = "material_gravel", count = 50 }
        })
    :requires_skill("chemistry", 3)
    :batch_discount(75, 3)
)

content.replace(content.Recipe {
    id = "mortar_build",
    result = "mortar_build",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("concrete_mix_tool", 50)
    :component("material_cement", 50)
    :component("material_sand", 150)
    :component_any({
            { id = "water", count = 5 },
            { id = "water_clean", count = 5 }
        })
    :quality("CONTAIN", 1, 1)
    :batch_discount(75, 3)
)

content.replace(content.Recipe {
    id = "glass_shard",
    result = "glass_shard",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal", count = 1 },
            { id = "fire_brick", count = 1 },
            { id = "anvil", count = 1 },
            { id = "anvil_crude", count = 1 },
            { id = "anvil_bronze", count = 1 },
            { id = "casting_mold", count = 1 }
        })
    :tool_charges("forge", 26)
    :component("material_sand", 10)
    :component("ammonia_liquid", 1)
    :component_any({
            { id = "salt", count = 20 },
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 },
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :component_any({
            { id = "material_quicklime", count = 2 },
            { id = "bone_meal_any", count = 1, requirement = true }
        })
    :quality("CHEM", 1, 1)
    :requires_skill("chemistry", 4)
    :proficiency("prof_glassblowing")
    :batch_discount(35, 2)
)

-- Forest glass, as cited: https://etheses.whiterose.ac.uk/3464/1/287681.pdf
content.add(content.Recipe {
    id = "glass_shard_from ash",
    result = "glass_shard",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal", count = 1 },
            { id = "fire_brick", count = 1 },
            { id = "anvil", count = 1 },
            { id = "anvil_crude", count = 1 },
            { id = "anvil_bronze", count = 1 },
            { id = "casting_mold", count = 1 }
        })
    :tool_charges("forge", 26)
    :component("material_sand", 10)
    :component("ash", 50)
    :component_any({
            { id = "material_quicklime", count = 2 },
            { id = "material_limestone", count = 2 }
        })
    :quality("CHEM", 1, 1)
    :requires_skill("chemistry", 4)
    :proficiency("prof_glassblowing")
    :batch_discount(30, 2)
)

content.replace(content.Recipe {
    id = "glass_tinted",
    result = "glass_tinted",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("tongs", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal_small", count = 1 },
            { id = "sheet_metal", count = 1 }
        })
    :tool_charges("forge", 60)
    :component("glass_shard", 2)
    :component("chem_sulphur", 1)
    :component("scrap", 1)
    :component("charcoal", 1)
    :quality("CHEM", 1, 1)
    :proficiency("prof_glassblowing")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "sheet_fibercloth",
    result = "sheet_fibercloth",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :tool("loom_frame", 1)
    :tool("shed_stick", 1)
    :component("plant_fibre", 5)
    :quality("CUT", 2, 1)
    :proficiency("prof_weaving")
)

content.replace(content.Recipe {
    id = "lc_steel_lump",
    result = "lc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 64 },
            { id = "charcoal", count = 40 }
        })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.replace(content.Recipe {
    id = "mc_steel_lump",
    result = "mc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 77 },
            { id = "charcoal", count = 48 }
        })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.replace(content.Recipe {
    id = "hc_steel_lump",
    result = "hc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 90 },
            { id = "charcoal", count = 68 }
        })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.replace(content.Recipe {
    id = "steel_lump_from_other_steel",
    result = "steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("metal_tank", 1)
    :tool_charges("forge", 200)
    :component_any({
            { id = "hc_steel_lump", count = 1 },
            { id = "hc_steel_chunk", count = 4 },
            { id = "mc_steel_lump", count = 1 },
            { id = "mc_steel_chunk", count = 4 },
            { id = "lc_steel_lump", count = 1 },
            { id = "lc_steel_chunk", count = 4 }
        })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

-- Abstracted production of chitosan, using acid to demineralise chitin powder then lye to deacetylate.
content.add(content.Recipe {
    id = "plastic_chunk_from chitin",
    result = "plastic_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    result_multiplier = 15,
}
    :tool_charges("surface_heat", 30, true)
    :component("meal_chitin_piece", 30)
    :component_any({
            { id = "lye", count = 4 },
            { id = "lye_potassium", count = 6 }
        })
    :component("any_strong_acid", 1, true)
    :quality("CHEM", 2, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(80, 2)
)

content.replace(content.Recipe {
    id = "scrap_bronze",
    result = "scrap_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "tin", count = 12 },
            { id = "aluminum_foil", count = 371 },
            { id = "chem_aluminium_powder", count = 29 },
            { id = "can_drink", count = 2 },
            { id = "scrap_aluminum", count = 1 }
        })
    :component("copper_scrap_equivalent", 1, true)
    :requirement("forging_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :batch_discount(90, 4)
)

content.replace(content.Recipe {
    id = "bandages",
    result = "bandages",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    result_multiplier = 3,
}
    :component_any({
            { id = "cotton_patchwork", count = 3 },
            { id = "medical_gauze", count = 1 },
            { id = "fibercloth_patchwork", count = 3 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "medical_tape", count = 5 }
        })
    :component_any({
            { id = "disinfectant", count = 5 },
            { id = "thyme_oil", count = 1 },
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "methed_alcohol", count = 250 }
        })
)

content.replace(content.Recipe {
    id = "arm_xlsplint",
    result = "arm_xlsplint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "fibercloth_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 },
            { id = "mop", count = 2 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "arm_splint",
    result = "arm_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 5 },
            { id = "fibercloth_patchwork", count = 5 },
            { id = "medical_gauze", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 },
            { id = "medical_tape", count = 25 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "mop", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "arm_xs_splint",
    result = "arm_xs_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "fibercloth_patchwork", count = 2 },
            { id = "medical_gauze", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 10 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "leg_splint",
    result = "leg_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "fibercloth_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 },
            { id = "mop", count = 2 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "leg_xlsplint",
    result = "leg_xlsplint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "fibercloth_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 4 },
            { id = "broom", count = 4 },
            { id = "2x4", count = 4 },
            { id = "pool_cue", count = 4 },
            { id = "mop", count = 4 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "leg_xs_splint",
    result = "leg_xs_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 5 },
            { id = "fibercloth_patchwork", count = 10 },
            { id = "medical_gauze", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.replace(content.Recipe {
    id = "makeshift_crutches",
    result = "makeshift_crutches",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "fibercloth_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 }
        })
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :proficiency("prof_carpentry_basic")
)

content.replace(content.Recipe {
    id = "pilot_light",
    result = "pilot_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap", 3)
    :component("cable", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("mechanics", 2)
)

content.replace(content.Recipe {
    id = "water_faucet",
    result = "water_faucet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("plastic_chunk", 1)
    :component("pipe_fittings", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("mechanics", 1)
    :proficiency("prof_metalworking", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_plumbing", { required = false, time_multiplier = 3, skill_penalty = 0.5 })
)

content.replace(content.Recipe {
    id = "well_pump",
    result = "well_pump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 2340000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :component_any({
            { id = "steel_chunk_any", count = 6, requirement = true },
            { id = "scrap", count = 18 }
        })
    :component("pipe", 2)
    :component("adhesive", 2, true)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("GLARE", 1, 1)
    :requirement("blacksmithing_standard", 8)
    :book("textbook_fabrication", 4)
    :book("manual_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "makeshift_transformer",
    result = "makeshift_transformer",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 123000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cable", 7)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :requires_skill("electronics", 1)
)

content.replace(content.Recipe {
    id = "motor_micro",
    result = "motor_micro",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 126000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "e_scrap", count = 1 },
            { id = "makeshift_transformer", count = 1 }
        })
    :component("scrap", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 3)
)

content.replace(content.Recipe {
    id = "motor_tiny",
    result = "motor_tiny",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 1)
    :component_any({
            { id = "e_scrap", count = 3 },
            { id = "makeshift_transformer", count = 3 }
        })
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 5)
    :requirement("steel_chunk_any", 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
)

content.replace(content.Recipe {
    id = "motor_small",
    result = "motor_small",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "e_scrap", count = 5 },
            { id = "makeshift_transformer", count = 5 }
        })
    :component("cable", 2)
    :quality("HAMMER", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requirement("steel_standard", 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
)

content.replace(content.Recipe {
    id = "vehicle_controls",
    result = "vehicle_controls",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component("pipe", 6)
    :component_any({
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :component("wire", 3)
    :component("cable", 4)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.replace(content.Recipe {
    id = "electronics_controls",
    result = "electronics_controls",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "e_scrap", count = 5 },
            { id = "makeshift_transformer", count = 5 }
        })
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component("cable", 2)
    :component("plastic_chunk", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 40)
    :requires_skill("mechanics", 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "vac_pump",
    result = "vac_pump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 2)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("gasket_plastic", 2)
    :component("well_pump", 1)
    :component_any({
            { id = "drivebelt", count = 1 },
            { id = "drivebelt_makeshift", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :requirement("welding_standard", 10)
    :requirement("blacksmithing_standard", 5)
    :requires_skill("mechanics", 2)
    :book("textbook_extraction", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.replace(content.Recipe {
    id = "drivebelt_makeshift",
    result = "drivebelt_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "leather_belt", count = 1 },
            { id = "rope_superior_short", count = 1, requirement = true }
        })
    :component("duct_tape", 20)
    :quality("CUT", 2, 1)
    :book("mag_fieldrepair", 1)
)

content.add(content.Recipe {
    id = "foot_crank",
    result = "foot_crank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("metal_file", 1)
    :component("simple_crank", 2)
    :component("sheet_metal", 1)
    :component("chain", 3)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("mechanics", 2)
    :proficiency("prof_metalworking", { required = false, time_multiplier = 1.5 })
)

content.replace(content.Recipe {
    id = "power_supply",
    result = "power_supply",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "amplifier", count = 2 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 3)
    :book("manual_electronics", 1)
    :book("textbook_electronics", 2)
    :book("advanced_electronics", 2)
)

-- This is the old, completely inaccurate and frankly just terrible recipe from the mainline. It was ported
-- to Innawoods for the sake of not removing the ability to learn electronics for players but it should
-- ideally be changed/replaced.
content.add(content.Recipe {
    id = "antenna_innawood",
    result = "antenna",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 18000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "electronics",
}
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 3 },
            { id = "knife_butter", count = 2 }
        })
    :quality("SAW_M", 1, 1)
)

content.replace(content.Recipe {
    id = "battery_charger",
    result = "battery_charger",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "duct_tape", count = 10 }
        })
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 0)
    :book("mag_electronics", 1)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "makeshift_hand_crank_charger",
    result = "makeshift_hand_crank_charger",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "casting_mold_small", count = 1 },
            { id = "casting_mold_small", count = 1 }
        })
    :component("2x4", 3)
    :component("copper_scrap_equivalent", 10, true)
    :component("stick", 1)
    :component("copper_wire", 1)
    :component("rope_any_short", 2, true)
    :component("chunk_magnetite", 1)
    :quality("HAMMER", 2, 1)
    :quality("ANVIL", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("forging_standard", 1)
    :requires_skill("electronics", 2)
    :learn_by_disassembly("fabrication", 3)
    :learn_automatically("electronics", 2)
    :proficiency("prof_elec_circuits")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_redsmithing")
)

content.replace(content.Recipe {
    id = "condensor_coil",
    result = "condensor_coil",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("cu_pipe", 3)
    :component("motor_tiny", 1)
    :component("sheet_metal_small", 5)
    :component_any({
            { id = "scrap", count = 12 },
            { id = "steel_chunk_any", count = 4, requirement = true }
        })
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("soldering_standard", 10)
)

content.replace(content.Recipe {
    id = "evaporator_coil",
    result = "evaporator_coil",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("cu_pipe", 4)
    :component("sheet_metal_small", 8)
    :component("sheet_metal", 2)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 2, 1)
    :requirement("soldering_standard", 50)
)

content.replace(content.Recipe {
    id = "light_minus_disposable_cell",
    result = "light_minus_disposable_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    flags = { "FULL_MAGAZINE" },
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_manganese_dioxide", 29)
    :component("zinc_metal", 8)
    :component("chem_potassium_hydroxide", 7)
    :component("duct_tape", 1)
    :component("water_clean", 1)
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 2 }
        })
    :requirement("blacksmithing_standard", 1)
    :requires_skill("electronics", 5)
)

content.replace(content.Recipe {
    id = "filter_air_makeshift",
    result = "filter_air_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "plastic_bottles_any", count = 1, requirement = true },
            { id = "can_medium", count = 1 }
        })
    :component("paper", 50)
    :component("duct_tape", 20)
    :quality("CUT", 2, 1)
)

content.replace(content.Recipe {
    id = "chemistry_set_basic",
    result = "chemistry_set_basic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "glass_goggles", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "hose", count = 3 },
            { id = "makeshift_hose", count = 3 }
        })
    :component_any({
            { id = "flask_glass", count = 4 },
            { id = "jar_glass_sealed", count = 4 },
            { id = "bottle_glass", count = 4 },
            { id = "test_tube", count = 20 }
        })
    :component_any({
            { id = "box_small", count = 1 },
            { id = "bag_canvas", count = 1 },
            { id = "backpack", count = 1 },
            { id = "backpack_leather", count = 1 },
            { id = "rucksack", count = 1 }
        })
    :requires_skill("chemistry", 2)
    :learn_by_disassembly("fabrication", 0)
)

content.replace(content.Recipe {
    id = "chemistry_set",
    result = "chemistry_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "cable", count = 4 },
            { id = "wire", count = 1 }
        })
    :component("hotplate", 1)
    :component("chemistry_set_basic", 1)
    :requires_skill("chemistry", 2)
    :learn_by_disassembly("fabrication", 0)
)

content.replace(content.Recipe {
    id = "duct_tape",
    result = "duct_tape",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("glue_strong", 1)
    :component_any({
            { id = "cotton_patchwork", count = 8 },
            { id = "fibercloth_patchwork", count = 8 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fibercloth", count = 1 }
        })
    :component("plastic_chunk", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :requirement("filament", 50)
    :result_charges(40)
)

content.replace(content.Recipe {
    id = "pipe_cleaner",
    result = "pipe_cleaner",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component_any({
            { id = "wire", count = 2 },
            { id = "lc_wire", count = 2 },
            { id = "mc_wire", count = 2 },
            { id = "hc_wire", count = 2 },
            { id = "qt_wire", count = 2 },
            { id = "ch_wire", count = 2 },
            { id = "cable", count = 1 }
        })
    :component_any({
            { id = "yarn", count = 1 },
            { id = "cotton_ball", count = 1 },
            { id = "wool_staple", count = 1 }
        })
)

content.replace(content.Recipe {
    id = "funnel_separation",
    result = "funnel_separation",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :component("plastic_chunk", 1)
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "still_lab",
    result = "still_lab",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "thermometer",
    result = "thermometer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "test_tube", count = 2 },
            { id = "marble", count = 25 }
        })
    :component("chem_ethanol", 10)
    :quality("CHISEL", 3, 1)
    :requirement("dye_cloth", 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "yoke_harness",
    result = "yoke_harness",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 1 },
            { id = "fur", count = 8 },
            { id = "tanned_pelt", count = 1 }
        })
    :component("2x4", 4)
    :component("rope_superior_short", 2, true)
    :quality("HAMMER", 1, 1)
    :requirement("sewing_standard", 100)
    :book("textbook_fabrication", 5)
    :book("textbook_carpentry", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- The tailoring kit is an expanded sewing kit, so a bone/wood needle is inappropriate.
content.replace(content.Recipe {
    id = "tailors_kit",
    result = "tailors_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
    flags = { "BLIND_EASY" },
}
    :component("sewing_kit", 1)
    :component("scissors", 1)
    :component("kevlar_shears", 1)
    :component("knitting_needles", 1)
    :component("awl_steel", 1)
    :component("needle_curved", 1)
    :component_any({
            { id = "splinter", count = 3 },
            { id = "bone", count = 2 }
        })
    :component("leather", 2)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
)

content.replace(content.Recipe {
    id = "training_dummy_light",
    result = "training_dummy_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("wood_panel", 1)
    :component("2x4", 2)
    :component("nails", 30, true)
    :component_any({
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 50 },
            { id = "paint", count = 25, requirement = true },
            { id = "charcoal", count = 10 }
        })
    :component_any({
            { id = "2x4", count = 4 },
            { id = "log", count = 1 },
            { id = "wood_beam", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :proficiency("prof_carpentry_basic")
)

content.replace(content.Recipe {
    id = "mop",
    result = "mop",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "fibercloth_patchwork", count = 4 }
        })
    :quality("CUT", 2, 1)
    :requirement("cordage", 1)
    :proficiency("prof_carving")
)

content.replace(content.Recipe {
    id = "mirror",
    result = "mirror",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component("glass_shard", 3)
    :component("silver_small", 10)
    :proficiency("prof_glassblowing", { required = false, time_multiplier = 6 })
)

content.replace(content.Recipe {
    id = "steam_watts_small",
    result = "steam_watts_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("pipe", 16)
    :component_any({
            { id = "scrap", count = 90 },
            { id = "steel_chunk_any", count = 30, requirement = true },
            { id = "steel_lump_any", count = 10, requirement = true }
        })
    :component("chain", 4)
    :component("spring", 4)
    :component("30gal_drum", 3)
    :component_any({
            { id = "filter_air", count = 1 },
            { id = "filter_air_makeshift", count = 1 }
        })
    :component("well_pump", 2)
    :component("cable", 14)
    :component("frame", 1)
    :component("steel_plate", 8)
    :component_any({
            { id = "water", count = 150 },
            { id = "water_clean", count = 150 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 20)
    :proficiency("prof_basic_engines")
    :proficiency("prof_welding_basic")
)

content.replace(content.Recipe {
    id = "alternator_bicycle",
    result = "alternator_bicycle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 2)
    :component("makeshift_transformer", 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 4)
    :requirement("steel_chunk_any", 1)
    :requires_skill("fabrication", 3)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.replace(content.Recipe {
    id = "alternator_motorbike",
    result = "alternator_motorbike",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 10)
    :component("makeshift_transformer", 4)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 4)
    :requirement("steel_chunk_any", 1)
    :requires_skill("fabrication", 4)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.replace(content.Recipe {
    id = "still",
    result = "still",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1200000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("material_sand", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "pot_makeshift_copper", count = 1 }
        })
    :component("cu_pipe", 1)
    :component_any({
            { id = "glue_weak", count = 150 },
            { id = "glue_strong", count = 1 }
        })
    :component("duct_tape", 10)
    :quality("DRILL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requires_skill("chemistry", 3)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "jack",
    result = "jack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("swage", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 10)
    :requirement("steel_standard", 5)
    :requires_skill("mechanics", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.replace(content.Recipe {
    id = "jack_makeshift",
    result = "jack_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 4)
    :component("scrap", 2)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("mechanics", 1)
)

content.replace(content.Recipe {
    id = "jack_small",
    result = "jack_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1200000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 4)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 5)
    :requires_skill("mechanics", 2)
    :proficiency("prof_metalworking")
)

content.replace(content.Recipe {
    id = "sewing_kit",
    result = "sewing_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("tongs", 1)
    :tool("hotcut", 1)
    :component("scrap", 2)
    :component_any({
            { id = "splinter", count = 5 },
            { id = "bone", count = 2 }
        })
    :component("leather", 2)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "scissors_wooden_handle",
    result = "scissors",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("hotcut", 1)
    :component("scrap", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_scrap", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_toolsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_bladesmith", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_carving", { required = false, time_multiplier = 1.5 })
    :byproduct("splinter", 5)
)

content.replace(content.Recipe {
    id = "jar_3l_glass_sealed",
    result = "jar_3l_glass_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 150)
    :component_any({
            { id = "glass_shard", count = 5 },
            { id = "flask_glass", count = 5 },
            { id = "test_tube", count = 10 },
            { id = "marble", count = 125 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "bottle_glass",
    result = "bottle_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "jar_glass_sealed",
    result = "jar_glass_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 50)
    :component_any({
            { id = "glass_shard", count = 2 },
            { id = "flask_glass", count = 2 },
            { id = "test_tube", count = 4 },
            { id = "marble", count = 50 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "flask_glass",
    result = "flask_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 25)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "test_tube", count = 2 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "test_tube",
    result = "test_tube",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 24000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 2,
}
    :tool("tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 5)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 3, 1)
    :proficiency("prof_glassblowing")
)

content.replace(content.Recipe {
    id = "bag_canvas_small",
    result = "bag_canvas_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "fibercloth_patchwork", count = 2 }
        })
    :requirement("filament", 50)
    :requirement("cordage_short", 1)
)

content.replace(content.Recipe {
    id = "bag_canvas",
    result = "bag_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "cotton_patchwork", count = 12 },
            { id = "fibercloth_patchwork", count = 12 }
        })
    :requirement("filament", 300)
    :requirement("cordage", 1)
)

content.replace(content.Recipe {
    id = "water_purifier",
    result = "water_purifier",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 8 }
        })
    :component_any({
            { id = "bottle_glass", count = 2 },
            { id = "plastic_bottles_4l", count = 2, requirement = true }
        })
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("scrap", 3)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 2)
)

content.replace(content.Recipe {
    id = "soldering_iron",
    result = "soldering_iron",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "e_scrap", count = 2 },
            { id = "glowplug", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "copper", count = 1 },
            { id = "nails", count = 1, requirement = true },
            { id = "wire", count = 1 }
        })
    :component("scrap", 1)
    :component("duct_tape", 10)
    :component("cable", 2)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 2)
    :book("textbook_anarch", 2)
    :proficiency("prof_elec_soldering", { skill_penalty = 0.125 })
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "soldering_iron_portable",
    result = "soldering_iron_portable",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "e_scrap", count = 2 },
            { id = "glowplug", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "copper", count = 1 },
            { id = "nails", count = 1, requirement = true },
            { id = "wire", count = 1 }
        })
    :component("scrap", 1)
    :component("duct_tape", 10)
    :component("cable", 2)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 2)
    :book("textbook_anarch", 2)
    :proficiency("prof_elec_soldering", { skill_penalty = 0.125 })
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "hotplate",
    result = "hotplate",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 4 }
        })
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 1 }
        })
    :component_any({
            { id = "scrap", count = 2 },
            { id = "pan", count = 1 },
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "knife_huge", count = 2 },
            { id = "knife_small", count = 6 },
            { id = "knife_butter", count = 6 },
            { id = "muffler", count = 1 }
        })
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 2)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "coffeemaker",
    result = "coffeemaker",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 4 }
        })
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 1 }
        })
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "sieve_steel", count = 1 },
            { id = "colander_steel", count = 1 },
            { id = "splatter_guard", count = 1 }
        })
    :component_any({
            { id = "scrap", count = 2 },
            { id = "pan", count = 1 },
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "knife_huge", count = 2 },
            { id = "knife_small", count = 6 },
            { id = "knife_butter", count = 6 },
            { id = "muffler", count = 1 }
        })
    :component("cable", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :learn_by_disassembly("electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "dehydrator",
    result = "dehydrator",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 2 }
        })
    :component_any({
            { id = "amplifier", count = 2 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component("power_supply", 1)
    :component("cable", 4)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 }
        })
    :component("plastic_chunk", 18)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 20)
    :learn_by_disassembly("electronics", 4)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("textbook_chemistry", 5)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "makeshift_sealer",
    result = "makeshift_sealer",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("scrap", 4)
    :component("plastic_chunk", 2)
    :component("motor_micro", 1)
    :component("glue_strong", 2)
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 2 }
        })
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("power_supply", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.replace(content.Recipe {
    id = "makeshift_vacuum_mold",
    result = "makeshift_vacuum_mold",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("2x4", 4)
    :component("plastic_chunk", 2)
    :component("motor_micro", 1)
    :component("nails", 16, true)
    :component("wood_panel", 1)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("power_supply", 1)
    :quality("VISE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_W", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_carpentry_basic")
)

content.replace(content.Recipe {
    id = "food_processor",
    result = "food_processor",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("scrap", 4)
    :component("cable", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 }
        })
    :component("motor_micro", 1)
    :component_any({
            { id = "e_scrap", count = 1 },
            { id = "makeshift_transformer", count = 1 }
        })
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 3, 1)
    :requirement("soldering_standard", 20)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "microcentrifuge",
    result = "microcentrifuge",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("sheet_metal_small", 2)
    :component("steel_chunk_any", 4, true)
    :component("cable", 1)
    :component("motor_small", 1)
    :component("2x4", 1)
    :component("adhesive", 1, true)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 3, 1)
    :quality("CUT_FINE", 1, 1)
    :requirement("soldering_standard", 30)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "xacto",
    result = "xacto",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("hotcut", 1)
    :component("scrap", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "blacksmith_kit",
    result = "blacksmith_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "BLIND_EASY" },
}
    :component("metalworking_tongs", 1)
    :component("metal_file", 1)
    :component("hammer", 1)
    :component_any({
            { id = "clay_canister", count = 1 },
            { id = "bowl_clay", count = 1 },
            { id = "jug_clay", count = 1 }
        })
)

content.add(content.Recipe {
    id = "hammer_sledge",
    result = "hammer_sledge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 13)
)

content.replace(content.Recipe {
    id = "hammer_sledge_short_forged",
    result = "hammer_sledge_short",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 14)
)

content.replace(content.Recipe {
    id = "hammer_sledge_heavy",
    result = "hammer_sledge_heavy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 20)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 13)
)

content.replace(content.Recipe {
    id = "metalworking_tongs_bronze",
    result = "metalworking_tongs_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "nails", count = 1, requirement = true },
            { id = "nuts_bolts", count = 1 }
        })
    :requirement("blacksmithing_standard", 3)
    :requirement("bronze_tiny", 3)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.replace(content.Recipe {
    id = "metalworking_tongs_bronze_casting",
    result = "metalworking_tongs_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 750000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "casting_mold_large", count = 1 },
            { id = "casting_mold_long", count = 1 }
        })
    :component_any({
            { id = "nails", count = 1, requirement = true },
            { id = "nuts_bolts", count = 1 }
        })
    :requirement("forging_standard", 3)
    :requirement("bronze_tiny", 3)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_toolsmithing")
)

content.replace(content.Recipe {
    id = "reading_light",
    result = "reading_light",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("plastic_chunk", 1)
    :component("glue_strong", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component_any({
            { id = "light_bulb", count = 1 },
            { id = "e_scrap", count = 1 }
        })
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 2)
)

content.replace(content.Recipe {
    id = "electric_lantern",
    result = "electric_lantern",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 3)
    :component("plastic_chunk", 2)
    :component("circuit", 2)
    :component_any({
            { id = "e_scrap", count = 2 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 7)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
)

content.replace(content.Recipe {
    id = "flashlight",
    result = "flashlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "scrap", count = 4 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "bottle_glass", count = 1 },
            { id = "plastic_bottles_any", count = 1, requirement = true }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("cable", 4)
    :learn_by_disassembly("electronics", 0)
)

content.replace(content.Recipe {
    id = "floodlight",
    result = "floodlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "amplifier", count = 4 },
            { id = "makeshift_transformer", count = 8 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "scrap", count = 6 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 4 },
            { id = "light_bulb", count = 4 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
)

content.replace(content.Recipe {
    id = "directed_floodlight",
    result = "directed_floodlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "amplifier", count = 4 },
            { id = "makeshift_transformer", count = 8 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "scrap", count = 6 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 4 },
            { id = "light_bulb", count = 4 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
)

content.replace(content.Recipe {
    id = "car_headlight",
    result = "car_headlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "amplifier", count = 2 },
            { id = "makeshift_transformer", count = 4 }
        })
    :component_any({
            { id = "plastic_chunk", count = 2 },
            { id = "scrap", count = 3 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 2 },
            { id = "light_bulb", count = 2 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
)

content.replace(content.Recipe {
    id = "car_wide_headlight",
    result = "car_wide_headlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "amplifier", count = 3 },
            { id = "makeshift_transformer", count = 6 }
        })
    :component_any({
            { id = "plastic_chunk", count = 3 },
            { id = "scrap", count = 4 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 3 },
            { id = "light_bulb", count = 3 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.5 })
)

content.replace(content.Recipe {
    id = "wearable_light",
    result = "wearable_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("flashlight", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "leather", count = 2 },
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :quality("CUT", 2, 1)
    :book("textbook_fabrication", 0)
    :book("manual_fabrication", 0)
    :book("mag_electronics", 0)
)

content.replace(content.Recipe {
    id = "standing_lamp",
    result = "standing_lamp",
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
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("steel_lump_any", 1, true)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
)

content.replace(content.Recipe {
    id = "standing_floodlight",
    result = "standing_floodlight",
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
    :component_any({
            { id = "amplifier", count = 1 },
            { id = "makeshift_transformer", count = 2 }
        })
    :component("floodlight", 1)
    :component("steel_lump_any", 1, true)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
)
