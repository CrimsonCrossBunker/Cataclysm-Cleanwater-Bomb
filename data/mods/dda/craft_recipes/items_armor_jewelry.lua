local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "gold_ring",
    result = "gold_ring",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("gold_small", 2)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "gold_necklace",
    result = "gold_necklace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("gold_small", 10)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "copper_necklace",
    result = "copper_necklace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("copper", 6)
    :quality("CHISEL", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :book("jewelry_book", 6)
    :proficiency("prof_fine_metalsmithing")
)

content.add(content.Recipe {
    id = "silver_necklace",
    result = "silver_necklace",
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

content.add(content.Recipe {
    id = "bead_bracelet",
    result = "bead_bracelet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("wooden_bead", 10)
    :component("cordage_short", 1, true)
)

content.add(content.Recipe {
    id = "bead_necklace",
    result = "bead_necklace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("wooden_bead", 30)
    :component("cordage", 1, true)
)
