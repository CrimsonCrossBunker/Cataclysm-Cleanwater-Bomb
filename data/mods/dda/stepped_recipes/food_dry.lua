local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- 300g of stuff. Slicing is hands-on; dehydration runs unattended and drains the heat source over the wait.
content.add(content.Recipe {
    id = "dry_meat",
    result = "dry_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("meat_red_raw", 1, true)
    :remove_result_flag("BAD_TASTE")
    :step {
        name = content.text("Slice the meat into thin strips"),
        duration_moves = 18000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 67, at_batch = 5 },
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Dehydrate the strips"),
        duration_moves = 72000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 67, at_batch = 5 },
        tools = {
            { { id = "dehydrating_heat", charges = 30, requirement = true } },
        },
    }
)

-- The cured meat has already lost some moisture. Slicing is hands-on; dehydration runs unattended and drains
-- the heat source over the wait.
content.add(content.Recipe {
    id = "dehydrated_cured_meat",
    result = "dehydrated_cured_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("raw_cured_meat", 1)
    :remove_result_flag("BAD_TASTE")
    :step {
        name = content.text("Slice the cured meat into thin strips"),
        duration_moves = 18000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 67, at_batch = 5 },
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Dehydrate the cured strips"),
        duration_moves = 72000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 67, at_batch = 5 },
        tools = {
            { { id = "dehydrating_heat", charges = 25, requirement = true } },
        },
    }
)

-- 120-132g of stuff depending on cheese type
content.add(content.Recipe {
    id = "cheese_powder",
    result = "cheese_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "cheese", count = 5 },
            { id = "cheese_hard", count = 3 }
        })
    :result_charges(2)
    :step {
        name = content.text("Cut it into small pieces"),
        duration_moves = 12000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 25, at_batch = 3 },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
    }
    :step {
        -- dehydrating cheese is done in low temperature and is a long process
        name = content.text("Dehydrate it"),
        duration_moves = 2160000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("Cheese dehydration is complete."),
        batch = { discount_percent = 98, at_batch = 2 },
        tools = {
            { { id = "dehydrating_heat", charges = 13, requirement = true } },
        },
    }
    :step {
        name = content.text("Grind it"),
        duration_moves = 6000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 50, at_batch = 3 },
        tools = {
            { { id = "food_processor", charges = 25 } },
        },
    }
)

content.add(content.Recipe {
    id = "protein_powder_with_from_food_processor",
    result = "protein_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :component_any({
            { id = "dry_meat", count = 2 },
            { id = "dry_fish", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "dry_poultry", count = 2 },
            { id = "dry_froglegs", count = 8 },
            { id = "jerky", count = 1 }
        })
    :result_charges(8)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 2000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 50, at_batch = 3 },
    }
    :step {
        name = content.text("Grind it"),
        duration_moves = 12000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { discount_percent = 50, at_batch = 3 },
        tools = {
            { { id = "food_processor", charges = 50 } },
        },
    }
)
