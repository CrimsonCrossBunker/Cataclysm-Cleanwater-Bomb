local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

-- 100cm weld
content.add(content.Recipe {
    id = "cantilever_medium",
    result = "cantilever_medium",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 5,
}
    :component("pipe", 32)
    :component("chain", 1)
    :component("pipe_fittings", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("welding_standard", 100)
    :requirement("steel_standard", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_fabrication", 6)
    :book("textbook_mechanics", 5)
)

-- 50cm weld
content.add(content.Recipe {
    id = "cantilever_small",
    result = "cantilever_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 2,
}
    :component("pipe", 8)
    :component("any_wire", 8, true)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 50)
    :requirement("steel_chunk_any", 2)
    :requires_skill("fabrication", 2)
    :book("textbook_fabrication", 4)
    :book("textbook_mechanics", 2)
    :book("manual_mechanics", 2)
)

-- 40cm weld
content.add(content.Recipe {
    id = "pallet_lifter",
    result = "pallet_lifter",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("jack", 1)
    :component("pipe", 4)
    :component("pipe_fittings", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 40)
    :requirement("steel_chunk_any", 2)
    :requires_skill("fabrication", 2)
)

content.add(content.Recipe {
    id = "drivebelt_makeshift",
    result = "drivebelt_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "leather_belt", count = 1 },
            { id = "rope_superior_short", count = 1, requirement = true }
        })
    :component("duct_tape", 20)
    :quality("CUT", 2, 1)
    :book("mag_fieldrepair", 1)
)

content.add(content.Recipe {
    id = "filter_air_makeshift",
    result = "filter_air_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 2,
}
    :component("plastic_bottles_any", 1, true)
    :component("paper", 50)
    :component("duct_tape", 20)
    :quality("CUT", 2, 1)
    :book("mag_fieldrepair", 2)
)

content.add(content.Recipe {
    id = "filter_liquid_makeshift",
    result = "filter_liquid_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :component("paper", 50)
    :component("duct_tape", 20)
    :quality("CUT", 2, 1)
    :book("mag_fieldrepair", 2)
)

content.add(content.Recipe {
    id = "cargo_lock",
    result = "cargo_lock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 24000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component_any({
            { id = "sheet_metal", count = 1 },
            { id = "steel_standard", count = 1, requirement = true }
        })
    :component_any({
            { id = "clockworks", count = 2 },
            { id = "lock", count = 1 }
        })
    :quality("HAMMER_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requires_skill("traps", 1)
)

content.add(content.Recipe {
    id = "door_lock",
    result = "door_lock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("steel_standard", 1, true)
    :component("clockworks", 2)
    :component_any({
            { id = "clockworks", count = 2 },
            { id = "lock", count = 1 }
        })
    :component("any_wire", 1, true)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requires_skill("traps", 2)
)

-- 300cm weld
content.add(content.Recipe {
    id = "livestock_carrier",
    result = "livestock_carrier",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("frame", 4)
    :component("pipe", 11)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("rope_natural", 4)
    :requirement("welding_standard", 300)
    :requirement("steel_standard", 2)
    :requires_skill("mechanics", 1)
)

-- 80cm weld
content.add(content.Recipe {
    id = "livestock_carrier_repurpose_cargo_rack",
    result = "livestock_carrier",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 12)
    :component("cargo_rack", 1)
    :component("pipe_fittings", 6)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 80)
    :requirement("steel_standard", 1)
    :requires_skill("mechanics", 1)
)

-- 60cm weld
content.add(content.Recipe {
    id = "animal_locker",
    result = "animal_locker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("any_wire", 40, true)
    :component("pipe", 6)
    :component("pipe_fittings", 3)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("rope_natural", 2)
    :requirement("welding_standard", 60)
    :requires_skill("mechanics", 1)
)

-- 30cm weld
content.add(content.Recipe {
    id = "animal_locker_repurpose_wire_basket",
    result = "animal_locker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 6)
    :component("basket", 1)
    :component("pipe_fittings", 3)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 30)
    :requires_skill("mechanics", 1)
)
