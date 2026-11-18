local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "microscope_slide_water_murky",
    result = "microscope_slide_water_murky",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
}
    :tool("water_murky", 1)
    :component("microscope_slide", 1)
)

content.add(content.Recipe {
    id = "microscope_slide_soil",
    result = "microscope_slide_soil",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
}
    :tool("material_soil", 1)
    :component("microscope_slide", 1)
)
