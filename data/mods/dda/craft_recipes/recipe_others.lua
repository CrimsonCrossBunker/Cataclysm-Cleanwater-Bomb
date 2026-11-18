local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
content.add(content.Recipe {
    id = "concrete",
    result = "concrete",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 2,
}
    :quality("CONTAIN", 1, 1)
    :requirement("concrete_materials_dry", 1)
    :book("concrete_book", 4)
    :batch_discount(80, 2)
)

content.add(content.Recipe {
    id = "down_pillow",
    result = "down_pillow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("cotton_patchwork", 6)
    :component("down_feather", 5)
    :requirement("sewing_standard", 12)
)

content.add(content.Recipe {
    id = "down_mattress",
    result = "down_mattress",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("cotton_patchwork", 60)
    :component("down_feather", 60000)
    :requirement("sewing_standard", 12)
)

content.add(content.Recipe {
    id = "pillow",
    result = "pillow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("cotton_patchwork", 4)
    :component("cotton_ball", 8)
    :requirement("sewing_standard", 12)
)

content.add(content.Recipe {
    id = "makeshift_pillow",
    result = "makeshift_pillow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("cotton_patchwork", 4)
    :component_any({
            { id = "straw_pile", count = 3 },
            { id = "withered", count = 15 },
            { id = "pine_bough", count = 10 }
        })
    :requirement("sewing_standard", 12)
)

content.add(content.Recipe {
    id = "bodypillow_bodypillow_makeshift",
    result = "bodypillow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
    variant = "bodypillow_makeshift",
}
    :component("sheet", 1)
    :component("cotton_ball", 20)
    :requirement("sewing_standard", 12)
    :requirement("drawing_tool", 20)
)

content.add(content.Recipe {
    id = "screw_press_tool",
    result = "screw_press_tool",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("wood_beam", 3)
    :component("wood_panel", 1)
    :component("2x4", 4)
    :component_any({
            { id = "wood_panel", count = 1 },
            { id = "sheet_metal", count = 1 }
        })
    :component("giant_wood_screw", 1)
    :component("long_pole", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 3)
    :learn_by_disassembly("fabrication", 2)
    :book("winemaking_beginner", 1)
    :book("distilling_cookbook", 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "wind_mill",
    result = "wind_mill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3000000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 25 },
            { id = "frame_wood", count = 4 }
        })
    :component("sheet_metal_small", 3)
    :component("nails", 100, true)
    :component("pipe", 4)
    :component_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 }
        })
    :component_any({
            { id = "any_wire", count = 6, requirement = true },
            { id = "rope_6", count = 6 },
            { id = "vine_6", count = 6 },
            { id = "rope_makeshift_6", count = 6 }
        })
    :component_any({
            { id = "chain", count = 1 },
            { id = "rope_natural", count = 1, requirement = true }
        })
    :component_any({
            { id = "rebar", count = 2 },
            { id = "steel_chunk_any", count = 4, requirement = true }
        })
    :component("rock", 40)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requires_skill("survival", 4)
    :learn_by_disassembly("fabrication", 2)
)

content.add(content.Recipe {
    id = "water_mill",
    result = "water_mill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 15 },
            { id = "frame_wood", count = 3 }
        })
    :component_any({
            { id = "wood_panel", count = 6 },
            { id = "wood_sheet", count = 3 }
        })
    :component("sheet_metal_small", 6)
    :component("nails", 100, true)
    :component("pipe", 8)
    :component("wheel_wood_b", 2)
    :component_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 }
        })
    :component_any({
            { id = "any_wire", count = 6, requirement = true },
            { id = "rope_6", count = 6 },
            { id = "vine_6", count = 6 },
            { id = "rope_makeshift_6", count = 6 }
        })
    :component_any({
            { id = "chain", count = 1 },
            { id = "rope_natural", count = 1, requirement = true }
        })
    :component_any({
            { id = "rebar", count = 2 },
            { id = "steel_chunk_any", count = 4, requirement = true }
        })
    :component("rock", 40)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_W", 2, 1)
    :requires_skill("survival", 4)
    :learn_by_disassembly("fabrication", 3)
)

content.add(content.Recipe {
    id = "tent_kit",
    result = "tent_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 168000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("tarp", 2)
    :component("tent_pole", 2)
    :component("plastic_sheet", 1)
    :component("plastic_sheet_small", 1)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 1)
    :requires_skill("survival", 2)
    :book("fun_survival", 1)
    :book("manual_survival", 1)
    :book("textbook_survival", 1)
)

content.add(content.Recipe {
    id = "tent_kit_from_broken",
    result = "tent_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 84000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("broketent", 1)
    :component("plastic_sheet", 1)
    :component("plastic_sheet_small", 1)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 1)
    :requires_skill("survival", 2)
    :book("fun_survival", 1)
    :book("manual_survival", 1)
    :book("textbook_survival", 1)
)

content.add(content.Recipe {
    id = "large_tent_kit",
    result = "large_tent_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 192000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("tarp", 6)
    :component("tent_pole", 6)
    :component("plastic_sheet", 3)
    :component("plastic_sheet_small", 3)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 3)
    :requires_skill("survival", 2)
    :book("fun_survival", 1)
    :book("manual_survival", 1)
    :book("textbook_survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "large_tent_kit_from_broken",
    result = "large_tent_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("largebroketent", 1)
    :component("tarp", 2)
    :component("plastic_sheet", 1)
    :component("plastic_sheet_small", 2)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 3)
    :requires_skill("survival", 2)
    :book("fun_survival", 1)
    :book("manual_survival", 1)
    :book("textbook_survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

-- 75 cm weld
content.add(content.Recipe {
    id = "small_space_heater",
    result = "small_space_heater",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 12 }
        })
    :component("cable", 2)
    :component("sheet_metal_small", 5)
    :component("power_supply", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 75)
    :requirement("steel_standard", 2)
    :learn_by_disassembly("fabrication", 3)
    :proficiency("prof_appliance_repair")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 200 cm weld
content.add(content.Recipe {
    id = "large_space_heater",
    result = "large_space_heater",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 900000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 12 },
            { id = "crude_heating_element", count = 18 }
        })
    :component("cable", 3)
    :component("sheet_metal", 2)
    :component("power_supply", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 200)
    :requirement("steel_standard", 4)
    :learn_by_disassembly("fabrication", 3)
    :proficiency("prof_appliance_repair")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "puller",
    result = "puller",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :component("plastic_chunk", 5)
    :component("scrap", 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 6)
    :book("textbook_fabrication", 7)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "press_dowel",
    result = "press_dowel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "mop", count = 1 },
            { id = "broom", count = 1 },
            { id = "hoe", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 1 },
            { id = "puck", count = 1 }
        })
    :component_any({
            { id = "nails", count = 1, requirement = true },
            { id = "antenna", count = 1 }
        })
    :component("shot_hull", 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_carving")
)

