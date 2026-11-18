local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "aperture_potato",
    result = "aperture_potato",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 11000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 8,
}
    :component("circuit", 1)
    :component("e_scrap", 3)
    :component("cable", 2)
    :component("light_minus_battery_cell", 1)
    :component("potato", 1)
    :quality("SCREW", 1, 1)
    :book("textbook_robots", 4)
)
