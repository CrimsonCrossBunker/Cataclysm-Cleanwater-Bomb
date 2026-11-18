local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "gold_bracelet",
    result = "gold_bracelet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("gold_small", 8)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "copper_bracelet",
    result = "copper_bracelet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("copper", 9)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "silver_bracelet",
    result = "silver_bracelet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("silver_small", 6)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)
