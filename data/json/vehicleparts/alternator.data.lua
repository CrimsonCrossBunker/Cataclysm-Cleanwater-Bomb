local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "vehicle_alternator",
    fuel_type = "battery",
    color = "yellow",
    broken_color = "red",
    categories = { "energy" },
    flags = { "ALTERNATOR" },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

-- 3.0 A @ 12 VDC ~ 0.1 HP drain @ 48% efficiency
ccb.content.define_vehicle_part {
    id = "alternator_bicycle",
    copy_from = "vehicle_alternator",
    item = "alternator_bicycle",
    description = ccb.content.text("A very lightweight alternator used to power a bicycle's headlights."),
    looks_like = "alternator_motorbike",
    durability = 250,
    power = "-12 W",
    epower = "6 W",
    damage_modifier = 80,
    folded_volume = "133 ml",
    breaks_into = { { item = "scrap_aluminum", count = { 1, 4 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "vehicle_screw", 1 } },
        },
    },
    damage_reduction = { all = 12 },
}

-- 30 A @ 12 VDC ~ 1 HP drain @ 48% efficiency
ccb.content.define_vehicle_part {
    id = "alternator_motorbike",
    copy_from = "vehicle_alternator",
    item = "alternator_motorbike",
    description = ccb.content.text("A compact, lightweight alternator used to power small vehicle electrical systems."),
    durability = 250,
    power = "-746 W",
    epower = "360 W",
    damage_modifier = 80,
    folded_volume = "1250 ml",
    breaks_into = {
        { item = "mc_steel_lump", count = { 2, 5 } },
        { item = "mc_steel_chunk", count = { 2, 5 } },
        { item = "scrap", count = { 2, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 }, { "vehicle_screw", 1 } },
        },
    },
    damage_reduction = { all = 12 },
}

-- 65 A @ 12 VDC ~ 2 HP drain @ 52% efficiency
-- 20 cm weld to repair per damage quadrant
ccb.content.define_vehicle_part {
    id = "alternator_car",
    copy_from = "vehicle_alternator",
    item = "alternator_car",
    description = ccb.content.text("A standard alternator used to power vehicle electrical systems."),
    durability = 275,
    power = "-1492 W",
    epower = "780 W",
    damage_modifier = 80,
    breaks_into = {
        { item = "mc_steel_lump", count = { 3, 6 } },
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "scrap", count = { 3, 6 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 2 },
                { "soldering_standard", 6 },
                { "vehicle_wrench_1", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 20 },
}

-- 110 A @ 12 VDC ~ 3 HP drain @ 60% efficiency
-- 20 cm weld to repair per damage quadrant
ccb.content.define_vehicle_part {
    id = "alternator_truck",
    copy_from = "vehicle_alternator",
    item = "alternator_truck",
    description = ccb.content.text("A larger and more powerful alternator used to power vehicle electrical systems."),
    durability = 325,
    power = "-2238 W",
    epower = "1320 W",
    damage_modifier = 80,
    breaks_into = {
        { item = "mc_steel_lump", count = { 4, 7 } },
        { item = "mc_steel_chunk", count = { 4, 7 } },
        { item = "scrap", count = { 4, 7 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 2 },
                { "soldering_standard", 10 },
                { "vehicle_wrench_1", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 20 },
}
