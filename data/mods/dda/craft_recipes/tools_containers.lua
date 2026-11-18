local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
content.add(content.Recipe {
    id = "waterskin",
    result = "waterskin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "leather", count = 6 },
            { id = "tanned_hide", count = 1 },
            { id = "fur", count = 6 },
            { id = "tanned_pelt", count = 1 }
        })
    :component("filament", 10, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "waterskin2",
    result = "waterskin2",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "leather", count = 14 },
            { id = "tanned_hide", count = 2 },
            { id = "fur", count = 14 },
            { id = "tanned_pelt", count = 2 }
        })
    :component("filament", 20, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "waterskin3",
    result = "waterskin3",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "leather", count = 24 },
            { id = "tanned_hide", count = 4 },
            { id = "fur", count = 24 },
            { id = "tanned_pelt", count = 4 }
        })
    :component("filament", 30, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2 })
)

-- 150cm weld
content.add(content.Recipe {
    id = "metal_tank",
    result = "metal_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal", 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 150)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

-- 30cm weld
content.add(content.Recipe {
    id = "metal_tank_little",
    result = "metal_tank_little",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal_small", 4)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 30)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "jerrycan",
    result = "jerrycan",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("duct_tape", 50)
    :component("jug_plastic", 4)
    :quality("CUT", 2, 1)
    :requirement("cordage", 1)
)

-- 60cm weld
content.add(content.Recipe {
    id = "jerrycan_big_welder",
    result = "jerrycan_big",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal", 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 60)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "flask_hip",
    result = "flask_hip",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("swage", 1)
    :component("scrap", 2)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_scrap", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "bowl_plastic",
    result = "bowl_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("plastic_chunk", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "bottle_plastic",
    result = "bottle_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 1)
    :requirement("plastic_molding", 1)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "bottle_bathroom",
    result = "bottle_bathroom",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 2)
    :requirement("plastic_molding", 1)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "bottle_plastic_small",
    result = "bottle_plastic_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 1)
    :requirement("plastic_molding", 1)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "bottle_twoliter",
    result = "bottle_twoliter",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 3)
    :requirement("plastic_molding", 2)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "canister_empty",
    result = "canister_empty",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "can_medium",
    result = "can_medium",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "can_food",
    result = "can_food",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "can_food_big",
    result = "can_food_big",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("sheet_metal_small", 3)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "wooden_barrel",
    result = "wooden_barrel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 30)
    :component("scrap", 6)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "55gal_drum_from_scratch",
    result = "55gal_drum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("steel_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "30gal_drum_from_scratch",
    result = "30gal_drum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1560000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "metal_tank_from_scratch",
    result = "metal_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 960000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- 270cm weld
content.add(content.Recipe {
    id = "55gal_drum_welded",
    result = "55gal_drum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "sheet_metal", count = 4 },
            { id = "sheet_metal_small", count = 80 }
        })
    :requirement("welding_standard", 270)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 180cm weld
content.add(content.Recipe {
    id = "30gal_drum_welded",
    result = "30gal_drum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "sheet_metal", count = 2 },
            { id = "sheet_metal_small", count = 32 }
        })
    :requirement("welding_standard", 180)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "30gal_barrel",
    result = "30gal_barrel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("plastic_chunk", 77)
    :requirement("plastic_molding", 98)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "jar_3l_glass_sealed",
    result = "jar_3l_glass_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 150)
    :component_any({
            { id = "glass_shard", count = 13 },
            { id = "flask_glass", count = 20 },
            { id = "test_tube", count = 27 },
            { id = "marble", count = 318 }
        })
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "jar_3l_glass_sealed_glassblowers_crucible",
    result = "jar_3l_glass_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_charges("glassblowers_crucible_tool", 4800)
    :tool_charges("forge", 150)
    :tool("casting_mold_small", 1)
    :component_any({
            { id = "glass_shard", count = 13 },
            { id = "flask_glass", count = 20 },
            { id = "test_tube", count = 27 },
            { id = "marble", count = 318 }
        })
    :component("scrap", 1)
    :component("chunk_rubber", 1)
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
    :batch_discount(80, 1)
)

content.add(content.Recipe {
    id = "bottle_glass",
    result = "bottle_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 7 },
            { id = "pipe_glass", count = 4 },
            { id = "flask_glass", count = 11 },
            { id = "test_tube", count = 47 },
            { id = "marble", count = 171 }
        })
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "jar_glass_sealed",
    result = "jar_glass_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 50)
    :component_any({
            { id = "glass_shard", count = 4 },
            { id = "flask_glass", count = 6 },
            { id = "test_tube", count = 8 },
            { id = "marble", count = 93 }
        })
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 4)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "flask_glass",
    result = "flask_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 25)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "test_tube", count = 2 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 4)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "test_tube",
    result = "test_tube",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 24000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 2,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 5)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 2, 1)
    :book("glassblowing_book", 4)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "wrapper",
    result = "wrapper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("paper", 2)
)

