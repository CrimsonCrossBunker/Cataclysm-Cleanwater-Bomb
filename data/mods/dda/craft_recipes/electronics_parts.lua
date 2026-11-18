local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "battery_car",
    result = "battery_car",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("scrap", 4)
    :component("lead", 2400)
    :component("chem_sulphuric_acid", 13)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 20)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "battery_motorbike",
    result = "battery_motorbike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("scrap", 1)
    :component("lead", 360)
    :component("chem_sulphuric_acid", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 4)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "heavy_atomic_battery_cell",
    result = "heavy_atomic_battery_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("scrap", 6)
    :component("cable", 2)
    :component("plut_cell", 20)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 4)
    :book("recipe_atomic_battery", 6)
)

content.add(content.Recipe {
    id = "solder_wire",
    result = "solder_wire",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 1,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("swage", 1)
    :tool_any({
            { id = "surface_heat", charges = 1, requirement = true },
            { id = "forge", charges = 1 },
            { id = "oxy_torch", charges = 1 }
        })
    :component_any({
            { id = "lead", count = 15 },
            { id = "bismuth", count = 25 }
        })
    :component("tin", 25)
    :component("rosin", 2)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :requirement("surface_heat", 50)
    :requires_skill("fabrication", 1)
    :batch_discount(70, 5)
    :result_charges(50)
)
