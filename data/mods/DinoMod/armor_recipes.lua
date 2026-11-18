local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "helmet_dino",
    result = "helmet_dino",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "skull_dino_small", count = 1 },
            { id = "skull_dino_med", count = 1 },
            { id = "skull_dino_large", count = 1 }
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

content.add(content.Recipe {
    id = "helmet_ceratopsian_lokiceratops",
    result = "helmet_ceratopsian",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_lokiceratops", 1)
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

content.add(content.Recipe {
    id = "helmet_ceratopsian_triceratops",
    result = "helmet_ceratopsian",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_triceratops", 1)
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

content.add(content.Recipe {
    id = "helmet_ceratopsian_centrosaurus",
    result = "helmet_ceratopsian",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_centrosaurus", 1)
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

content.add(content.Recipe {
    id = "helmet_ceratopsian_torosaurus",
    result = "helmet_ceratopsian",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_torosaurus", 1)
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

content.add(content.Recipe {
    id = "helmet_ceratopsian_styracosaurus",
    result = "helmet_ceratopsian",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_styracosaurus", 1)
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

content.add(content.Recipe {
    id = "helmet_dino_pred",
    result = "helmet_dino_pred",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "skull_dino_pred_small", count = 1 },
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

content.add(content.Recipe {
    id = "helmet_dino_pred_tyrannosaurus",
    result = "helmet_dino_pred",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_tyrannosaurus", 1)
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

content.add(content.Recipe {
    id = "helmet_dino_pred_allosaurus",
    result = "helmet_dino_pred",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_allosaurus", 1)
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

content.add(content.Recipe {
    id = "helmet_dino_pred_acrocanthosaurus",
    result = "helmet_dino_pred",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("skull_acrocanthosaurus", 1)
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

content.add(content.Recipe {
    id = "acidchitin_armor_bear",
    result = "acidchitin_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("survival", 4)
    :requires_skill("firstaid", 2)
    :requires_skill("fabrication", 4)
    :book("textbook_arthropod", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "chitin_armor_bear",
    result = "chitin_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("fabrication", 4)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "chainmail_armor_bear",
    result = "chainmail_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 35)
    :component("lc_chain_link", 917)
    :component("lc_wire", 7)
    :component_any({
            { id = "fur", count = 42 },
            { id = "tanned_pelt", count = 7 },
            { id = "leather", count = 42 },
            { id = "tanned_hide", count = 7 }
        })
    :requirement("chainmail_standard", 7)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2, skill_penalty = 0.2 })
)

content.add(content.Recipe {
    id = "leather_armor_bear_from_scratch",
    result = "leather_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 3780000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 30 },
            { id = "water_clean", count = 30 }
        })
    :component_any({
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :component("cotton_patchwork", 18)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 190)
    :requirement("surface_heat", 60)
    :requirement("clasps", 4)
    :requires_skill("tailor", 6)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :book("textbook_survival", 3)
    :book("trappers_companion", 3)
    :book("survival_book", 3)
    :book("textbook_armwest", 6)
    :book("textbook_armschina", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "iron_armor_bear",
    result = "iron_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 60, requirement = true },
            { id = "scrap", count = 180 }
        })
    :component("leather_armor_bear", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 260)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "bronze_armor_bear",
    result = "bronze_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 60)
    :component("leather_armor_bear", 1)
    :requirement("forging_standard", 120)
    :requirement("bronzesmithing_tools", 10)
    :requires_skill("fabrication", 5)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "acidchitin_armor_elephant",
    result = "acidchitin_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("survival", 4)
    :requires_skill("firstaid", 2)
    :requires_skill("fabrication", 4)
    :book("textbook_arthropod", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "chitin_armor_elephant",
    result = "chitin_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("fabrication", 4)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "chainmail_armor_elephant",
    result = "chainmail_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 35)
    :component("lc_chain_link", 917)
    :component("lc_wire", 7)
    :component_any({
            { id = "fur", count = 42 },
            { id = "tanned_pelt", count = 7 },
            { id = "leather", count = 42 },
            { id = "tanned_hide", count = 7 }
        })
    :requirement("chainmail_standard", 7)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2, skill_penalty = 0.2 })
)

content.add(content.Recipe {
    id = "leather_armor_elephant_from_scratch",
    result = "leather_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 3780000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 30 },
            { id = "water_clean", count = 30 }
        })
    :component_any({
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :component("cotton_patchwork", 18)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 190)
    :requirement("surface_heat", 60)
    :requirement("clasps", 4)
    :requires_skill("tailor", 6)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :book("textbook_survival", 3)
    :book("trappers_companion", 3)
    :book("survival_book", 3)
    :book("textbook_armwest", 6)
    :book("textbook_armschina", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "iron_armor_elephant",
    result = "iron_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 60, requirement = true },
            { id = "scrap", count = 180 }
        })
    :component("leather_armor_elephant", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 260)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "bronze_armor_elephant",
    result = "bronze_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 60)
    :component("leather_armor_elephant", 1)
    :requirement("forging_standard", 120)
    :requirement("bronzesmithing_tools", 10)
    :requires_skill("fabrication", 5)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "acidchitin_armor_ostrich",
    result = "acidchitin_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("survival", 4)
    :requires_skill("firstaid", 2)
    :requires_skill("fabrication", 4)
    :book("textbook_arthropod", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "chitin_armor_ostrich",
    result = "chitin_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 84)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 7)
    :requires_skill("fabrication", 4)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "chainmail_armor_ostrich",
    result = "chainmail_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 35)
    :component("lc_chain_link", 917)
    :component("lc_wire", 7)
    :component_any({
            { id = "fur", count = 42 },
            { id = "tanned_pelt", count = 7 },
            { id = "leather", count = 42 },
            { id = "tanned_hide", count = 7 }
        })
    :requirement("chainmail_standard", 7)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2, skill_penalty = 0.2 })
)

content.add(content.Recipe {
    id = "leather_armor_ostrich_from_scratch",
    result = "leather_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 3780000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 30 },
            { id = "water_clean", count = 30 }
        })
    :component_any({
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :component("cotton_patchwork", 18)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 190)
    :requirement("surface_heat", 60)
    :requirement("clasps", 4)
    :requires_skill("tailor", 6)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :book("textbook_survival", 3)
    :book("trappers_companion", 3)
    :book("survival_book", 3)
    :book("textbook_armwest", 6)
    :book("textbook_armschina", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "iron_armor_ostrich",
    result = "iron_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 60, requirement = true },
            { id = "scrap", count = 180 }
        })
    :component("leather_armor_ostrich", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 260)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "bronze_armor_ostrich",
    result = "bronze_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 60)
    :component("leather_armor_ostrich", 1)
    :requirement("forging_standard", 120)
    :requirement("bronzesmithing_tools", 10)
    :requires_skill("fabrication", 5)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_armorsmithing")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation")
)
