local content = require("ccb").content

local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "lobotomizer_weapon",
    result = "lobotomizer_weapon",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2640000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("hotcut", 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :book("manual_fabrication", 8)
    :book("textbook_fabrication", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)
