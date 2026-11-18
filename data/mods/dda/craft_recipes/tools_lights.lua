local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "candle",
    result = "candle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
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
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 20, requirement = true },
            { id = "edible_tallow", count = 20, requirement = true }
        })
    :component("cordage_short", 1, true)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "reading_light",
    result = "reading_light",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("plastic_chunk", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component_any({
            { id = "light_bulb", count = 1 },
            { id = "e_scrap", count = 1 }
        })
    :quality("SCREW", 1, 1)
    :requirement("glue_any", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 3)
    :book("advanced_electronics", 3)
)

content.add(content.Recipe {
    id = "electric_lantern",
    result = "electric_lantern",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 3)
    :component("plastic_chunk", 2)
    :component("circuit", 2)
    :component("e_scrap", 2)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 7)
    :book("manual_electronics", 3)
    :book("mag_electronics", 4)
    :book("textbook_electronics", 2)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "flashlight",
    result = "flashlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("amplifier", 1)
    :component_any({
            { id = "scrap_aluminum", count = 4 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "bottle_glass", count = 1 },
            { id = "plastic_bottles_any", count = 1, requirement = true }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("cable", 4)
    :learn_by_disassembly("electronics", 0)
    :book("manual_electronics", 0)
    :book("mag_electronics", 1)
)

content.add(content.Recipe {
    id = "floodlight",
    result = "floodlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("amplifier", 4)
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "scrap", count = 6 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 4 },
            { id = "light_bulb", count = 4 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :book("manual_electronics", 1)
    :book("mag_electronics", 2)
)

content.add(content.Recipe {
    id = "directed_floodlight",
    result = "directed_floodlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("amplifier", 4)
    :component_any({
            { id = "steel_chunk_any", count = 2, requirement = true },
            { id = "scrap", count = 6 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 4 },
            { id = "light_bulb", count = 4 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :book("manual_electronics", 1)
    :book("mag_electronics", 2)
)

content.add(content.Recipe {
    id = "car_headlight",
    result = "car_headlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("amplifier", 2)
    :component_any({
            { id = "plastic_chunk", count = 2 },
            { id = "scrap", count = 3 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 2 },
            { id = "light_bulb", count = 2 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :book("manual_electronics", 1)
    :book("mag_electronics", 2)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "car_wide_headlight",
    result = "car_wide_headlight",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("amplifier", 3)
    :component_any({
            { id = "plastic_chunk", count = 3 },
            { id = "scrap", count = 4 }
        })
    :component_any({
            { id = "lightstrip_inactive", count = 3 },
            { id = "light_bulb", count = 3 }
        })
    :component("cable", 4)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 1)
    :book("manual_electronics", 1)
    :book("mag_electronics", 2)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "wearable_light",
    result = "wearable_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("flashlight", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "leather", count = 2 },
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :quality("CUT", 2, 1)
    :book("textbook_fabrication", 0)
    :book("manual_fabrication", 0)
    :book("mag_electronics", 0)
)

content.add(content.Recipe {
    id = "wearable_big_light",
    result = "wearable_big_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("heavy_flashlight", 1)
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "leather", count = 4 },
            { id = "duct_tape", count = 20 },
            { id = "medical_tape", count = 40 },
            { id = "cordage", count = 1, requirement = true }
        })
    :quality("CUT", 2, 1)
    :book("textbook_fabrication", 0)
    :book("manual_fabrication", 0)
    :book("mag_electronics", 0)
)

content.add(content.Recipe {
    id = "oil_lamp",
    result = "oil_lamp",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "cordage_superior_short", count = 1, requirement = true }
        })
    :component_any({
            { id = "bottle_glass", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "jar_glass_sealed", count = 1 }
        })
    :component_any({
            { id = "clay_teapot", count = 1 },
            { id = "jug_clay", count = 1 },
            { id = "can_food", count = 1 },
            { id = "can_drink", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "oil_lamp_clay",
    result = "oil_lamp_clay",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("clay_lump", 3)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "cordage_superior_short", count = 1, requirement = true }
        })
    :requirement("earthenware_firing", 70)
    :requires_skill("survival", 1)
    :proficiency("prof_pottery")
)

content.add(content.Recipe {
    id = "gasoline_lantern",
    result = "gasoline_lantern",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "cordage_superior_short", count = 1, requirement = true }
        })
    :component_any({
            { id = "bottle_glass", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "jar_glass_sealed", count = 1 }
        })
    :component_any({
            { id = "clay_teapot", count = 1 },
            { id = "jug_clay", count = 1 },
            { id = "can_food", count = 1 },
            { id = "can_drink", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "propane_lantern",
    result = "propane_lantern",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap", 2)
    :component("pipe", 2)
    :component("pipe_fittings", 4)
    :component("pilot_light", 1)
    :quality("WRENCH", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 50)
    :requires_skill("mechanics", 3)
    :book("textbook_fabrication", 6)
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

-- 25cm weld
content.add(content.Recipe {
    id = "headlight_reinforced",
    result = "headlight_reinforced",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 270000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("car_headlight", 1)
    :component_any({
            { id = "mc_wire", count = 2 },
            { id = "hc_wire", count = 2 },
            { id = "ch_wire", count = 2 },
            { id = "qt_wire", count = 2 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 25)
    :requirement("glue_strong", 10)
    :book("textbook_fabrication", 3)
    :book("textbook_mechanics", 3)
    :book("welding_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

-- 25cm weld
content.add(content.Recipe {
    id = "wide_headlight_reinforced",
    result = "wide_headlight_reinforced",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("car_wide_headlight", 1)
    :component_any({
            { id = "mc_wire", count = 3 },
            { id = "hc_wire", count = 3 },
            { id = "ch_wire", count = 3 },
            { id = "qt_wire", count = 3 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 25)
    :requirement("glue_strong", 15)
    :book("textbook_fabrication", 3)
    :book("textbook_mechanics", 3)
    :book("welding_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)
