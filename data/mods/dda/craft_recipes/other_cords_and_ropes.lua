local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "string_6",
    result = "string_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("filament", 50, true)
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "string_6_spinwheel",
    result = "string_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("filament", 50, true)
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_from_string",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "string_36", count = 6 },
            { id = "string_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_6_spinwheel_string",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "string_36", count = 6 },
            { id = "string_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_from_filament",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("filament", 1800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_6_spinwheel_filament",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("filament", 1800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_from_cloth",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "cotton_patchwork", count = 30 },
            { id = "leather", count = 30 },
            { id = "felt_patch", count = 30 },
            { id = "tanned_hide", count = 5 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_6_spinwheel_cloth",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "cotton_patchwork", count = 30 },
            { id = "leather", count = 30 },
            { id = "felt_patch", count = 30 },
            { id = "tanned_hide", count = 5 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "string_36",
    result = "string_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "string_6", count = 6 },
            { id = "filament", count = 300, requirement = true }
        })
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "string_36_spinwheel",
    result = "string_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "string_6", count = 6 },
            { id = "filament", count = 300, requirement = true }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("rope_6", 5)
    :proficiency("prof_fibers_rope", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "rope_30_spinwheel_ropes",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("rope_6", 5)
    :proficiency("prof_fibers_rope", { required = false, time_multiplier = 1.5 })
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_from_cloth",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "cotton_patchwork", count = 150 },
            { id = "leather", count = 150 },
            { id = "felt_patch", count = 150 },
            { id = "tanned_hide", count = 25 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_30_spinwheel_cloth",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "cotton_patchwork", count = 150 },
            { id = "leather", count = 150 },
            { id = "felt_patch", count = 150 },
            { id = "tanned_hide", count = 25 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_from_string",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "string_36", count = 30 },
            { id = "string_6", count = 180 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_30_spinwheel_string",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "string_36", count = 30 },
            { id = "string_6", count = 180 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_from_filament",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("filament", 10800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_30_spinwheel_filament",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("filament", 10800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_6",
    result = "cordage_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "withered", count = 1 },
            { id = "straw_pile", count = 1 },
            { id = "tanbark", count = 1 },
            { id = "willowbark", count = 1 }
        })
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "cordage_6_spinwheel_plant",
    result = "cordage_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "withered", count = 1 },
            { id = "straw_pile", count = 1 },
            { id = "tanbark", count = 1 },
            { id = "willowbark", count = 1 }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_36",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "withered", count = 6 },
            { id = "straw_pile", count = 6 },
            { id = "tanbark", count = 6 },
            { id = "willowbark", count = 6 }
        })
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "cordage_36_spinwheel_plant",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "withered", count = 6 },
            { id = "straw_pile", count = 6 },
            { id = "tanbark", count = 6 },
            { id = "willowbark", count = 6 }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_36_from_cordage_6",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("cordage_6", 6)
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "cordage_36_spinwheel_ropes",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 800,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("cordage_6", 6)
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_6_leather",
    result = "cordage_6_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("leather", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "cordage_36_leather",
    result = "cordage_36_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("cordage_6_leather", 6)
)

content.add(content.Recipe {
    id = "rope_makeshift_6",
    result = "rope_makeshift_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component_any({
            { id = "cordage_36", count = 6 },
            { id = "cordage_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_makeshift_6_spinwheel_cordages",
    result = "rope_makeshift_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "cordage_36", count = 6 },
            { id = "cordage_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_makeshift_30_from_cordage",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component_any({
            { id = "cordage_6", count = 150 },
            { id = "cordage_36", count = 30 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_makeshift_30_spinwheel_cordages",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "cordage_6", count = 150 },
            { id = "cordage_36", count = 30 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_makeshift_30_from_rope_makeshift_6",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component("rope_makeshift_6", 5)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
)

content.add(content.Recipe {
    id = "rope_makeshift_30_spinwheel_ropes",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("rope_makeshift_6", 5)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_6_electric_spinwheel_plant",
    result = "cordage_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 1)
    :component_any({
            { id = "withered", count = 1 },
            { id = "straw_pile", count = 1 },
            { id = "tanbark", count = 1 },
            { id = "willowbark", count = 1 }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "string_6_electric_spinwheel",
    result = "string_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 1)
    :component("filament", 50, true)
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_electric_spinwheel_string",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component_any({
            { id = "string_36", count = 6 },
            { id = "string_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_electric_spinwheel_filament",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 13)
    :component("filament", 1800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_6_electric_spinwheel_cloth",
    result = "rope_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 7)
    :component_any({
            { id = "cotton_patchwork", count = 30 },
            { id = "leather", count = 30 },
            { id = "felt_patch", count = 30 },
            { id = "tanned_hide", count = 5 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "string_36_electric_spinwheel",
    result = "string_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component_any({
            { id = "string_6", count = 6 },
            { id = "filament", count = 300, requirement = true }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_electric_spinwheel_ropes",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 11)
    :component("rope_6", 5)
    :proficiency("prof_fibers_rope", { required = false, time_multiplier = 1.5 })
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_electric_spinwheel_cloth",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 32)
    :component_any({
            { id = "cotton_patchwork", count = 150 },
            { id = "leather", count = 150 },
            { id = "felt_patch", count = 150 },
            { id = "tanned_hide", count = 25 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_electric_spinwheel_string",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 21)
    :component_any({
            { id = "string_36", count = 30 },
            { id = "string_6", count = 180 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_30_electric_spinwheel_filament",
    result = "rope_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 63)
    :component("filament", 10800, true)
    :proficiency("prof_fibers", { skill_penalty = 0.5 })
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_36_electric_spinwheel_plant",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component_any({
            { id = "withered", count = 6 },
            { id = "straw_pile", count = 6 },
            { id = "tanbark", count = 6 },
            { id = "willowbark", count = 6 }
        })
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "cordage_36_electric_spinwheel_ropes",
    result = "cordage_36",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 800,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 1)
    :component("cordage_6", 6)
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_makeshift_6_electric_spinwheel_cordages",
    result = "rope_makeshift_6",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component_any({
            { id = "cordage_36", count = 6 },
            { id = "cordage_6", count = 36 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_makeshift_30_electric_spinwheel_cordages",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 17)
    :component_any({
            { id = "cordage_6", count = 150 },
            { id = "cordage_36", count = 30 }
        })
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "rope_makeshift_30_electric_spinwheel_ropes",
    result = "rope_makeshift_30",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 1)
    :component("rope_makeshift_6", 5)
    :proficiency("prof_fibers")
    :proficiency("prof_fibers_rope")
    :batch_discount(70, 1)
)
