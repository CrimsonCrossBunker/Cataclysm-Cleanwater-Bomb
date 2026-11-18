local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "sauropod_stomach_sealed",
    result = "sauropod_stomach_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "water", count = 16 },
            { id = "water_clean", count = 16 }
        })
    :component("stomach_sauropod", 1)
    :component_any({
            { id = "cordage_short", count = 6, requirement = true },
            { id = "filament", count = 300, requirement = true }
        })
    :quality("CUT", 2, 1)
    :quality("BOIL", 1, 1)
    :requirement("waterproofing", 2)
)

content.add(content.Recipe {
    id = "mutagen_raptor_from_sample",
    result = "mutagen_raptor",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :component("mutagen", 1)
    :component("raptor_sample", 1)
    :component_any({
            { id = "egg_saurornitholestes", count = 2 },
            { id = "egg_velociraptor", count = 2 },
            { id = "egg_deinonychus", count = 2 },
            { id = "egg_utahraptor", count = 2 },
            { id = "egg_dromaeosaurus", count = 2 },
            { id = "egg_stenonychosaurus", count = 2 },
            { id = "raptor_sample", count = 1 }
        })
    :component_any({
            { id = "feather", count = 2 },
            { id = "raptor_sample", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 1)
    :book("recipe_raptor", 8)
)

content.add(content.Recipe {
    id = "mutagen_stego",
    result = "mutagen_stego",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :component("mutagen", 1)
    :component("stego_sample", 1)
    :component_any({
            { id = "egg_scutellosaurus", count = 1 },
            { id = "egg_stegosaurus", count = 1 },
            { id = "egg_hesperosaurus", count = 1 },
            { id = "egg_gargoyleosaurus", count = 1 },
            { id = "egg_sauropelta", count = 1 },
            { id = "egg_nodosaurus", count = 1 },
            { id = "egg_edmontonia", count = 1 },
            { id = "egg_zuul", count = 1 },
            { id = "egg_dyoplosaurus", count = 1 },
            { id = "egg_ankylosaurus", count = 1 },
            { id = "stego_sample", count = 1 }
        })
    :component_any({
            { id = "bone", count = 1 },
            { id = "stego_sample", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 1)
    :book("kiernans_notes", 8)
)

content.add(content.Recipe {
    id = "mutagen_horns",
    result = "mutagen_horns",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :component("mutagen", 1)
    :component("horns_sample", 1)
    :component_any({
            { id = "egg_aquilops", count = 1 },
            { id = "egg_leptoceratops", count = 1 },
            { id = "egg_zuniceratops", count = 1 },
            { id = "egg_styracosaurus", count = 1 },
            { id = "egg_centrosaurus", count = 1 },
            { id = "egg_einiosaurus", count = 1 },
            { id = "egg_achelousaurus", count = 1 },
            { id = "egg_pachyrhinosaurus", count = 1 },
            { id = "egg_chasmosaurus", count = 1 },
            { id = "egg_pentaceratops", count = 1 },
            { id = "egg_kosmoceratops", count = 1 },
            { id = "egg_torosaurus", count = 1 },
            { id = "egg_triceratops", count = 1 },
            { id = "horns_sample", count = 1 }
        })
    :component_any({
            { id = "bone", count = 1 },
            { id = "horns_sample", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 1)
    :book("kiernans_notes", 8)
)

content.add(content.Recipe {
    id = "mutagen_tyrant",
    result = "mutagen_tyrant",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :component("mutagen", 1)
    :component("tyrant_sample", 1)
    :component_any({
            { id = "egg_dryptosaurus", count = 1 },
            { id = "egg_appalachiosaurus", count = 1 },
            { id = "egg_gorgosaurus", count = 1 },
            { id = "egg_albertosaurus", count = 1 },
            { id = "egg_qianzhousaurus", count = 1 },
            { id = "egg_nanuqsaurus", count = 1 },
            { id = "egg_daspletosaurus", count = 1 },
            { id = "egg_tyrannosaurus", count = 1 },
            { id = "tyrant_sample", count = 1 }
        })
    :component_any({
            { id = "feather", count = 2 },
            { id = "tyrant_sample", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :requires_skill("firstaid", 1)
    :book("kiernans_notes", 8)
)

content.add(content.Recipe {
    id = "iv_mutagen_tyrant",
    result = "iv_mutagen_tyrant",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_tyrant", 2)
    :component("tyrant_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("kiernans_notes", 9)
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "iv_mutagen_stego",
    result = "iv_mutagen_stego",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_stego", 2)
    :component("stego_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("kiernans_notes", 9)
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "iv_mutagen_horns",
    result = "iv_mutagen_horns",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_horns", 2)
    :component("horns_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("kiernans_notes", 9)
    :batch_discount(20, 5)
)

content.add(content.Recipe {
    id = "iv_mutagen_raptor_from_sample",
    result = "iv_mutagen_raptor",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_MUTAGEN",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component("mutagen_raptor", 2)
    :component("raptor_sample", 1)
    :requirement("serum_production_standard", 37)
    :requires_skill("firstaid", 3)
    :book("kiernans_notes", 9)
    :batch_discount(20, 5)
)

content.replace(content.Recipe {
    id = "fertilizer_liquid_simple",
    result = "fertilizer_liquid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "BLIND_HARD", "ALLOW_ROTTEN" },
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component_any({
            { id = "meal_bone", count = 2 },
            { id = "meal_bone_tainted", count = 4 }
        })
    :component("meal_chitin_piece", 1)
    :component_any({
            { id = "feces_bird", count = 10 },
            { id = "feces_cow", count = 4 },
            { id = "feces_manure", count = 6 },
            { id = "feces_dino", count = 4 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "soft_adobe_brick",
    result = "soft_adobe_brick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "frame_wood", count = 1 },
            { id = "frame_wood_light", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("material_soil", 2)
    :component_any({
            { id = "withered", count = 2 },
            { id = "straw_pile", count = 2 },
            { id = "feces_cow", count = 1 },
            { id = "feces_roach", count = 4 },
            { id = "feces_manure", count = 2 },
            { id = "feces_dino", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(75, 4)
)

content.add(content.Recipe {
    id = "kevlar_armor_bear",
    result = "kevlar_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 56)
    :component("cotton_patchwork", 42)
    :component_any({
            { id = "leather", count = 24 },
            { id = "tanned_hide", count = 4 }
        })
    :requirement("sewing_standard", 190)
    :requirement("clasps", 4)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_armor_bear",
    result = "leather_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
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
    id = "leatherbone_armor_bear",
    result = "leatherbone_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
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
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 75)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 21)
)

content.add(content.Recipe {
    id = "leatherbone_armor_bear_from_leatherarmor",
    result = "leatherbone_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 39, true)
    :component("leather_armor_bear", 1)
    :requirement("sewing_standard", 35)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_carving")
    :byproduct("cotton_patchwork", 6)
)

content.add(content.Recipe {
    id = "leatherbone_armor_bear_from_scratch",
    result = "leatherbone_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
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
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component("bone_sturdy", 39, true)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :requirement("sewing_standard", 225)
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
    id = "rubber_armor_bear",
    result = "rubber_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
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
    id = "rubber_armor_bear_from_scratch",
    result = "rubber_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("duct_tape", 350)
    :component("bag_plastic", 70)
    :component("cotton_patchwork", 70)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "sweater_armor_bear",
    result = "sweater_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
    duration_moves = 18000000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_wool_knitting", 5000)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "steel_armor_bear",
    result = "steel_armor_bear",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_BEAR ARMOR",
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
    id = "kevlar_armor_elephant",
    result = "kevlar_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 56)
    :component("cotton_patchwork", 42)
    :component_any({
            { id = "leather", count = 24 },
            { id = "tanned_hide", count = 4 }
        })
    :requirement("sewing_standard", 190)
    :requirement("clasps", 4)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_armor_elephant",
    result = "leather_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
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
    id = "leatherbone_armor_elephant",
    result = "leatherbone_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
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
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 75)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 21)
)

content.add(content.Recipe {
    id = "leatherbone_armor_elephant_from_leatherarmor",
    result = "leatherbone_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 39, true)
    :component("leather_armor_elephant", 1)
    :requirement("sewing_standard", 35)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_carving")
    :byproduct("cotton_patchwork", 6)
)

content.add(content.Recipe {
    id = "leatherbone_armor_elephant_from_scratch",
    result = "leatherbone_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
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
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component("bone_sturdy", 39, true)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :requirement("sewing_standard", 225)
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
    id = "rubber_armor_elephant",
    result = "rubber_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
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
    id = "rubber_armor_elephant_from_scratch",
    result = "rubber_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("duct_tape", 350)
    :component("bag_plastic", 70)
    :component("cotton_patchwork", 70)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "sweater_armor_elephant",
    result = "sweater_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
    duration_moves = 18000000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_wool_knitting", 5000)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "steel_armor_elephant",
    result = "steel_armor_elephant",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_ELEPHANT ARMOR",
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
    id = "kevlar_armor_ostrich",
    result = "kevlar_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 4500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 56)
    :component("cotton_patchwork", 42)
    :component_any({
            { id = "leather", count = 24 },
            { id = "tanned_hide", count = 4 }
        })
    :requirement("sewing_standard", 190)
    :requirement("clasps", 4)
    :proficiency("prof_polymerworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leather_armor_ostrich",
    result = "leather_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
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
    id = "leatherbone_armor_ostrich",
    result = "leatherbone_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
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
    id = "leatherbone_armor_ostrich_from_leatherarmor",
    result = "leatherbone_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("bone_sturdy", 39, true)
    :component("leather_armor_ostrich", 1)
    :requirement("sewing_standard", 35)
    :requirement("clasps", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_carving")
    :byproduct("cotton_patchwork", 6)
)

content.add(content.Recipe {
    id = "leatherbone_armor_ostrich_from_scratch",
    result = "leatherbone_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
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
            { id = "wax", count = 6 },
            { id = "any_tallow", count = 60, requirement = true },
            { id = "vinegar", count = 30 },
            { id = "pine_bough", count = 60 }
        })
    :component("salt", 150)
    :component("bone_sturdy", 39, true)
    :component_any({
            { id = "leather", count = 105 },
            { id = "tanned_hide", count = 17 }
        })
    :requirement("sewing_standard", 225)
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
    id = "rubber_armor_ostrich",
    result = "rubber_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
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
    id = "rubber_armor_ostrich_from_scratch",
    result = "rubber_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("duct_tape", 350)
    :component("bag_plastic", 70)
    :component("cotton_patchwork", 70)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "sweater_armor_ostrich",
    result = "sweater_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
    duration_moves = 18000000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_wool_knitting", 5000)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "steel_armor_ostrich",
    result = "steel_armor_ostrich",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_OSTRICH ARMOR",
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
    id = "dino_carrier_wooden",
    result = "dino_carrier_wooden",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 40)
    :component("nails", 200, true)
    :component("hinge", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
)
