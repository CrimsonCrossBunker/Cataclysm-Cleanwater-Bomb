local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "plastic_jack_o_lantern",
    result = "plastic_jack_o_lantern",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("plastic_bottles_4l", 1, true)
    :component("lightstrip_inactive", 1)
    :component("light_battery_cell", 1)
    :component("paint_yellow", 1)
    :quality("CUT", 2, 1)
    :requirement("plastic_molding", 2)
    :book("plastics_book", 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "decorative_wreath",
    result = "decorative_wreath",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pine_bough", 4)
    :component_any({
            { id = "duct_tape", count = 10 },
            { id = "cordage_superior", count = 6, requirement = true }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "jackolantern",
    result = "jackolantern",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pumpkin", 1)
    :component("candle", 1)
    :quality("CUT", 2, 1)
    :byproduct("pumpkin_cut", 1)
    :byproduct("seed_pumpkin", 6)
)
