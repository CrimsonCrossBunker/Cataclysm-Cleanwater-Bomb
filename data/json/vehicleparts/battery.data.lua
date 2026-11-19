local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "battery_car",
    item = "battery_car",
    fuel_type = "battery",
    categories = { "energy" },
    color = "yellow",
    broken_color = "red",
    durability = 120,
    description = ccb.content.text("A battery for storing electrical power, and discharging it to power electrical devices built into the vehicle."),
    folded_volume = "10 L",
    breaks_into = {
        { item = "lead", count = { 1680, 2380 } },
        { item = "chem_sulphuric_acid", count = { 5, 8 }, container_item = "null" },
        { item = "plastic_chunk", count = { 14, 20 } },
        { item = "scrap", count = { 2, 3 } },
        { item = "shredded_rubber", count = { 10, 14 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "50 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "50 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "600 s",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    damage_reduction = { bash = 10 },
    flags = { "BATTERY" },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "battery_motorbike",
    copy_from = "battery_car",
    item = "battery_motorbike",
    durability = 100,
    folded_volume = "1500 ml",
    breaks_into = {
        { item = "lead", count = { 252, 357 } },
        { item = "chem_sulphuric_acid", count = { 0, 1 }, container_item = "null" },
        { item = "plastic_chunk", count = { 2, 3 } },
        { item = "scrap", count = { 0, 1 } },
        { item = "shredded_rubber", count = { 1, 2 } },
    },
}

ccb.content.define_vehicle_part {
    id = "battery_motorbike_small",
    copy_from = "battery_car",
    item = "battery_motorbike_small",
    durability = 30,
    folded_volume = "750 ml",
    breaks_into = {
        { item = "lead", count = { 126, 178 } },
        { item = "chem_sulphuric_acid", count = { 0, 1 }, container_item = "null" },
        { item = "plastic_chunk" },
        { item = "scrap", count = { 0, 1 } },
        { item = "shredded_rubber", count = { 0, 1 } },
    },
}

ccb.content.define_vehicle_part {
    id = "large_storage_battery",
    copy_from = "storage_battery",
    item = "large_storage_battery",
    durability = 600,
    breaks_into = {
        { item = "lc_steel_lump", count = { 10, 20 } },
        { item = "lc_steel_chunk", count = { 5, 10 } },
        { item = "scrap", count = { 5, 10 } },
        { item = "storage_battery", count = { 0, 1 } },
    },
}

ccb.content.define_vehicle_part {
    id = "large_storage_battery_removable",
    copy_from = "large_storage_battery",
    name = ccb.content.text("swappable very large storage battery"),
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "10 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "10 s", using_requirements = {} },
    },
    description = ccb.content.text("A battery for storing electrical power, and discharging it to power electrical devices built into the vehicle.  This one is mounted on a quick release framework to allow it to be easily swapped, though it still weighs so much that a lifting tool of some kind is necessary for most people."),
    flags = { "BATTERY", "NEEDS_BATTERY_MOUNT" },
}

ccb.content.define_vehicle_part {
    id = "medium_storage_battery",
    copy_from = "storage_battery",
    item = "medium_storage_battery",
    durability = 250,
    folded_volume = "5 L",
    breaks_into = {
        { item = "scrap", count = { 1, 4 } },
        { item = "small_storage_battery", count = { 0, 7 } },
    },
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "200 s", using_requirements = "vehicle_screw" },
        removal = { skills = { { "mechanics", 0 } }, duration = "200 s", using_requirements = "vehicle_screw" },
    },
}

ccb.content.define_vehicle_part {
    id = "small_storage_battery",
    copy_from = "storage_battery",
    item = "small_storage_battery",
    durability = 100,
    folded_volume = "500 ml",
    breaks_into = { { item = "scrap", count = { 1, 2 } } },
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "100 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "100 s", using_requirements = {} },
    },
}