-- The tailoring kit is an expanded sewing kit, so a bone/wood needle is inappropriate.
content.add(content.Recipe {
    id = "tailors_kit",
    result = "tailors_kit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
    flags = { "BLIND_EASY" },
}
    :component("sewing_kit", 1)
    :component("scissors", 1)
    :component("kevlar_shears", 1)
    :component("knitting_needles", 1)
    :component("awl_steel", 1)
    :component("needle_curved", 1)
    :component("plastic_chunk", 3)
    :requirement("soldering_standard", 5)
    :learn_by_disassembly("tailor", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
)

content.add(content.Recipe {
    id = "analytical_set_basic",
    result = "analytical_set_basic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("ph_meter", 1)
    :component("spectrophotometer", 1)
    :component("cuvettes", 1)
    :component("paper", 1)
    :component("balance_small", 1)
    :component("melting_point", 1)
    :component("box_medium", 1)
)

content.add(content.Recipe {
    id = "makeshift_hammer",
    result = "makeshift_hammer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component_any({
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :quality("HAMMER", 1, 1)
    :requirement("steel_chunk_any", 1)
)

content.add(content.Recipe {
    id = "needle_bone",
    result = "needle_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "bone_sturdy", count = 1, requirement = true },
            { id = "skewer_bone", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "needle_wood",
    result = "needle_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("splinter", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bone_flute",
    result = "bone_flute",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_WIND",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :component("bone_sturdy", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "knitting_needles",
    result = "knitting_needles",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("splinter", 2)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "distaff_spindle",
    result = "distaff_spindle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "carding_paddles",
    result = "carding_paddles",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "stick", count = 2 },
            { id = "2x4", count = 1 }
        })
    :component_any({
            { id = "skewer_bone", count = 20 },
            { id = "splinter", count = 20 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "makeshift_funnel",
    result = "makeshift_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "plastic_bottles_4l", count = 1, requirement = true },
            { id = "bottle_bathroom", count = 3 },
            { id = "aluminum_foil", count = 6 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "shelter_kit",
    result = "shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 10 },
            { id = "2x4", count = 5 }
        })
    :component_any({
            { id = "leather", count = 64 },
            { id = "sheet_leather_patchwork", count = 8 },
            { id = "tanned_hide", count = 8 }
        })
    :component("filament", 40, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "large_shelter_kit",
    result = "large_shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :component("stick", 10)
    :component_any({
            { id = "sheet_leather_patchwork", count = 24 },
            { id = "sheet_leather", count = 24 },
            { id = "tanned_hide", count = 24 }
        })
    :component("filament", 500, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "shelter_kit_repair",
    result = "shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("repaired %s"),
}
    :component_any({
            { id = "stick", count = 3 },
            { id = "2x4", count = 2 }
        })
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 }
        })
    :component("damaged_shelter_kit", 1)
    :component("filament", 5, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "large_shelter_kit_repair",
    result = "large_shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("repaired %s"),
}
    :component("stick", 6)
    :component_any({
            { id = "leather", count = 16 },
            { id = "sheet_leather", count = 4 },
            { id = "sheet_leather_patchwork", count = 4 },
            { id = "tanned_hide", count = 4 }
        })
    :component("large_damaged_shelter_kit", 1)
    :component("filament", 100, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("tailor", 2)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "fur_rollmat",
    result = "fur_rollmat",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "fur", count = 24 },
            { id = "tanned_pelt", count = 4 },
            { id = "sheet_fur_patchwork", count = 4 }
        })
    :component("filament", 20, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("tailor", 1)
    :learn_by_disassembly("survival", 0)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "w_table",
    result = "w_table",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 4)
    :component("wood_panel", 1)
    :component("nails", 8, true)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :learn_by_disassembly("fabrication", 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "v_table",
    result = "v_table",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 5)
    :component("wood_panel", 1)
    :component("nails", 14, true)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :learn_by_disassembly("fabrication", 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_carving")
    :byproduct("splinter", 5)
)

-- 220 cm weld
content.add(content.Recipe {
    id = "workbench",
    result = "workbench",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 8)
    :component("sheet_metal", 2)
    :component("sheet_metal_small", 4)
    :component("pipe_fittings", 4)
    :requirement("welding_standard", 220)
    :learn_by_disassembly("fabrication", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "workbench_with_recharger",
    result = "workbench_with_recharger",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("workbench", 1)
    :component("battery_charger", 1)
    :requirement("welding_standard", 5)
    :learn_by_disassembly("fabrication", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "rolling_paper",
    result = "rolling_paper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("paper", 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "lc_wire",
    result = "lc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s by hand"),
}
    :component("lc_steel_lump", 1)
    :requirement("blacksmithing_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "lc_wire_wire_draw_machine",
    result = "lc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s using wire draw machine"),
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("lc_steel_lump", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "mc_wire",
    result = "mc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s by hand"),
}
    :component("mc_steel_lump", 1)
    :requirement("blacksmithing_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_wire_wire_draw_machine",
    result = "mc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s using wire draw machine"),
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("mc_steel_lump", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "hc_wire",
    result = "hc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s by hand"),
}
    :component("hc_steel_lump", 1)
    :requirement("blacksmithing_standard", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_wire_wire_draw_machine",
    result = "hc_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s using wire draw machine"),
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("hc_steel_lump", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "ch_wire",
    result = "ch_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s by hand"),
}
    :component("lc_steel_lump", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("carbon", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_wire_wire_draw_machine",
    result = "ch_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s using wire draw machine"),
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("lc_steel_lump", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :requirement("carbon", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "qt_wire",
    result = "qt_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s by hand"),
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("carbon", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "qt_wire_wire_draw_machine",
    result = "qt_wire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
    name = content.text("%s using wire draw machine"),
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 22 },
            { id = "charcoal", count = 19 }
        })
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "wire_barbed",
    result = "wire_barbed",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :component("lc_wire", 2)
    :quality("HAMMER", 3, 1)
)

