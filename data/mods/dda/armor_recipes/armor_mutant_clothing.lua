local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "horseshoes_wearable",
    result = "horseshoes_wearable",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 100,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 0,
    flags = { "BLIND_EASY" },
}
    :component("horseshoe", 2)
)