-- 29 cm length battery, welded on at least two edges
ccb.content.define_vehicle_part {
    id = "storage_battery",
    categories = { "energy" },
    item = "storage_battery",
    location = "fuel_source",
    fuel_type = "battery",
    color = "yellow",
    broken_color = "red",
    durability = 300,
    description = ccb.content.text("A battery for storing electrical power, and discharging it to power electrical devices built into the vehicle."),
    damage_modifier = 80,
    breaks_into = {
        { item = "lc_steel_lump", count = { 5, 10 } },
        { item = "lc_steel_chunk", count = { 5, 10 } },
        { item = "scrap", count = { 5, 10 } },
        { item = "medium_storage_battery", count = { 1, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "25 m",
            using_requirements = { { "welding_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = "vehicle_weld_removal",
        },
    },
    damage_reduction = { bash = 10 },
    flags = { "BATTERY" },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "storage_battery_removable",
    copy_from = "storage_battery",
    name = ccb.content.text("swappable large storage battery"),
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "10 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "10 s", using_requirements = {} },
    },
    description = ccb.content.text("A battery for storing electrical power, and discharging it to power electrical devices built into the vehicle.  This one is mounted on a quick release framework to allow it to be easily swapped, though it still weighs so much that a lifting tool of some kind is necessary for some people."),
    flags = { "BATTERY", "NEEDS_BATTERY_MOUNT" },
}

ccb.content.define_vehicle_part {
    id = "car_light_minus_battery_cell",
    copy_from = "battery_car",
    item = "light_minus_battery_cell",
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
    },
    durability = 10,
    folded_volume = "10 ml",
    breaks_into = { { item = "e_scrap", probability = 10 } },
    flags = { "BATTERY", "NEEDS_HANDHELD_BATTERY_MOUNT", "NO_REPAIR" },
}

ccb.content.define_vehicle_part {
    id = "car_light_battery_cell",
    copy_from = "battery_car",
    item = "light_battery_cell",
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
    },
    durability = 20,
    folded_volume = "25 ml",
    breaks_into = { { item = "e_scrap", probability = 10 } },
    flags = { "BATTERY", "NEEDS_HANDHELD_BATTERY_MOUNT", "NO_REPAIR" },
}

ccb.content.define_vehicle_part {
    id = "car_medium_battery_cell",
    copy_from = "battery_car",
    item = "medium_battery_cell",
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
    },
    durability = 30,
    folded_volume = "450 ml",
    breaks_into = { { item = "light_battery_cell", count = { 0, 3 } }, { item = "scrap", count = { 1, 4 } } },
    flags = { "BATTERY", "NEEDS_HANDHELD_BATTERY_MOUNT", "NO_REPAIR" },
}

ccb.content.define_vehicle_part {
    id = "car_heavy_battery_cell",
    copy_from = "battery_car",
    item = "heavy_battery_cell",
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
    },
    durability = 40,
    folded_volume = "1225 ml",
    breaks_into = { { item = "medium_battery_cell", count = { 0, 1 } }, { item = "scrap", count = { 1, 4 } } },
    flags = { "BATTERY", "NEEDS_HANDHELD_BATTERY_MOUNT", "NO_REPAIR" },
}

ccb.content.define_vehicle_part {
    id = "car_heavy_plus_battery_cell",
    copy_from = "battery_car",
    item = "heavy_plus_battery_cell",
    location = "on_battery_mount",
    requirements = {
        install = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
        removal = { skills = { { "mechanics", 0 } }, duration = "50 s", using_requirements = {} },
    },
    durability = 40,
    folded_volume = "1500 ml",
    breaks_into = { { item = "medium_battery_cell", count = { 0, 1 } }, { item = "scrap", count = { 1, 4 } } },
    flags = { "BATTERY", "NEEDS_HANDHELD_BATTERY_MOUNT", "NO_REPAIR" },
}

ccb.content.define_vehicle_part {
    id = "ap_power_station_portable",
    name = ccb.content.text("portable power station"),
    categories = { "energy" },
    looks_like = "battery_car",
    color = "red",
    flags = { "APPLIANCE" },
    description = ccb.content.text("A portable power station wired for grid use."),
    item = "power_station_portable",
    breaks_into = {
        { item = "e_scrap", count = { 10, 15 } },
        { item = "plastic_chunk", count = { 14, 20 } },
        { item = "scrap", count = { 5, 10 } },
    },
    durability = 120,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}
