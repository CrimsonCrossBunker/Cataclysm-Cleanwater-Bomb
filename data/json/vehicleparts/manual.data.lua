local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "engine_manual",
    location = "engine_block",
    categories = { "movement", "operations" },
    fuel_type = "muscle",
    broken_color = "red",
    damage_modifier = 50,
    noise_factor = 5,
    m2c = 45,
    engine_exclusions = { "manual" },
    flags = { "ENGINE", "E_STARTS_INSTANTLY", "E_ALTERNATOR" },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "foot_pedals",
    copy_from = "engine_manual",
    item = "foot_crank",
    durability = 50,
    power = "360 W",
    description = ccb.content.text("A set of bicycle-style foot pedals attached to a crank.  If mounted on the same tile as a seat, they allow you to use your stamina to produce engine power, using your legs.  Provides more power the stronger you are."),
    muscle_power_factor = 60,
    folded_volume = "500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 0 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    breaks_into = { { item = "mc_steel_chunk", count = { 1, 2 } }, { item = "scrap", count = { 0, 2 } } },
    extend = { flags = { "MUSCLE_LEGS", "CONTROLS" } },
    damage_reduction = { all = 4 },
}

ccb.content.define_vehicle_part {
    id = "hand_rims",
    copy_from = "engine_manual",
    name = ccb.content.text("hand rims"),
    item = "hand_rims",
    durability = 50,
    description = ccb.content.text("A set of wheelchair-style hoop hand rims, often attached directly to the wheels.  If mounted on the same tile as seat, they allow you to use your stamina to produce engine power, using your arms.  Provides more power the stronger you are."),
    power = "240 W",
    muscle_power_factor = 40,
    folded_volume = "500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 0 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    breaks_into = { { item = "mc_steel_chunk", count = { 1, 2 } }, { item = "scrap", count = { 0, 2 } } },
    extend = { flags = { "MUSCLE_ARMS", "CONTROLS" } },
    damage_reduction = { all = 4 },
}

ccb.content.define_vehicle_part {
    id = "hand_paddles",
    copy_from = "engine_manual",
    durability = 50,
    power = "720 W",
    muscle_power_factor = 40,
    noise_factor = 8,
    item = "hand_paddles",
    folded_volume = "500 ml",
    requirements = {
        install = { skills = { { "fabrication", 1 } }, duration = "6 m" },
        removal = { skills = { { "fabrication", 2 } }, duration = "6 m" },
        repair = { skills = { { "fabrication", 2 } }, duration = "60 m" },
    },
    flags = { "ENGINE", "CONTROLS", "MUSCLE_ARMS", "E_STARTS_INSTANTLY" },
    breaks_into = { { item = "splinter", count = { 2, 4 } } },
    damage_reduction = { all = 5 },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "reins_tackle",
    categories = { "operations" },
    description = ccb.content.text("A set of leather bindings to control a mountable creature."),
    broken_color = "red",
    durability = 80,
    bonus = 10,
    damage_modifier = 5,
    item = "reins_tackle",
    folded_volume = "250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "3 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CONTROL_ANIMAL" },
    breaks_into = { { item = "leather", count = { 1, 2 } } },
    variants = { { symbols = "W", broken_symbols = "X" } },
}
