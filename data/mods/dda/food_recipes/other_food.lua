local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- same weight as chunk of meat, so same power cost
content.add(content.Recipe {
    id = "meat_fatty_cooked_obsolete",
    result = "meat_fatty_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    name = content.text("%s with obsolete component"),
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "porkbelly", count = 1 },
            { id = "raw_curing_fatty_meat", count = 1 },
            { id = "raw_cured_fatty_meat", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- same weight as chunk of meat, so same power cost
content.add(content.Recipe {
    id = "pepperfat_obsolete",
    result = "pepperfat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    name = content.text("%s with obsolete component"),
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "porkbelly", count = 1 },
            { id = "raw_curing_fatty_meat", count = 1 },
            { id = "raw_cured_fatty_meat", count = 1 }
        })
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "cured_roe_vacuum_packed_obsolete",
    result = "cured_roe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
    container = "plastic_bag_vac",
    name = content.text("vacuum packed %s with obsolete ingredient"),
}
    :component("curing_roe", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(2)
)
