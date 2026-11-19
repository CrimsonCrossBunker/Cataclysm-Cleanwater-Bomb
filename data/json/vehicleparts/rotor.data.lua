local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "helicopter_rotors",
    categories = { "movement" },
    location = "on_roof",
    color = "light_blue",
    flags = { "ROTOR", "NO_INSTALL_PLAYER", "NO_REPAIR", "SMASH_REMOVE" },
    variants = { { symbols = "X", broken_symbols = "O" } },
    control = { air = { proficiencies = { "prof_helicopter_pilot" } } },
}

-- rotor diameter is in meters
ccb.content.define_vehicle_part {
    id = "heavy_duty_military_rotor",
    copy_from = "helicopter_rotors",
    item = "heavy_duty_military_rotor",
    description = ccb.content.text("A set of four rotor blades from a military attack helicopter."),
    rotor_diameter = 15,
    durability = 450,
    damage_modifier = 80,
    requirements = {
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "1 h",
            using_requirements = "vehicle_weld_removal",
        },
    },
    breaks_into = { { item = "scrap", count = { 15, 30 } }, { item = "ch_steel_chunk", count = { 8, 16 } } },
    damage_reduction = { all = 66 },
}

-- rotor diameter is in meters
ccb.content.define_vehicle_part {
    id = "small_civilian_rotors",
    copy_from = "helicopter_rotors",
    item = "small_helicopter_rotor",
    description = ccb.content.text("A set of four rotor blades from a civilian light helicopter."),
    rotor_diameter = 8,
    durability = 100,
    damage_modifier = 80,
    requirements = {
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "1 h",
            using_requirements = "vehicle_weld_removal",
        },
    },
    breaks_into = { { item = "scrap", count = { 8, 15 } }, { item = "ch_steel_chunk", count = { 2, 8 } } },
    damage_reduction = { all = 22 },
}

-- rotor diameter is in meters
ccb.content.define_vehicle_part {
    id = "heavy_duty_military_blackhawk_rotors",
    copy_from = "heavy_duty_military_rotor",
    name = ccb.content.text("heavy-duty military Blackhawk rotors"),
    rotor_diameter = 16,
}

-- rotor diameter is in meters
ccb.content.define_vehicle_part {
    id = "heavy_duty_military_osprey_rotors",
    copy_from = "heavy_duty_military_rotor",
    name = ccb.content.text("heavy-duty military Osprey rotors"),
    rotor_diameter = 11,
}