content.add(content.Recipe {
    id = "wrapper_foil",
    result = "wrapper_foil",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("aluminum_foil", 6)
)

content.add(content.Recipe {
    id = "cup_foil",
    result = "cup_foil",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("aluminum_foil", 6)
    :book("mag_dude", 0)
    :book("mag_survival", 0)
    :book("pocket_survival", 0)
)

content.add(content.Recipe {
    id = "bag_canvas_small",
    result = "bag_canvas_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_canvas_patchwork", 1)
    :requirement("cordage_short", 1)
    :byproduct("canvas_patch", 3)
    :byproduct("scrap_canvas", 6)
)

content.add(content.Recipe {
    id = "bag_canvas",
    result = "bag_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("cordage", 1)
    :byproduct("scrap_canvas", 8)
)

content.add(content.Recipe {
    id = "bag_garbage_reinforced",
    result = "bag_garbage_reinforced",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component("bag_garbage", 10)
)

content.add(content.Recipe {
    id = "storage_line",
    result = "storage_line",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("scrap", 4)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_nylon_patchwork", 2)
    :proficiency("prof_closures")
)

-- 50cm weld
content.add(content.Recipe {
    id = "toolbox_empty",
    result = "toolbox_empty",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal_small", 16)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 50)
    :requires_skill("fabrication", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "vacutainer",
    result = "vacutainer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 18000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 4,
}
    :component("syringe", 1)
    :component_any({
            { id = "flask_glass", count = 1 },
            { id = "bottle_plastic_small", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 2)
)

-- 30cm weld
content.add(content.Recipe {
    id = "bucket",
    result = "bucket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("sheet_metal_small", 4)
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "scrap", count = 9 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 30)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "bucket_wood",
    result = "bucket_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component("log", 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "jug_plastic_with_plastic_molding",
    result = "jug_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 3)
    :requirement("plastic_molding", 2)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "clay_pot",
    result = "clay_pot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 5)
    :requirement("earthenware_firing", 90)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "clay_pot_flower",
    result = "clay_pot_flower",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 4)
    :requirement("earthenware_firing", 75)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "clay_teapot",
    result = "clay_teapot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 3)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 40)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "clay_urn",
    result = "clay_urn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 8)
    :requirement("earthenware_firing", 120)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "canteen",
    result = "canteen",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 3)
    :component_any({
            { id = "cotton_patchwork", count = 3 },
            { id = "leather", count = 3 },
            { id = "fur", count = 3 }
        })
    :requirement("sewing_standard", 4)
    :requirement("plastic_molding", 2)
    :book("plastics_book", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "2lcanteen",
    result = "2lcanteen",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 3)
    :component_any({
            { id = "cotton_patchwork", count = 3 },
            { id = "leather", count = 3 },
            { id = "fur", count = 3 }
        })
    :requirement("sewing_standard", 4)
    :requirement("plastic_molding", 2)
    :book("plastics_book", 3)
    :proficiency("prof_plasticworking")
)

-- 100cm weld
content.add(content.Recipe {
    id = "pot_canning",
    result = "pot_canning",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 100)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "pot_canning_clay",
    result = "pot_canning_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 2, true)
    :component("clay_lump", 15)
    :requirement("earthenware_firing", 140)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
)

content.add(content.Recipe {
    id = "bowl_clay",
    result = "bowl_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 4)
    :component_any({
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :requirement("cordage_short", 1)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 40)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "bowl_wood",
    result = "bowl_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bowl_wood_large",
    result = "bowl_wood_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bowl_skull",
    result = "bowl_skull",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "skull_human", count = 1 },
            { id = "skull_human_tainted", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "clay_canister",
    result = "clay_canister",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 2)
    :component_any({
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :requirement("cordage_short", 1)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 60)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "clay_hydria",
    result = "clay_hydria",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 2, true)
    :component("clay_lump", 10)
    :component_any({
            { id = "leather", count = 3 },
            { id = "fur", count = 3 }
        })
    :requirement("cordage_short", 2)
    :requirement("glazing", 2)
    :requirement("earthenware_firing", 120)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "clay_watercont",
    result = "clay_watercont",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 3, true)
    :component("clay_lump", 20)
    :component_any({
            { id = "leather", count = 3 },
            { id = "fur", count = 3 }
        })
    :requirement("cordage_short", 2)
    :requirement("glazing", 3)
    :requirement("earthenware_firing", 160)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "clay_watercont_no_lid",
    result = "clay_watercont_no_lid",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 462000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 3, true)
    :component("clay_lump", 20)
    :requirement("glazing", 3)
    :requirement("earthenware_firing", 160)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "jug_clay",
    result = "jug_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_lump", 6)
    :component_any({
            { id = "leather", count = 3 },
            { id = "fur", count = 3 }
        })
    :requirement("cordage_short", 2)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 50)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "keg_steel",
    result = "keg_steel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 984000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 52)
    :requirement("steel_standard", 13)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "stomach_sealed",
    result = "stomach_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 3, true)
    :component_any({
            { id = "water", count = 5 },
            { id = "water_clean", count = 5 }
        })
    :component("meat_stomach_small", 1, true)
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :quality("CUT", 2, 1)
    :quality("BOIL", 1, 1)
    :requirement("waterproofing", 1)
)

content.add(content.Recipe {
    id = "large_stomach_sealed",
    result = "large_stomach_sealed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 4, true)
    :component_any({
            { id = "water", count = 8 },
            { id = "water_clean", count = 8 }
        })
    :component("meat_stomach_large", 1, true)
    :component_any({
            { id = "cordage_short", count = 3, requirement = true },
            { id = "filament", count = 150, requirement = true }
        })
    :quality("CUT", 2, 1)
    :quality("BOIL", 1, 1)
    :requirement("waterproofing", 2)
)

content.add(content.Recipe {
    id = "canteen_wood",
    result = "canteen_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("2x4", 2)
    :component_any({
            { id = "any_wire", count = 1, requirement = true },
            { id = "scrap", count = 2 },
            { id = "copper_scrap_equivalent", count = 1, requirement = true }
        })
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "felt_patch", count = 2 },
            { id = "leather", count = 2 },
            { id = "fur", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("SAW_W", 2, 1)
    :requirement("adhesive", 1)
    :requirement("wood_sealant_nontoxic_small", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bottle_metal",
    result = "bottle_metal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "box_small_crafted",
    result = "box_small",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("cardboard", 5)
    :component("duct_tape", 25)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_small_assembly",
    result = "box_small",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("box_small_folded", 1)
    :component("duct_tape", 5)
)

content.add(content.Recipe {
    id = "box_medium_crafted",
    result = "box_medium",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("cardboard", 40)
    :component("duct_tape", 50)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_medium_assembly",
    result = "box_medium",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("box_medium_folded", 1)
    :component("duct_tape", 10)
)

content.add(content.Recipe {
    id = "box_large_crafted",
    result = "box_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cardboard", 200)
    :component("duct_tape", 100)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_large_assembly",
    result = "box_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("box_large_folded", 1)
    :component("duct_tape", 20)
)

content.add(content.Recipe {
    id = "box_large_reinforced",
    result = "box_large_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "box_large", count = 2 },
            { id = "box_large_folded", count = 2 }
        })
    :component("duct_tape", 100)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_oversize_crafted",
    result = "box_oversize",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cardboard", 200)
    :component("duct_tape", 100)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_oversize_assembly",
    result = "box_oversize",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("box_oversize_folded", 1)
    :component("duct_tape", 20)
)

content.add(content.Recipe {
    id = "box_oversize_reinforced",
    result = "box_oversize_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "box_oversize", count = 2 },
            { id = "box_oversize_folded", count = 2 }
        })
    :component("duct_tape", 80)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "box_small_wood",
    result = "box_small_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :component("nails", 10, true)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 12)
)

content.add(content.Recipe {
    id = "box_medium_wood",
    result = "box_medium_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 2)
    :component("nails", 20, true)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "box_large_wood",
    result = "box_large_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 16)
    :component("nails", 40, true)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "box_oversize_wood",
    result = "box_oversize_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 2)
    :component("wood_panel", 2)
    :component("nails", 40, true)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "box_small_metal",
    result = "box_small_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("sheet_metal_small", 3)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 10)
    :proficiency("prof_metalworking")
)

-- 100cm weld
content.add(content.Recipe {
    id = "box_medium_metal",
    result = "box_medium_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal", 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 100)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

-- 500cm weld
content.add(content.Recipe {
    id = "box_large_metal",
    result = "box_large_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal", 8)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 500)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "box_oversize_metal",
    result = "box_oversize_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet_metal", 8)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "leather_journal",
    result = "leather_journal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "leather", count = 3 },
            { id = "tanned_hide", count = 1 },
            { id = "tanned_pelt", count = 1 }
        })
    :component("filament", 35, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "heavy_punching_bag_sack",
    result = "heavy_punching_bag_sack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("tanned_hide", 9)
    :component("filament", 80, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "55gal_drum_aluminum",
    result = "55gal_drum_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "scrap_aluminum", count = 200 },
            { id = "material_aluminium_ingot", count = 40 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 64)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "30gal_drum_aluminum",
    result = "30gal_drum_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1560000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "scrap_aluminum", count = 52 },
            { id = "material_aluminium_ingot", count = 11 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 40)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "aquarium_medium_drying_active",
    result = "aquarium_medium_drying_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("glass_sheet", 5)
    :component("silicone", 9)
    :component("duct_tape", 53)
    :quality("CUT_GLASS", 1, 1)
)

content.add(content.Recipe {
    id = "aquarium_small_drying_active",
    result = "aquarium_small_drying_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1530000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("glass_sheet", 3)
    :component("silicone", 7)
    :component("duct_tape", 42)
    :quality("CUT_GLASS", 1, 1)
)

content.add(content.Recipe {
    id = "aquarium_large_drying_active",
    result = "aquarium_large_drying_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("glass_sheet", 8)
    :component("silicone", 12)
    :component("duct_tape", 70)
    :quality("CUT_GLASS", 1, 1)
)

content.add(content.Recipe {
    id = "bottle_gourd",
    result = "bottle_gourd",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("dry_bottle_gourd", 1)
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "stock_pot",
    result = "stock_pot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("scrap_aluminum", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 30)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "makeshift_pressure_cooker",
    result = "makeshift_pressure_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("stock_pot", 1)
    :component("chunk_rubber", 2)
    :component("cu_pipe", 1)
    :component("thermometer", 1)
    :component_any({
            { id = "clamp", count = 3 },
            { id = "pliers_locking", count = 3 }
        })
    :quality("DRILL", 2, 1)
    :quality("FILE", 1, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "tankard_wooden",
    result = "tankard_wooden",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component("stick", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "tankard_metal",
    result = "tankard_metal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 5)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ceramic_cup",
    result = "ceramic_cup",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("clay_kaolin", 2)
    :requirement("cordage_short", 1)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 40)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "clay_cup",
    result = "clay_cup",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("any_water", 1, true)
    :component("clay_lump", 2)
    :requirement("cordage_short", 1)
    :requirement("glazing", 1)
    :requirement("earthenware_firing", 40)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
    :proficiency("prof_pottery_glazing")
)

content.add(content.Recipe {
    id = "small_biogas_tank",
    result = "small_biogas_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("small_propane_tank", 1)
)

content.add(content.Recipe {
    id = "medium_biogas_tank",
    result = "medium_biogas_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("medium_propane_tank", 1)
)

content.add(content.Recipe {
    id = "large_biogas_tank",
    result = "large_biogas_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("large_propane_tank", 1)
)

content.add(content.Recipe {
    id = "xl_biogas_tank",
    result = "xl_biogas_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("xl_propane_tank", 1)
)

-- 600cm weld to join the tank bank and manifold.
content.add(content.Recipe {
    id = "bulk_liquid_tank",
    result = "bulk_liquid_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("metal_tank", 10)
    :component("nuts_bolts", 20)
    :component_any({
            { id = "element", count = 12 },
            { id = "crude_heating_element", count = 18 }
        })
    :component("thermostat", 2)
    :component("plastic_chunk", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 600)
    :book("welding_book", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)
