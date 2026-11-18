local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "battery_car_assembly",
    result = "battery_car_assembly",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("battery_car", 6)
    :component("processor", 2)
    :component("e_scrap", 12)
    :component("scrap", 8)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 60)
    :requires_skill("fabrication", 4)
    :learn_by_disassembly("electronics", 3)
    :book("manual_mechanics", 5)
    :book("textbook_mechanics", 5)
    :book("advanced_electronics", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)
