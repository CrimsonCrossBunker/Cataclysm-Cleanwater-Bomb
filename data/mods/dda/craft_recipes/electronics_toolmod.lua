local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "battery_ups",
    result = "battery_ups",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("power_supply", 1)
    :component("scrap", 4)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 24)
    :learn_by_disassembly("electronics", 4)
    :book("manual_electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_lab_elec", 3)
    :book("textbook_anarch", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "battery_bionic",
    result = "battery_bionic",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("power_supply", 1)
    :component("exodii_wire_kit", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 24)
    :learn_by_disassembly("electronics", 4)
    :book("exodii_wiring_kit_reference", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "magazine_battery_mod",
    result = "magazine_battery_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("power_supply", 1)
    :component("scrap", 4)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :learn_by_disassembly("electronics", 2)
    :learn_automatically("electronics", 4)
    :learn_automatically("mechanics", 2)
    :book("manual_electronics", 3)
    :book("advanced_electronics", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "magazine_battery_light_mod",
    result = "magazine_battery_light_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 4)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("electronics", 3)
    :learn_by_disassembly("fabrication", 2)
    :book("manual_electronics", 2)
    :book("advanced_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "magazine_battery_medium_mod",
    result = "magazine_battery_medium_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 6)
    :component("cable", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 3)
    :learn_by_disassembly("fabrication", 2)
    :book("manual_electronics", 2)
    :book("advanced_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "magazine_battery_heavy_mod",
    result = "magazine_battery_heavy_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 8)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("electronics", 3)
    :learn_by_disassembly("fabrication", 2)
    :book("manual_electronics", 2)
    :book("advanced_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "heavy_battery_cell",
    result = "heavy_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("medium_battery_cell", 5)
    :component("scrap", 4)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "heavy_plus_battery_cell",
    result = "heavy_plus_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("medium_battery_cell", 10)
    :component("scrap", 4)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)
