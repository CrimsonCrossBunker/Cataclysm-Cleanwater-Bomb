local content = require("ccb").content

local MODERATE_EXERCISE = 4

-- a long pole is a single piece of wood, and the stout branch just isn't large enough.
content.add(content.Recipe {
    id = "soaking_long_pole",
    result = "soaking_long_pole",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 960000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("wooden_post_long", 1)
    :component("wood_sealant_any", 2, true)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :book("textbook_weapeast", 4)
    :byproduct("splinter", 60)
)

content.add(content.Recipe {
    id = "soaking_spear_shaft",
    result = "soaking_spear_shaft",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick_long", 1)
    :component("wood_sealant_any", 1, true)
    :quality("CUT", 2, 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("FILE", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.25 })
    :byproduct("splinter", 12)
)

content.add(content.Recipe {
    id = "spear_shaft_from long pole",
    result = "spear_shaft",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("long_pole", 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :byproduct("splinter", 6)
)
