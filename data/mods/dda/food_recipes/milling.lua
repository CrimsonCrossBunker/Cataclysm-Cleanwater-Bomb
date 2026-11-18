local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "bread_flour",
    result = "bread_flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
    name = content.text("%s with quern"),
}
    :tool("rock_quern", 1)
    :component("flour", 1)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "oats", count = 4 },
            { id = "starch", count = 1 },
            { id = "dry_rice", count = 5 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 }
        })
    :batch_discount(83, 3)
    :result_charges(16)
)

content.add(content.Recipe {
    id = "bread_flour_with_from_food_processor",
    result = "bread_flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
    name = content.text("%s using food processor"),
}
    :tool_charges("food_processor", 20)
    :component("flour", 1)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "oats", count = 4 },
            { id = "starch", count = 1 },
            { id = "dry_rice", count = 5 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 }
        })
    :batch_discount(83, 3)
    :result_charges(16)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "chilly-p_mill_1_50",
    result = "chilly-p",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("dry_chili", 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chilly-p_with_heat",
    result = "chilly-p",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :tool("rock_quern", 1)
    :component("any_chili_pepper", 1, true)
    :book("cookbook_mexican", 1)
    :batch_discount(83, 3)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chilly-p",
    result = "chilly-p",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 }
        })
    :component("dry_chili", 1)
    :book("cookbook_mexican", 1)
    :batch_discount(83, 3)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chilly-p_with_from_food_processor",
    result = "chilly-p",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 13100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 10)
    :component("any_chili_pepper", 1, true)
    :book("cookbook_mexican", 1)
    :batch_discount(95, 10)
    :result_charges(50)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "cornmeal_mill_1_3",
    result = "cornmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("dry_corn", 1)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "cornmeal",
    result = "cornmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :tool("rock_quern", 1)
    :component_any({
            { id = "dry_corn", count = 1 },
            { id = "kernels", count = 1 }
        })
    :book("cookbook_mexican", 1)
    :batch_discount(83, 3)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "cornmeal_with_from_food_processor",
    result = "cornmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 67500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component("dry_corn", 1)
    :book("cookbook_mexican", 1)
    :batch_discount(83, 3)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "cornmeal_mortar",
    result = "cornmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 405000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("dry_corn", 1)
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :book("cookbook_mexican", 1)
    :batch_discount(83, 3)
    :result_charges(3)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "dry_wild_rice_mill_1_5",
    result = "dry_wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("wild_rice", 1)
    :result_charges(5)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_mill_1_15",
    result = "flour",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "barley", count = 1 },
            { id = "starch", count = 1 },
            { id = "wheat", count = 1 },
            { id = "winter_wheat", count = 1 }
        })
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour",
    result = "flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "starch", count = 1 }
        })
    :batch_discount(83, 3)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour_with_from_food_processor",
    result = "flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "starch", count = 1 }
        })
    :batch_discount(83, 3)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour_mortar",
    result = "flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 405000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "starch", count = 1 }
        })
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(83, 3)
    :result_charges(15)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_1_1",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("dry_soybean", 1)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_1_4",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :result_charges(4)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_1_15",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("buckwheat", 1)
    :result_charges(15)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_2_3",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("acorns_cooked", 2)
    :result_charges(3)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_2_15",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("roasted_cattail_rhizome", 2)
    :result_charges(15)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_4_5",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("chestnut_roasted", 4)
    :result_charges(5)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "flour_wheat_free_mill_4_15",
    result = "flour_wheat_free",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("oats", 4)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour_wheat_free",
    result = "flour_wheat_free",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "buckwheat", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "roasted_cattail_rhizome", count = 2 },
            { id = "dry_rice", count = 5 },
            { id = "dry_soybean", count = 15 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 },
            { id = "oats", count = 4 }
        })
    :batch_discount(83, 3)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour_wheat_free_with_from_food_processor",
    result = "flour_wheat_free",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "buckwheat", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "roasted_cattail_rhizome", count = 2 },
            { id = "dry_rice", count = 5 },
            { id = "dry_soybean", count = 15 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 },
            { id = "oats", count = 4 }
        })
    :batch_discount(83, 3)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "flour_wheat_free_mortar",
    result = "flour_wheat_free",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 405000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "buckwheat", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "roasted_cattail_rhizome", count = 2 },
            { id = "dry_rice", count = 5 },
            { id = "dry_soybean", count = 15 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 },
            { id = "oats", count = 4 }
        })
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(83, 3)
    :result_charges(15)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "garlic_powder_mill_1_50",
    result = "garlic_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("dry_garlic", 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "garlic_powder_with_heat",
    result = "garlic_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :tool("rock_quern", 1)
    :component("garlic_clove", 1)
    :book("cookbook_italian", 1)
    :batch_discount(83, 3)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "garlic_powder_from_quern",
    result = "garlic_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 }
        })
    :component("dry_garlic", 1)
    :book("cookbook_italian", 1)
    :batch_discount(83, 3)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "garlic_powder",
    result = "garlic_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 10)
    :component("garlic_clove", 1)
    :book("cookbook_italian", 1)
    :batch_discount(83, 3)
    :result_charges(50)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_mill_1_4",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "bone_edible", count = 1, requirement = true },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_medium", count = 1, requirement = true }
        })
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_bone",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "bone_edible", count = 1, requirement = true },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_medium", count = 1, requirement = true }
        })
    :batch_discount(83, 3)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_bone_with_from_food_processor",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "bone_edible", count = 1, requirement = true },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_medium", count = 1, requirement = true }
        })
    :batch_discount(83, 3)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_bone_mortar",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "bone_edible", count = 1, requirement = true },
            { id = "skull_humanlike", count = 1, requirement = true },
            { id = "skull_medium", count = 1, requirement = true }
        })
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(83, 3)
    :result_charges(4)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_mill_20_1",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("skull_rodent", 20)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_mill_2_1",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("skull_tiny", 2, true)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_mill_1_1",
    result = "meal_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("skull_small", 1, true)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_tainted_mill_1_4",
    result = "meal_bone_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "bone_tainted", count = 1 },
            { id = "skull_human_tainted", count = 1 }
        })
    :result_charges(4)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_bone_tainted_mill_6_1",
    result = "meal_bone_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("skewer_bone", 6)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "meal_bone_tainted",
    result = "meal_bone_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "bone_tainted", count = 1 },
            { id = "skewer_bone", count = 25 },
            { id = "skull_human_tainted", count = 1 }
        })
    :batch_discount(83, 3)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_bone_tainted_with_from_food_processor",
    result = "meal_bone_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "bone_tainted", count = 1 },
            { id = "skewer_bone", count = 25 },
            { id = "skull_human_tainted", count = 1 }
        })
    :batch_discount(83, 3)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_bone_tainted_mortar",
    result = "meal_bone_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "bone_tainted", count = 1 },
            { id = "skewer_bone", count = 25 },
            { id = "skull_human_tainted", count = 1 }
        })
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(83, 3)
    :result_charges(4)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "meal_chitin_piece_mill_1_4",
    result = "meal_chitin_piece",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "acidchitin_piece", count = 1 },
            { id = "chitin_piece", count = 1 },
            { id = "endochitin", count = 1 }
        })
    :result_charges(4)
)

