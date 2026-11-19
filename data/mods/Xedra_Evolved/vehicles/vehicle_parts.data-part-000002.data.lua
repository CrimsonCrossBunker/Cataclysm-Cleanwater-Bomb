local ccb = require("ccb")

-- Item does not matter, none of these parts are installable or uninstallable.
ccb.content.define_vehicle_part {
    id = "floralframe",
    copy_from = "frame_abstract",
    name = ccb.content.text("floral frame"),
    durability = 150,
    description = ccb.content.text("The thick part of the flower, floating on the water."),
    item = "floral_base_item",
    breaks_into = { { item = "stick", count = { 1, 4 } }, { item = "leaves", count = { 10, 20 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "9 m",
            using_requirements = { { "repair_welding_alloys", 5 } },
        },
    },
    damage_reduction = { all = 20 },
    extend = { flags = { "NO_INSTALL_HIDDEN", "NO_UNINSTALL" } },
}

ccb.content.define_vehicle_part {
    id = "floral_engine",
    copy_from = "engine_motor",
    fuel_type = "battery",
    m2c = 30,
    durability = 200,
    epower = "0 W",
    power = "43300 W",
    item = "floral_base_item",
    energy_consumption = "114300 W",
    breaks_into = { { item = "leaves", count = { 10, 20 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 60 },
    extend = { flags = { "NO_INSTALL_HIDDEN", "NO_UNINSTALL" } },
}

ccb.content.define_vehicle_part {
    id = "floral_boat_hull",
    name = ccb.content.text("floral petal"),
    description = ccb.content.text("A giant flower petal."),
    categories = { "hull" },
    color = "green",
    damage_modifier = 50,
    durability = 480,
    location = "under",
    item = "floral_base_item",
    epower = "3000 W",
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "40 m",
            using_requirements = { { "vehicle_screw", 1 }, { "drilling_standard", 40 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 3 } },
        },
    },
    flags = { "FLOATS", "SEAT", "BELTABLE", "BOARDABLE", "NO_INSTALL_HIDDEN", "NO_UNINSTALL", "SOLAR_PANEL" },
    breaks_into = { { item = "stick", count = { 1, 4 } }, { item = "leaves", count = { 10, 20 } } },
    damage_reduction = { all = 14 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "floral_controls",
    copy_from = "controls",
    name = ccb.content.text("stamen"),
    description = ccb.content.text("The central part of the flower."),
    durability = 50,
    item = "floral_base_item",
    requirements = {
        install = { skills = { { "fabrication", 1 } }, duration = "6 m" },
        removal = { skills = { { "fabrication", 2 } }, duration = "6 m" },
        repair = { skills = { { "fabrication", 2 } }, duration = "60 m" },
    },
    flags = { "CONTROLS", "NO_INSTALL_HIDDEN", "NO_UNINSTALL" },
    breaks_into = { { item = "splinter", count = { 2, 4 } } },
    damage_reduction = { all = 5 },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "floral_battery",
    copy_from = "battery_car",
    name = ccb.content.text("solar power"),
    item = "floral_battery",
    durability = 30,
    breaks_into = { { item = "leaves", count = { 10, 20 } } },
}
