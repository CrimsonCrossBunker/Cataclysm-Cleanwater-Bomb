local content = require("ccb").content

local NO_EXERCISE = 1
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "caramel_ointement",
    result = "caramel_ointement",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 2, true)
    :component("sugar", 10)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("sugarkin_flyer", 1)
    :result_charges(3)
)

-- quite a lot of sugar is scattered when you bash the bones apart
content.add(content.Recipe {
    id = "sugar_bone_smash",
    result = "sugar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 0,
}
    :component("bone_sugar", 1)
    :quality("HAMMER", 1, 1)
    :batch_discount(95, 2)
    :result_charges(100)
)
