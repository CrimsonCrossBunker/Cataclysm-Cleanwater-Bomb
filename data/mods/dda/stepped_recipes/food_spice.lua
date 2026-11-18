local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "salt_from_salt_water",
    result = "salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    autolearn = true,
    skill = "chemistry",
}
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :result_charges(10)
    :step {
        name = content.text("Boiling"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 80, at_batch = 4 },
        tools = {
            { { id = "water_boiling_heat", charges = 7, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "sugar",
    result = "sugar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    autolearn = true,
    skill = "cooking",
}
    :component("sweet_water", 1)
    :result_charges(10)
    :step {
        -- When overcooked, sugar caramelises before it's burnt
        name = content.text("Boiling"),
        duration_moves = 54000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 840,
        batch = { discount_percent = 20, at_batch = 1 },
        tools = {
            { { id = "water_boiling_heat", charges = 7, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
)
