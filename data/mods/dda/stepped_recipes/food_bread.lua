local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "bread",
    result = "bread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "flour", count = 22 },
            { id = "bread_flour", count = 5 }
        })
    :component("yeast", 1)
    :component("water_clean", 2)
    :component("sugar", 4)
    :book("family_cookbook", 1)
    :book("baking_book", 1)
    :book("cookbook", 2)
    :book("cookbook_italian", 3)
    :book("atomic_survival", 6)
    :result_charges(10)
    :step {
        name = content.text("mixing the dough"),
        duration_moves = 30000,
        activity_level = MODERATE_EXERCISE,
        batch = { discount_percent = 25, at_batch = 4 },
        proficiencies = {
            { id = "prof_food_prep" },
            { id = "prof_baking" },
            { id = "prof_baking_bread" },
        },
    }
    :step {
        name = content.text("letting the dough rise"),
        duration_moves = 60000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The dough has finished rising."),
        batch = { discount_percent = 5, at_batch = 4 },
    }
    :step {
        name = content.text("baking"),
        duration_moves = 30000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 50, at_batch = 4 },
        tools = {
            { { id = "surface_heat", charges = 22, requirement = true } },
        },
        qualities = {
            { { id = "OVEN", level = 1, count = 1 } },
        },
    }
)
