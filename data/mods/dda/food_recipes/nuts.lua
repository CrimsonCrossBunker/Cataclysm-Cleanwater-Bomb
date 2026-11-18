local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "walnut_roasted",
    result = "walnut_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("walnut_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "butternut_roasted",
    result = "butternut_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("butternut_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "soy_nuts",
    result = "soy_nuts",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("soybean", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "edamame_roasted",
    result = "edamame_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("raw_edamame", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "pecan_roasted",
    result = "pecan_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("pecan_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "pistachio_roasted",
    result = "pistachio_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("pistachio_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "almond_roasted",
    result = "almond_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("almond_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "chestnut_roasted",
    result = "chestnut_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("chestnut_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "hazelnut_roasted",
    result = "hazelnut_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("hazelnut_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "acorn_roasted",
    result = "acorn_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("acorns_cooked", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "hickory_nut_roasted",
    result = "hickory_nut_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("hickory_nut_shelled", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

-- nuts: 24u, milk = 1u, sugar = 2 (cook the milk-nut-sugar mix and then dillute it in water?
content.add(content.Recipe {
    id = "hickory_nut_ambrosia",
    result = "hickory_nut_ambrosia",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 27, true)
    :component("hickory_nut_shelled", 4)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component("sugar_standard", 2, true)
    :component("water_clean", 10)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :book("family_cookbook", 5)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("cookbook_foodfashions", 6, { name = content.text("Shagbark Nut Ambrosia") })
    :proficiency("prof_food_prep")
    :batch_discount(80, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "peanutbutter",
    result = "peanutbutter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 40)
    :component("any_nut", 3, true)
    :component("sugar_standard", 2, true)
    :quality("COOK", 1, 1)
    :result_charges(4)
)