content.add(content.Recipe {
    id = "holy_symbol_wood",
    result = "holy_symbol_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "splinter", count = 1 },
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("cordage_short", 3)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "stepladder",
    result = "stepladder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 12)
    :component("nails", 30, true)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "duct_tape",
    result = "duct_tape",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("glue_weak", 250)
    :component_any({
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 }
        })
    :component("plastic_sheet_small", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("textbook_fabrication", 3)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "tree_spile",
    result = "tree_spile",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "makeshift_tree_spile",
    result = "makeshift_tree_spile",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component_any({
            { id = "pointy_stick", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "brazier",
    result = "brazier",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal", 1)
    :quality("HAMMER", 2, 1)
    :byproduct("lc_steel_chunk", 6)
)

content.add(content.Recipe {
    id = "solar_cooker",
    result = "solar_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("pipe", 6)
    :component("scrap", 6)
    :component("sheet_metal", 2)
    :component_any({
            { id = "mirror", count = 56 },
            { id = "bigmirror", count = 2 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("CUT_GLASS", 1, 1)
)

content.add(content.Recipe {
    id = "solar_cooker_from_polished_metal",
    result = "solar_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("pipe", 6)
    :component("scrap", 6)
    :component("sheet_metal", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("GRIND", 2, 1)
)

content.add(content.Recipe {
    id = "makeshift_brazier",
    result = "makeshift_brazier",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_any({
            { id = "spike", count = 1 },
            { id = "nail", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "rebar", count = 1 },
            { id = "spear_rebar", count = 1 }
        })
    :component("bucket", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "55gal_firebarrel",
    result = "55gal_firebarrel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_any({
            { id = "spike", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "rebar", count = 1 },
            { id = "spear_rebar", count = 1 }
        })
    :component("55gal_drum", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "30gal_firebarrel",
    result = "30gal_firebarrel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :tool_any({
            { id = "spike", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "rebar", count = 1 },
            { id = "spear_rebar", count = 1 }
        })
    :component("30gal_drum", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "chemistry_set_basic",
    result = "chemistry_set_basic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "glass_goggles", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "hose", count = 3 },
            { id = "makeshift_hose", count = 3 }
        })
    :component_any({
            { id = "flask_glass", count = 4 },
            { id = "jar_glass_sealed", count = 4 },
            { id = "bottle_glass", count = 4 },
            { id = "test_tube", count = 20 }
        })
    :component_any({
            { id = "box_small", count = 1 },
            { id = "bag_canvas", count = 1 },
            { id = "backpack", count = 1 },
            { id = "backpack_leather", count = 1 },
            { id = "rucksack", count = 1 }
        })
    :requires_skill("chemistry", 2)
    :learn_by_disassembly("fabrication", 0)
    :book("adv_chemistry", 1)
    :book("textbook_chemistry", 1)
)

content.add(content.Recipe {
    id = "chemistry_set",
    result = "chemistry_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "cable", count = 4 },
            { id = "any_wire", count = 1, requirement = true }
        })
    :component("hotplate", 1)
    :component("chemistry_set_basic", 1)
    :requires_skill("chemistry", 2)
    :learn_by_disassembly("fabrication", 0)
    :book("adv_chemistry", 1)
    :book("textbook_chemistry", 1)
)

content.add(content.Recipe {
    id = "misc_repairkit",
    result = "misc_repairkit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
    flags = { "BLIND_EASY" },
}
    :component("xacto", 1)
    :component_any({
            { id = "saw", count = 1 },
            { id = "bow_saw", count = 1 },
            { id = "saw_bronze", count = 1 }
        })
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "faux_fur", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :learn_by_disassembly("fabrication", 1)
)

content.add(content.Recipe {
    id = "small_repairkit",
    result = "small_repairkit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component("pipe_cleaner", 1)
    :component("soldering_iron_portable", 1)
    :component("screwdriver_set", 1)
    :component("wrench", 1)
    :component("chisel", 1)
    :component("hacksaw", 1)
    :component("hammer", 1)
    :book("manual_shotgun", 0)
    :book("manual_rifle", 0)
    :book("manual_smg", 0)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :book("textbook_mechanics", 1)
    :book("mag_mechanics", 2)
    :book("mag_rifle", 2)
)

content.add(content.Recipe {
    id = "tire_repair_kit",
    result = "tire_repair_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component_any({
            { id = "bag_plastic_small", count = 1 },
            { id = "bag_plastic", count = 1 }
        })
    :component("glue_strong", 5)
    :component("soapy_water", 1)
    :component_any({
            { id = "shredded_rubber", count = 1 },
            { id = "string_6", count = 4 },
            { id = "cotton_patchwork", count = 1 },
            { id = "canvas_patch", count = 1 },
            { id = "lycra_patch", count = 1 },
            { id = "denim_patch", count = 1 },
            { id = "nylon", count = 1 },
            { id = "nomex", count = 1 }
        })
)

content.add(content.Recipe {
    id = "pipe_cleaner",
    result = "pipe_cleaner",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component_any({
            { id = "any_wire", count = 2, requirement = true },
            { id = "cable", count = 1 }
        })
    :component_any({
            { id = "yarn", count = 1 },
            { id = "cotton_ball", count = 1 },
            { id = "wool_staple", count = 1 }
        })
    :book("manual_shotgun", 0)
    :book("manual_rifle", 0)
    :book("manual_smg", 0)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :book("textbook_mechanics", 1)
    :book("decoy_elfa", 1)
    :book("mag_mechanics", 2)
    :book("mag_rifle", 2)
)

content.add(content.Recipe {
    id = "popcan_stove",
    result = "popcan_stove",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("can_drink", 2)
    :component("plastic_bottles_2l", 1, true)
    :quality("CUT", 2, 1)
    :book("fun_survival", 1)
    :book("manual_fabrication", 1)
)

content.add(content.Recipe {
    id = "forge",
    result = "forge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "welder", charges = 200 },
            { id = "welding_kit", charges = 200 },
            { id = "welder_crude", charges = 300 },
            { id = "integrated_welder", charges = 300 },
            { id = "soldering_iron", charges = 300 },
            { id = "soldering_iron_portable", charges = 300 },
            { id = "integrated_electrokit", charges = 300 },
            { id = "oxy_torch", charges = 40 }
        })
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 12 }
        })
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :component("cable", 2)
    :component("power_supply", 1)
    :component("fire_brick", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :learn_by_disassembly("fabrication", 4)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "glassblowers_crucible",
    result = "glassblowers_crucible",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 12 }
        })
    :component("pot_canning_clay", 1)
    :component("cable", 2)
    :component("power_supply", 1)
    :component("fire_brick", 25)
    :component("pipe", 8)
    :component("pipe_fittings", 4)
    :component("sheet_metal_small", 4)
    :component("small_lcd_screen", 1)
    :component("processor", 1)
    :component("thermostat", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 100)
    :requirement("clay_refractory", 10)
    :learn_by_disassembly("fabrication", 4)
    :book("glassblowing_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_pottery")
)

content.add(content.Recipe {
    id = "crucible_clay",
    result = "crucible_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("any_water", 1, true)
    :component("graphite", 250)
    :component("material_sand", 10)
    :requirement("earthenware_firing", 90)
    :requirement("clay_refractory", 5)
    :proficiency("prof_pottery")
)

-- Tin can be melted by fire, but you need something to contain and work with it. Hence the press.
content.add(content.Recipe {
    id = "pot_copper",
    result = "pot_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_charges("surface_heat", 10, true)
    :component("copper_scrap_equivalent", 3, true)
    :component("tin", 30)
    :quality("HAMMER", 3, 1)
)

-- Alternative to the press explained above: this electroplates the tin using an electrolysis kit.
-- Handling acids requires some knowledge.
content.add(content.Recipe {
    id = "pot_copper_by_electrolysis",
    result = "pot_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s by electrolysis"),
}
    :tool_charges("electrolysis_kit", 10)
    :tool_charges("surface_heat", 10, true)
    :component("copper_scrap_equivalent", 3, true)
    :component("tin", 30)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("any_strong_acid", 1, true)
    :quality("HAMMER", 3, 1)
    :book("textbook_chemistry", 4)
    :book("textbook_fabrication", 4)
    :book("welding_book", 4)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "pot",
    result = "pot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "book_binder",
    result = "book_binder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("duct_tape", 20)
    :component("plastic_chunk", 2)
    :component("cordage_short", 2, true)
)

content.add(content.Recipe {
    id = "teapot",
    result = "teapot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
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
    id = "survivor_scope",
    result = "survivor_scope",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 4)
    :component("lens", 1)
    :component_any({
            { id = "lens", count = 1 },
            { id = "lens_small", count = 1 }
        })
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 3)
    :book("plastics_book", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "crackpipe",
    result = "crackpipe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "bottle_glass", count = 1 },
            { id = "flask_glass", count = 1 }
        })
)

content.add(content.Recipe {
    id = "char_forge",
    result = "char_forge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "soldering_iron", charges = 150 },
            { id = "soldering_iron_portable", charges = 150 },
            { id = "integrated_electrokit", charges = 150 },
            { id = "oxy_torch", charges = 20 }
        })
    :component("pilot_light", 1)
    :component_any({
            { id = "steel_lump_any", count = 3, requirement = true },
            { id = "steel_chunk_any", count = 12, requirement = true },
            { id = "scrap", count = 36 }
        })
    :component("metal_tank_little", 1)
    :component("pipe", 3)
    :component("pipe_fittings", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "char_smoker",
    result = "char_smoker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 420000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "welder", charges = 50 },
            { id = "welding_kit", charges = 50 },
            { id = "welder_crude", charges = 75 },
            { id = "integrated_welder", charges = 75 },
            { id = "soldering_iron", charges = 75 },
            { id = "soldering_iron_portable", charges = 75 },
            { id = "integrated_electrokit", charges = 75 },
            { id = "oxy_torch", charges = 10 }
        })
    :component("pilot_light", 1)
    :component("scrap", 4)
    :component("metal_tank_little", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("cooking", 2)
    :learn_by_disassembly("fabrication", 1)
    :book("textbook_fabrication", 2)
    :book("manual_fabrication", 3)
    :book("cookbook", 3)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "waffleiron",
    result = "waffleiron",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 900000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("scrap_aluminum", 11)
    :requirement("blacksmithing_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "pastaextruder",
    result = "pastaextruder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 900000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

-- 100 cm weld
content.add(content.Recipe {
    id = "kiln",
    result = "kiln",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 12 }
        })
    :component("cable", 2)
    :component("power_supply", 1)
    :component("metal_tank_little", 1)
    :component("pipe", 8)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 100)
    :requirement("steel_standard", 6)
    :learn_by_disassembly("fabrication", 4)
    :book("textbook_fabrication", 4)
    :book("manual_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 338cm weld. 108cm from pipes making the base and handles, 20cm from welding four sheets for the blades on
-- the inside of the drum, 200cm from welding six sheets around the motor.
-- The component list is by no means perfect - this craft still generates ~7.2kg of mass. I can't, however,
-- improve it without adding nonexistent components to the recipe, so I think this is an acceptable state of
-- things.
content.add(content.Recipe {
    id = "con_mix_foldable",
    result = "con_mix_foldable",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1620000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("pipe", 12)
    :component("sheet_metal_small", 10)
    :component("motor_small", 1)
    :component("small_storage_battery", 1)
    :component("wheel_small", 2)
    :component("wheel_mount_light", 2)
    :component("nuts_bolts", 8)
    :component("30gal_barrel", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 25)
    :requirement("welding_standard", 338)
    :requires_skill("electronics", 3)
    :book("textbook_fabrication", 7)
    :book("manual_fabrication", 7)
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "char_kiln",
    result = "char_kiln",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("55gal_drum", 1)
    :component("pipe", 2)
    :quality("HAMMER", 3, 1)
    :quality_any({
            { id = "SAW_M", level = 1, count = 1 },
            { id = "CUT", level = 1, count = 1 }
        })
    :book("textbook_fabrication", 2)
    :book("manual_fabrication", 2)
    :proficiency("prof_metalworking")
)

-- resulting jug has 90 charges of charcoal, but is slightly overcharging for water purification so this
-- recipe gets a slight discount.
content.add(content.Recipe {
    id = "char_purifier",
    result = "char_purifier",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "FULL_MAGAZINE" },
}
    :component("jug_plastic", 1)
    :component("cotton_patchwork", 4)
    :component("charcoal", 84)
    :quality("CUT", 2, 1)
)

-- resulting hydria has 360 charges of charcoal, but is slightly overcharging for water purification so this
-- recipe gets a slight discount.
content.add(content.Recipe {
    id = "char_purifier_clay",
    result = "char_purifier_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "FULL_MAGAZINE" },
}
    :component("clay_hydria", 1)
    :component("cotton_patchwork", 4)
    :component("charcoal", 335)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "mop",
    result = "mop",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cotton_patchwork", 4)
    :quality("CUT", 2, 1)
    :requirement("cordage", 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "mirror",
    result = "mirror",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 75)
    :component("glass_shard", 3)
    :component("silver_small", 6)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing", { required = false, time_multiplier = 6 })
)

content.add(content.Recipe {
    id = "pipe_glass",
    result = "pipe_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
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
    :tool_charges("forge", 25)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :quality("CHISEL", 3, 1)
    :book("glassblowing_book", 6)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "grapnel",
    result = "grapnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rope_superior", 1, true)
    :component("grip_hook", 4)
    :book("mag_survival", 4)
    :book("atomic_survival", 3)
    :book("textbook_survival", 2)
)

content.add(content.Recipe {
    id = "grapnel_from_scratch",
    result = "grapnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
    name = content.text("%s from scratch"),
}
    :tool_charges("hotcut_any", 1, true)
    :component("rope_natural", 1, true)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_chunk_any", 8)
    :book("mag_survival", 4)
    :book("atomic_survival", 3)
    :book("textbook_survival", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "well_pump",
    result = "well_pump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "soldering_iron", charges = 150 },
            { id = "soldering_iron_portable", charges = 150 },
            { id = "integrated_electrokit", charges = 150 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 6, requirement = true },
            { id = "scrap", count = 18 }
        })
    :component("pipe", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("GLARE", 1, 1)
    :book("textbook_fabrication", 4)
    :book("manual_fabrication", 4)
)

content.add(content.Recipe {
    id = "wearable_rx12",
    result = "wearable_rx12",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("rx12_injector", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "leather", count = 2 },
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :quality("CUT", 2, 1)
    :book("recipe_caseless", 5)
)

content.add(content.Recipe {
    id = "fishing_hook_basic",
    result = "fishing_hook_basic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("nails", 1, true)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "fishing_hook_bone",
    result = "fishing_hook_bone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "bone_sturdy", count = 1, requirement = true },
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "splinter", count = 1 },
            { id = "2x4", count = 1 },
            { id = "mop", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "skewer_bone",
    result = "skewer_bone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("bone_sturdy", 1, true)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "fish_trap",
    result = "fish_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 2,
}
    :component("plastic_bottles_4l", 2, true)
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 },
            { id = "medical_tape", count = 25 }
        })
    :quality("CUT", 2, 1)
    :book("mag_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 1)
    :book("pocket_survival", 1)
)

content.add(content.Recipe {
    id = "fish_trap_basket",
    result = "fish_trap_basket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 4,
}
    :component("plant_cordage", 20, true)
    :quality("CUT", 1, 1)
    :requires_skill("tailor", 3)
    :proficiency("prof_basketweaving")
)

-- 180 cm weld
content.add(content.Recipe {
    id = "toolbox_workshop_empty",
    result = "toolbox_workshop_empty",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_CONTAINERS",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("sheet_metal_small", 32)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 180)
    :requires_skill("fabrication", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "survival_marker",
    result = "survival_marker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "charcoal", count = 5 },
            { id = "coal_lump", count = 5 }
        })
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "chitin_plate",
    result = "chitin_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("chitin_piece", 20)
    :component("rope_natural", 1, true)
    :component_any({
            { id = "rope_natural_short", count = 2, requirement = true },
            { id = "adhesive", count = 4, requirement = true }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_chitinworking")
)

content.add(content.Recipe {
    id = "acidchitin_plate",
    result = "acidchitin_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("acidchitin_piece", 20)
    :component("rope_natural", 1, true)
    :component_any({
            { id = "rope_natural_short", count = 2, requirement = true },
            { id = "adhesive", count = 4, requirement = true }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_chitinworking")
)

content.add(content.Recipe {
    id = "railroad_track_small",
    result = "railroad_track_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1620000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :component("2x4", 24)
    :component("nails", 40, true)
    :quality("SAW_W", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "jumper_cable",
    result = "jumper_cable",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cable", 34)
    :component("scrap", 4)
    :component("duct_tape", 50)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 25)
    :requires_skill("electronics", 2)
)

content.add(content.Recipe {
    id = "jumper_cable_heavy",
    result = "jumper_cable_heavy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("cable", 217)
    :component("scrap", 10)
    :component("duct_tape", 30)
    :component_any({
            { id = "hose", count = 2 },
            { id = "makeshift_hose", count = 2 }
        })
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 60)
    :requires_skill("electronics", 3)
)

content.add(content.Recipe {
    id = "extension_cable",
    result = "extension_cable",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cable", 100)
    :component("scrap", 1)
    :component("duct_tape", 50)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 50)
    :requires_skill("electronics", 2)
)

content.add(content.Recipe {
    id = "long_extension_cable",
    result = "long_extension_cable",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("cable", 300)
    :component("scrap", 2)
    :component("duct_tape", 50)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 90)
    :requires_skill("electronics", 3)
)

-- 10 cm weld
content.add(content.Recipe {
    id = "metal_funnel",
    result = "metal_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("sheet_metal", 1)
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "scrap", count = 9 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "tarp_raincatcher",
    result = "tarp_raincatcher",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 2,
}
    :component("pointy_stick", 3)
    :component("cordage", 1, true)
    :component_any({
            { id = "tarp", count = 1 },
            { id = "plastic_sheet", count = 1 }
        })
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "funnel",
    result = "funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
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
    id = "leather_funnel",
    result = "leather_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
    name = content.text("%s from patches"),
}
    :component_any({
            { id = "leather", count = 4 },
            { id = "fur", count = 4 }
        })
    :requirement("sewing_standard", 10)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "leather_funnel_from_sheets",
    result = "leather_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
    name = content.text("%s from sheets"),
}
    :component_any({
            { id = "sheet_leather_patchwork", count = 1 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 }
        })
    :requirement("sewing_standard", 10)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "birchbark_funnel",
    result = "birchbark_funnel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("birchbark", 12)
    :component("adhesive", 1, true)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "cured_hide",
    result = "cured_hide",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("%s from raw hide"),
}
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "salt", count = 2 }
        })
    :component("raw_leather", 1)
    :quality("CUT", 2, 1)
    :requires_skill("chemistry", 1)
)

content.add(content.Recipe {
    id = "cured_hide_scraped",
    result = "cured_hide",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("%s by scraping pelt"),
}
    :component("cured_pelt", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "tanning_hide_active",
    result = "tanning_hide_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component("tanning_agent", 1, true)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 },
            { id = "salt", count = 10 }
        })
    :component_any({
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "tallow_tainted", count = 1 }
        })
    :component("cured_hide", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("chemistry", 2)
    :batch_discount(20, 10)
)

