local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "armguard_tire",
    result = "armguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 8)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xs_armguard_tire",
    result = "xs_armguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 6)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 2)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_armguard_tire",
    result = "xl_armguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 330000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 10)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 3)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)
