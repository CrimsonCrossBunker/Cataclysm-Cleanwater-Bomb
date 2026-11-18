local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "boiled_egg",
    result = "boiled_egg",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true }
        })
    :step {
        -- this is technically cheating on energy, as you need to boil the water longer to really cook
        -- the egg.
        -- However, water that boiled an egg in it doesn't get contaminated and you'd keep putting eggs
        -- into the same boiling water, so this recipe uses water as a tool and has lentient energy use.
        -- At 15 minutes the egg white becomes rubbery and the yoke becomes dry, but at 2 hours the egg
        -- becomes inedible
        name = content.text("Boiling"),
        duration_moves = 60000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 7200,
        batch = { discount_percent = 80, at_batch = 4 },
        tools = {
            { { id = "water_boiling_heat", charges = 1, requirement = true } },
            {
                { id = "water", count = 1 },
                { id = "water_clean", count = 1 },
            },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
)
