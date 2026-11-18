local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "acidchitin_harness_dog",
    result = "acidchitin_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 12)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 1)
    :requirement("clasps", 3)
    :requires_skill("survival", 4)
    :requires_skill("firstaid", 2)
    :requires_skill("fabrication", 2)
    :book("textbook_arthropod", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "chitin_harness_dog",
    result = "chitin_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("chitin_piece", 12)
    :quality("CUT", 2, 1)
    :requirement("cordage", 1)
    :requirement("clasps", 3)
    :requires_skill("fabrication", 2)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "chainmail_harness_dog",
    result = "chainmail_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("lc_link_sheet", 5)
    :component("lc_chain_link", 131)
    :component("lc_wire", 1)
    :component_any({
            { id = "fur", count = 8 },
            { id = "tanned_pelt", count = 1 },
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 1 }
        })
    :requirement("chainmail_standard", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2, skill_penalty = 0.2 })
)

content.add(content.Recipe {
    id = "leather_harness_dog",
    result = "leather_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    flags = { "NO_RESIZE" },
}
    :component("vest_leather", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2, skill_penalty = 0.2 })
    :byproduct("leather", 3)
)

content.add(content.Recipe {
    id = "leather_harness_dog_from_scratch",
    result = "leather_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("clasps", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "leatherbone_harness_dog",
    result = "leatherbone_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component_any({
            { id = "bone", count = 13 },
            { id = "bone_human", count = 13 },
            { id = "bone_demihuman", count = 13 }
        })
    :component("vest_leather", 1)
    :quality("CUT", 2, 1)
    :requirement("sewing_standard", 15)
    :requirement("clasps", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 3)
)

content.add(content.Recipe {
    id = "leatherbone_harness_dog_from_leatherharness",
    result = "leatherbone_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("bone_sturdy", 13, true)
    :component("leather_harness_dog", 1)
    :requirement("sewing_standard", 5)
    :requirement("clasps", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "leatherbone_harness_dog_from_scratch",
    result = "leatherbone_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 13, true)
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("clasps", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "rubber_harness_dog",
    result = "rubber_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("duct_tape", 25)
    :component("coat_rain", 1)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 3)
    :requires_skill("fabrication", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "rubber_harness_dog_from_scratch",
    result = "rubber_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cotton_patchwork", 10)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 3)
    :requirement("waterproofing_plastic_sheets", 10)
    :requires_skill("fabrication", 1)
    :proficiency("prof_closures")
)
