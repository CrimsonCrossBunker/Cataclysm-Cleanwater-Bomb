local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "spaghetti_cooked",
    result = "spaghetti_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    autolearn = true,
    skill = "cooking",
}
    :component_any({
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 },
            { id = "lasagne_raw", count = 1 }
        })
    :component("water_clean", 1)
    :step {
        -- There are ways to cook pasta that don't require boiling the water, and they are a lot more
        -- efficient, so this uses surface_heat
        -- pasta by weight is 5u flour, + heating the water (2u)
        -- Pasta needs to be constantly seperated until they stop sticking together.
        name = content.text("Stir While Boiling"),
        duration_moves = 60000,
        activity_level = NO_EXERCISE,
        tools = {
            { { id = "surface_heat", charges = 7, requirement = true } },
        },
        qualities = {
            { { id = "COOK", level = 3, count = 1 } },
        },
    }
)
