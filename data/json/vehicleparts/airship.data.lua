local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "balloon",
    location = "anywhere",
    color = "light_blue",
    categories = { "movement" },
    looks_like = "inflatable_airbag",
    flags = { "PROTRUSION", "EXTENDABLE", "BALLOON", "SHOCK_IMMUNE" },
    variants = { { symbols = "|", broken_symbols = "O" } },
    description = ccb.content.text("A balloon that provides lift, but requires aircraft propellers for horizontal momentum."),
}

-- Todo: should explode if damaged or destroyed by bullets, fire, or electric damage.
ccb.content.define_vehicle_part {
    id = "airship_balloon",
    copy_from = "balloon",
    name = ccb.content.text("airship balloon"),
    item = "airship_balloon_item",
    categories = { "movement" },
    balloon_height = 30,
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
        removal = { skills = { { "mechanics", 2 } }, duration = "60 m", using_requirements = {} },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "plastics", 1 } },
        },
    },
    durability = 60,
    damage_modifier = 80,
    control = { air = { proficiencies = { "prof_airship_pilot" } } },
    breaks_into = { { item = "plastic_chunk", count = { 10, 20 } } },
    flags = { "BALLOON", "SHOCK_IMMUNE" },
    damage_reduction = { bash = 10 },
}

-- Overhead canopy acting as its own structural frame, so it can stand alone over empty tiles without a frame beneath.  Overhead flags keep it from being boarded or blocking movement.
ccb.content.define_vehicle_part {
    id = "airship_balloon_external",
    copy_from = "airship_balloon",
    name = ccb.content.text("external airship balloon"),
    location = "structure",
    categories = { "movement" },
    extend = { flags = { "EXTENDABLE", "AISLE", "ROOF", "NOCOLLIDE", "NOCOLLIDEBELOW" } },
}

ccb.content.define_vehicle_part {
    abstract = "propeller_rotors",
    location = "structure",
    color = "light_blue",
    categories = { "movement" },
    looks_like = "small_helicopter_rotor",
    broken_color = "light_gray",
    variants = { { symbols = "X", broken_symbols = "O" } },
    flags = { "PROPELLER", "PROTRUSION", "SHOCK_RESISTANT" },
    control = { air = { proficiencies = { "prof_airship_pilot" } } },
    description = ccb.content.text("A set of aerofoil propeller rotors, when spun at high speed, they generate thrust via horizontal momentum."),
}

ccb.content.define_vehicle_part {
    id = "propeller_metal",
    copy_from = "propeller_rotors",
    name = ccb.content.text("aircraft propeller"),
    item = "metal_propeller_item",
    categories = { "movement" },
    propeller_diameter = 3,
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "2 h",
            using_requirements = { { "welding_standard", 20 } },
        },
        removal = {
            skills = { { "mechanics", 6 } },
            duration = "2 h",
            using_requirements = { { "vehicle_weld_removal", 4 } },
        },
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "2 h",
            using_requirements = { { "welding_standard", 10 }, { "steel_tiny", 1 } },
        },
    },
    durability = 100,
    damage_modifier = 80,
    breaks_into = { { item = "scrap", count = { 8, 15 } }, { item = "steel_chunk", count = { 2, 8 } } },
    damage_reduction = { all = 22 },
}

ccb.content.define_vehicle_part {
    id = "propeller_wood",
    copy_from = "propeller_rotors",
    name = ccb.content.text("wooden aircraft propeller"),
    item = "wood_propeller_item",
    categories = { "movement" },
    propeller_diameter = 2,
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "2 h",
            using_requirements = { { "vehicle_nail_install", 20 } },
        },
        removal = {
            skills = { { "mechanics", 5 } },
            duration = "2 h",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "2 h",
            using_requirements = { { "nail_any_adhesive", 10 }, { "wood_structural_small", 1 } },
        },
    },
    durability = 75,
    damage_modifier = 80,
    breaks_into = { { item = "scrap", count = { 8, 15 } }, { item = "splinter", count = { 5, 10 } } },
    damage_reduction = { all = 15 },
    extend = { flags = { "FOLDABLE" } },
    folded_volume = "20 L",
    color = "brown",
}
