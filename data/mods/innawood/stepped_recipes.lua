local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.replace(content.Recipe {
    id = "pine_tea",
    result = "pine_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
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
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "dandelion_tea",
    result = "dandelion_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
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
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "dandelionburdock_tea",
    result = "dandelionburdock_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
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
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "chamomile_tea",
    result = "chamomile_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("chamomile", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "lotus_tea",
    result = "lotus_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("lotus", 1)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
    :result_charges(4)
)

content.replace(content.Recipe {
    id = "spurge_tea",
    result = "spurge_tea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
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
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "tea_bark",
    result = "tea_bark",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("tanbark", 2)
    :quality("BOIL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(20, 1)
)

content.replace(content.Recipe {
    id = "bread",
    result = "bread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
    :component_any({
            { id = "flour", count = 20 },
            { id = "bread_flour", count = 20 }
        })
    :component("yeast", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("OVEN", 1, 1)
    :book("family_cookbook", 1)
    :book("baking_book", 1)
    :book("cookbook", 2)
    :book("cookbook_italian", 3)
    :book("atomic_survival", 6)
    :batch_discount(50, 4)
    :result_charges(10)
)

content.replace(content.Recipe { id = "under_armor_shorts", result = "under_armor_shorts", obsolete = true })

content.replace(content.Recipe { id = "xs_binder_top", result = "xs_binder_top", obsolete = true })

content.replace(content.Recipe { id = "xl_binder_top", result = "xl_binder_top", obsolete = true })

content.replace(content.Recipe { id = "binder_top", result = "binder_top", obsolete = true })

content.replace(content.Recipe { id = "coat_faux_fur", result = "coat_faux_fur", obsolete = true })

content.replace(content.Recipe { id = "xs_coat_faux_fur", result = "xs_coat_faux_fur", obsolete = true })

content.replace(content.Recipe { id = "xl_coat_faux_fur", result = "xl_coat_faux_fur", obsolete = true })

content.replace(content.Recipe {
    id = "sword_wood",
    result = "sword_wood",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.replace(content.Recipe {
    id = "pike",
    result = "pike",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("hotcut", 1)
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { skill_penalty = 0 })
)
