local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "ugl_buttstock",
    result = "ugl_buttstock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 2 }
        })
    :component("scrap", 1)
    :quality("SAW_W", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("launcher", 3)
    :proficiency("prof_carpentry_basic")
)
