local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "atomic_butter",
    result = "atomic_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("milk_raw", 45)
    :component("salt", 15)
    :quality("CHURN", 2, 1)
    :result_charges(32)
)

content.add(content.Recipe {
    id = "afs_calorie_water",
    result = "afs_calorie_water",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("afs_calorie_pill", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "yum_lichen_extra",
    result = "yum_lichen_extra",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 60, true)
    :tool_any({
            { id = "pressure_cooker", count = 1 },
            { id = "makeshift_pressure_cooker", count = 1 }
        })
    :component("yum_lichen", 4)
    :quality("CONTAIN", 1, 1)
    :book("recipe_lichenlog", 2)
    :batch_discount(99, 1)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "frost_human_cooked",
    result = "frost_human_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("frost_human_flesh", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "alien_flesh_cooked",
    result = "alien_flesh_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_flesh", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "alien_meat_scrap_cooked",
    result = "alien_meat_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 1, true)
    :component("alien_meat_scrap", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "alien_brain_cooked",
    result = "alien_brain_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_brain", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "alien_lung_cooked",
    result = "alien_lung_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_lung", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "alien_kidney_cooked",
    result = "alien_kidney_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_kidney", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "alien_sweetbread_cooked",
    result = "alien_sweetbread_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_sweetbread", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "alien_liver_cooked",
    result = "alien_liver_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_liver", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "alien_tallow",
    result = "alien_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component("alien_fat", 3)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(12)
)

content.add(content.Recipe {
    id = "frost_human_tallow",
    result = "frost_human_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component("frost_human_fat", 3)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(12)
)
