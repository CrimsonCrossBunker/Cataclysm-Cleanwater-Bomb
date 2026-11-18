local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "deck_chair",
    result = "deck_chair",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 4)
    :component("wooden_post_short", 6)
    :component_any({
            { id = "cotton_patchwork", count = 35 },
            { id = "sheet_cotton", count = 5 },
            { id = "sheet_cotton_patchwork", count = 5 },
            { id = "sheet", count = 1 }
        })
    :component("nuts_bolts", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 140)
)

content.add(content.Recipe {
    id = "chair_wood",
    result = "chair_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("wooden_post", 2)
    :component("wooden_post_short", 4)
    :component("plank_short", 2)
    :component("wood_panel", 1)
    :component("nuts_bolts", 30)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("SCREW", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 168)
)

content.add(content.Recipe {
    id = "stool_wood",
    result = "stool_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 450000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("wooden_post_short", 5)
    :component("wood_panel", 1)
    :component("nuts_bolts", 10)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("SCREW", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 155)
)

content.add(content.Recipe {
    id = "stool_log",
    result = "stool_log",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("log", 1)
    :quality("AXE", 3, 1)
    :byproduct("splinter", 120)
)

content.add(content.Recipe {
    id = "chair_wood_black",
    result = "chair_wood_black",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("paint_brush", 1)
    :component("chair_wood", 1)
    :component("paint_black", 3)
)

content.add(content.Recipe {
    id = "chair_wood_white",
    result = "chair_wood_white",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("paint_brush", 1)
    :component("chair_wood", 1)
    :component("paint_white", 3)
)
