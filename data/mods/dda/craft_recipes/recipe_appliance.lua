local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "apartment_fridge",
    result = "apartment_fridge",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 20)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("cable", 1)
    :component("hose", 1)
    :component("pipe_fittings", 6)
    :component("thermostat", 1)
    :component("motor_tiny", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair", { required = false, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "glass_fridge",
    result = "glass_fridge",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 15)
    :component("glass_sheet", 1)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("cable", 1)
    :component("hose", 1)
    :component("pipe_fittings", 6)
    :component("thermostat", 1)
    :component("motor_tiny", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair", { required = false, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "apartment_freezer",
    result = "apartment_freezer",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 20)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("cable", 1)
    :component("hose", 1)
    :component("pipe_fittings", 6)
    :component("thermostat", 1)
    :component("motor_tiny", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair", { required = false, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "wall_light",
    result = "wall_light",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("amplifier", 1)
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("steel_chunk_any", 1, true)
    :component("scrap", 3)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "standing_lamp",
    result = "standing_lamp",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("amplifier", 1)
    :component_any({
            { id = "lightstrip_inactive", count = 1 },
            { id = "light_bulb", count = 1 }
        })
    :component("steel_lump_any", 1, true)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "standing_floodlight",
    result = "standing_floodlight",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("amplifier", 1)
    :component("floodlight", 1)
    :component("steel_lump_any", 1, true)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "standing_directed_floodlight",
    result = "standing_directed_floodlight",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_LIGHTING",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("cable", 1)
    :component("amplifier", 1)
    :component("directed_floodlight", 1)
    :component("steel_lump_any", 1, true)
    :component("pipe_fittings", 1)
    :component("pipe", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_automatically("electronics", 1)
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "foot_locker_recharge_station",
    result = "foot_locker_recharge_station",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("frame", 1)
    :component("recharge_station", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("electronics", 2)
    :learn_automatically("electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "box_battery_charger",
    result = "box_battery_charger",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("frame_wood", 1)
    :component("battery_charger", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("electronics", 1)
    :learn_automatically("electronics", 1)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "oil_press_electric",
    result = "oil_press_electric",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component("frame", 1)
    :component("sheet_metal", 4)
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 6 }
        })
    :component("motor_tiny", 1)
    :component("cable", 4)
    :component("power_supply", 1)
    :component("pipe_fittings", 2)
    :component("pipe", 2)
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component_any({
            { id = "metal_tank_little", count = 1 },
            { id = "jerrycan_big", count = 1 },
            { id = "jerrycan", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("electronics", 2)
)

content.add(content.Recipe {
    id = "electric_cooker",
    result = "electric_cooker",
    category = "CC_APPLIANCE",
    subcategory = "CSC_APPLIANCE_UTILITY",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "element", count = 16 },
            { id = "crude_heating_element", count = 24 }
        })
    :component("cable", 40)
    :component("nail", 10)
    :component("sheet_metal", 6)
    :component("power_supply", 1)
    :component("solder_wire", 50)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 200)
    :requirement("steel_standard", 4)
    :proficiency("prof_appliance_repair")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)
