local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "veh_tools_kitchen",
    copy_from = "veh_tools_kitchen",
    description = ccb.content.text("A table rig with a faucet for water tank access, fume hood, drawers and fixtures for storing tools, low power electric connectors and valves for fuel tank connections."),
    item = "veh_tools_kitchen",
    looks_like = "kitchen_unit",
    extend = { allowed_tools = { "fcl_atomic_coffeemaker", "fcl_atompot" } },
}

ccb.content.define_vehicle_part {
    id = "solar_panel_v3",
    categories = { "energy" },
    copy_from = "solar_panel",
    name = ccb.content.text("quantum solar panel"),
    looks_like = "solar_panel_v2",
    proportional = { epower = 6.0 },
    item = "solar_panel_v3",
    durability = 60,
    description = ccb.content.text("An extremely high-performance solar panel.  Will recharge the vehicle's electrical power when exposed to the sun.  Clouds will slow the recharge speed.  Extremely fragile, and reinforcing or modifying it requires unusually careful, advanced work."),
    requirements = {
        install = {
            skills = { { "mechanics", 8 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 6 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
    },
    extend = { flags = { "NO_REPAIR" } },
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 4 } },
        { item = "lc_steel_chunk", count = { 4, 4 } },
        { item = "scrap", count = { 4, 4 } },
        { item = "solar_cell_v3", count = { 2, 8 } },
    },
}

ccb.content.define_vehicle_part {
    id = "reinforced_solar_panel_v3",
    categories = { "energy" },
    copy_from = "solar_panel",
    name = ccb.content.text("reinforced quantum solar panel"),
    looks_like = "solar_panel_v3",
    description = ccb.content.text("A quantum solar panel that has been covered with a pane of reinforced glass.  The glass causes this panel to produce slightly less power than a normal quantum panel."),
    color = "light_blue",
    broken_color = "light_gray",
    proportional = { epower = 5.7 },
    damage_modifier = 80,
    durability = 450,
    item = "reinforced_solar_panel_v3",
    requirements = {
        install = {
            skills = { { "mechanics", 8 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 6 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "electronics", 8 } },
            duration = "75 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v3", 1 },
                { "soldering_standard", 16 },
                { "repair_welding_standard", 1 },
            },
        },
    },
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 7 } },
        { item = "lc_steel_chunk", count = { 4, 7 } },
        { item = "scrap", count = { 4, 7 } },
        { item = "solar_cell_v3", count = { 2, 8 } },
    },
    damage_reduction = { all = 10 },
}

-- Here it is a multiplier on power efficiency - 1 unit of plutonium is 10000 kJ
ccb.content.define_vehicle_part {
    id = "minireactor",
    name = ccb.content.text("minireactor"),
    categories = { "energy" },
    color = "light_green",
    broken_color = "red",
    damage_modifier = 80,
    durability = 580,
    description = ccb.content.text("A small nuclear reactor.  When loaded with plutonium cells and turned on, will generate a lot of electrical power."),
    power = "10000 W",
    epower = "149200 W",
    fuel_type = "plut_cell",
    item = "minireactor",
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 5 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 5 },
                { "repair_welding_alloys", 2 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    flags = { "REACTOR" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 6, 11 } },
        { item = "mc_steel_chunk", count = { 6, 11 } },
        { item = "scrap", count = { 6, 11 } },
    },
    damage_reduction = { all = 50 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "fcl_control_station",
    name = ccb.content.text("control station"),
    looks_like = "vehicle_dashboard",
    categories = { "operations" },
    color = "red",
    broken_color = "light_gray",
    damage_modifier = 10,
    durability = 400,
    description = ccb.content.text("A large and complex dashboard mounted with steering controls and several LCD touch screens for controlling vehicle systems."),
    bonus = 10,
    item = "fcl_control_station",
    epower = "-125 W",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    flags = {
        "VISION",
        "CAMERA",
        "CONTROLS",
        "CAMERA_CONTROL",
        "REMOTE_CONTROLS",
        "CTRL_ELECTRONIC",
        "ENABLED_DRAINS_EPOWER",
        "WATCH",
        "ALARMCLOCK",
    },
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 4 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 4 } },
        { item = "cable", count = { 2, 7 } },
        { item = "RAM", count = { 1, 4 } },
        { item = "e_scrap", count = { 3, 8 } },
    },
    variants = { { symbols = "$", broken_symbols = "$" } },
}

ccb.content.define_vehicle_part {
    id = "fcl_smart_omnicamera",
    copy_from = "omnicam",
    categories = { "operations" },
    description = ccb.content.text("A smart security camera you could connect to a display.  Not only is the field of vision great, but AI technology is also used for image prediction, which greatly improves the clarity of the image.  But its power consumption has also doubled."),
    durability = 200,
    bonus = 64,
    item = "fcl_smart_omnicamera",
    epower = "-20 W",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "VISION", "CAMERA", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "e_scrap", count = { 5, 15 } },
        { item = "cable", count = { 1, 3 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "lens", probability = 35 },
        { item = "scrap", count = { 3, 5 } },
        { item = "ai_module", count = { 0, 1 } },
    },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "fcl_smart_omnicamera_reinforced",
    copy_from = "fcl_smart_omnicamera",
    categories = { "operations" },
    description = ccb.content.text("A smart security camera with a cage built around it to protect it from damage without reducing its effectiveness."),
    durability = 500,
    item = "fcl_smart_omnicamera_reinforced",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "VISION", "CAMERA", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "e_scrap", count = { 5, 15 } },
        { item = "cable", count = { 1, 3 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "lens", probability = 35 },
        { item = "scrap", count = { 3, 5 } },
        { item = "ai_module", count = { 0, 1 } },
    },
    variants = { { symbols = "o", broken_symbols = "#" } },
}
