local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "lc_cavalry_sabre",
    result = "lc_cavalry_sabre",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "dao",
    result = "dao",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("casting_mold_long", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 5)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "makeshift_machete",
    result = "makeshift_machete",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("duct_tape", 50)
    :component("blade", 1)
)

content.add(content.Recipe {
    id = "sword_xiphos",
    result = "sword_xiphos",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 4)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :book("textbook_weapwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "khopesh",
    result = "khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 5)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_bladesmith", { required = true })
)

content.add(content.Recipe {
    id = "lc_khopesh",
    result = "lc_khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("bronze_book", 6)
    :book("bronze_mag", 6)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith", { required = true })
)

content.add(content.Recipe {
    id = "mc_khopesh",
    result = "mc_khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("bronze_book", 7)
    :book("bronze_mag", 7)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith", { required = true })
)

content.add(content.Recipe {
    id = "hc_khopesh",
    result = "hc_khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("bronze_book", 7)
    :book("bronze_mag", 7)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith", { required = true })
)

content.add(content.Recipe {
    id = "ch_khopesh",
    result = "ch_khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 5760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("bronze_book", 8)
    :book("bronze_mag", 8)
    :book("textbook_weapwest", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith", { required = true })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_khopesh",
    result = "qt_khopesh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 7560000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("bronze_book", 9)
    :book("bronze_mag", 9)
    :book("textbook_weapwest", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith", { required = true })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "sword_bronze",
    result = "sword_bronze",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 4)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "poleaxe",
    result = "poleaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("spear_shaft", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

-- this makes the simple makeshift glaive, but changing the id would break e.g.  tilesets.
content.add(content.Recipe {
    id = "makeshift_halberd",
    result = "makeshift_halberd",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("duct_tape", 100)
    :component_any({
            { id = "blade", count = 1 },
            { id = "knife_cleaver", count = 1 }
        })
    :component("stick_long", 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "makeshift_glaive",
    result = "makeshift_glaive",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("duct_tape", 100)
    :component_any({
            { id = "blade", count = 1 },
            { id = "knife_cleaver", count = 1 }
        })
    :component("stick_long", 1)
    :component("cordage", 2, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "makeshift_scythe_war",
    result = "makeshift_scythe_war",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("duct_tape", 50)
    :component("blade_scythe", 1)
    :component("stick_long", 1)
    :quality("HAMMER", 1, 1)
    :learn_by_disassembly("fabrication", 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "scythe_war_forge",
    result = "scythe_war",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component("stick_long", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :requirement("metal_punch", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "knuckle_katar",
    result = "knuckle_katar",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 8 }
        })
    :component("rebar", 5)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("bashing", 1)
    :book("recipe_melee", 3)
    :book("textbook_weapeast", 8)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "lc_kukri",
    result = "lc_kukri",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :book("manual_knives", 7)
    :book("textbook_weapeast", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
    :proficiency("prof_bladesmith")
)

-- basically 2.5x the resources of a single machete to cover the fact that it's two weapons, each with a hand
-- guard
content.add(content.Recipe {
    id = "butterfly_swords",
    result = "butterfly_swords",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 2)
    :book("textbook_weapeast", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "glass_shiv",
    result = "glass_shiv",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("glass_shard", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "duct_tape", count = 10 }
        })
)

content.add(content.Recipe {
    id = "sword_crude",
    result = "sword_crude",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sword_wood", 1)
    :component("scrap", 4)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "sword_crude_large",
    result = "sword_crude_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sword_wood_large", 1)
    :component("scrap", 8)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "cutlass",
    result = "cutlass",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "lc_cutlass",
    result = "lc_cutlass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_cutlass",
    result = "mc_cutlass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_cutlass",
    result = "hc_cutlass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_arming_sword",
    result = "lc_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_arming_sword",
    result = "mc_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "hc_arming_sword",
    result = "hc_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "lc_broadsword",
    result = "lc_broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "broadsword",
    result = "broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_broadsword",
    result = "hc_broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "sword_sheets_welded_sword_sheets_bolted",
    result = "sword_sheets_welded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "sword_sheets_bolted",
}
    :tool_charges("angle_grinder", 50)
    :component("sheet_metal", 1)
    :component("nuts_bolts", 4)
    :component("duct_tape", 25)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :byproduct("sheet_metal_small", 12)
)

-- 40cm weld
content.add(content.Recipe {
    id = "sword_sheets_welded_sword_sheets_welded",
    result = "sword_sheets_welded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "sword_sheets_welded",
}
    :tool_charges("angle_grinder", 50)
    :component("sheet_metal", 1)
    :component("duct_tape", 25)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 40)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :byproduct("sheet_metal_small", 12)
)

content.add(content.Recipe {
    id = "sword_sheets_welded_large_sword_sheets_bolted_large",
    result = "sword_sheets_welded_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "sword_sheets_bolted_large",
}
    :tool_charges("angle_grinder", 50)
    :component("sheet_metal", 1)
    :component("nuts_bolts", 4)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_carving", { time_multiplier = 1.2, skill_penalty = 0 })
    :byproduct("sheet_metal_small", 6)
)

-- 60cm weld
content.add(content.Recipe {
    id = "sword_sheets_welded_large_sword_sheets_welded_large",
    result = "sword_sheets_welded_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "sword_sheets_welded_large",
}
    :tool_charges("angle_grinder", 50)
    :component("sheet_metal", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 60)
    :proficiency("prof_metalworking")
    :proficiency("prof_carving", { time_multiplier = 1.2, skill_penalty = 0 })
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :byproduct("sheet_metal_small", 6)
)

content.add(content.Recipe {
    id = "sword_metal",
    result = "sword_metal",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sword_metal_large",
    result = "sword_metal_large",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "battleaxe",
    result = "battleaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 8)
    :book("recipe_melee", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "lc_battleaxe",
    result = "lc_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 7)
    :book("recipe_melee", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mc_battleaxe",
    result = "mc_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 8)
    :book("recipe_melee", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hc_battleaxe",
    result = "hc_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 8)
    :book("recipe_melee", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "ch_battleaxe",
    result = "ch_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 9)
    :book("recipe_melee", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_battleaxe",
    result = "qt_battleaxe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 1, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 10)
    :book("recipe_melee", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_jian",
    result = "lc_jian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_armschina", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_jian",
    result = "mc_jian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armschina", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_jian",
    result = "hc_jian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_armschina", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_jian",
    result = "ch_jian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armschina", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_jian",
    result = "qt_jian",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armschina", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_scimitar",
    result = "lc_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_estoc",
    result = "lc_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2580000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_estoc",
    result = "mc_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2940000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_estoc",
    result = "hc_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2940000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_longsword",
    result = "lc_longsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_longsword",
    result = "mc_longsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_longsword",
    result = "hc_longsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_kriegsmesser",
    result = "lc_kriegsmesser",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weapwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_kriegsmesser",
    result = "mc_kriegsmesser",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_kriegsmesser",
    result = "hc_kriegsmesser",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_kriegsmesser",
    result = "ch_kriegsmesser",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_kriegsmesser",
    result = "qt_kriegsmesser",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7560000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_falx",
    result = "lc_falx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_weapwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_falx",
    result = "mc_falx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_falx",
    result = "hc_falx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_falx",
    result = "ch_falx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_falx",
    result = "qt_falx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8280000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_zweihander",
    result = "lc_zweihander",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_weapwest", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_zweihander",
    result = "mc_zweihander",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_zweihander",
    result = "hc_zweihander",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weapwest", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_zweihander",
    result = "ch_zweihander",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_zweihander",
    result = "qt_zweihander",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weapwest", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_wakizashi",
    result = "lc_wakizashi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weapeast", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_wakizashi",
    result = "mc_wakizashi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weapeast", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_wakizashi",
    result = "hc_wakizashi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weapeast", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_katana",
    result = "lc_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weapeast", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_katana",
    result = "mc_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weapeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_katana",
    result = "hc_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_weapeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_nodachi",
    result = "lc_nodachi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :book("textbook_weapeast", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_nodachi",
    result = "mc_nodachi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_weapeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_nodachi",
    result = "hc_nodachi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :book("textbook_weapeast", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_nodachi",
    result = "ch_nodachi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_weapeast", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "bagh_nakha",
    result = "bagh_nakha",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_weapeast", 9)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lajatang",
    result = "lajatang",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component("q_staff", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_weapeast", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "bill_hook",
    result = "bill_hook",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("stick_long", 1)
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
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "naginata",
    result = "naginata",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2400000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("spear_shaft", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_weapeast", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "naginata_reforged",
    result = "naginata",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "katana", count = 1 },
            { id = "wakizashi", count = 1 }
        })
    :component("spear_shaft", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 5)
    :book("textbook_weapeast", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "survivor_machete_qt",
    result = "survivor_machete_qt",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 3168000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 80 },
            { id = "water_clean", count = 80 }
        })
    :component("machete", 1)
    :component("filament_durable", 20, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "chunk_rubber", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("blacksmithing_standard", 10)
    :requirement("glue_strong", 5)
    :requires_skill("melee", 5)
    :book("textbook_weapwest", 5)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "ax_sheets_bolted",
    result = "ax_sheets_bolted",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("angle_grinder", 50)
    :component("pipe", 2)
    :component("pipe_fittings", 1)
    :component("sheet_metal", 1)
    :component("nuts_bolts", 4)
    :component("duct_tape", 50)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :byproduct("sheet_metal_small", 6)
)

-- 30cm weld
content.add(content.Recipe {
    id = "ax_sheets_welded",
    result = "ax_sheets_welded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("angle_grinder", 50)
    :component("pipe", 2)
    :component("pipe_fittings", 1)
    :component("sheet_metal", 1)
    :component("duct_tape", 50)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 30)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :byproduct("sheet_metal_small", 6)
)

content.add(content.Recipe {
    id = "lc_talwar",
    result = "lc_talwar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_weparabic", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_talwar",
    result = "mc_talwar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_talwar",
    result = "hc_talwar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_talwar",
    result = "ch_talwar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_talwar",
    result = "qt_talwar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8280000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_kilij",
    result = "lc_kilij",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :book("textbook_weparabic", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "mc_kilij",
    result = "mc_kilij",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "mc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_weparabic", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_kilij",
    result = "hc_kilij",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "leather", count = 2 },
            { id = "hc_wire", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :book("textbook_weparabic", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "ch_kilij",
    result = "ch_kilij",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_weparabic", 9)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_kilij",
    result = "qt_kilij",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :quality("TEMPER", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_weparabic", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "halberd_crude",
    result = "halberd_crude",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "fire_ax", count = 1 },
            { id = "ax", count = 1 }
        })
    :component("nails", 3, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 2, 1)
    :requirement("glue_strong", 10)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "naginata_machete",
    result = "naginata_machete",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("spear_shaft", 1)
    :component("machete", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("DRILL", 2, 1)
    :requirement("glue_strong", 10)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "naginata_machete_temp",
    result = "naginata_machete_temp",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("spear_shaft", 1)
    :component("survivor_machete_qt", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("DRILL", 2, 1)
    :requirement("glue_strong", 10)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)
