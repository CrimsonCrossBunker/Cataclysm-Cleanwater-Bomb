local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "tsow_compost_bin_empty",
    result = "tsow_compost_bin_empty",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 0,
}
    :component("2x4", 6)
    :component("nail", 12)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "tsow_humus",
    result = "tsow_humus",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 0,
    result_multiplier = 10,
}
    :component_any({
            { id = "earthworm_handful", count = 1 },
            { id = "earthworm", count = 10 }
        })
    :component("material_soil", 10)
    :component("straw_pile", 20)
)

content.add(content.Recipe {
    id = "tsow_compost_bin_fermenting",
    result = "tsow_compost_bin_fermenting",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 0,
}
    :component("tsow_humus", 20)
    :component("tsow_compost_bin_empty", 1)
)
