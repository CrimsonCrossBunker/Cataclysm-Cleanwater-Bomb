local content = require("ccb").content

local NO_EXERCISE = 1
local MODERATE_EXERCISE = 4

-- See brew_vodka why this is 21 charges
content.add(content.Recipe {
    id = "brew_dragonfire",
    result = "brew_dragonfire",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water_clean", count = 3 },
            { id = "water", count = 3 }
        })
    :component("dragon_nail", 2)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :learn_automatically("cooking", 7)
    :book("distilling_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(50, 4)
    :result_charges(21)
)

-- See brew_vodka why this is 21 charges
content.add(content.Recipe {
    id = "brew_goldbrew",
    result = "brew_goldbrew",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water_clean", count = 3 },
            { id = "water", count = 3 }
        })
    :component("golden_reed_stalk", 2)
    :component("sugar", 50)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :learn_automatically("cooking", 7)
    :book("distilling_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(50, 4)
    :result_charges(21)
)

content.add(content.Recipe {
    id = "dragonfire_from_wash",
    result = "dragonfire",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_dragonfire", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "goldbrew_from_wash",
    result = "goldbrew",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_goldbrew", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("distilling_cookbook", 4)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "purified_meat",
    result = "purified_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component("mutant_meat", 3)
    :quality("COOK", 1, 1)
    :quality("MAGIC_MUTAGEN", 2, 1)
    :requires_skill("spellcraft", 1)
    :book("cooking_poison", 2)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "impure_meat",
    result = "impure_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 7, true)
    :component("meat_tainted", 4)
    :quality("COOK", 1, 1)
    :quality("MAGIC_MUTAGEN", 2, 1)
    :requires_skill("spellcraft", 3)
    :book("cooking_poison", 2)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "egg_owlbear",
    result = "egg_owlbear",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("egg_owlbear_rock", 1)
    :quality("HAMMER", 1, 1)
    :result_charges(40)
    :byproduct("stone_shell", 3)
)