content.add(content.Recipe {
    id = "meal_chitin_piece_with_from_food_processor",
    result = "meal_chitin_piece",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "chitin_piece", count = 1 },
            { id = "acidchitin_piece", count = 1 },
            { id = "endochitin", count = 1 }
        })
    :batch_discount(83, 3)
    :result_charges(4)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "paste_nut_mill_4_5",
    result = "paste_nut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("chestnut_roasted", 4)
    :result_charges(5)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "paste_nut_mill_5_1",
    result = "paste_nut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("soybean", 5)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "paste_nut_mill_10_1",
    result = "paste_nut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "acorns_blanched", count = 10 },
            { id = "almond_shelled", count = 10 },
            { id = "beech_nuts", count = 10 },
            { id = "cashews", count = 10 },
            { id = "chestnut_shelled", count = 10 },
            { id = "hazelnut_shelled", count = 10 },
            { id = "hickory_nut_shelled", count = 10 },
            { id = "peanut_shelled", count = 10 },
            { id = "pecan_shelled", count = 10 },
            { id = "pistachio_shelled", count = 10 },
            { id = "walnut_shelled", count = 10 }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "paste_nut",
    result = "paste_nut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "almond_shelled", count = 10 },
            { id = "chestnut_roasted", count = 4 },
            { id = "chestnut_shelled", count = 10 },
            { id = "peanut_shelled", count = 10 },
            { id = "walnut_shelled", count = 10 },
            { id = "pecan_shelled", count = 10 },
            { id = "hazelnut_shelled", count = 10 },
            { id = "pistachio_shelled", count = 10 },
            { id = "hickory_nut_shelled", count = 10 },
            { id = "acorns_blanched", count = 10 },
            { id = "cashews", count = 10 },
            { id = "beech_nuts", count = 10 },
            { id = "soybean", count = 5 }
        })
    :batch_discount(20, 1)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "paste_seed_mill_1_1",
    result = "paste_seed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("seed_canola", 1)
    :result_charges(1)
)

-- For use by mills, so the only entries used are the charges and components.
-- Note that there should only be a single component with no extras such as lubricants, etc.
content.add(content.Recipe {
    id = "paste_seed_mill_8_1",
    result = "paste_seed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "seed_cotton_boll", count = 8 },
            { id = "seed_grapes", count = 8 },
            { id = "seed_pumpkin", count = 8 },
            { id = "seed_sunflower", count = 8 },
            { id = "seed_poppy_bud", count = 8 },
            { id = "seed_weed", count = 8 }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "paste_seed",
    result = "paste_seed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool("rock_quern", 1)
    :component_any({
            { id = "seed_cotton_boll", count = 8 },
            { id = "seed_pumpkin", count = 8 },
            { id = "seed_sunflower", count = 8 },
            { id = "seed_canola", count = 1 },
            { id = "seed_grapes", count = 8 },
            { id = "seed_poppy_bud", count = 8 },
            { id = "seed_weed", count = 8 }
        })
    :batch_discount(20, 1)
    :result_charges(1)
)
