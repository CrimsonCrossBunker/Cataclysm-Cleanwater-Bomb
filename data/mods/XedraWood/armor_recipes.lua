local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "armor_lamellar_bronze",
    result = "armor_lamellar_bronze",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_bronze", 864)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 110)
    :requirement("fabric_leather_fur_hide", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.15, learning_time_multiplier = 0.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_lamellar_bronze_repair",
    result = "armor_lamellar_bronze",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("lamellae_bronze", 18)
    :component("armor_lamellar_bronze", 1)
    :requirement("cordage", 6)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "helmet_dragon_bird_pred",
    result = "helmet_dragon_bird_pred",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "skull_dino_pred_med", count = 1 },
            { id = "skull_dino_pred_large", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_carving")
    :byproduct("leather", 3)
    :byproduct("scrap_leather", 1)
    :byproduct("meal_bone", 1)
)
