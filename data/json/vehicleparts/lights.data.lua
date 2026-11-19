local ccb = require("ccb")

-- essentially an 800 lm 10 W LED flashlight
ccb.content.define_vehicle_part {
    id = "aisle_lights",
    name = ccb.content.text("aisle lights"),
    item = "flashlight",
    location = "on_ceiling",
    categories = { "lighting" },
    color = "white",
    durability = 20,
    epower = "-10 W",
    bonus = 30,
    folded_volume = "500 ml",
    breaks_into = { { item = "scrap", count = { 0, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "AISLE_LIGHT", "ENABLED_DRAINS_EPOWER" },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "floodlight",
    item = "floodlight",
    location = "on_roof",
    categories = { "lighting" },
    color = "white",
    broken_color = "blue",
    durability = 20,
    epower = "-110 W",
    bonus = 8000,
    damage_modifier = 10,
    folded_volume = "2 L",
    breaks_into = {
        { item = "cable", count = { 1, 4 } },
        { item = "lc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "CIRCLE_LIGHT", "ENABLED_DRAINS_EPOWER" },
    variants = { { symbols = "*", broken_symbols = "-" } },
}

-- 8000 lm 100 W LED floodlight
ccb.content.define_vehicle_part {
    id = "directed_floodlight",
    item = "directed_floodlight",
    copy_from = "floodlight",
    epower = "-55 W",
    flags = { "HALF_CIRCLE_LIGHT", "ENABLED_DRAINS_EPOWER" },
}

ccb.content.define_vehicle_part {
    id = "headlight",
    item = "car_headlight",
    categories = { "lighting" },
    color = "white",
    broken_color = "white",
    durability = 20,
    epower = "-60 W",
    bonus = 8000,
    damage_modifier = 10,
    folded_volume = "250 ml",
    breaks_into = { { item = "cable", count = { 1, 4 } }, { item = "scrap", count = { 0, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "CONE_LIGHT", "ENABLED_DRAINS_EPOWER" },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "motorcycle_headlight",
    item = "motorcycle_headlight",
    categories = { "lighting" },
    color = "white",
    broken_color = "white",
    durability = 8,
    epower = "-60 W",
    bonus = 8000,
    damage_modifier = 10,
    folded_volume = "250 ml",
    breaks_into = { { item = "cable", count = { 1, 4 } }, { item = "scrap", count = { 0, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "CONE_LIGHT", "ENABLED_DRAINS_EPOWER" },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "wide_headlight",
    item = "car_wide_headlight",
    copy_from = "headlight",
    epower = "-150 W",
    flags = { "WIDE_CONE_LIGHT", "ENABLED_DRAINS_EPOWER" },
}

ccb.content.define_vehicle_part {
    id = "headlight_reinforced",
    copy_from = "headlight",
    item = "headlight_reinforced",
    color = "light_blue",
    proportional = { durability = 4 },
    damage_reduction = { all = 12 },
}

ccb.content.define_vehicle_part {
    id = "wide_headlight_reinforced",
    copy_from = "wide_headlight",
    item = "wide_headlight_reinforced",
    color = "light_blue",
    proportional = { durability = 4 },
    damage_reduction = { all = 12 },
}

-- essentially a pair of overpowered RGB LED flashlights
ccb.content.define_vehicle_part {
    abstract = "light_emergency",
    categories = { "lighting" },
    location = "on_roof",
    durability = 20,
    epower = "-10 W",
    bonus = 500,
    damage_modifier = 10,
    folded_volume = "500 ml",
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 6 } },
        { item = "lc_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
        { item = "cable", count = { 2, 4 } },
        { item = "plastic_chunk", count = { 1, 3 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "CIRCLE_LIGHT", "ENABLED_DRAINS_EPOWER" },
    damage_reduction = { all = 6 },
    variants = { { symbols = "*", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "light_blue",
    copy_from = "light_emergency",
    item = "light_emergency_blue",
    description = ccb.content.text("A blue light from the top of an emergency services vehicle."),
    color = "blue",
    broken_color = "blue",
    light_color = { 30, 60, 255 },
    extend = { flags = { "EVENTURN" } },
}

ccb.content.define_vehicle_part {
    id = "light_red",
    copy_from = "light_emergency",
    item = "light_emergency_red",
    description = ccb.content.text("A red light from the top of an emergency services vehicle."),
    color = "red",
    broken_color = "red",
    light_color = { 255, 30, 30 },
    extend = { flags = { "ODDTURN" } },
}
