local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "legguard_tire",
    result = "legguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 8)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("strap_large", 3)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xs_legguard_tire",
    result = "xs_legguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 6)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("strap_large", 2)
    :requirement("cordage", 2)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_legguard_tire",
    result = "xl_legguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 10)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("strap_large", 3)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)
