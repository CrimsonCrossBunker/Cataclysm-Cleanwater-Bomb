local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "nail",
    result = "nail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 330000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("nail_header", 1)
    :component("lc_steel_chunk", 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { time_multiplier = 1.5 })
    :batch_discount(2, 10)
    :result_charges(83)
)

content.add(content.Recipe {
    id = "bronze_nail",
    result = "bronze_nail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 75000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "nail_header", count = 1 },
            { id = "nail_header_bronze", count = 1 }
        })
    :requirement("blacksmithing_standard", 1)
    :requirement("bronze_tiny", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { time_multiplier = 1.5 })
    :proficiency("prof_redsmithing_adv")
    :batch_discount(2, 40)
    :result_charges(12)
)

-- Eventually, smoothing tools should also be required, or we should distinguish between rough-hewn and
-- finished beams
content.add(content.Recipe {
    id = "wood_beam_from logs",
    result = "wood_beam",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("log", 2)
    :quality("AXE", 2, 1)
    :byproduct("splinter", 74)
)

-- Hopefully a balanced method of crafting planks without going through interface hoops
content.add(content.Recipe {
    id = "2x4_from logs",
    result = "2x4",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 8,
}
    :component("log", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("splinter", 69)
)

content.add(content.Recipe {
    id = "wood_beam_with_planer",
    result = "wood_beam",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("planer_tool", 250)
    :component("log", 2)
    :byproduct("splinter", 74)
)

-- I am assuming here that you actually get more than 4 smaller-than-represented wood panels, but any
-- application that requires panels means you'll be putting these side by side to get the effect of a single
-- panel.
content.add(content.Recipe {
    id = "wood_panel_from wooden beams",
    result = "wood_panel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("wood_beam", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("splinter", 7)
)

content.add(content.Recipe {
    id = "wood_panel_from wooden sheets",
    result = "wood_panel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("wood_sheet", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "wood_panel_from nailed planks",
    result = "wood_panel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 8)
    :component("nails", 36, true)
    :quality("SAW_W", 2, 1)
    :quality("HAMMER", 2, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 50)
)

content.add(content.Recipe {
    id = "plank_long",
    result = "plank_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    result_multiplier = 8,
}
    :component("wood_beam", 1)
    :requirement("power_saw_long", 5)
    :byproduct("splinter", 65)
)

content.add(content.Recipe {
    id = "2x4_from long planks by hand",
    result = "2x4",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("plank_long", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "2x4_from long planks with powertools",
    result = "2x4",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("plank_long", 1)
    :requirement("power_saw_long", 2)
)

content.add(content.Recipe {
    id = "plank_short_from long planks by hand",
    result = "plank_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("plank_long", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "plank_short_from long planks with powertools",
    result = "plank_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("plank_long", 1)
    :requirement("power_saw_long", 4)
)

content.add(content.Recipe {
    id = "plank_short_from planks by hand",
    result = "plank_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("2x4", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "plank_short_from planks with powertools",
    result = "plank_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("2x4", 1)
    :requirement("power_saw_long", 2)
)

content.add(content.Recipe {
    id = "wooden_post_long",
    result = "wooden_post_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    result_multiplier = 4,
}
    :component("wood_beam", 1)
    :requirement("power_saw_long", 4)
    :byproduct("splinter", 22)
)

content.add(content.Recipe {
    id = "wooden_post_from long posts by hand",
    result = "wooden_post",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("wooden_post_long", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "wooden_post_from long posts with powertools",
    result = "wooden_post",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("wooden_post_long", 1)
    :requirement("power_saw_long", 2)
)

content.add(content.Recipe {
    id = "wooden_post_short_from long posts by hand",
    result = "wooden_post_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("wooden_post_long", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "wooden_post_short_from long posts with powertools",
    result = "wooden_post_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("wooden_post_long", 1)
    :requirement("power_saw_long", 4)
)

content.add(content.Recipe {
    id = "wooden_post_short_from posts by hand",
    result = "wooden_post_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("wooden_post", 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "wooden_post_short_from posts with powertools",
    result = "wooden_post_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 2,
}
    :component("wooden_post", 1)
    :requirement("power_saw_long", 2)
)

content.add(content.Recipe {
    id = "wood_block",
    result = "wood_block",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("wooden_post_short", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("splinter", 13)
)

content.add(content.Recipe {
    id = "giant_wood_screw_from wooden beams",
    result = "giant_wood_screw",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("wood_beam", 1)
    :quality("SAW_W", 2, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_carving")
    :byproduct("splinter", 225)
)

content.add(content.Recipe {
    id = "pipe",
    result = "pipe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "rebar",
    result = "rebar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("hotcut_any", 1, true)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hinge",
    result = "hinge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1260000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "glass_sheet",
    result = "glass_sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("sheet_metal", 1)
    :tool_charges("forge", 75)
    :component("glass_shard", 88)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "tempered_glass_sheet",
    result = "tempered_glass_sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("sheet_metal", 1)
    :tool_charges("forge", 75)
    :component("glass_shard", 227)
    :proficiency("prof_glassblowing")
)

-- 240cm total, the panes are pretty thick so they should be joined with 2 lines of weld
content.add(content.Recipe {
    id = "reinforced_glass_sheet",
    result = "reinforced_glass_sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("reinforced_glass_pane", 4)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 240)
    :learn_by_disassembly("fabrication", 3)
    :proficiency("prof_glassblowing", { required = false, time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "pipe_fittings",
    result = "pipe_fittings",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "cu_pipe",
    result = "cu_pipe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component("copper_scrap_equivalent", 2, true)
    :requirement("blacksmithing_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
)

content.add(content.Recipe {
    id = "brick",
    result = "brick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("clay_lump", 1)
    :component("any_water", 1, true)
    :requirement("earthenware_firing", 60)
    :batch_discount(75, 4)
)

content.add(content.Recipe {
    id = "fire_brick",
    result = "fire_brick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("clay_lump", 1)
    :component("material_sand", 5)
    :component_any({
            { id = "rock", count = 1 },
            { id = "pebble", count = 10 }
        })
    :component("any_water", 1, true)
    :requirement("earthenware_firing", 60)
    :batch_discount(70, 4)
)

content.add(content.Recipe {
    id = "soft_adobe_brick_active",
    result = "soft_adobe_brick_active",
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
    :component("any_water", 1, true)
    :component("material_soil", 2)
    :component_any({
            { id = "withered", count = 2 },
            { id = "straw_pile", count = 2 },
            { id = "feces_cow", count = 1 },
            { id = "feces_roach", count = 4 },
            { id = "feces_manure", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(75, 4)
)

content.add(content.Recipe {
    id = "adobe_pallet_full_active",
    result = "adobe_pallet_full_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("soft_adobe_brick_active", 20)
    :component("frame_wood_light", 1)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "mortar_adobe",
    result = "mortar_adobe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("material_soil", 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "mortar_build",
    result = "mortar_build",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
}
    :tool_charges("concrete_mix_tool", 50)
    :component("material_cement", 50)
    :component("material_sand", 150)
    :book("concrete_book", 2)
    :book("bag_durasack_cement", 1)
)

content.add(content.Recipe {
    id = "mortar_lime",
    result = "mortar_lime",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 100, true)
    :component("material_quicklime", 50)
    :component_any({
            { id = "material_sand", count = 150 },
            { id = "ash", count = 30 }
        })
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "2x4_from logs with powertools",
    result = "2x4",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    result_multiplier = 8,
}
    :component("log", 1)
    :requirement("power_saw_long", 5)
    :byproduct("splinter", 69)
)

content.add(content.Recipe {
    id = "rivets",
    result = "rivets",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 330000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("nail_header", 1)
    :tool("monkey_tool", 1)
    :component("lc_steel_chunk", 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { time_multiplier = 1.5 })
    :batch_discount(2, 10)
    :result_charges(83)
)
