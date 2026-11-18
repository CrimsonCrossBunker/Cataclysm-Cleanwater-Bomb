local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "acidchitin_armor_horse",
    result = "acidchitin_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
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
    id = "chitin_armor_horse",
    result = "chitin_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 84)
    :quality("CUT", 2, 1)
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
    id = "chainmail_armor_horse",
    result = "chainmail_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
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

-- recipe composition is off of the item composition due to not wanting to require 280 cotton sheets for
-- this.
content.add(content.Recipe {
    id = "kevlar_armor_horse",
    result = "kevlar_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 55)
    :requirement("armor_kevlar_layered", 24)
    :requirement("tailoring_cotton_patchwork", 143)
    :requirement("clasps", 4)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_armor_horse",
    result = "leather_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("armor_blarmor", 3)
    :component("cotton_patchwork", 18)
    :requirement("sewing_standard", 30)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 21)
)

content.add(content.Recipe {
    id = "leather_armor_horse_from_scratch",
    result = "leather_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 3780000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "wax_any", count = 6, requirement = true },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_leather_patchwork", 55)
    :requirement("tailoring_cotton_patchwork", 55)
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
    id = "leatherbone_armor_horse",
    result = "leatherbone_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "bone", count = 39 },
            { id = "bone_human", count = 39 },
            { id = "bone_demihuman", count = 39 }
        })
    :component("armor_blarmor", 3)
    :requirement("sewing_standard", 75)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 21)
)

content.add(content.Recipe {
    id = "leatherbone_armor_horse_from_leatherarmor",
    result = "leatherbone_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 39, true)
    :component("leather_armor_horse", 1)
    :requirement("sewing_standard", 35)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_carving")
    :byproduct("leather", 6)
)

content.add(content.Recipe {
    id = "leatherbone_armor_horse_from_scratch",
    result = "leatherbone_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 60, true)
    :component_any({
            { id = "water", count = 30 },
            { id = "water_clean", count = 30 }
        })
    :component_any({
            { id = "wax_any", count = 6, requirement = true },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component("bone_sturdy", 39, true)
    :requirement("tailoring_leather_patchwork", 29)
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
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "rubber_armor_horse",
    result = "rubber_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("duct_tape", 175)
    :component("coat_rain", 7)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "rubber_armor_horse_from_scratch",
    result = "rubber_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("duct_tape", 350)
    :component("plastic_sheet", 9)
    :component("cotton_patchwork", 70)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "iron_armor_horse",
    result = "iron_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
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
    :component("leather_armor_horse", 1)
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
    id = "bronze_armor_horse",
    result = "bronze_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 60)
    :component("leather_armor_horse", 1)
    :requirement("forging_standard", 120)
    :requirement("bronzesmithing_tools", 10)
    :requires_skill("tailor", 3)
    :book("bronze_book", 4)
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
    id = "steel_armor_horse",
    result = "steel_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 34560000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 800)
    :requirement("steel_standard", 200)
    :requirement("fabric_leather_fur_hide", 30)
    :requires_skill("tailor", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "fitted_horseshoes",
    result = "fitted_horseshoes",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE STORAGE",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("horseshoe", 4)
    :component("nails", 16, true)
)

content.add(content.Recipe {
    id = "saddlebag",
    result = "saddlebag",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("clasps", 2)
    :book("book_horse_tack", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)
