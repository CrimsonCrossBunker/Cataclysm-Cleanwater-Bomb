local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "right_arm_prosthetic_wood_old",
    result = "right_arm_prosthetic_wood_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("nail", 16)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "cotton_ball", count = 4 },
            { id = "straw_pile", count = 2 },
            { id = "withered", count = 7 },
            { id = "pine_bough", count = 5 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SEW", 2, 1)
    :requirement("armor_wood", 3)
    :requirement("fabric_standard", 2)
    :proficiency("prof_closures", { time_multiplier = 1.1, skill_penalty = 0.1 })
    :proficiency("prof_carving", { time_multiplier = 1.5 })
    :proficiency("prof_carpentry_basic", { time_multiplier = 1.2 })
)

content.add(content.Recipe {
    id = "left_arm_prosthetic_wood_old",
    result = "left_arm_prosthetic_wood_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("nail", 16)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "cotton_ball", count = 4 },
            { id = "straw_pile", count = 2 },
            { id = "withered", count = 7 },
            { id = "pine_bough", count = 5 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SEW", 2, 1)
    :requirement("armor_wood", 3)
    :requirement("fabric_standard", 2)
    :proficiency("prof_closures", { time_multiplier = 1.1, skill_penalty = 0.1 })
    :proficiency("prof_carving", { time_multiplier = 1.5 })
    :proficiency("prof_carpentry_basic", { time_multiplier = 1.2 })
)

-- 1.71 time and material increase, based on light plate arm guards.
content.add(content.Recipe {
    id = "right_arm_prosthetic_steel_old",
    result = "right_arm_prosthetic_steel_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9234000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 14)
    :requirement("steel_standard", 3)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

-- 1.71 time and material increase, based on light plate arm guards.
content.add(content.Recipe {
    id = "left_arm_prosthetic_steel_old",
    result = "left_arm_prosthetic_steel_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9234000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 14)
    :requirement("steel_standard", 3)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("tailor", 3)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "right_peg_leg_old",
    result = "right_peg_leg_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("nail", 20)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "cotton_ball", count = 4 },
            { id = "straw_pile", count = 2 },
            { id = "withered", count = 7 },
            { id = "pine_bough", count = 5 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SEW", 2, 1)
    :requirement("armor_wood", 4)
    :requirement("fabric_standard", 2)
    :proficiency("prof_closures", { time_multiplier = 1.1, skill_penalty = 0.1 })
    :proficiency("prof_carving", { time_multiplier = 1.5 })
    :proficiency("prof_carpentry_basic", { time_multiplier = 1.2 })
)

content.add(content.Recipe {
    id = "left_peg_leg_old",
    result = "left_peg_leg_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("nail", 20)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "cotton_ball", count = 4 },
            { id = "straw_pile", count = 2 },
            { id = "withered", count = 7 },
            { id = "pine_bough", count = 5 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SEW", 2, 1)
    :requirement("armor_wood", 4)
    :requirement("fabric_standard", 2)
    :proficiency("prof_closures", { time_multiplier = 1.1, skill_penalty = 0.1 })
    :proficiency("prof_carving", { time_multiplier = 1.5 })
    :proficiency("prof_carpentry_basic", { time_multiplier = 1.2 })
)

-- 1.71 times increase in material and time, based on steel legguards.
content.add(content.Recipe {
    id = "right_leg_prosthetic_steel_old",
    result = "right_leg_prosthetic_steel_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1950000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 48)
    :requirement("steel_standard", 12)
    :requirement("strap_small", 7)
    :requirement("clasps", 7)
    :requirement("tailoring_leather", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "left_leg_prosthetic_steel_old",
    result = "left_leg_prosthetic_steel_old",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1950000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 48)
    :requirement("steel_standard", 12)
    :requirement("strap_small", 7)
    :requirement("clasps", 7)
    :requirement("tailoring_leather", 1)
    :book("textbook_armwest", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)
