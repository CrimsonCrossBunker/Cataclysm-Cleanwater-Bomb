local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

-- Essentially a ball of glued-together string with some leather around it
content.add(content.Recipe {
    id = "baseball",
    result = "baseball",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component_any({
            { id = "string_36", count = 3 },
            { id = "cordage_36", count = 3 }
        })
    :component_any({
            { id = "glue_strong", count = 5 },
            { id = "glue_weak", count = 150 }
        })
    :requirement("tailoring_leather_small", 2)
    :proficiency("prof_leatherworking_basic")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "arrow_small_game_fletched",
    result = "arrow_small_game_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 1)
    :book("pocket_survival", 1)
    :book("book_archery", 2)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_fire_hardened_fletched",
    result = "arrow_fire_hardened_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :book("recipe_arrows", 1)
    :book("book_archery", 1)
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_wood",
    result = "arrow_wood",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("archery", 4)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_field_point_fletched",
    result = "arrow_field_point_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("archery", 4)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_heavy_field_point_fletched",
    result = "arrow_heavy_field_point_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("archery", 4)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_metal_sharpened_fletched",
    result = "arrow_metal_sharpened_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 10, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("GRIND", 1, 1)
    :requires_skill("archery", 4)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_heavy_fire_hardened_fletched",
    result = "arrow_heavy_fire_hardened_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("fire", 1)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 10, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 3)
    :requires_skill("archery", 1)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_wood_heavy",
    result = "arrow_wood_heavy",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "bee_sting", count = 2 },
            { id = "mop", count = 2 }
        })
    :component_any({
            { id = "bone_sturdy", count = 5, requirement = true },
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "scrap", count = 2 },
            { id = "nails", count = 10, requirement = true },
            { id = "rock_flaking_any", count = 1, requirement = true }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 2)
    :book("pocket_survival", 2)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_heavy_field_point_fletched_lathe",
    result = "arrow_heavy_field_point_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 30)
    :component("adhesive", 1, true)
    :component("glue_strong", 5, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component_any({
            { id = "small_lc_steel_bar_round", count = 1 },
            { id = "small_mc_steel_bar_round", count = 1 },
            { id = "small_hc_steel_bar_round", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 3)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_machining_basic")
    :batch_discount(50, 2)
    :result_charges(1)
    :byproduct("scrap", 1)
)

content.add(content.Recipe {
    id = "arrow_field_point_fletched_lathe",
    result = "arrow_field_point_fletched",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 30)
    :component("adhesive", 1, true)
    :component("glue_strong", 5, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component_any({
            { id = "small_lc_steel_bar_round", count = 1 },
            { id = "small_mc_steel_bar_round", count = 1 },
            { id = "small_hc_steel_bar_round", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 3)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_machining_basic")
    :batch_discount(50, 2)
    :result_charges(1)
    :byproduct("scrap", 1)
)

content.add(content.Recipe {
    id = "bolt_ballista_steel",
    result = "bolt_ballista_steel",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("2x4", 1)
    :component("nails", 2, true)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_standard", 1)
    :requires_skill("survival", 1)
    :requires_skill("traps", 1)
    :book("ballista_book", 4)
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bolt_wood",
    result = "bolt_wood",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_wood_bodkin",
    result = "bolt_wood_bodkin",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_wood_small_game",
    result = "bolt_wood_small_game",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_metal",
    result = "bolt_metal",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 10, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("GRIND", 1, 1)
    :requires_skill("survival", 2)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_wood_bodkin_lathe",
    result = "bolt_wood_bodkin",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 30)
    :component("adhesive", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component_any({
            { id = "small_lc_steel_bar_round", count = 1 },
            { id = "small_mc_steel_bar_round", count = 1 },
            { id = "small_hc_steel_bar_round", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 2)
    :book("recipe_arrows", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_machining_basic")
    :result_charges(1)
    :byproduct("scrap", 1)
)

content.add(content.Recipe {
    id = "bolt_crude",
    result = "bolt_crude",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :book("recipe_arrows", 1)
    :book("book_archery", 1)
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_simple_wood",
    result = "bolt_simple_wood",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("fire", 1)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 10, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 3)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_simple_small_game",
    result = "bolt_simple_small_game",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 1)
    :book("pocket_survival", 1)
    :book("book_archery", 2)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bolt_makeshift",
    result = "bolt_makeshift",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "bee_sting", count = 2 },
            { id = "mop", count = 2 }
        })
    :component_any({
            { id = "bone_sturdy", count = 5, requirement = true },
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "scrap", count = 2 },
            { id = "nails", count = 10, requirement = true },
            { id = "rock_flaking_any", count = 1, requirement = true }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("survival", 1)
    :book("recipe_arrows", 2)
    :book("pocket_survival", 2)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "flamable_arrow",
    result = "flamable_arrow",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("arrow_field_point_fletched", 1)
    :component("cotton_patchwork", 1, false, false)
    :component_any({
            { id = "lamp_oil", count = 50, recoverable = false },
            { id = "motor_oil", count = 50, recoverable = false },
            { id = "chem_ethanol", count = 100, recoverable = false },
            { id = "denat_alcohol", count = 100, recoverable = false },
            { id = "methed_alcohol", count = 100, recoverable = false },
            { id = "gasoline", count = 250, recoverable = false },
            { id = "diesel", count = 250, recoverable = false },
            { id = "biodiesel", count = 250, recoverable = false }
        })
    :quality("CUT", 2, 1)
    :requires_skill("archery", 3)
    :book("recipe_arrows", 5)
)

content.add(content.Recipe {
    id = "fishspear",
    result = "fishspear",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("scrap", 4)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carving")
    :result_charges(4)
)

content.add(content.Recipe {
    id = "m_fishspear",
    result = "m_fishspear",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "scrap", count = 8 }
        })
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "arrow_plastic",
    result = "arrow_plastic",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 336000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("plastic_chunk", 1)
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "bee_sting", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("CUT", 2, 1)
    :requirement("plastic_molding", 1)
    :requires_skill("archery", 3)
    :requires_skill("survival", 1)
    :book("plastics_book", 4)
    :proficiency("prof_plasticworking")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "combatnail",
    result = "combatnail",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("gun", 1)
    :result_charges(83)
)
