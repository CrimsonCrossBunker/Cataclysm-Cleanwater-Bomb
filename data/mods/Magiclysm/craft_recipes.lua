local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8
local EXTRA_EXERCISE = 10

content.add(content.Recipe {
    id = "dragon_essence",
    result = "dragon_essence",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("food_processor", 40)
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "dragon_scale", count = 4, requirement = true },
            { id = "meat_dragon", count = 40 }
        })
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("SEPARATE", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :requires_skill("spellcraft", 2)
    :book("black_dragons", 2)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "dragon_essence_with_blood",
    result = "dragon_essence",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "dragon_scale", count = 6, requirement = true },
            { id = "meat_dragon", count = 60 }
        })
    :component("dragon_blood", 500)
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("SEPARATE", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("black_dragons", 5)
    :proficiency("prof_alchemy", { required = true })
    :batch_discount(40, 3)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "spell_scroll_acid_resistance",
    result = "spell_scroll_acid_resistance",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 2,
    flags = { "SECRET" },
}
    :tool("paint_brush", 1)
    :component_any({
            { id = "blood_tainted", count = 8 },
            { id = "edible_blood", count = 8, requirement = true },
            { id = "dragon_blood", count = 2000 }
        })
    :component("any_strong_acid", 4, true)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :book("black_dragons", 2)
)

content.add(content.Recipe {
    id = "mana_dust",
    result = "mana_dust",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("mortar_pestle", 1)
    :component("crystallized_mana", 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("spellcraft", 2)
)

content.add(content.Recipe {
    id = "mana_infused_blood",
    result = "mana_infused_blood",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :component("mana_dust", 1)
    :component("edible_blood", 1, true)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :book("journeyman_enchanting", 4)
    :book("alchemy_basic", 3)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "enchanted_wood",
    result = "enchanted_wood",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("mana_dust", 10)
    :component("stick_long", 1)
    :quality("MANA_INFUSE", 1, 1)
    :book("journeyman_enchanting", 4)
    :book("alchemy_basic", 3)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "mana_pearl",
    result = "mana_pearl",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 5,
}
    :component("crystallized_mana", 50)
    :quality("MANA_INFUSE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :book("journeyman_enchanting", 4)
    :book("alchemy_basic", 3)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "bundle_demon_chitin_piece",
    result = "bundle_demon_chitin_piece",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MATERIALS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("demon_chitin_piece", 10)
    :component("rope_any_short", 1, true)
)

content.add(content.Recipe {
    id = "biomancer_booster_sludge",
    result = "biomancer_booster_sludge",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool("rune_biomancer", 1)
    :component("mana_energy_weak", 1, true)
    :component("edible_blood", 3, true)
    :component("meat_raw_steak", 1, true)
    :component("edible_bonemarrow", 1, true)
    :quality("CONTAIN", 1, 1)
    :requires_skill("spellcraft", 2)
    :proficiency("prof_alchemy")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "enchanted_jar",
    result = "enchanted_jar",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 3,
}
    :component("mana_dust", 10)
    :component("jar_glass_sealed", 1)
    :quality("MANA_INFUSE", 1, 1)
    :book("journeyman_enchanting", 4)
    :book("alchemy_basic", 3)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "sealed_fading_embers",
    result = "sealed_fading_embers",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 5,
}
    :component("fading_embers_active", 1)
    :component("enchanted_jar", 1)
    :book("harnessing_hellfire", 5)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "mcandle_everburning",
    result = "mcandle_everburning",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 5,
}
    :tool_any({
            { id = "lighter", charges = 5 },
            { id = "ref_lighter", charges = 5 },
            { id = "surface_heat", charges = 2, requirement = true }
        })
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 20, requirement = true },
            { id = "edible_tallow", count = 20, requirement = true }
        })
    :component("cordage_short", 1, true)
    :component("sealed_fading_embers", 1)
    :component("mana_dust", 2)
    :quality("CONTAIN", 1, 1)
    :requires_skill("fabrication", 1)
    :book("harnessing_hellfire", 5)
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "helmet_demonchitin",
    result = "helmet_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 7,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 1)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :byproduct("demon_chitin_piece", 3)
)

