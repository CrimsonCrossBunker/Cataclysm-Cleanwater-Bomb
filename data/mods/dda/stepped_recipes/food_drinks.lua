local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "water_clean",
    result = "water_clean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    autolearn = true,
    skill = "cooking",
}
    :component("water", 1)
    :result_charges(1)
    :step {
        -- 1u of water_boiling_heat takes 5 m minimum, heat at full power
        name = content.text("Boiling"),
        duration_moves = 30000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        max_time_turns = 1800,
        batch = { discount_percent = 20, at_batch = 1 },
        tools = {
            { { id = "water_boiling_heat", charges = 1, requirement = true } },
        },
        qualities = {
            { { id = "BOIL", level = 1, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "water_clean_using_tablets",
    result = "water_clean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_EASY" },
}
    :component("water", 4)
    :component("pur_tablets", 1)
    :result_charges(4)
    :step {
        name = content.text("Mixing and shaking"),
        duration_moves = 60000,
        activity_level = MODERATE_EXERCISE,
        batch = { setup_moves = 60000 },
    }
    :step {
        name = content.text("Purifying"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { setup_moves = 240000 },
    }
)

content.add(content.Recipe {
    id = "water_clean_using_bleach",
    result = "water_clean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_EASY" },
}
    :component("water", 48)
    :component("bleach", 1)
    :result_charges(48)
    :step {
        name = content.text("Mixing and shaking"),
        duration_moves = 60000,
        activity_level = MODERATE_EXERCISE,
        batch = { setup_moves = 60000 },
    }
    :step {
        name = content.text("Purifying"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { setup_moves = 240000 },
    }
)

content.add(content.Recipe {
    id = "water_clean_using_tablets_from_murky_water",
    result = "water_clean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    autolearn = true,
    skill = "cooking",
}
    :component("water_murky", 4)
    :component("pur_tablets", 2)
    :step {
        name = content.text("Mixing and shaking"),
        duration_moves = 60000,
        activity_level = MODERATE_EXERCISE,
        batch = { setup_moves = 60000 },
    }
    :step {
        name = content.text("Purifying"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        batch = { setup_moves = 240000 },
    }
)

-- 2 minutes to boil per 250ml, then simultaneous steeping time of 6 minutes.
content.add(content.Recipe {
    id = "herbal_tea_from_tea_bag",
    result = "herbal_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("herbal_tea_bag", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "tea_fruit",
    result = "tea_fruit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("tea_fruit_bag", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "dandelion_tea_from_tea_bag",
    result = "dandelion_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("tea_bag_dandelion", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "chamomile_tea_from_tea_bag",
    result = "chamomile_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("tea_bag_chamomile", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "herbal_tea",
    result = "herbal_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("wild_herbs", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "pine_tea",
    result = "pine_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("pine_bough", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "dandelion_tea",
    result = "dandelion_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("raw_dandelion", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :book("cookbook_daintydishes", 2, { name = content.text("Royal Penny Tea") })
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "dandelionburdock_tea",
    result = "dandelionburdock_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("raw_dandelion", 1)
    :component("raw_burdock", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :book("cookbook_daintydishes", 2, { name = content.text("Royal Penny Tea") })
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "chamomile_tea",
    result = "chamomile_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("chamomile", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "lotus_tea",
    result = "lotus_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 4, true)
    :component("lotus", 1)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "spurge_tea",
    result = "spurge_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("spurge", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_forage_cooking")
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "tea_bark",
    result = "tea_bark",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("tanbark", 2)
    :quality("BOIL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 6)
    :book("textbook_survival", 5)
    :book("atomic_survival", 4)
    :book("survival_book", 3)
    :batch_discount(75, 1)
)

content.add(content.Recipe {
    id = "bee_balm_tea",
    result = "bee_balm_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("bee_balm", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(75, 1)
)
