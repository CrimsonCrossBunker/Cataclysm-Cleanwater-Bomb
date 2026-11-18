local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "primitive_hammer",
    result = "primitive_hammer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock", 1)
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 1 },
            { id = "material_gravel", count = 1 }
        })
    :component_any({
            { id = "cordage_short", count = 1, requirement = true },
            { id = "filament", count = 50, requirement = true }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :requires_skill("fabrication", 3)
)

content.add(content.Recipe {
    id = "primitive_knife",
    result = "primitive_knife",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 5,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock_flaking_any", 1, true)
    :component_any({
            { id = "cordage_short", count = 1, requirement = true },
            { id = "filament", count = 50, requirement = true }
        })
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("PUNCH", 1, 1)
    :quality("CUT", 1, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "digging_stick",
    result = "digging_stick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 3, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "primitive_shovel",
    result = "primitive_shovel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("2x4", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 3, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "primitive_shovel_blade_from_log",
    result = "primitive_shovel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("log", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 3, skill_penalty = 0 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "copper_ax",
    result = "copper_ax",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("scrap_copper", 1)
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :quality("HAMMER", 1, 1)
    :book("mag_survival", 1)
    :book("atomic_survival", 1)
    :book("textbook_carpentry", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
)

content.add(content.Recipe {
    id = "primitive_axe",
    result = "primitive_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 4,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock_flaking_any", 1, true)
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "primitive_axe_by grinding",
    result = "primitive_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 5,
}
    :tool("fire", 1)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock", 1)
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 1 },
            { id = "material_gravel", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :requires_skill("fabrication", 2)
    :book("mag_survival", 1)
    :book("atomic_survival", 1)
    :book("textbook_carpentry", 2)
)

content.add(content.Recipe {
    id = "sickle_stone",
    result = "sickle_stone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock_flaking_any", 1, true)
    :component("cordage_short", 2, true)
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("PUNCH", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "primitive_adze",
    result = "primitive_adze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component_any({
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "rock_flaking_any", count = 1, requirement = true }
        })
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "rock_quern",
    result = "rock_quern",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("rock_large", 2)
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 1 },
            { id = "material_gravel", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("DRILL_ROCK", 1, 1)
    :requires_skill("survival", 4)
    :book("atomic_survival", 1)
    :book("textbook_survival", 1)
    :book("cookbook", 3)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "fire_drill",
    result = "fire_drill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("stick", 1)
    :component("splinter", 1)
    :quality("CUT", 1, 1)
    :requirement("cordage_short", 1)
)

content.add(content.Recipe {
    id = "fire_drill_large",
    result = "fire_drill_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("stick", 1)
    :component_any({
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 }
        })
    :quality("CUT", 1, 1)
    :quality_any({
            { id = "DRILL_ROCK", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 }
        })
    :requirement("cordage_short", 1)
)

content.add(content.Recipe {
    id = "notched_plank",
    result = "notched_plank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    flags = { "FULL_MAGAZINE" },
    result_multiplier = 4,
}
    :component("2x4", 1)
    :quality_any({
            { id = "CUT", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 },
            { id = "DRILL_ROCK", level = 1, count = 1 }
        })
)

content.add(content.Recipe {
    id = "notched_stick",
    result = "notched_stick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    flags = { "FULL_MAGAZINE" },
    result_multiplier = 4,
}
    :component("stick", 1)
    :quality_any({
            { id = "CUT", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 },
            { id = "DRILL_ROCK", level = 1, count = 1 }
        })
)

content.add(content.Recipe {
    id = "billet_bone",
    result = "billet_bone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bone_sturdy", 1, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

-- As of writing, a stick/plank is 130 cm, a splinter is 30 cm, this is intentionally 'generous' because this
-- is rounded up and material tends to be uneven anyways
content.add(content.Recipe {
    id = "billet_wood",
    result = "billet_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :byproduct("splinter", 4)
)

content.add(content.Recipe {
    id = "drill_rock_primitive",
    result = "drill_rock_primitive",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "stone_chisel",
    result = "stone_chisel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :component("rock", 1)
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 1 },
            { id = "material_gravel", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "stone_chopper",
    result = "stone_chopper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("rock_flaking_any", 1, true)
    :quality("HAMMER", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "hand_axe",
    result = "hand_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 324000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 4,
}
    :component("rock_flaking_any", 1, true)
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "leather_filing",
    result = "leather_filing",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("material_sand", 1)
    :component("leather", 1)
)

-- Carving notches into the sticks (~15m), looping and knotting the string to sit securely in them (~30m),
-- testing/misc/overhead (~5m)
-- Pop culture magazine lacks most helpful information, requires inferring and therefore doesn't learn the
-- recipe until survival 2
content.add(content.Recipe {
    id = "light_snare_kit",
    result = "light_snare_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "survival",
    difficulty = 3,
}
    :component("pointy_stick", 2)
    :component("rock", 1)
    :component("string_36", 1)
    :quality("CUT", 1, 1)
    :learn_by_disassembly("survival", 1)
    :book("mag_survival", 2)
    :book("pocket_survival", 1)
    :book("manual_survival", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :proficiency("prof_carving", { max_experience_turns = 900 })
    :proficiency("prof_fibers", { max_experience_turns = 1800 })
)

content.add(content.Recipe {
    id = "weather_glass",
    result = "weather_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 150)
    :tool("casting_mold_long", 1)
    :component_any({
            { id = "glass_shard", count = 27 },
            { id = "flask_glass", count = 40 },
            { id = "test_tube", count = 40 }
        })
    :component_any({
            { id = "water", count = 15 },
            { id = "water_clean", count = 15 }
        })
    :quality("CHISEL", 3, 1)
    :requires_skill("chemistry", 4)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "glass_thermometer",
    result = "glass_thermometer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 150)
    :component_any({
            { id = "glass_shard", count = 27 },
            { id = "flask_glass", count = 40 },
            { id = "test_tube", count = 40 }
        })
    :component("mercury", 5)
    :quality("CHISEL", 3, 1)
    :requires_skill("chemistry", 4)
    :proficiency("prof_glassblowing")
)

-- Slow sand biofilter:
-- https://wwwnc.cdc.gov/travel/yellowbook/2024/preparing/water-disinfection#:~:text=Figure%202%2D02.%20Emergency%20gravel%20and%20sand%20filter
-- Density of sand is around 1.6g/cm^3. Gravel is similar. In a 10 in diameter bucket, 4 in of gravel is
-- about 8 kg and 10 in of sand is about 20 kg.
content.add(content.Recipe {
    id = "water_filter_sand",
    result = "water_filter_sand",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 2,
}
    :component_any({
            { id = "bucket_5gal", count = 1 },
            { id = "clay_watercont", count = 1 },
            { id = "clay_watercont_no_lid", count = 1 }
        })
    :component("material_sand", 2500)
    :component("material_gravel", 1000)
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "wire_mesh", count = 4 }
        })
    :requires_skill("survival", 2)
)
