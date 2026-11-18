local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "launcher_ballista",
    result = "launcher_ballista",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("blacksmithing_intermediate", 1, true)
    :component("wood_structural", 10, true)
    :component("rope_superior_short", 3, true)
    :component("foot_crank", 1)
    :component("fabric_hides_proper", 4, true)
    :component("steel_standard", 2, true)
    :component("nail_glue", 80, true)
    :quality("CUT", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("SMOOTH", 1, 1)
    :book("recipe_bows", 6)
    :book("textbook_weapwest", 6)
)

content.add(content.Recipe {
    id = "ammo_ballista_wood",
    result = "ammo_ballista_wood",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "wood_structural_small", count = 1, requirement = true },
            { id = "broom", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "pointy_stick", count = 1 }
        })
    :quality("CUT", 1, 1)
    :book("recipe_arrows", 1)
    :book("textbook_weapwest", 1)
)

content.add(content.Recipe {
    id = "ammo_ballista_iron",
    result = "ammo_ballista_iron",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("blacksmithing_standard", 1, true)
    :component("ammo_ballista_wood", 1)
    :component("steel_tiny", 1, true)
    :quality("HAMMER", 1, 1)
    :book("recipe_arrows", 3)
    :book("textbook_weapwest", 3)
)

content.add(content.Recipe {
    id = "sling_bullet",
    result = "sling_bullet",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "kiln", charges = 10 },
            { id = "surface_heat", charges = 10, requirement = true }
        })
    :component_any({
            { id = "lead", count = 50 },
            { id = "bismuth", count = 125 }
        })
    :quality("CONTAIN", 1, 1)
    :batch_discount(70, 1)
    :result_charges(1)
)
