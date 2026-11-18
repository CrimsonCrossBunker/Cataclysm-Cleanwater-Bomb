local content = require("ccb").content

local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "hatchet",
    result = "hatchet",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
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
    :requirement("steel_standard", 1)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "diveknife",
    result = "diveknife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "plastic_chunk", count = 2 },
            { id = "scrap", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 2)
    :book("manual_knives", 5)
    :book("recipe_melee", 6)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.25, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "scythe",
    result = "scythe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :requirement("metal_punch", 1)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "pockknife",
    result = "pockknife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1560000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("plastic_chunk", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("manual_knives", 3)
    :book("recipe_melee", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "knife_small_knife_steak",
    result = "knife_small",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    variant = "knife_steak",
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_huge_knife_butcher",
    result = "knife_huge",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "knife_butcher",
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "knife_hunting",
    result = "knife_hunting",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2340000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
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
    :book("manual_knives", 3)
    :book("recipe_melee", 4)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "brush_handaxe_from_scratch",
    result = "brush_handaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "brush_handaxe_from_brush_axe",
    result = "brush_handaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 0,
}
    :component("brush_axe", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("2x4", 1)
)

content.add(content.Recipe {
    id = "brush_handaxe_from_brush_pole",
    result = "brush_handaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 0,
}
    :component("brush_pole", 1)
    :quality("SAW_W", 2, 1)
    :byproduct("stick_long", 1)
)

content.add(content.Recipe {
    id = "brush_axe_from_scratch",
    result = "brush_axe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
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
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3.0 })
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "brush_axe_from_bill",
    result = "brush_axe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("brush_handaxe", 1)
    :component("nails", 4, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("DRILL", 2, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
    :byproduct("splinter", 1)
)

content.add(content.Recipe {
    id = "brush_pole_from_scratch",
    result = "brush_pole",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2760000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
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
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "brush_pole_from_bill",
    result = "brush_pole",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("brush_handaxe", 1)
    :component("nails", 4, true)
    :component("stick_long", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :quality("DRILL", 2, 1)
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0 })
    :byproduct("splinter", 3)
)

content.add(content.Recipe {
    id = "bronze_brush_handaxe",
    result = "bronze_brush_handaxe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("scrap_bronze", 10)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "bronze_brush_axe",
    result = "bronze_brush_axe",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("scrap_bronze", 10)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.add(content.Recipe {
    id = "bronze_brush_pole",
    result = "bronze_brush_pole",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true }
        })
    :component("scrap_bronze", 10)
    :component("stick_long", 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)
