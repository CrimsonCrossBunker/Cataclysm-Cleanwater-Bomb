local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.replace(content.Recipe {
    id = "armguard_metal",
    result = "armguard_metal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :requires_skill("tailor", 4)
    :book("recipe_melee", 3)
    :requirement("cordage", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :component("sheet_metal_small", 4)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

content.replace(content.Recipe {
    id = "makeshift_funnel",
    result = "makeshift_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :quality("CUT", 2, 1)
    :component_any({
            { id = "jug_plastic", count = 1 },
            { id = "bottle_plastic", count = 3 },
            { id = "bottle_bathroom", count = 3 },
            { id = "bottle_plastic_small", count = 6 },
            { id = "aluminum_foil", count = 6 }
        })
)
