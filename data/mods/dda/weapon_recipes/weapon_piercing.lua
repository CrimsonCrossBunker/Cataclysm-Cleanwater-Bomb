local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "fencing_epee_sharpened_from_scratch",
    result = "fencing_epee_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2160000,
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
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "karambit",
    result = "karambit",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :book("textbook_weapeast", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "fencing_foil_sharpened_from_scratch",
    result = "fencing_foil_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2160000,
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
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "fencing_sabre_sharpened_from_scratch",
    result = "fencing_sabre_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2160000,
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
    :component("sheet_metal_small", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :book("textbook_weapwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sword_metal_fencing",
    result = "sword_metal_fencing",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1440000,
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
    id = "kirpan",
    result = "kirpan",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :book("textbook_weapeast", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "pitchfork",
    result = "pitchfork",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component("stick_long", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "spear_stone",
    result = "spear_stone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 6,
}
    :component("spear_shaft", 1)
    :component("rock_flaking_any", 1, true)
    :component("cordage_short", 1, true)
    :quality("PUNCH", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
    :proficiency("prof_carving", { skill_penalty = 0.15 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "spear_stone_simple",
    result = "spear_stone_simple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 6,
}
    :component("stick_long", 1)
    :component("rock_flaking_any", 1, true)
    :component("cordage_short", 1, true)
    :quality("PUNCH", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_knapping")
    :proficiency("prof_knapping_speed")
    :proficiency("prof_carving", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "sharpened_pipe",
    result = "sharpened_pipe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "BLIND_EASY" },
}
    :component("pipe", 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("melee", 1)
)

content.add(content.Recipe {
    id = "simple_spear_pipe",
    result = "simple_spear_pipe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 3)
    :component("pipe_fittings", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("melee", 1)
)

-- 20cm weld
content.add(content.Recipe {
    id = "spear_pipe",
    result = "spear_pipe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("simple_spear_pipe", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 20)
    :requirement("steel_chunk_any", 1)
    :requirement("cordage_superior", 2)
    :requires_skill("melee", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "simple_pike_pipe",
    result = "simple_pike_pipe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 5)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requires_skill("melee", 1)
)

-- 60cm weld
content.add(content.Recipe {
    id = "pike_pipe",
    result = "pike_pipe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 5)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 60)
    :requirement("steel_chunk_any", 1)
    :requirement("cordage_superior", 2)
    :requires_skill("melee", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

-- 10cm weld
content.add(content.Recipe {
    id = "grip_hook",
    result = "grip_hook",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("spike", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 10)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "ji",
    result = "ji",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 4)
    :component("spear_shaft", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "felt_patch", count = 2 },
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_dory",
    result = "spear_dory",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 2)
    :component("long_pole", 1)
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 3)
    :book("bronze_mag", 4)
    :book("textbook_weapwest", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_bronze",
    result = "spear_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 2)
    :component("spear_shaft", 1)
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 3)
    :book("bronze_mag", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "knife_rambo",
    result = "knife_rambo",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_knife_rambo",
    result = "lc_knife_rambo",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "hc_knife_rambo",
    result = "hc_knife_rambo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "qiang",
    result = "qiang",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("filament", 100, true)
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_armschina", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "copper_knife",
    result = "copper_knife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("copper_scrap_equivalent", 1, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "makeshift_knife",
    result = "makeshift_knife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("spike", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "knife_baselard",
    result = "knife_baselard",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "pointy_stick",
    result = "pointy_stick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4800,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "broom", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "pointy_stick_long",
    result = "pointy_stick_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("stick_long", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "pointed_rebar",
    result = "pointed_rebar",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("rebar", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "sharp_rebar",
    result = "sharp_rebar",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rebar", 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("FILE", 1, 1)
)

-- 5cm weld
content.add(content.Recipe {
    id = "spear_rebar",
    result = "spear_rebar",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("rebar", 1)
    :component("sharp_rebar", 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "pike_wood",
    result = "pike_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("fire", 1)
    :component("long_pole", 1)
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
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "pike_copper",
    result = "pike_copper",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("long_pole", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "cordage_short", count = 1, requirement = true },
            { id = "filament", count = 50, requirement = true }
        })
    :component("copper_scrap_equivalent", 2, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_wood",
    result = "spear_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("fire", 1)
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "pointy_stick_long", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_wood_simple",
    result = "spear_wood_simple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "pointy_stick_long", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_shaft_sharpened",
    result = "spear_shaft_sharpened",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("spear_shaft", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_copper",
    result = "spear_copper",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("spear_shaft", 1)
    :component("copper_scrap_equivalent", 2, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "spear_homemade_halfpike_from_spike",
    result = "spear_homemade_halfpike",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("stick_long", 1)
    :component("spike", 1)
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 75 }
        })
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requires_skill("stabbing", 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "spear_homemade_halfpike_from_knife",
    result = "spear_homemade_halfpike",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick_long", 1)
    :component_any({
            { id = "spike", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_folding", count = 1 },
            { id = "scalpel", count = 1 },
            { id = "xacto", count = 1 }
        })
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
)

content.add(content.Recipe {
    id = "javelin",
    result = "javelin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("fire", 1)
    :component_any({
            { id = "spear_wood", count = 1 },
            { id = "spear_wood_simple", count = 1 },
            { id = "pointy_stick_long", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("throw", 2)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "javelin_iron",
    result = "javelin_iron",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("javelin", 1)
    :component("scrap", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requires_skill("throw", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "spear_spike",
    result = "spear_spike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("stick_long", 1)
    :component_any({
            { id = "spike", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_folding", count = 1 },
            { id = "scalpel", count = 1 },
            { id = "xacto", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "spear_steel_crude",
    result = "spear_steel_crude",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "spike", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_folding", count = 1 },
            { id = "scalpel", count = 1 },
            { id = "xacto", count = 1 }
        })
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "spear_knife",
    result = "spear_knife",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "long_pole", count = 1 }
        })
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_KABAR", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_hunting", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "knife_rm42", count = 1 },
            { id = "knife_trench", count = 1 },
            { id = "tanto", count = 1 },
            { id = "kirpan", count = 1 }
        })
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "spear_knife_superior",
    result = "spear_knife_superior",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "long_pole", count = 1 }
        })
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_KABAR", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_hunting", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "knife_rm42", count = 1 },
            { id = "knife_trench", count = 1 },
            { id = "tanto", count = 1 },
            { id = "kirpan", count = 1 }
        })
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "spear_knife_superior_from simple version",
    result = "spear_knife_superior",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("spear_knife", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "spear_knife_proper",
    result = "spear_knife_proper",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_large", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_KABAR", count = 1 },
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "knife_hunting", count = 1 },
            { id = "knife_rambo", count = 1 },
            { id = "knife_rm42", count = 1 },
            { id = "knife_trench", count = 1 },
            { id = "tanto", count = 1 },
            { id = "kirpan", count = 1 }
        })
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "nuts_bolts", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "knife_combat",
    result = "knife_combat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("manual_knives", 4)
    :book("recipe_melee", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lc_knife_trench",
    result = "lc_knife_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1980000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("manual_knives", 3)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "switchblade",
    result = "switchblade",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component("plastic_chunk", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("manual_knives", 5)
    :book("recipe_melee", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_plasticworking", { time_multiplier = 1.1, learning_time_multiplier = 0.1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "punch_dagger",
    result = "punch_dagger",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("manual_knives", 3)
    :book("recipe_melee", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "bone_knife",
    result = "bone_knife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("bone_sturdy", 1, true)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "sharp_toothbrush",
    result = "sharp_toothbrush",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "toothbrush_plain", count = 1 },
            { id = "hairbrush", count = 1 },
            { id = "comb_pocket", count = 1 },
            { id = "plastic_chunk", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("GRIND", 1, 1)
)

content.add(content.Recipe {
    id = "fencing_foil_sharpened",
    result = "fencing_foil_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "sharp_rock", count = 1 }
        })
    :component("fencing_foil", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "fencing_epee_sharpened",
    result = "fencing_epee_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "sharp_rock", count = 1 }
        })
    :component("fencing_epee", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "fencing_sabre_sharpened",
    result = "fencing_sabre_sharpened",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "rock", count = 1 },
            { id = "ceramic_shard", count = 1 },
            { id = "sharp_rock", count = 1 }
        })
    :component("fencing_sabre", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "shock_foil",
    result = "shock_foil",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fencing_foil_sharpened", 1)
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :component("tazer", 1)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("adhesive", 1)
    :requires_skill("electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_melee", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "shock_epee",
    result = "shock_epee",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fencing_epee_sharpened", 1)
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :component("tazer", 1)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("adhesive", 1)
    :requires_skill("electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_melee", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "shock_sabre",
    result = "shock_sabre",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fencing_sabre_sharpened", 1)
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :component("tazer", 1)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("adhesive", 1)
    :requires_skill("electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_melee", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "knuckle_skewer",
    result = "knuckle_skewer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_knuckle_skewer",
    result = "xl_knuckle_skewer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_knuckle_skewer",
    result = "xs_knuckle_skewer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "sword_bayonet",
    result = "sword_bayonet",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :component("plastic_chunk", 4)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :requires_skill("gun", 1)
    :book("welding_book", 7)
    :book("recipe_melee", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_plasticworking", { time_multiplier = 1.1, learning_time_multiplier = 0.1, skill_penalty = 0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "crude_goedendag",
    result = "crude_goedendag",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("q_staff", 1)
    :component("pipe_fittings", 1)
    :component("spike", 1)
    :component("nuts_bolts", 2)
    :quality("HAMMER", 3, 1)
    :quality("CUT", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("DRILL", 3, 1)
    :proficiency("prof_carpentry_basic", { skill_penalty = 0 })
)