content.add(content.Recipe {
    id = "armguard_demonchitin",
    result = "armguard_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 2)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :byproduct("demon_chitin_piece", 8)
)

content.add(content.Recipe {
    id = "xl_armguard_demonchitin",
    result = "xl_armguard_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 3)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :byproduct("demon_chitin_piece", 8)
)

content.add(content.Recipe {
    id = "armor_demonchitin",
    result = "armor_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 8,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 4)
    :component("demon_chitin_piece", 6)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "xl_armor_demonchitin",
    result = "xl_armor_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 8,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 10)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "boots_demonchitin",
    result = "boots_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 960000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 2)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "xl_boots_demonchitin",
    result = "xl_boots_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 5)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "gauntlets_demonchitin",
    result = "gauntlets_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_piece", 10)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "xl_gauntlets_demonchitin",
    result = "xl_gauntlets_demonchitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_piece", 14)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :book("magic_armormaking", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "demonchitin_armor_horse",
    result = "demonchitin_armor_horse",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_EQUINE ARMOR",
    duration_moves = 6300000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 8,
}
    :component("demon_chitin_plate", 4)
    :component("demon_chitin_piece", 20)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requirement("cordage", 7)
    :requires_skill("spellcraft", 6)
    :requires_skill("fabrication", 4)
    :requires_skill("survival", 4)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "demonchitin_harness_dog",
    result = "demonchitin_harness_dog",
    category = "CC_ANIMALS",
    subcategory = "CSC_ANIMALS_CANINE ARMOR",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 8,
}
    :component("demon_chitin_piece", 12)
    :quality("CHISEL", 1, 1)
    :quality("SEW", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requirement("cordage", 1)
    :requires_skill("spellcraft", 6)
    :requires_skill("fabrication", 4)
    :requires_skill("survival", 4)
    :book("magic_armormaking", 7)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "quiver_of_holding_plus_one",
    result = "quiver_of_holding_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("tailoring_leather_small", 8)
    :requirement("fastener_large", 2)
    :requires_skill("spellcraft", 4)
    :requires_skill("archery", 1)
    :learn_by_disassembly("tailor", 3)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "quiver_of_holding_plus_two",
    result = "quiver_of_holding_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 6,
}
    :component("quiver_of_holding_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "orichalcum_ingot",
    result = "orichalcum_ingot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("demon_forge", 15)
    :tool("metalworking_tongs", 1)
    :component_any({
            { id = "orichalcum_sliver", count = 8 },
            { id = "orichalcum_lump", count = 2 }
        })
    :component("mercury", 100)
    :book("metal_legends", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_metallurgy")
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
    :proficiency("prof_almetallurgy")
    :batch_discount(50, 2)
)

content.add(content.Recipe {
    id = "orichalcum_ingot_with_bronze",
    result = "orichalcum_ingot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("demon_forge", 15)
    :tool("metalworking_tongs", 1)
    :component("scrap_bronze", 9)
    :component("mercury", 400)
    :book("metal_legends", 4)
    :proficiency("prof_metallurgy")
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
    :proficiency("prof_almetallurgy")
    :batch_discount(50, 2)
)

content.add(content.Recipe {
    id = "demon_chitin_flux",
    result = "demon_chitin_flux",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component("charcoal", 50)
    :component("crystallized_mana", 1)
    :component_any({
            { id = "any_strong_acid", count = 4, requirement = true },
            { id = "demon_chitin_piece", count = 1 }
        })
    :quality("MANA_INFUSE", 1, 1)
    :quality("COOK", 3, 1)
    :quality("DISTILL", 1, 1)
    :requirement("surface_heat", 50)
    :requires_skill("chemistry", 1)
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
    :batch_discount(70, 5)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "fireproof_mortar",
    result = "fireproof_mortar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("concrete_mix_tool", 50)
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "clay_quern", count = 1 },
            { id = "mortar_pestle", count = 1 }
        })
    :component("material_cement", 50)
    :component("material_sand", 150)
    :component("demon_chitin_piece", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("metal_legends", 2)
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
    :proficiency("prof_pottery")
)

content.add(content.Recipe {
    id = "alumentum",
    result = "alumentum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("charcoal", 50)
    :component("crystallized_mana", 10)
    :component_any({
            { id = "denat_alcohol", count = 10 },
            { id = "chem_ethanol", count = 10 }
        })
    :quality("MANA_INFUSE", 1, 1)
    :quality("COOK", 3, 1)
    :quality("DISTILL", 1, 1)
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
    :result_charges(50)
)

content.add(content.Recipe {
    id = "golemcore",
    result = "golemcore",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("demon_forge", 30)
    :tool("metalworking_tongs", 1)
    :component("orichalcum_ingot", 4)
    :component("mercury", 4)
    :component("crystallized_mana", 100)
    :quality("CHISEL", 2, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("FILE", 2, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("metal_legends", 6)
    :proficiency("prof_almetallurgy", { required = true })
    :proficiency("prof_golemancy_basic", { required = false, time_multiplier = 1.5, skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "magus_booster_1",
    result = "magus_booster_1",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick", 2)
    :component("rune_magus", 1)
    :quality("CUT", 1, 1)
    :requirement("cordage_short", 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("survival", 1)
    :book("caster_boosts_info", 2)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "magus_booster_2",
    result = "magus_booster_2",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("metalworking_tongs", 1)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component("filament", 5, true)
    :component("rune_magus", 1)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("cordage_short", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("spellcraft", 4)
    :book("caster_boosts_info", 6)
    :proficiency("prof_carving")
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "kelvinist_booster_1",
    result = "kelvinist_booster_1",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "FULL_MAGAZINE" },
}
    :tool_any({
            { id = "lighter", charges = 5 },
            { id = "ref_lighter", charges = 5 },
            { id = "surface_heat", charges = 2, requirement = true }
        })
    :tool("rune_kelvinist", 1)
    :component_any({
            { id = "wax", count = 1 },
            { id = "any_tallow", count = 10, requirement = true },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("cordage_short", 1, true)
    :quality("CONTAIN", 1, 1)
    :requires_skill("spellcraft", 2)
    :book("caster_boosts_info", 0)
)

content.add(content.Recipe {
    id = "kelvinist_booster_2",
    result = "kelvinist_booster_2",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "cordage_superior_short", count = 1, requirement = true }
        })
    :component("rune_kelvinist", 1)
    :quality("HAMMER", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("spellcraft", 4)
    :book("caster_boosts_info", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "technomancer_booster_1",
    result = "technomancer_booster_1",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("rune_technomancer", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("clay_lump", 1)
    :requirement("earthenware_firing", 120)
    :requires_skill("spellcraft", 2)
    :requires_skill("survival", 1)
    :book("caster_boosts_info", 2)
    :proficiency("prof_pottery")
    :batch_discount(25, 3)
)

content.add(content.Recipe {
    id = "technomancer_booster_2",
    result = "technomancer_booster_2",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("scrap", 4)
    :component("cable", 1)
    :component("motor_tiny", 1)
    :component("power_supply", 1)
    :component("rune_technomancer", 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 3, 1)
    :requirement("soldering_standard", 20)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :requires_skill("spellcraft", 4)
    :requires_skill("fabrication", 2)
    :book("caster_boosts_info", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "biomancer_booster_1",
    result = "biomancer_booster_1",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("bone_sturdy", 1, true)
    :component("rune_biomancer", 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("firstaid", 1)
    :book("caster_boosts_info", 1)
)

content.add(content.Recipe {
    id = "biomancer_booster_2",
    result = "biomancer_booster_2",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 1)
    :component("rune_biomancer", 1)
    :quality("HAMMER", 3, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :requirement("welding_standard", 10)
    :requirement("blacksmithing_standard", 5)
    :requirement("steel_chunk_any", 1)
    :requires_skill("spellcraft", 4)
    :requires_skill("firstaid", 2)
    :book("caster_boosts_info", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "flu_shot",
    result = "flu_shot",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
}
    :tool_charges("surface_heat", 7, true)
    :component("mutant_fat", 2)
    :component("syringe", 1)
    :component("owlbear_stone", 1)
    :component("glow_dust", 2)
    :component("aspirin", 20)
    :component("meth", 3)
    :quality("COOK", 1, 1)
    :quality("MAGIC_MUTAGEN", 1, 1)
    :requires_skill("spellcraft", 5)
    :book("cooking_poison", 2)
)

content.add(content.Recipe {
    id = "black_dragon_tanning_hide",
    result = "black_dragon_tanning_hide",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MATERIALS",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component("dragon_essence", 1)
    :component("black_dragon_hide_raw", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 5)
    :book("black_dragons", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_alchemy")
    :batch_discount(20, 10)
    :byproduct("dragon_black_scale", 20)
)

content.add(content.Recipe {
    id = "bundle_black_scale",
    result = "bundle_black_scale",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MATERIALS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("dragon_black_scale", 10)
    :component("cotton_patchwork", 3)
    :quality("SEW", 2, 1)
    :requirement("filament", 8)
)

-- volume of black dragon hide is leather x8 so it needs x8 filament
content.add(content.Recipe {
    id = "bundle_black_hide",
    result = "bundle_black_hide",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MATERIALS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("black_dragon_tanned_hide", 10)
    :quality("SEW", 1, 1)
    :requirement("filament", 64)
)

content.add(content.Recipe {
    id = "suit_black_dragon_hide",
    result = "suit_black_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 22)
    :component("dragon_essence", 11)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 250)
    :requires_skill("spellcraft", 3)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "suit_black_dragon_scale",
    result = "suit_black_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 104400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("black_dragon_tanned_hide", 22)
    :component("dragon_black_scale", 1100)
    :component("dragon_essence", 11)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 250)
    :requirement("welding_standard", 50)
    :requires_skill("spellcraft", 5)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "boots_black_dragon_hide",
    result = "boots_black_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 4)
    :component("dragon_essence", 2)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 100)
    :requires_skill("spellcraft", 3)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "boots_black_dragon_scale",
    result = "boots_black_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("black_dragon_tanned_hide", 6)
    :component("dragon_black_scale", 75)
    :component("dragon_essence", 4)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 100)
    :requirement("welding_standard", 10)
    :requires_skill("spellcraft", 5)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "helmet_black_dragon_hide",
    result = "helmet_black_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 3)
    :component("dragon_essence", 2)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 100)
    :requires_skill("spellcraft", 3)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "helmet_black_dragon_scale",
    result = "helmet_black_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("black_dragon_tanned_hide", 1)
    :component("dragon_black_scale", 90)
    :component("dragon_essence", 4)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 100)
    :requirement("welding_standard", 10)
    :requires_skill("spellcraft", 5)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "gloves_black_dragon_hide",
    result = "gloves_black_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 3)
    :component("dragon_essence", 3)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 100)
    :requires_skill("spellcraft", 3)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "gauntlets_black_dragon_scale",
    result = "gauntlets_black_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("black_dragon_tanned_hide", 4)
    :component("dragon_black_scale", 50)
    :component("dragon_essence", 5)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 100)
    :requirement("welding_standard", 10)
    :requires_skill("spellcraft", 5)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "suit_xlblack_dragon_hide",
    result = "suit_xlblack_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("black_dragon_tanned_hide", 35)
    :component("dragon_essence", 18)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 350)
    :requires_skill("spellcraft", 4)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "suit_xlblack_dragon_scale",
    result = "suit_xlblack_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 122400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("black_dragon_tanned_hide", 35)
    :component("dragon_black_scale", 1800)
    :component("dragon_essence", 20)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 350)
    :requirement("welding_standard", 100)
    :requires_skill("spellcraft", 6)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "boots_xlblack_dragon_hide",
    result = "boots_xlblack_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("black_dragon_tanned_hide", 6)
    :component("dragon_essence", 3)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 150)
    :requires_skill("spellcraft", 4)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "boots_xlblack_dragon_scale",
    result = "boots_xlblack_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("black_dragon_tanned_hide", 8)
    :component("dragon_black_scale", 125)
    :component("dragon_essence", 6)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 150)
    :requirement("welding_standard", 20)
    :requires_skill("spellcraft", 6)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_cobbling")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "helmet_xlblack_dragon_hide",
    result = "helmet_xlblack_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("black_dragon_tanned_hide", 4)
    :component("dragon_essence", 3)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 150)
    :requires_skill("spellcraft", 4)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "helmet_xlblack_dragon_scale",
    result = "helmet_xlblack_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("black_dragon_tanned_hide", 2)
    :component("dragon_black_scale", 140)
    :component("dragon_essence", 6)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 150)
    :requirement("welding_standard", 20)
    :requires_skill("spellcraft", 6)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "gloves_xlblack_dragon_hide",
    result = "gloves_xlblack_dragon_hide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :component("black_dragon_tanned_hide", 4)
    :component("dragon_essence", 4)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 150)
    :requires_skill("spellcraft", 4)
    :book("black_dragons", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
)

content.add(content.Recipe {
    id = "gauntlets_xlblack_dragon_scale",
    result = "gauntlets_xlblack_dragon_scale",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("black_dragon_tanned_hide", 6)
    :component("dragon_black_scale", 75)
    :component("dragon_essence", 7)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CHISEL", 3, 1)
    :requirement("sewing_standard", 150)
    :requirement("welding_standard", 20)
    :requires_skill("spellcraft", 6)
    :book("black_dragons", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation", { required = false, time_multiplier = 2 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_scaleworking_dragon")
)

content.add(content.Recipe {
    id = "mutagen_black_dragon",
    result = "mutagen_black_dragon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("dragon_essence", 5)
    :component("potion_starter_superior", 1)
    :quality("CHEM", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("black_dragons_historical", 7)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "iv_black_dragon",
    result = "iv_black_dragon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("dragon_essence", 5)
    :component("mutagen_black_dragon", 1)
    :component("manatouched_serum", 1)
    :quality("CHEM", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 8)
    :book("black_dragons_historical", 8)
    :batch_discount(80, 20)
)

content.add(content.Recipe {
    id = "backpack_black_dragon_hide",
    result = "backpack_black_dragon_hide",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 10)
    :component("dragon_essence", 3)
    :component("plastic_sheet", 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 120)
    :requirement("fastener_large", 2)
    :requires_skill("spellcraft", 2)
    :requires_skill("fabrication", 3)
    :book("black_dragons", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "backpack_xl_black_dragon_hide",
    result = "backpack_xl_black_dragon_hide",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ARMOR",
    duration_moves = 4680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("black_dragon_tanned_hide", 14)
    :component("dragon_essence", 4)
    :component("plastic_sheet", 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("CHISEL", 1, 1)
    :requirement("sewing_standard", 130)
    :requirement("fastener_large", 2)
    :requires_skill("spellcraft", 2)
    :requires_skill("fabrication", 3)
    :book("black_dragons", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_dragon")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "mag_awoken_weaver",
    result = "mag_awoken_weaver",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 2,
}
    :component("mag_brokeweaver", 1)
    :component("rune_druid", 1)
    :component("mag_awakened_water", 50)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("mana_energy_weak", 1)
)

content.add(content.Recipe {
    id = "mag_immature_weaver",
    result = "mag_immature_weaver",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 2,
}
    :component("enchanted_wood", 2)
    :component("rune_druid", 1)
    :component("mag_awakened_water", 100)
    :component_any({
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "wax_any", count = 1, requirement = true },
            { id = "candle", count = 1 }
        })
    :quality("MANA_INFUSE", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL", 1, 1)
    :requirement("mana_energy_weak", 2)
    :requires_skill("fabrication", 2)
    :book("mag_druid_items_master", 2)
)

content.add(content.Recipe {
    id = "mag_wildwood_beetle_ball",
    result = "mag_wildwood_beetle_ball",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 6,
}
    :component("enchanted_wood", 2)
    :component("mana_pearl", 2)
    :component("rune_druid", 1)
    :component("mag_awakened_water", 50)
    :component_any({
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "wax_any", count = 1, requirement = true },
            { id = "candle", count = 1 }
        })
    :quality("MANA_INFUSE", 2, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL", 2, 1)
    :requirement("mana_energy_strong", 3)
    :requires_skill("fabrication", 3)
    :book("mag_druid_items_master", 5)
)

content.add(content.Recipe {
    id = "rune_wildwood",
    result = "rune_wildwood",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 3,
}
    :tool("mag_large_wildwood_beetle_ball", 1)
    :component("rune_druid", 1)
    :component("mag_awakened_water", 10)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL", 1, 1)
    :requirement("mana_energy_weak", 1)
    :requirement("mag_green_roughage", 2)
    :requires_skill("fabrication", 2)
    :book("mag_druid_items_master", 3)
)

content.add(content.Recipe {
    id = "mag_sealed_glowing_gourd",
    result = "mag_sealed_glowing_gourd",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 2,
}
    :component("bottle_gourd", 1)
    :component("rune_druid", 1)
    :component_any({
            { id = "water", count = 9 },
            { id = "water_clean", count = 9 }
        })
    :quality("MANA_INFUSE", 1, 1)
    :requirement("mana_energy_weak", 2)
    :requires_skill("cooking", 2)
    :book("mag_druid_items_master", 2)
)

content.add(content.Recipe {
    id = "cestus_plus_one",
    result = "cestus_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cestus", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cestus_plus_two",
    result = "cestus_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cestus_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "flaming_fist_plus_one",
    result = "flaming_fist_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("flaming_fist", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "flaming_fist_plus_two",
    result = "flaming_fist_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("flaming_fist_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cudgel_plus_one",
    result = "cudgel_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cudgel", 1)
    :component("mana_dust", 20)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cudgel_plus_two",
    result = "cudgel_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cudgel_plus_one", 1)
    :component("mana_dust", 20)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "q_staff_plus_one",
    result = "q_staff_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("q_staff", 1)
    :component("mana_dust", 20)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "q_staff_plus_two",
    result = "q_staff_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("q_staff_plus_one", 1)
    :component("mana_dust", 20)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "i_staff_plus_one",
    result = "i_staff_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("i_staff", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "i_staff_plus_two",
    result = "i_staff_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("i_staff_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "longsword_plus_one",
    result = "longsword_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_longsword", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "longsword_plus_two",
    result = "longsword_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("longsword_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "warhammer_plus_one",
    result = "warhammer_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("warhammer", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "warhammer_plus_two",
    result = "warhammer_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("warhammer_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "spear_steel_plus_one",
    result = "spear_steel_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("spear_steel", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "spear_steel_plus_two",
    result = "spear_steel_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("spear_steel_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "qiang_plus_one",
    result = "qiang_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qiang", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "qiang_plus_two",
    result = "qiang_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qiang_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "halberd_plus_one",
    result = "halberd_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("halberd", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "halberd_plus_two",
    result = "halberd_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("halberd_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "glaive_plus_one",
    result = "glaive_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("glaive", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "glaive_plus_two",
    result = "glaive_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("glaive_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "naginata_plus_one",
    result = "naginata_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("naginata", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "naginata_plus_two",
    result = "naginata_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("naginata_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "mace_plus_one",
    result = "mace_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_mace", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "mace_plus_two",
    result = "mace_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("mace_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "morningstar_plus_one",
    result = "morningstar_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("morningstar", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "morningstar_plus_two",
    result = "morningstar_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("morningstar_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "jian_plus_one",
    result = "jian_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_jian", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "jian_plus_two",
    result = "jian_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("jian_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "scimitar_plus_one",
    result = "scimitar_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_scimitar", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "scimitar_plus_two",
    result = "scimitar_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("scimitar_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "estoc_plus_one",
    result = "estoc_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_estoc", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "estoc_plus_two",
    result = "estoc_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("estoc_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "arming_sword_plus_one",
    result = "arming_sword_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_arming_sword", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "arming_sword_plus_two",
    result = "arming_sword_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("arming_sword_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "broadsword_plus_one",
    result = "broadsword_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_broadsword", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "broadsword_plus_two",
    result = "broadsword_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("broadsword_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "battleaxe_plus_one",
    result = "battleaxe_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_battleaxe", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "battleaxe_plus_two",
    result = "battleaxe_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("battleaxe_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cavalry_sabre_plus_one",
    result = "cavalry_sabre_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_cavalry_sabre", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cavalry_sabre_plus_two",
    result = "cavalry_sabre_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cavalry_sabre_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cutlass_plus_one",
    result = "cutlass_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_cutlass", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "cutlass_plus_two",
    result = "cutlass_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cutlass_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "katana_plus_one",
    result = "katana_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_katana", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "katana_plus_two",
    result = "katana_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("katana_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_combat_plus_one",
    result = "knife_combat_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("knife_combat", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_combat_plus_two",
    result = "knife_combat_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("knife_combat_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_rambo_plus_one",
    result = "knife_rambo_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_knife_rambo", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_rambo_plus_two",
    result = "knife_rambo_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("knife_rambo_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_trench_plus_one",
    result = "knife_trench_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_knife_trench", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "knife_trench_plus_two",
    result = "knife_trench_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("knife_trench_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "kris_plus_one",
    result = "kris_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("kris", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "kris_plus_two",
    result = "kris_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("kris_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "kukri_plus_one",
    result = "kukri_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_kukri", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "kukri_plus_two",
    result = "kukri_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("kukri_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "nodachi_plus_one",
    result = "nodachi_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_nodachi", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "nodachi_plus_two",
    result = "nodachi_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("nodachi_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "pike_plus_one",
    result = "pike_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pike", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "pike_plus_two",
    result = "pike_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pike_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "rapier_plus_one",
    result = "rapier_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_rapier", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "rapier_plus_two",
    result = "rapier_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("rapier_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "tanto_plus_one",
    result = "tanto_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("tanto", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "tanto_plus_two",
    result = "tanto_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("tanto_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "wakizashi_plus_one",
    result = "wakizashi_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_wakizashi", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "wakizashi_plus_two",
    result = "wakizashi_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("wakizashi_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "zweihander_plus_one",
    result = "zweihander_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("qt_zweihander", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "zweihander_plus_two",
    result = "zweihander_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("zweihander_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "khopesh_plus_one",
    result = "khopesh_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("khopesh", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "khopesh_plus_two",
    result = "khopesh_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("khopesh_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "sword_xiphos_plus_one",
    result = "sword_xiphos_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sword_xiphos", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "sword_xiphos_plus_two",
    result = "sword_xiphos_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sword_xiphos_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "dao_plus_one",
    result = "dao_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("dao", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "dao_plus_two",
    result = "dao_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("dao_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "lucerne_plus_one",
    result = "lucerne_plus_one",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("lucern_hammer", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "lucerne_plus_two",
    result = "lucerne_plus_two",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_ENCHANTING",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("lucerne_plus_one", 1)
    :component("mana_dust", 20)
    :component("mercury", 10)
    :quality("MANA_INFUSE", 1, 1)
    :book("weapon_enchanting_guide", 4)
    :proficiency("prof_weapon_enchanting")
)

content.add(content.Recipe {
    id = "everburning_torch_candelabra",
    result = "everburning_torch_candelabra",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("wooden_post", 3)
    :component("wooden_post_short", 4)
    :component("plank_short", 12)
    :component("nuts_bolts", 30)
    :component("scrap", 15)
    :component("mtorch_everburning", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 2, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 45)
)

-- Nails are needed here rather than at the finished product because more than one ingredient in an appliance
-- recipe throws an error
content.add(content.Recipe {
    id = "everburning_sconce",
    result = "everburning_sconce",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("plank_short", 1)
    :component("nuts_bolts", 4)
    :component("scrap", 2)
    :component("mtorch_everburning", 1)
    :component("nails", 4, true)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 2, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "copper_circlet",
    result = "copper_circlet",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "scrap_copper", count = 1 },
            { id = "copper", count = 50 }
        })
    :component("splinter", 3)
    :quality("HAMMER_FINE", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requires_skill("spellcraft", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = false, time_multiplier = 3 })
    :byproduct("tinder", 1)
)

content.add(content.Recipe {
    id = "copper_infuser",
    result = "copper_infuser",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("copper_bracelet", 1)
    :quality("CHISEL", 1, 1)
    :requires_skill("spellcraft", 2)
    :book("alchemy_basic", 3)
    :book("necro_basic", 4)
    :book("techno_basic", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "silver_circlet",
    result = "silver_circlet",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component("silver_small", 50)
    :component("splinter", 3)
    :quality("HAMMER_FINE", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :requires_skill("spellcraft", 3)
    :book("journeyman_enchanting", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
    :byproduct("tinder", 1)
)

content.add(content.Recipe {
    id = "silver_infuser",
    result = "silver_infuser",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "silver_bracelet", count = 1 },
            { id = "diamond_silver_bracelet", count = 1 },
            { id = "garnet_silver_bracelet", count = 1 },
            { id = "amethyst_silver_bracelet", count = 1 },
            { id = "aquamarine_silver_bracelet", count = 1 },
            { id = "emerald_silver_bracelet", count = 1 },
            { id = "alexandrite_silver_bracelet", count = 1 },
            { id = "ruby_silver_bracelet", count = 1 },
            { id = "peridot_silver_bracelet", count = 1 },
            { id = "sapphire_silver_bracelet", count = 1 },
            { id = "tourmaline_silver_bracelet", count = 1 },
            { id = "citrine_silver_bracelet", count = 1 },
            { id = "blue_topaz_silver_bracelet", count = 1 },
            { id = "opal_silver_bracelet", count = 1 },
            { id = "pearl_silver_bracelet", count = 1 },
            { id = "onyx_silver_bracelet", count = 1 }
        })
    :quality("CHISEL", 1, 1)
    :requires_skill("spellcraft", 3)
    :book("alchemy_basic", 3)
    :book("necro_basic", 4)
    :book("techno_basic", 4)
    :book("journeyman_enchanting", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_fine_metalsmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "rune_alchemist",
    result = "rune_alchemist",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pebble", 1)
    :quality("CHISEL", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 6)
)

content.add(content.Recipe {
    id = "cauldron_demon_chitin",
    result = "cauldron_demon_chitin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("demon_chitin_piece", 16)
    :component("glue_weak", 1500)
    :quality("CHISEL", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :book("cooking_poison", 3)
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "demon_forge",
    result = "demon_forge",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("demon_chitin_plate", 24)
    :component("fireproof_mortar", 30)
    :component("pilot_light", 1)
    :component("pipe", 3)
    :component("crystallized_mana", 80)
    :quality("CHISEL", 2, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("SMOOTH", 1, 1)
    :requires_skill("spellcraft", 3)
    :book("metal_legends", 3)
    :proficiency("prof_chitinworking", { required = false, time_multiplier = 1.5, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "mana_dot_sight",
    result = "mana_dot_sight",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MODS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 7,
}
    :tool_any({
            { id = "rune_alchemist", count = 1 },
            { id = "rune_technomancer", count = 1 },
            { id = "rune_technomancer_weapon", count = 1 },
            { id = "rune_technomancer_weapon_adept", count = 1 }
        })
    :component("plastic_chunk", 2)
    :component("amplifier", 1)
    :component("power_supply", 1)
    :component("light_minus_battery_cell", 1)
    :component("crystallized_mana", 15)
    :component("silver_small", 10)
    :component("gold_small", 10)
    :component("chem_aluminium_powder", 10)
    :component("chem_chromium_oxide", 10)
    :component("lens", 2)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHEM", 2, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("plastic_molding", 1)
    :requires_skill("spellcraft", 7)
    :requires_skill("gun", 4)
    :book("techno_basic", 5)
)

content.add(content.Recipe {
    id = "mana_laser_under",
    result = "mana_laser_under",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_MODS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :tool_any({
            { id = "rune_technomancer", count = 1 },
            { id = "rune_technomancer_weapon", count = 1 },
            { id = "rune_technomancer_weapon_adept", count = 1 },
            { id = "rune_alchemist", count = 1 }
        })
    :component("amplifier", 1)
    :component("power_supply", 1)
    :component_any({
            { id = "lens", count = 2 },
            { id = "lens_small", count = 2 }
        })
    :component("light_minus_battery_cell", 1)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("small_mana_crystal", 1)
    :component("cable", 2)
    :quality("SCREW_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("spellcraft", 4)
    :requires_skill("gun", 4)
    :book("techno_basic", 4)
)

content.add(content.Recipe {
    id = "manatouched_serum",
    result = "manatouched_serum",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component("mana_dust", 20)
    :component_any({
            { id = "mana_potion", count = 4 },
            { id = "mana_potion_greater", count = 1 },
            { id = "mana_infused_blood", count = 6 }
        })
    :quality("MAGIC_MUTAGEN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :requires_skill("spellcraft", 6)
    :proficiency("prof_alchemy")
    :batch_discount(80, 5)
)

content.add(content.Recipe {
    id = "manatouched_mutagen",
    result = "manatouched_mutagen",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component("mana_dust", 5)
    :component_any({
            { id = "mana_potion", count = 1 },
            { id = "mana_infused_blood", count = 2 }
        })
    :component("mutagen", 1)
    :quality("MAGIC_MUTAGEN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("SEPARATE", 1, 1)
    :quality("ANALYSIS", 1, 1)
    :requires_skill("spellcraft", 4)
    :proficiency("prof_alchemy")
    :batch_discount(80, 5)
)

content.add(content.Recipe {
    id = "potion_fruit_apple",
    result = "potion_fruit_apple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("apple", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 6)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :book("druid_healing_power_spellbook", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_peach",
    result = "potion_fruit_peach",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("peach", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 7)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :book("druid_healing_power_spellbook", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_pear",
    result = "potion_fruit_pear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("pear", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 7)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_blackberries",
    result = "potion_fruit_blackberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("blackberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_raspberries",
    result = "potion_fruit_raspberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("raspberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 6)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_strawberries",
    result = "potion_fruit_strawberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("strawberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 6)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_elderberries",
    result = "potion_fruit_elderberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("elderberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 6)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_blueberries",
    result = "potion_fruit_blueberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("blueberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_cranberries",
    result = "potion_fruit_cranberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("cranberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 7)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :book("druid_healing_power_spellbook", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_huckleberries",
    result = "potion_fruit_huckleberries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("huckleberries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 6)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_wintergreen",
    result = "potion_fruit_wintergreen",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("wintergreen_berry", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_cherry",
    result = "potion_fruit_cherry",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("cherries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :book("druid_healing_power_spellbook", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_apricot",
    result = "potion_fruit_apricot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("apricot", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_mayapple",
    result = "potion_fruit_mayapple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("mayapple", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_grapes",
    result = "potion_fruit_grapes",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("grapes", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_fruit_m_stellatum_berries",
    result = "potion_fruit_m_stellatum_berries",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 4,
}
    :component("m_stellatum_berries", 1)
    :component("mana_dust", 10)
    :quality("MANA_INFUSE", 1, 1)
    :learn_automatically("spellcraft", 5)
    :learn_automatically("cooking", 3)
    :book("history_botanical_enchantment", 3)
    :proficiency("prof_alchemy")
    :proficiency("prof_botanical_enchantment")
    :batch_discount(15, 2)
)

content.add(content.Recipe {
    id = "potion_starter_superior",
    result = "potion_starter_superior",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 15, true)
    :component("chem_ethanol", 7)
    :component("alumentum", 1)
    :component("water_clean", 7)
    :quality("CHEM", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("necro_basic", 4)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(75, 2)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "potion_starter",
    result = "potion_starter",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 15, true)
    :component_any({
            { id = "water", count = 7 },
            { id = "water_clean", count = 7 },
            { id = "water_mineral", count = 7 }
        })
    :component("mana_dust", 7)
    :quality("CHEM", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("hard_liquor_and_whiskflower", 7)
    :requires_skill("spellcraft", 2)
    :book("alchemy_basic", 1)
    :book("necro_basic", 2)
    :book("alchemy_master", 1)
    :proficiency("prof_alchemy", { required = false, time_multiplier = 1.5 })
    :batch_discount(75, 2)
    :result_charges(7)
)

-- first level flasks
content.add(content.Recipe {
    id = "flask_illumination",
    result = "flask_illumination",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :tool("mortar_pestle", 1)
    :component("potion_starter", 2)
    :component("glowing_mushroom", 2)
    :component("wood_barnacle", 4)
    :component("dragon_nail", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("DISTILL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :requires_skill("spellcraft", 2)
    :book("alchemy_basic", 2)
    :book("alchemy_master", 2)
    :proficiency("prof_alchemy")
    :batch_discount(80, 2)
)

content.add(content.Recipe {
    id = "flask_rebreather",
    result = "flask_rebreather",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :tool("mortar_pestle", 1)
    :component("potion_starter", 2)
    :component("wood_barnacle", 2)
    :component("olieribos", 2)
    :component("horn_moss_capsule", 2)
    :component("golden_reed_stalk", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("DISTILL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :requires_skill("spellcraft", 2)
    :book("alchemy_basic", 2)
    :book("alchemy_master", 2)
    :proficiency("prof_alchemy")
    :batch_discount(80, 2)
)

content.add(content.Recipe {
    id = "mana_potion_lesser",
    result = "mana_potion_lesser",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :tool("mortar_pestle", 1)
    :component("potion_starter", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :quality("DISTILL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :requirement("mana_energy_weak", 2)
    :requires_skill("spellcraft", 2)
    :book("alchemy_basic", 2)
    :book("alchemy_master", 2)
    :proficiency("prof_alchemy")
    :batch_discount(80, 2)
)

-- second level flasks
content.add(content.Recipe {
    id = "cats_grace_potion",
    result = "cats_grace_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter_superior", 1)
    :component("fern_flower", 2)
    :component_any({
            { id = "glowing_mushroom", count = 4 },
            { id = "mossling_fur", count = 4 }
        })
    :component("wood_barnacle", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "ogres_strength_potion",
    result = "ogres_strength_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter_superior", 1)
    :component("fern_flower", 2)
    :component("olieribos", 4)
    :component("wood_barnacle", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "eagles_sight_potion",
    result = "eagles_sight_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter_superior", 1)
    :component("fern_flower", 2)
    :component("dragon_nail", 4)
    :component("wood_barnacle", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "foxs_cunning_potion",
    result = "foxs_cunning_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter_superior", 1)
    :component("fern_flower", 2)
    :component("golden_reed_stalk", 4)
    :component("wood_barnacle", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_resistance",
    result = "flask_resistance",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 4)
    :component("wood_barnacle", 2)
    :component("olieribos", 2)
    :component("moly_tuber", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_max_mana",
    result = "flask_max_mana",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("golden_reed_stalk", 2)
    :component("funnelcap_chunk", 6)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_fireball",
    result = "flask_fireball",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("dragon_nail", 2)
    :component("glowing_mushroom", 4)
    :component("funnelcap_chunk", 6)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

-- if you read this, ping me to remind me to check does inheritance rewrite book_learn, or does it summarise
-- the values. thank you
content.add(content.Recipe {
    id = "flask_confusion",
    result = "flask_confusion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("funnelcap_chunk", 6)
    :component("glowing_mushroom", 2)
    :component("kampuch", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_illegal", 5)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_spear",
    result = "flask_spear",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("dragon_nail", 3)
    :component("funnelcap_chunk", 5)
    :component("moly_tuber", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_shadow_field",
    result = "flask_shadow_field",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("glowing_mushroom", 3)
    :component("moly_tuber", 2)
    :component("golden_reed_stalk", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "flask_sludge_field",
    result = "flask_sludge_field",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 2)
    :component("kampuch", 2)
    :component("golden_reed_stalk", 1)
    :component("funnelcap_chunk", 8)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "alchemist_bomb",
    result = "alchemist_bomb",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 3)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requirement("mana_energy_weak", 3)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 4)
    :book("alchemy_master", 4)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "mana_potion",
    result = "mana_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool("mortar_pestle", 2)
    :component("potion_starter", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requirement("mana_energy_weak", 3)
    :requires_skill("spellcraft", 4)
    :book("alchemy_basic", 3)
    :book("alchemy_master", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
)

content.add(content.Recipe {
    id = "twisted_restore_potion",
    result = "twisted_restore_potion",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :tool_any({
            { id = "rune_alchemist", count = 1 },
            { id = "rune_animist", count = 1 },
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 }
        })
    :component("potion_starter", 5)
    :component("edible_blood", 3, true)
    :component("meat_tainted", 12)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("DISTILL", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("necro_basic", 3)
    :proficiency("prof_alchemy")
    :batch_discount(60, 2)
    :result_charges(5)
)

-- third level flasks
content.add(content.Recipe {
    id = "flask_healing",
    result = "flask_healing",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 1)
    :component("horn_moss_capsule", 3)
    :component("funnelcap_chunk", 8)
    :component("wood_barnacle", 3)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_stamina",
    result = "flask_stamina",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 2)
    :component("glowing_mushroom", 2)
    :component("kampuch", 1)
    :component_any({
            { id = "horn_moss_capsule", count = 3 },
            { id = "gnome_eye", count = 1 }
        })
    :component("wood_barnacle", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_excitement",
    result = "flask_excitement",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 2)
    :component("wood_barnacle", 2)
    :component("olieribos", 2)
    :component("moonflowers", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requirement("mana_energy_weak", 2)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_regeneration",
    result = "flask_regeneration",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 3)
    :component_any({
            { id = "wood_barnacle", count = 4 },
            { id = "bracken_eye", count = 1 }
        })
    :component("horn_moss_capsule", 3)
    :component("moonflowers", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_mana_regen",
    result = "flask_mana_regen",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 2)
    :component("wood_barnacle", 4)
    :component("golden_reed_stalk", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requirement("mana_energy_weak", 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_mood",
    result = "flask_mood",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 1)
    :component("whiskflower", 4)
    :component("wood_barnacle", 3)
    :component("moonflowers", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_illegal", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_charm",
    result = "flask_charm",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 2)
    :component("moonflowers", 2)
    :component("moly_tuber", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_illegal", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_night_vision",
    result = "flask_night_vision",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 2)
    :component("moonflowers", 2)
    :component("wood_barnacle", 2)
    :component("fern_flower", 2)
    :component_any({
            { id = "glowing_mushroom", count = 5 },
            { id = "gnome_eye", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requirement("mana_energy_weak", 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_toxin",
    result = "flask_toxin",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 1)
    :component("kampuch", 3)
    :component("moonflowers", 2)
    :component("golden_reed_stalk", 2)
    :component("dragon_nail", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_illegal", 5)
    :book("necro_basic", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "flask_venom",
    result = "flask_venom",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("mortar_pestle", 3)
    :component("potion_starter_superior", 1)
    :component("kampuch", 2)
    :component("moonflowers", 2)
    :component("golden_reed_stalk", 2)
    :component("moly_tuber", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("alchemy_illegal", 5)
    :book("necro_basic", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "mana_potion_greater",
    result = "mana_potion_greater",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :tool("rune_alchemist", 1)
    :component("potion_starter_superior", 1)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :requirement("mana_energy_strong", 1)
    :requirement("mana_energy_weak", 3)
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
)

content.add(content.Recipe {
    id = "twisted_restore_potion_improved",
    result = "twisted_restore_potion_improved",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 10, true)
    :tool_any({
            { id = "rune_animist", count = 1 },
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 }
        })
    :component("potion_starter", 5)
    :component("edible_blood", 5, true)
    :component("meat_tainted", 15)
    :component("horn_moss_capsule", 5)
    :quality("CHEM", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("necro_basic", 5)
    :proficiency("prof_alchemy")
    :batch_discount(40, 2)
    :result_charges(5)
)

-- fourth level flasks
content.add(content.Recipe {
    id = "flask_speed",
    result = "flask_speed",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 3)
    :component("moonflowers", 2)
    :component("glowing_mushroom", 4)
    :component("wood_barnacle", 2)
    :component("golden_reed_stalk", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requires_skill("spellcraft", 7)
    :book("alchemy_master", 7)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "flask_teleport_rand",
    result = "flask_teleport_rand",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 3)
    :component("sojourners_flower", 2)
    :component("dragon_nail", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requirement("mana_energy_strong", 1)
    :requires_skill("spellcraft", 7)
    :book("alchemy_illegal", 6)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "flask_teleport",
    result = "flask_teleport",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 2)
    :component("sojourners_flower", 3)
    :component("dragon_nail", 2)
    :component("moonflowers", 2)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requirement("mana_energy_strong", 2)
    :requires_skill("spellcraft", 7)
    :book("alchemy_illegal", 6)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "flask_clairvoyance",
    result = "flask_clairvoyance",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 3)
    :component("sojourners_flower", 2)
    :component("dragon_nail", 2)
    :component("glowing_mushroom", 6)
    :component_any({
            { id = "moonflowers", count = 1 },
            { id = "bracken_eye", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requires_skill("spellcraft", 7)
    :book("alchemy_master", 7)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "flask_invisibility",
    result = "flask_invisibility",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 3)
    :component("glowing_mushroom", 2)
    :component("moonflowers", 2)
    :component_any({
            { id = "funnelcap_chunk", count = 15 },
            { id = "mossling_fur", count = 20 }
        })
    :component("wood_barnacle", 4)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requires_skill("spellcraft", 7)
    :book("alchemy_illegal", 6)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "flask_feather",
    result = "flask_feather",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_POTIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :tool("mortar_pestle", 4)
    :component("potion_starter_superior", 2)
    :component("glowing_mushroom", 8)
    :component("moonflowers", 2)
    :component("funnelcap_chunk", 20)
    :component("wood_barnacle", 5)
    :quality("CONTAIN", 1, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("MAGIC_CAULDRON", 1, 1)
    :requires_skill("spellcraft", 7)
    :book("alchemy_master", 7)
    :proficiency("prof_alchemy")
    :batch_discount(20, 2)
)

content.add(content.Recipe {
    id = "light_orichalcum_frame",
    result = "light_orichalcum_frame",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = false,
    skill = "mechanics",
    difficulty = 4,
}
    :component("orichalcum_frame", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("CHISEL", 2, 1)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking", { required = false, learning_time_multiplier = 0.5 })
    :proficiency("prof_welding_basic", { required = false, skill_penalty = 0.5 })
    :byproduct("orichalcum_lump", 2)
    :byproduct("orichalcum_sliver", 4)
)

content.add(content.Recipe {
    id = "parabolan_felt_patch",
    result = "parabolan_felt_patch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("soap", 5)
    :component("water_clean", 3)
    :component("crystallized_mana", 6)
    :component("parabolan_wool_staple", 1)
    :requires_skill("tailor", 1)
)

content.add(content.Recipe {
    id = "parabolan_yarn",
    result = "parabolan_yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :tool("distaff_spindle", 1)
    :component("parabolan_wool_staple", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_spinning")
    :proficiency("prof_fibers")
    :result_charges(50)
)

-- Forging and water included for glass heat-tempering process
content.add(content.Recipe {
    id = "rune_magus_weapon",
    result = "rune_magus_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("water", 1)
    :tool("metalworking_tongs", 1)
    :component("q_staff", 1)
    :component("jar_glass_sealed", 2)
    :component("rune_magus", 2)
    :component_any({
            { id = "any_tallow", count = 5, requirement = true },
            { id = "cooking_oil", count = 16 },
            { id = "lamp_oil", count = 250 }
        })
    :quality("CHISEL", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 2)
    :requires_skill("spellcraft", 2)
    :requires_skill("bashing", 2)
    :proficiency("prof_glassblowing")
)

-- This recipes uses cut to represent the carving, alchemy for the infusion of the mana and to make life
-- difficult
content.add(content.Recipe {
    id = "rune_magus_weapon_adept",
    result = "rune_magus_weapon_adept",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 3960000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("water", 1)
    :tool("metalworking_tongs", 1)
    :component("enchanted_wood", 1)
    :component("mana_pearl", 2)
    :component("leather", 4)
    :component("rune_magus", 2)
    :component_any({
            { id = "any_tallow", count = 5, requirement = true },
            { id = "cooking_oil", count = 16 },
            { id = "lamp_oil", count = 250 }
        })
    :quality("CHISEL", 2, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CUT", 1, 1)
    :requirement("forging_standard", 2)
    :requires_skill("spellcraft", 6)
    :requires_skill("bashing", 4)
    :proficiency("prof_carving")
    :proficiency("prof_alchemy", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "rune_biomancer_weapon",
    result = "rune_biomancer_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 12000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("fire", 1)
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "bone", count = 3 },
            { id = "bone_human", count = 3 },
            { id = "bone_tainted", count = 6 }
        })
    :component("rune_biomancer", 1)
    :quality("CUT", 2, 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("stabbing", 2)
)

content.add(content.Recipe {
    id = "rune_biomancer_weapon_adept",
    result = "rune_biomancer_weapon_adept",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 3960000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("fire", 1)
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :component_any({
            { id = "fat", count = 10 },
            { id = "fat_tainted", count = 1 },
            { id = "mutant_fat", count = 1 },
            { id = "fur", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "filament", count = 20, requirement = true }
        })
    :component("slime_scrap", 20)
    :component_any({
            { id = "bone", count = 3 },
            { id = "bone_human", count = 3 },
            { id = "bone_tainted", count = 6 }
        })
    :component_any({
            { id = "meat_tainted", count = 5 },
            { id = "meat_scrap", count = 15 },
            { id = "meat", count = 7 },
            { id = "mutant_meat", count = 3 },
            { id = "mutant_meat_scrap", count = 10 },
            { id = "human_flesh", count = 4 }
        })
    :component("rune_biomancer", 1)
    :quality("CUT", 2, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requires_skill("spellcraft", 6)
    :requires_skill("stabbing", 4)
    :requires_skill("rifle", 2)
    :proficiency("prof_carving")
    :proficiency("prof_alchemy", { required = false, time_multiplier = 3 })
    :proficiency("prof_gunsmithing_basic", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "rune_animist_weapon",
    result = "rune_animist_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component("rune_animist", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 2)
    :requirement("steel_chunk_any", 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("stabbing", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "rune_animist_weapon_adept",
    result = "rune_animist_weapon_adept",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("rune_animist_weapon", 1)
    :component("twisted_restore_potion", 1)
    :component("blood", 5)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("steel_chunk_any", 1)
    :requires_skill("spellcraft", 6)
    :requires_skill("stabbing", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_alchemy", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "rune_druid_weapon",
    result = "rune_druid_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("compositebow", 1)
    :component("rune_druid", 2)
    :quality("CUT", 2, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("archery", 2)
)

content.add(content.Recipe {
    id = "rune_technomancer_weapon",
    result = "rune_technomancer_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("rune_technomancer", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 14)
    :requirement("steel_standard", 3)
    :requires_skill("spellcraft", 2)
    :requires_skill("mechanics", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "rune_technomancer_weapon_adept",
    result = "rune_technomancer_weapon_adept",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 600000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("rune_technomancer_weapon", 1)
    :component("processor", 1)
    :component("RAM", 1)
    :component("scrap", 4)
    :component("cable", 4)
    :component("small_lcd_screen", 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("CUT_FINE", 2, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("spellcraft", 6)
    :requires_skill("computer", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "rune_stormshaper_weapon",
    result = "rune_stormshaper_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component_any({
            { id = "scrap_copper", count = 10 },
            { id = "copper", count = 1000 }
        })
    :component("silver_small", 100)
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 40, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :component("rune_stormshaper", 1)
    :quality("HAMMER", 2, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 5)
    :requires_skill("spellcraft", 2)
    :requires_skill("bashing", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
)

content.add(content.Recipe {
    id = "rune_stormshaper_weapon_adept",
    result = "rune_stormshaper_weapon_adept",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("rune_stormshaper_weapon", 1)
    :component_any({
            { id = "scrap_copper", count = 10 },
            { id = "copper", count = 1000 }
        })
    :component("gold_small", 100)
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 40, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :component("rune_stormshaper", 1)
    :quality("HAMMER", 2, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 5)
    :requires_skill("spellcraft", 6)
    :requires_skill("bashing", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
)

content.add(content.Recipe {
    id = "rune_earthshaper_weapon",
    result = "rune_earthshaper_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("leather", 4)
    :component("scrap", 8)
    :component("rock", 1)
    :component("rune_earthshaper", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 2)
    :requires_skill("unarmed", 2)
)

content.add(content.Recipe {
    id = "rune_kelvinist_weapon",
    result = "rune_kelvinist_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2520000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("rune_kelvinist", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requirement("forging_standard", 4)
    :requirement("steel_standard", 2)
    :requires_skill("spellcraft", 2)
    :requires_skill("cutting", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 2.5 })
)

content.add(content.Recipe {
    id = "rune_kelvinist_ice_adept_weapon",
    result = "rune_kelvinist_ice_adept_weapon",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 2520000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("rune_kelvinist", 1)
    :component("mana_pearl", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("MANA_INFUSE", 2, 1)
    :requirement("forging_standard", 4)
    :requirement("steel_standard", 2)
    :requires_skill("spellcraft", 6)
    :requires_skill("cutting", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 2.5 })
    :proficiency("prof_alchemy", { required = false, time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "animist_doll_zombie",
    result = "animist_doll_zombie",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :tool_any({
            { id = "rune_alchemist", count = 1 },
            { id = "rune_animist", count = 1 },
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 }
        })
    :component_any({
            { id = "brain", count = 1 },
            { id = "brain_cooked", count = 1 }
        })
    :component_any({
            { id = "lung", count = 2 },
            { id = "lung_cooked", count = 2 }
        })
    :component_any({
            { id = "stomach", count = 1 },
            { id = "hstomach", count = 1 }
        })
    :component_any({
            { id = "liver", count = 1 },
            { id = "liver_cooked", count = 1 }
        })
    :component_any({
            { id = "kidney", count = 2 },
            { id = "kidney_cooked", count = 2 }
        })
    :component_any({
            { id = "leather", count = 6 },
            { id = "tanned_hide", count = 1 }
        })
    :component("sinew", 60)
    :component_any({
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_tainted", count = 2 }
        })
    :component("needle_bone", 1)
    :quality("SEW", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 4)
    :book("necro_basic", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "animist_doll_skeleton",
    result = "animist_doll_skeleton",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :tool_any({
            { id = "rune_alchemist", count = 1 },
            { id = "rune_animist", count = 1 },
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 }
        })
    :component_any({
            { id = "brain", count = 1 },
            { id = "brain_cooked", count = 1 }
        })
    :component_any({
            { id = "lung", count = 2 },
            { id = "lung_cooked", count = 2 }
        })
    :component_any({
            { id = "stomach", count = 1 },
            { id = "hstomach", count = 1 }
        })
    :component_any({
            { id = "liver", count = 1 },
            { id = "liver_cooked", count = 1 }
        })
    :component_any({
            { id = "kidney", count = 2 },
            { id = "kidney_cooked", count = 2 }
        })
    :component_any({
            { id = "leather", count = 6 },
            { id = "tanned_hide", count = 1 }
        })
    :component("sinew", 60)
    :component_any({
            { id = "bone", count = 4 },
            { id = "bone_human", count = 4 },
            { id = "bone_tainted", count = 8 }
        })
    :component("needle_bone", 1)
    :quality("SEW", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 5)
    :book("necro_basic", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "animist_doll_decayed_pouncer",
    result = "animist_doll_decayed_pouncer",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 1260000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 7,
}
    :tool_any({
            { id = "rune_animist", count = 1 },
            { id = "rune_animist_weapon", count = 1 },
            { id = "rune_animist_weapon_adept", count = 1 }
        })
    :component_any({
            { id = "brain", count = 1 },
            { id = "brain_cooked", count = 1 }
        })
    :component_any({
            { id = "lung", count = 2 },
            { id = "lung_cooked", count = 2 }
        })
    :component_any({
            { id = "stomach", count = 1 },
            { id = "hstomach", count = 1 }
        })
    :component_any({
            { id = "liver", count = 1 },
            { id = "liver_cooked", count = 1 }
        })
    :component_any({
            { id = "kidney", count = 2 },
            { id = "kidney_cooked", count = 2 }
        })
    :component_any({
            { id = "fur", count = 6 },
            { id = "tanned_pelt", count = 1 }
        })
    :component("hairball", 2)
    :component("sinew", 60)
    :component_any({
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_tainted", count = 2 }
        })
    :component("needle_bone", 1)
    :quality("SEW", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 7)
    :book("necro_basic", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "flaming_fist",
    result = "flaming_fist",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 1620000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 6,
}
    :component("leather", 4)
    :component("rune_kelvinist", 6)
    :component("scrap", 8)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 6)
    :requires_skill("unarmed", 3)
    :book("book_mythological", 6)
)

content.add(content.Recipe {
    id = "gauntlet_pounding",
    result = "gauntlet_pounding",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 1620000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "spellcraft",
    difficulty = 6,
}
    :component("leather", 8)
    :component("rune_earthshaper", 12)
    :component("scrap", 16)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 6)
    :requires_skill("unarmed", 3)
    :book("book_mythological", 6)
)

content.add(content.Recipe {
    id = "arrow_odin",
    result = "arrow_odin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("metalworking_tongs", 1)
    :component("orichalcum_ingot", 1)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 10, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requirement("forging_standard", 1)
    :requires_skill("archery", 4)
    :requires_skill("spellcraft", 5)
    :book("book_mythological", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_fletching", { required = false, time_multiplier = 2 })
    :proficiency("prof_almetallurgy")
    :result_charges(4)
)

content.add(content.Recipe {
    id = "magi_staff_minor",
    result = "magi_staff_minor",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick_long", 1)
    :component("small_mana_crystal", 1)
    :component("leather", 2)
    :component("mana_dust", 10)
    :quality("CUT", 2, 1)
    :requires_skill("spellcraft", 2)
    :proficiency("prof_carving")
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "magi_staff_lesser",
    result = "magi_staff_lesser",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("rune_alchemist", 1)
    :component("enchanted_wood", 1)
    :component("mana_pearl", 1)
    :component("leather", 2)
    :component("mana_dust", 10)
    :quality("CUT", 2, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 6)
    :book("enchantment_basic", 2)
    :proficiency("prof_carving")
    :proficiency("prof_alchemy")
)

content.add(content.Recipe {
    id = "magi_staff_greater",
    result = "magi_staff_greater",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_WEAPONS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "rune_alchemist", count = 1 },
            { id = "metalworking_tongs", count = 1 }
        })
    :tool("swage", 1)
    :component("enchanted_wood", 1)
    :component("bulette_pearl", 1)
    :component("mithril_ingot", 1)
    :component("mana_dust", 10)
    :quality("CUT", 2, 1)
    :quality("MANA_INFUSE", 2, 1)
    :quality("MANA_FOCUS", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 2)
    :requires_skill("spellcraft", 8)
    :book("enchantment_basic", 5)
    :proficiency("prof_carving")
    :proficiency("prof_alchemy")
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "arrow_druid_crafted",
    result = "arrow_druid_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_druid", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_stormshaper_crafted",
    result = "arrow_stormshaper_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_stormshaper", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_earthshaper_crafted",
    result = "arrow_earthshaper_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "stick_long", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_earthshaper", 1)
    :component_any({
            { id = "rock", count = 1 },
            { id = "scrap", count = 1 }
        })
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_kelvinist_crafted",
    result = "arrow_kelvinist_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_kelvinist", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_biomancer_crafted",
    result = "arrow_biomancer_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_biomancer", 1)
    :component_any({
            { id = "bone", count = 1 },
            { id = "bone_human", count = 1 },
            { id = "bone_tainted", count = 1 }
        })
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_technomancer_crafted",
    result = "arrow_technomancer_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_technomancer", 1)
    :component("e_scrap", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_magus_crafted",
    result = "arrow_magus_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_magus", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "arrow_animist_crafted",
    result = "arrow_animist_crafted",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
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
            { id = "mop", count = 1 }
        })
    :component("fletching", 1, true)
    :component("rune_animist", 1)
    :quality("CUT", 1, 1)
    :quality("MANA_INFUSE", 1, 1)
    :requires_skill("spellcraft", 3)
    :requires_skill("archery", 1)
    :book("arcane_archer_companion", 3)
    :proficiency("prof_carving")
    :proficiency("prof_fletching", { required = false, time_multiplier = 1.8 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "glow_light",
    result = "glow_light",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "spellcraft",
    difficulty = 3,
}
    :component("mana_potion_lesser", 1)
    :component_any({
            { id = "flask_glass", count = 1 },
            { id = "beaker", count = 1 }
        })
    :component("glow_dust", 2)
    :component_any({
            { id = "diamond", count = 1 },
            { id = "bulette_pearl", count = 1 }
        })
    :component("string_6", 1)
    :component("cotton_patchwork", 2)
)
