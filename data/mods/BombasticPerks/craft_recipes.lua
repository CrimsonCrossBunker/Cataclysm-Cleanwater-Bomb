local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "item_ewwww_de_zombie",
    result = "item_ewwww_de_zombie",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 15, true)
    :component("meat_tainted", 3)
    :component("blood_tainted", 25)
    :component("fat_tainted", 8)
    :quality("BOIL", 1, 1)
    :quality("COOK", 3, 1)
)

content.add(content.Recipe {
    id = "meat_hunk",
    result = "meat_hunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("meat_tainted", 180)
    :component("bone_tainted", 80)
    :component("pipe", 2)
    :quality("SEW", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("JUMPSTART", 1, 1)
    :requires_skill("electronics", 4)
)
