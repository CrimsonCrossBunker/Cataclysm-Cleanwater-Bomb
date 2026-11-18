local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "brandy",
    result = "brandy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component_any({
            { id = "cheap_wine", count = 21, requirement = true },
            { id = "worthy_wine", count = 15, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :learn_automatically("cooking", 8)
    :book("distilling_cookbook", 2)
    :book("winemaking_beginner", 2)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "gin_from_mash",
    result = "gin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("gin_mash", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "vodka_from_wash",
    result = "vodka",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_vodka", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "rum",
    result = "rum",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_rum", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "whiskey",
    result = "whiskey",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_whiskey", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "moonshine",
    result = "moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_moonshine", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("distilling_cookbook", 1)
    :proficiency("prof_distilling")
    :proficiency("prof_beverage_distilling")
    :batch_discount(50, 4)
    :result_charges(7)
)