content.add(content.Recipe {
    id = "cured_pelt",
    result = "cured_pelt",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "salt", count = 2 }
        })
    :component_any({
            { id = "raw_fur", count = 1 },
            { id = "raw_hfur", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("chemistry", 1)
)

content.add(content.Recipe {
    id = "tanning_pelt_active",
    result = "tanning_pelt_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component("tanning_agent", 1, true)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 },
            { id = "salt", count = 10 }
        })
    :component_any({
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "tallow_tainted", count = 1 }
        })
    :component("cured_pelt", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("chemistry", 2)
    :batch_discount(20, 10)
)

-- Unlike recipes above, this one actually requires handling of dangerous chemical substances (lye powder).
content.add(content.Recipe {
    id = "tanning_hide_active_modern",
    result = "tanning_hide_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s using lye powder"),
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component_any({
            { id = "lye_powder", count = 10 },
            { id = "aspirin", count = 10 }
        })
    :component("cured_hide", 6)
    :quality("CHEM", 1, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 3)
    :book("textbook_survival", 6)
    :book("textbook_chemistry", 4)
    :book("modern_tanner", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "tanning_pelt_active_modern",
    result = "tanning_pelt_active",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s using lye powder"),
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :component_any({
            { id = "lye_powder", count = 10 },
            { id = "aspirin", count = 10 }
        })
    :component("cured_pelt", 6)
    :quality("CHEM", 1, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("survival", 3)
    :book("textbook_survival", 6)
    :book("textbook_chemistry", 4)
    :book("modern_tanner", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "charcoal_cooker",
    result = "charcoal_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("metal_tank_little", 1)
    :component("pilot_light", 1)
    :component("pipe_fittings", 1)
    :component("pipe", 1)
    :component("duct_tape", 50)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
)

content.add(content.Recipe {
    id = "oil_cooker",
    result = "oil_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("oil_lamp", 1)
    :component("pilot_light", 1)
    :component("metal_tank_little", 1)
    :component("duct_tape", 50)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
)

content.add(content.Recipe {
    id = "gasoline_cooker",
    result = "gasoline_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("gasoline_lantern", 1)
    :component("pilot_light", 1)
    :component("metal_tank_little", 1)
    :component("duct_tape", 50)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
)

content.add(content.Recipe {
    id = "bagpipes",
    result = "bagpipes",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_WIND",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "large_stomach_sealed", count = 1 },
            { id = "tanned_hide", count = 2 },
            { id = "leather", count = 16 },
            { id = "tanned_pelt", count = 2 },
            { id = "fur", count = 16 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cotton_patchwork", 3)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "medical_tape", count = 50 }
        })
    :requirement("sewing_standard", 20)
    :requires_skill("tailor", 4)
    :book("scots_tailor", 3)
    :book("scots_cookbook", 7)
)

content.add(content.Recipe {
    id = "survivor_shavingkit",
    result = "survivor_shavingkit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component("cotton_patchwork", 1)
    :component("razor_shaving", 1)
    :component("mirror", 1)
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "skewer_bone", count = 4 },
            { id = "splinter", count = 4 }
        })
    :requirement("cordage_short", 2)
)

content.add(content.Recipe {
    id = "survivor_hairtrimmer",
    result = "survivor_hairtrimmer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component("cotton_patchwork", 1)
    :component("scissors", 1)
    :component("mirror", 1)
    :requirement("cordage_short", 4)
)

content.add(content.Recipe {
    id = "plant_fibre",
    result = "plant_fibre",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "dogbane", count = 1 },
            { id = "cattail_stalk", count = 1 },
            { id = "cottonwood_tree_boll", count = 1 }
        })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "plant_fibre_s_scutcher",
    result = "plant_fibre",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 36000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
    name = content.text("%s using scutcher"),
}
    :tool("scutcheritem", 1)
    :component_any({
            { id = "dogbane", count = 8 },
            { id = "cattail_stalk", count = 8 },
            { id = "stick_fiber", count = 1 },
            { id = "cottonwood_tree_boll", count = 8 }
        })
    :batch_discount(50, 2)
    :result_charges(80)
)

content.add(content.Recipe {
    id = "wash_kit",
    result = "wash_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component_any({
            { id = "sponge", count = 1 },
            { id = "cotton_patchwork", count = 1 },
            { id = "brush", count = 1 },
            { id = "dish_towel", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "lamellae_lc_small",
    result = "lamellae_lc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("sheet_metal_small", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_metalworking")
    :result_charges(18)
)

content.add(content.Recipe {
    id = "lamellae_lc_small_fast",
    result = "lamellae_lc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    name = content.text("%s using powered drill"),
}
    :tool_any({
            { id = "drill_press_tool", charges = 10 },
            { id = "cordless_drill", charges = 20 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M_FINE", 1, 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_metalworking")
    :result_charges(18)
)

content.add(content.Recipe {
    id = "lamellae_lc_large",
    result = "lamellae_lc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 4320000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    name = content.text("many %s"),
}
    :component("sheet_metal", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_metalworking")
    :result_charges(432)
)

content.add(content.Recipe {
    id = "lamellae_lc_large_fast",
    result = "lamellae_lc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    name = content.text("many %s using powered drill"),
}
    :tool_any({
            { id = "drill_press_tool", charges = 10 },
            { id = "cordless_drill", charges = 20 }
        })
    :component("sheet_metal", 1)
    :quality("SAW_M_FINE", 1, 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :proficiency("prof_metalworking")
    :result_charges(432)
)

content.add(content.Recipe {
    id = "lamellae_ch",
    result = "lamellae_ch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("lamellae_lc", 18)
    :requirement("carbon", 1)
    :book("textbook_armwest", 2)
    :book("textbook_armeast", 2)
    :book("textbook_armschina", 2)
    :book("welding_book", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_hardening")
    :batch_discount(90, 1)
    :result_charges(18)
)

content.add(content.Recipe {
    id = "lc_chain_link_fabrication",
    result = "lc_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("lc_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(425)
)

content.add(content.Recipe {
    id = "mc_chain_link_fabrication",
    result = "mc_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("mc_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(425)
)

content.add(content.Recipe {
    id = "hc_chain_link_fabrication",
    result = "hc_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("hc_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(425)
)

content.add(content.Recipe {
    id = "ch_chain_link_fabrication",
    result = "ch_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("ch_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(425)
)

content.add(content.Recipe {
    id = "qt_chain_link_fabrication",
    result = "qt_chain_link",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "toolset", count = 1 }
        })
    :tool("cu_pipe", 1)
    :component("qt_wire", 1)
    :quality("WRENCH", 1, 1)
    :book("textbook_armwest", 1)
    :book("textbook_fabrication", 1)
    :book("recipe_melee", 1)
    :result_charges(425)
)

-- 1kg per sheet, wire is 0.15kg, links need to cover 850g = 2550 links
content.add(content.Recipe {
    id = "lc_link_sheet",
    result = "lc_link_sheet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("lc_chain_link", 2550)
    :component("lc_wire", 1)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 2)
    :book("textbook_fabrication", 2)
    :book("recipe_melee", 2)
)

-- 1kg per sheet, wire is 0.15kg, links need to cover 850g = 2550 links
content.add(content.Recipe {
    id = "mc_link_sheet",
    result = "mc_link_sheet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("mc_chain_link", 2550)
    :component("mc_wire", 1)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 2)
    :book("textbook_fabrication", 2)
    :book("recipe_melee", 2)
)

-- 1kg per sheet, wire is 0.15kg, links need to cover 850g = 2550 links
content.add(content.Recipe {
    id = "hc_link_sheet",
    result = "hc_link_sheet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("hc_chain_link", 2550)
    :component("hc_wire", 1)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 2)
    :book("textbook_fabrication", 2)
    :book("recipe_melee", 2)
)

-- 1kg per sheet, wire is 0.15kg, links need to cover 850g = 2550 links
content.add(content.Recipe {
    id = "ch_link_sheet",
    result = "ch_link_sheet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("ch_chain_link", 2550)
    :component("ch_wire", 1)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 2)
    :book("textbook_fabrication", 2)
    :book("recipe_melee", 2)
)

-- 1kg per sheet, wire is 0.15kg, links need to cover 850g = 2550 links
content.add(content.Recipe {
    id = "qt_link_sheet",
    result = "qt_link_sheet",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("qt_chain_link", 2550)
    :component("qt_wire", 1)
    :requirement("chainmail_standard", 1)
    :book("textbook_armwest", 2)
    :book("textbook_fabrication", 2)
    :book("recipe_melee", 2)
)

content.add(content.Recipe {
    id = "metal_butcher_rack",
    result = "metal_butcher_rack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("scrap", 6)
    :component_any({
            { id = "pipe", count = 18 },
            { id = "cu_pipe", count = 18 },
            { id = "frame", count = 3 }
        })
    :component("nails", 12, true)
    :component_any({
            { id = "any_wire", count = 6, requirement = true },
            { id = "rope_6", count = 6 },
            { id = "vine_6", count = 6 },
            { id = "rope_makeshift_6", count = 6 }
        })
    :component_any({
            { id = "chain", count = 1 },
            { id = "rope_natural", count = 1, requirement = true }
        })
    :component("spike", 4)
    :component("pipe_fittings", 15)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :book("textbook_fabrication", 2)
    :book("textbook_mechanics", 3)
)

content.add(content.Recipe {
    id = "metal_smoking_rack",
    result = "metal_smoking_rack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("scrap", 6)
    :component_any({
            { id = "pipe", count = 15 },
            { id = "cu_pipe", count = 15 },
            { id = "frame", count = 2 }
        })
    :component("nails", 12, true)
    :component_any({
            { id = "any_wire", count = 6, requirement = true },
            { id = "rope_natural_short", count = 6, requirement = true }
        })
    :component("spike", 4)
    :component("pipe_fittings", 30)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :book("textbook_fabrication", 2)
    :book("textbook_mechanics", 3)
)

content.add(content.Recipe {
    id = "tourist_table",
    result = "tourist_table",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 48000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("scrap", 6)
    :component("pipe", 6)
    :component("nails", 12, true)
    :component("sheet_metal", 1)
    :component("pipe_fittings", 6)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :book("textbook_fabrication", 2)
    :book("textbook_mechanics", 3)
)

-- The quantity of leather is accurate to the weight, but keeping it below requirements guideline time. Split
-- to two recipes due to mixed materials
content.add(content.Recipe {
    id = "leather_tarp",
    result = "leather_tarp",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_leather_patchwork", 8)
    :proficiency("prof_leatherworking_basic")
    :byproduct("leather", 2)
)

-- making from pelts takes longer due to extra processing time to scrape the fur off
content.add(content.Recipe {
    id = "leather_tarp_from_pelts",
    result = "leather_tarp",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
    name = content.text("%s from pelts"),
}
    :requirement("tailoring_fur_patchwork", 8)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "fiber_mat",
    result = "fiber_mat",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("plant_cordage", 6, true)
    :requirement("sewing_simple", 10)
    :proficiency("prof_basketweaving")
)

-- Strong acid handling requires at least basic chemistry knowledge.
content.add(content.Recipe {
    id = "platinum_grille",
    result = "platinum_grille",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 10)
    :tool_charges("surface_heat", 10, true)
    :component("steel_grille", 1)
    :component("platinum_small", 1)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("any_strong_acid", 1, true)
    :quality("HAMMER", 3, 1)
    :book("textbook_chemistry", 4)
    :book("textbook_fabrication", 4)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "steel_grille",
    result = "steel_grille",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "wooden_bead",
    result = "wooden_bead",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("splinter", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "anvil_crude",
    result = "anvil_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("angle_grinder", 220)
    :tool_charges("drill_press_tool", 20)
    :component("railroad_track_item_half", 1)
    :quality("HAMMER", 2, 1)
    :quality("CHISEL", 3, 1)
    :quality("GRIND", 2, 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing")
    :byproduct("mc_steel_lump", 15)
)

-- Traditional casting method for making a small anvil. Requires significant metal and careful mold
-- preparation.
content.add(content.Recipe {
    id = "anvil_crude_cast",
    result = "anvil_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2880000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 100 },
            { id = "oxy_torch", charges = 100 }
        })
    :tool_any({
            { id = "casting_mold", count = 1 },
            { id = "casting_mold_small", count = 1 }
        })
    :component_any({
            { id = "steel_lump_any", count = 17, requirement = true },
            { id = "steel_chunk_any", count = 68, requirement = true },
            { id = "scrap", count = 340 }
        })
    :quality("HAMMER", 2, 1)
    :quality("CHISEL", 2, 1)
    :learn_automatically("fabrication", 6)
    :book("textbook_fabrication", 4)
    :book("manual_fabrication", 4)
    :book("metal_casting_book", 3)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

-- Traditional forging method - hammer welding multiple steel pieces together to form a solid anvil. Very
-- labor intensive but doesn't require casting.
content.add(content.Recipe {
    id = "anvil_crude_forged",
    result = "anvil_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 4320000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "steel_lump_any", count = 19, requirement = true },
            { id = "steel_chunk_any", count = 76, requirement = true }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_simple", 12)
    :learn_automatically("fabrication", 7)
    :book("textbook_fabrication", 5)
    :book("manual_fabrication", 5)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { required = true })
    :proficiency("prof_toolsmithing")
)

-- Compared to a railroad tie, the right piece of equipment will often need a lot less modification, so this
-- is a quicker recipe.
content.add(content.Recipe {
    id = "anvil_scavenged",
    result = "anvil_scavenged",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("angle_grinder", 220)
    :component_any({
            { id = "hdframe", count = 1 },
            { id = "frame", count = 1 },
            { id = "engine_block_large", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("GRIND", 2, 1)
    :quality("WRENCH", 2, 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing")
    :byproduct("lc_steel_lump", 15)
)

content.add(content.Recipe {
    id = "anvil_bronze",
    result = "anvil_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap_bronze", 90)
    :quality("HAMMER", 1, 1)
    :quality("DIG", 2, 1)
    :requirement("forging_standard", 45)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "anvil_stump",
    result = "anvil_stump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("log", 1)
    :component("sheet_metal_small", 1)
    :component("spike", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_W", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("steel_lump_any_steel", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :byproduct("splinter", 5)
)

content.add(content.Recipe {
    id = "pet_carrier_wooden",
    result = "pet_carrier_wooden",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 4)
    :component("nails", 20, true)
    :component("hinge", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
)

content.add(content.Recipe {
    id = "razor_shaving",
    result = "razor_shaving",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("razor_blade", 1)
    :component("plastic_chunk", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "funnel_separation",
    result = "funnel_separation",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
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
    :tool_charges("forge", 75)
    :component_any({
            { id = "glass_shard", count = 3 },
            { id = "pipe_glass", count = 1 },
            { id = "flask_glass", count = 3 },
            { id = "test_tube", count = 6 },
            { id = "marble", count = 75 }
        })
    :component("stopcock", 1)
    :quality("CHISEL", 3, 1)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "training_dummy_light",
    result = "training_dummy_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("wood_panel", 1)
    :component("2x4", 2)
    :component("nails", 30, true)
    :component_any({
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 50 },
            { id = "paint", count = 1, requirement = true }
        })
    :component_any({
            { id = "2x4", count = 4 },
            { id = "log", count = 1 },
            { id = "wood_beam", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :requirement("marking_hard", 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "training_dummy_heavy",
    result = "training_dummy_heavy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("training_dummy_light", 1)
    :component_any({
            { id = "duct_tape", count = 50 },
            { id = "cordage", count = 2, requirement = true }
        })
    :component("scrap", 150)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "propane_cooker",
    result = "propane_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("propane_lantern", 1)
    :component("pilot_light", 1)
    :component("metal_tank_little", 1)
    :component("duct_tape", 50)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
)

content.add(content.Recipe {
    id = "biogas_cooker",
    result = "biogas_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("propane_cooker", 1)
)

content.add(content.Recipe {
    id = "gas_forge",
    result = "gas_forge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "propane_lantern", count = 3 },
            { id = "propane_cooker", count = 2 }
        })
    :component("pilot_light", 1)
    :component("scrap", 10)
    :component("brick", 8)
    :book("textbook_fabrication", 4)
    :book("textbook_weapeast", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
)

content.add(content.Recipe {
    id = "acetylene_cooker",
    result = "acetylene_cooker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("oxylamp", 1)
    :component("pilot_light", 1)
    :component("metal_tank_little", 1)
    :component("duct_tape", 50)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
)

content.add(content.Recipe {
    id = "oil_press_manual",
    result = "oil_press_manual",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 }
        })
    :component("hotplate", 1)
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("pipe", 1)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :book("manual_fabrication", 2)
    :book("textbook_fabrication", 2)
)

content.add(content.Recipe {
    id = "oil_press_primitive",
    result = "oil_press_primitive",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 }
        })
    :component("oil_cooker", 1)
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("2x4", 20)
    :component("nails", 30, true)
    :component("stick_long", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("FILE", 1, 1)
    :requirement("waterproofing", 1)
)

content.add(content.Recipe {
    id = "archery_target_box",
    result = "archery_target_box",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("box_medium", 1)
    :requirement("fabric_standard", 200)
    :requirement("marking_hard", 1)
)

content.add(content.Recipe {
    id = "target_spinner",
    result = "target_spinner",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "mil_plate", count = 1 },
            { id = "hard_plate", count = 1 },
            { id = "alloy_plate", count = 1 }
        })
    :component_any({
            { id = "mil_plate", count = 1 },
            { id = "hard_plate", count = 1 },
            { id = "alloy_plate", count = 1 },
            { id = "steel_plate", count = 1 },
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "sheet_metal", count = 1 }
        })
    :component("pipe", 8)
    :component("nuts_bolts", 30)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 3, 1)
    :quality("WRENCH", 2, 1)
)

content.add(content.Recipe {
    id = "welding_kit",
    result = "welding_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("welder", 1)
    :component_any({
            { id = "welding_blanket", count = 1 },
            { id = "makeshift_welding_blanket", count = 1 }
        })
)

content.add(content.Recipe {
    id = "pot_aluminum",
    result = "pot_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "can_medium", count = 1 },
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 10)
    :component_any({
            { id = "scrap_aluminum", count = 5 },
            { id = "material_aluminium_ingot", count = 1 }
        })
    :quality("HAMMER", 3, 1)
)

-- Small metal wheels of this size and type aren't used anywhere else, so forged for the recipe with the
-- pipes as axles + mounting and small metal sheets for housing.
-- 80 cm weld
content.add(content.Recipe {
    id = "block_and_tackle",
    result = "block_and_tackle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :component("pipe", 2)
    :component("grip_hook", 1)
    :component("sheet_metal_small", 8)
    :quality("SAW_M", 2, 1)
    :requirement("steel_standard", 2)
    :requirement("welding_standard", 80)
    :requirement("blacksmithing_standard", 8)
    :requires_skill("mechanics", 2)
    :book("textbook_fabrication", 2)
    :book("textbook_mechanics", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :proficiency("prof_blacksmithing")
)

-- 2 carved wheels, housing nailed together and wood axles.
content.add(content.Recipe {
    id = "block_and_tackle_wood",
    result = "block_and_tackle_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 2)
    :component("nails", 10, true)
    :component("stick", 1)
    :quality("SAW_W", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :requires_skill("mechanics", 1)
    :book("textbook_fabrication", 2)
    :book("textbook_mechanics", 1)
    :proficiency("prof_carving")
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "leather_bellow_from_sheets",
    result = "leather_bellow",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("2x4", 2)
    :component("nails", 12, true)
    :component_any({
            { id = "sheet_leather_patchwork", count = 2 },
            { id = "tanned_hide", count = 2 },
            { id = "sheet_fur_patchwork", count = 2 },
            { id = "tanned_pelt", count = 2 }
        })
    :requirement("sewing_standard", 10)
    :requires_skill("survival", 1)
    :proficiency("prof_leatherworking_basic")
    :byproduct("splinter", 6)
    :byproduct("scrap_leather", 5)
)

content.add(content.Recipe {
    id = "fanning_mill",
    result = "fanning_mill",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component("wood_panel", 4)
    :component("2x4", 16)
    :component_any({
            { id = "sieve_primitive", count = 1 },
            { id = "sieve_steel", count = 1 }
        })
    :component_any({
            { id = "wood_panel", count = 1 },
            { id = "sheet_metal", count = 1 }
        })
    :component("nails", 40, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 3)
    :book("reference_fabrication1", 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "seaweed_pile",
    result = "seaweed_pile",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("seaweed", 20)
)

content.add(content.Recipe {
    id = "dry_seaweed_pile",
    result = "dry_seaweed_pile",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("dry_seaweed", 20)
)

content.add(content.Recipe {
    id = "butterfly_net_makeshift",
    result = "butterfly_net_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("stick", 1)
    :component_any({
            { id = "sheet_canvas", count = 1 },
            { id = "sheet_canvas_patchwork", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :byproduct("splinter", 8)
)

content.add(content.Recipe {
    id = "razor_blade_taped",
    result = "razor_blade_taped",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = false,
    skill = "survival",
    difficulty = 0,
}
    :component("razor_blade", 1)
    :component_any({
            { id = "duct_tape", count = 5 },
            { id = "medical_tape", count = 10 }
        })
)

content.add(content.Recipe {
    id = "discharging_battery",
    result = "discharging_battery",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("small_storage_battery", 1)
    :component("salt_water", 2)
    :quality("CHEM", 1, 1)
)
