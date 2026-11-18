local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "screwdriver",
    result = "screwdriver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("wood_block", 1)
    :quality("DRILL", 1, 1)
    :quality("FILE", 1, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "screwdriver_set_forged",
    result = "screwdriver_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 2 },
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("SAW_M", 2, 1)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "socket_screwdriver_set",
    result = "socket_screwdriver_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("SAW_M", 2, 1)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "picklocks",
    result = "picklocks",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "flint_steel",
    result = "flint_steel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("hc_steel_chunk", 1)
    :component("flint", 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "tongs",
    result = "tongs",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { required = true })
    :proficiency("prof_toolsmithing", { required = true })
)

content.add(content.Recipe {
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
    :requirement("bronze_punch", 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing", { required = true })
)

content.add(content.Recipe {
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
    :proficiency("prof_toolsmithing", { required = true })
)

content.add(content.Recipe {
    id = "metalworking_tongs",
    result = "metalworking_tongs",
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
    :requirement("steel_chunk_any", 3)
    :requirement("metal_punch", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "metalworking_tongs_casting",
    result = "metalworking_tongs",
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
    :component("steel_chunk_any", 3, true)
    :component_any({
            { id = "nails", count = 1, requirement = true },
            { id = "nuts_bolts", count = 1 }
        })
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_toolsmithing")
)

-- Specifically avoids blacksmithing requirement groups so that it's craftable without the metal fileset -
-- this process would still be possible, just realistically take slightly longer.
content.add(content.Recipe {
    id = "chisel",
    result = "chisel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_fabrication", 3)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

-- Specifically avoids blacksmithing requirement groups so that it's craftable without the metal fileset -
-- this process would still be possible, just realistically take slightly longer.
content.add(content.Recipe {
    id = "chisel_bronze",
    result = "chisel_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("scrap_bronze", 2)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 3)
    :book("textbook_fabrication", 3)
    :book("textbook_weparabic", 5)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "swage",
    result = "swage",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hotcut",
    result = "hotcut",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "drift",
    result = "drift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "temper_block",
    result = "temper_block",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :quality("HAMMER", 3, 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("mc_steel_standard", 2)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "hammer",
    result = "hammer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :requirement("metal_punch", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hammer_bronze",
    result = "hammer_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("casting_mold_small", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component("scrap_bronze", 2)
    :quality("ANVIL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requirement("forging_standard", 4)
    :requirement("bronze_punch", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "bronze_axe",
    result = "bronze_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "cordage_short", count = 2, requirement = true }
        })
    :component("scrap_bronze", 10)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "nail_puller_bronze",
    result = "nail_puller_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 10)
    :quality("ANVIL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requirement("forging_standard", 8)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "saw_bronze",
    result = "saw_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 20)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("ANVIL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requirement("forging_standard", 8)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hand_drill",
    result = "hand_drill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 840000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 },
            { id = "splinter", count = 6 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "metal_smoother",
    result = "metal_smoother",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "wood_smoother",
    result = "wood_smoother",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 48000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("nails", 8, true)
    :component("2x4", 3)
    :quality("HAMMER", 2, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "chipper",
    result = "chipper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "paint_brush",
    result = "paint_brush",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("cotton_patchwork", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "needle_curved",
    result = "needle_curved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 2)
    :requirement("blacksmithing_scrap", 2)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "needle_steel",
    result = "needle_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 1)
    :requirement("blacksmithing_scrap", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "wrench",
    result = "wrench",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "scrap", count = 9 },
            { id = "steel_chunk_any", count = 2, requirement = true }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "wrench_small",
    result = "wrench_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "wrench_large",
    result = "wrench_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "lug_wrench",
    result = "lug_wrench",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 7)
    :requirement("steel_chunk_any", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "pliers",
    result = "pliers",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "scrap", count = 1 }
        })
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "big_pliers",
    result = "big_pliers",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "scrap", count = 1 }
        })
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "pliers_locking",
    result = "pliers_locking",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "scrap", count = 1 }
        })
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hacksaw",
    result = "hacksaw",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1920000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("manual_mechanics", 3)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "tin_snips",
    result = "tin_snips",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_bladesmith", { required = false, time_multiplier = 1.5 })
)

-- not so much the engineering as hardening the edge
content.add(content.Recipe {
    id = "boltcutters",
    result = "boltcutters",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2280000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("manual_mechanics", 4)
    :book("manual_fabrication", 4)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "shovel",
    result = "shovel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1680000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("2x4", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("manual_fabrication", 2)
    :book("textbook_fabrication", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "e_tool",
    result = "e_tool",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1920000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hoe",
    result = "hoe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1920000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "bronze_hoe",
    result = "bronze_hoe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "leather", count = 2 },
            { id = "fur", count = 2 },
            { id = "cordage_short", count = 4, requirement = true }
        })
    :component("scrap_bronze", 12)
    :component_any({
            { id = "stick", count = 4 },
            { id = "2x4", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "ax",
    result = "ax",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "saw",
    result = "saw",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "bow_saw",
    result = "bow_saw",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("2x4", 2)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "hammer_sledge_from_scratch",
    result = "hammer_sledge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 13)
)

content.add(content.Recipe {
    id = "hammer_sledge_from_short_sledge",
    result = "hammer_sledge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 1)
    :component("hammer_sledge_short", 1)
    :quality("CUT", 2, 1)
    :quality("FILE", 1, 1)
    :proficiency("prof_carving")
    :byproduct("splinter", 4)
)

content.add(content.Recipe {
    id = "hammer_sledge_short_forged",
    result = "hammer_sledge_short",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 14)
)

content.add(content.Recipe {
    id = "hammer_sledge_short_from_cutting",
    result = "hammer_sledge_short",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("hammer_sledge", 1)
    :quality("CUT", 2, 1)
    :byproduct("splinter", 1)
)

content.add(content.Recipe {
    id = "hammer_sledge_heavy",
    result = "hammer_sledge_heavy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 64)
    :requirement("steel_standard", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 13)
)

content.add(content.Recipe {
    id = "hammer_sledge_engineer",
    result = "hammer_sledge_engineer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :byproduct("splinter", 16)
)

content.add(content.Recipe {
    id = "hammer_sledge_crude",
    result = "hammer_sledge_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("angle_grinder", 100)
    :tool_charges("drill_press_tool", 10)
    :component("2x4", 1)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :requirement("welding_standard", 120)
    :requirement("steel_lump_any", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_carving")
    :byproduct("splinter", 13)
)

content.add(content.Recipe {
    id = "crash_axe",
    result = "crash_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("filament", 100, true)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "felt_patch", count = 2 },
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_fireman", 6)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "fire_ax",
    result = "fire_ax",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :book("textbook_fireman", 8)
    :book("textbook_fabrication", 9)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_small_knife_paring",
    result = "knife_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    variant = "knife_paring",
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_scrap", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "sickle",
    result = "sickle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :requirement("metal_punch", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bronze_sickle",
    result = "bronze_sickle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "cordage_short", count = 2, requirement = true }
        })
    :component("scrap_bronze", 6)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "knife_large_knife_chef",
    result = "knife_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    variant = "knife_chef",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_large_knife_carving",
    result = "knife_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "knife_carving",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_large_knife_bread",
    result = "knife_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    variant = "knife_bread",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_cleaver_knife_vegetable_cleaver",
    result = "knife_cleaver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "knife_vegetable_cleaver",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_cleaver_knife_meat_cleaver",
    result = "knife_cleaver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "knife_meat_cleaver",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_folding",
    result = "knife_folding",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 4)
    :component("plastic_chunk", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.15, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "pickaxe",
    result = "pickaxe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_carpentry", 5)
    :book("textbook_fabrication", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "bronze_pickaxe",
    result = "bronze_pickaxe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "fur", count = 2 },
            { id = "cordage_short", count = 4, requirement = true }
        })
    :component("scrap_bronze", 20)
    :component_any({
            { id = "stick", count = 4 },
            { id = "2x4", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "crowbar",
    result = "crowbar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "heavy_crowbar",
    result = "heavy_crowbar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2280000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 28)
    :requirement("steel_standard", 7)
    :book("textbook_fireman", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "halligan",
    result = "halligan",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_fireman", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "claw_bar",
    result = "claw_bar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 600000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "iceaxe",
    result = "iceaxe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("material_aluminium_ingot", 1)
    :component("filament", 100, true)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "felt_patch", count = 2 },
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "makeshift_hand_drill",
    result = "makeshift_hand_drill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 1)
    :component_any({
            { id = "nails", count = 1, requirement = true },
            { id = "screwdriver", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
            { id = "splinter", count = 3 }
        })
    :quality("HAMMER", 2, 1)
    :quality("HAMMER_FINE", 1, 1)
)

content.add(content.Recipe {
    id = "shovel_snow",
    result = "shovel_snow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "shovel_snow_plastic",
    result = "shovel_snow_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("plastic_molding", 5)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rake",
    result = "rake",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("ANVIL", 3, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "rake_plastic",
    result = "rake_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("plastic_molding", 5)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "draw_plate",
    result = "draw_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal_small", 1)
    :quality("DRILL", 2, 1)
)

content.add(content.Recipe {
    id = "casting_mold_small",
    result = "casting_mold_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("any_water", 1, true)
    :component("clay_lump", 1)
    :component("material_sand", 113)
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "nails", count = 8, requirement = true },
            { id = "glue_strong", count = 4 }
        })
    :quality("SIEVE", 1, 1)
    :quality("HAMMER", 2, 1)
)

content.add(content.Recipe {
    id = "casting_mold_large",
    result = "casting_mold_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("any_water", 32, true)
    :component("clay_lump", 32)
    :component("material_sand", 9000)
    :component("2x4", 8)
    :component_any({
            { id = "nails", count = 16, requirement = true },
            { id = "glue_strong", count = 8 }
        })
    :quality("SIEVE", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
)

content.add(content.Recipe {
    id = "casting_mold_long",
    result = "casting_mold_long",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("any_water", 9, true)
    :component("clay_lump", 9)
    :component("material_sand", 2532)
    :component("2x4", 8)
    :component_any({
            { id = "nails", count = 16, requirement = true },
            { id = "glue_strong", count = 8 }
        })
    :quality("SIEVE", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
)

content.add(content.Recipe {
    id = "casting_mold",
    result = "casting_mold",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("any_water", 5, true)
    :component("clay_lump", 5)
    :component("material_sand", 1350)
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "nails", count = 8, requirement = true },
            { id = "glue_strong", count = 4 }
        })
    :quality("SIEVE", 1, 1)
    :quality("HAMMER", 2, 1)
)

content.add(content.Recipe {
    id = "stone_polishing",
    result = "stone_polishing",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("rock", 1)
    :component_any({
            { id = "material_sand", count = 5 },
            { id = "material_gravel", count = 5 }
        })
    :component("rock_large", 1)
    :component("any_water", 1, true)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
)

content.add(content.Recipe {
    id = "pedal_grindstone",
    result = "pedal_grindstone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "stick", count = 6 },
            { id = "2x4", count = 6 },
            { id = "xlframe", count = 1 },
            { id = "frame_wood", count = 1 }
        })
    :component("rock_large", 4)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component_any({
            { id = "rope_6", count = 2 },
            { id = "rope_30", count = 1 }
        })
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 2 },
            { id = "material_gravel", count = 2 }
        })
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("DRILL_ROCK", 1, 1)
    :quality("CHISEL", 3, 1)
    :requires_skill("mechanics", 2)
    :book("textbook_fabrication", 3)
    :book("textbook_weapeast", 4)
    :book("textbook_weapwest", 4)
    :book("textbook_armeast", 4)
    :book("textbook_armwest", 4)
    :book("manual_mechanics", 3)
    :book("textbook_weparabic", 5)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "scraper_steel",
    result = "scraper_steel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_fabrication", 2)
    :book("textbook_weapeast", 3)
    :book("textbook_weapwest", 3)
    :book("textbook_armeast", 3)
    :book("textbook_armwest", 3)
    :book("textbook_weparabic", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "simple_crank",
    result = "simple_crank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "thread_cutting_set",
    result = "thread_cutting_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("casting_mold", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 3)
    :book("manual_mechanics", 3)
    :book("manual_fabrication", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)
