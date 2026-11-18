local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "broth",
    result = "broth",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :requirement("broth_ingredients", 1)
    :result_charges(2)
    :step {
        -- Copied from water boiling recipe step.
        -- 2u for 2 units of water to boil
        name = content.text("Boiling"),
        duration_moves = 30000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 20, at_batch = 1 },
        tools = {
            { { id = "water_boiling_heat", charges = 2, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
    :step {
        -- 4u for 30 min of boiling of 2 units of water, but since it is simmering, not boiling, half as
        -- much, so 2u.
        name = content.text("Cooking"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 5400,
        batch = { setup_moves = 180000 },
        tools = {
            { { id = "water_boiling_heat", charges = 2, requirement = true } },
        },
        qualities = {
            { { id = "COOK", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_food_prep" },
        },
    }
)

content.add(content.Recipe {
    id = "broth_meat",
    result = "broth_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :requirement("broth_meat_ingredients", 1)
    :result_charges(2)
    :step {
        -- Copied from water boiling recipe step.
        -- 2u for 2 units of water to boil
        name = content.text("Boiling"),
        duration_moves = 30000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 20, at_batch = 1 },
        tools = {
            { { id = "water_boiling_heat", charges = 2, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
    :step {
        -- 8u for 1 hour of boiling of 2 units of water, but since it is simmering, not boiling, half as
        -- much, so 4u.
        name = content.text("Cooking"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 14400,
        batch = { setup_moves = 360000 },
        tools = {
            { { id = "water_boiling_heat", charges = 4, requirement = true } },
        },
        qualities = {
            { { id = "COOK", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_food_prep" },
        },
    }
)

-- Bone broth uses minimum 1:2-1:4 bone:water per weight.
content.add(content.Recipe {
    id = "broth_bone",
    result = "broth_bone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("bone_edible", 1, true)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :result_charges(2)
    :byproduct("gelatin_fresh", 2)
    :step {
        -- Copied from water boiling recipe step.
        -- 2u for 2 units of water to boil
        name = content.text("Boiling"),
        duration_moves = 30000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 20, at_batch = 1 },
        tools = {
            { { id = "water_boiling_heat", charges = 2, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
    :step {
        -- 32u for 4 of boiling of 2 units of water, but since it is simmering, not boiling, half as
        -- much, so 16u.
        name = content.text("Cooking"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 57600,
        batch = { setup_moves = 1440000 },
        tools = {
            { { id = "water_boiling_heat", charges = 16, requirement = true } },
        },
        qualities = {
            { { id = "COOK", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_food_prep" },
        },
    }
)
