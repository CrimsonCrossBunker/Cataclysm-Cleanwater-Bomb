local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "acidchitin_armor_cow",
    result = "acidchitin_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 3690000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 100)
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
    id = "chitin_armor_cow",
    result = "chitin_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 3690000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 100)
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
    id = "chainmail_armor_cow",
    result = "chainmail_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 42)
    :component("lc_chain_link", 1100)
    :component("lc_wire", 8)
    :component_any({
            { id = "fur", count = 50 },
            { id = "tanned_pelt", count = 8 },
            { id = "leather", count = 50 },
            { id = "tanned_hide", count = 8 }
        })
    :requirement("chainmail_standard", 7)
    :requirement("clasps", 5)
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
    id = "kevlar_armor_cow",
    result = "kevlar_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 66)
    :requirement("armor_kevlar_layered", 28)
    :requirement("tailoring_cotton_patchwork", 171)
    :requirement("clasps", 5)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_armor_cow",
    result = "leather_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("armor_blarmor", 3)
    :component("cotton_patchwork", 21)
    :requirement("sewing_standard", 36)
    :requirement("clasps", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 25)
)

content.add(content.Recipe {
    id = "leather_armor_cow_from_scratch",
    result = "leather_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 36 },
            { id = "water_clean", count = 36 }
        })
    :component_any({
            { id = "wax_any", count = 7, requirement = true },
            { id = "any_tallow", count = 70, requirement = true },
            { id = "vinegar", count = 36 },
            { id = "pine_bough", count = 66 }
        })
    :component("salt", 180)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_leather_patchwork", 66)
    :requirement("tailoring_cotton_patchwork", 66)
    :requirement("surface_heat", 60)
    :requirement("clasps", 5)
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
    id = "leatherbone_armor_cow",
    result = "leatherbone_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "bone", count = 46 },
            { id = "bone_human", count = 46 },
            { id = "bone_demihuman", count = 46 }
        })
    :component("armor_blarmor", 3)
    :requirement("sewing_standard", 90)
    :requirement("clasps", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 25)
)

content.add(content.Recipe {
    id = "leatherbone_armor_cow_from_leatherarmor",
    result = "leatherbone_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 2790000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 46, true)
    :component("leather_armor_cow", 1)
    :requirement("sewing_standard", 41)
    :requirement("clasps", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_carving")
    :byproduct("leather", 7)
)

content.add(content.Recipe {
    id = "leatherbone_armor_cow_from_scratch",
    result = "leatherbone_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 60, true)
    :component_any({
            { id = "water", count = 36 },
            { id = "water_clean", count = 36 }
        })
    :component_any({
            { id = "wax_any", count = 7, requirement = true },
            { id = "any_tallow", count = 70, requirement = true },
            { id = "vinegar", count = 36 },
            { id = "pine_bough", count = 72 }
        })
    :component("salt", 180)
    :component("bone_sturdy", 45, true)
    :requirement("tailoring_leather_patchwork", 34)
    :requirement("clasps", 5)
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
    id = "rubber_armor_cow",
    result = "rubber_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("duct_tape", 210)
    :component("coat_rain", 8)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 5)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "rubber_armor_cow_from_scratch",
    result = "rubber_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("duct_tape", 420)
    :component("plastic_sheet", 11)
    :component("cotton_patchwork", 84)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 5)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "iron_armor_cow",
    result = "iron_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 10350000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 72, requirement = true },
            { id = "scrap", count = 216 }
        })
    :component("leather_armor_cow", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 302)
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
    id = "bronze_armor_cow",
    result = "bronze_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 10350000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 72)
    :component("leather_armor_cow", 1)
    :requirement("forging_standard", 144)
    :requirement("bronzesmithing_tools", 12)
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
    id = "steel_armor_cow",
    result = "steel_armor_cow",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BOVINE ARMOR",
    duration_moves = 41490000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 960)
    :requirement("steel_standard", 240)
    :requirement("fabric_leather_fur_hide", 36)
    :requires_skill("tailor", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)
