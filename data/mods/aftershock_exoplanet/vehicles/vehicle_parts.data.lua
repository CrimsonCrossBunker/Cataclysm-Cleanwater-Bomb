local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "afs_cargo_trough",
    copy_from = "trunk",
    name = ccb.content.text("cargo trough"),
    categories = { "cargo" },
    color = "light_gray",
    broken_color = "light_gray",
    looks_like = "trunk",
    location = "center",
    durability = 200,
    description = ccb.content.text("This is little more than a sheet metal basin welded to the bottom of the vehicle, extending below it.  Though it holds a lot of stuff, its shoddiness makes it fragile."),
    size = "150 L",
    breaks_into = { { item = "lc_steel_lump", count = { 4, 6 } }, { item = "scrap", count = { 4, 6 } } },
}

ccb.content.define_vehicle_part {
    id = "afs_crude_plating",
    name = ccb.content.text("crude plating"),
    description = ccb.content.text("A piece of sheet metal welded onto a vehicle as armor.  Thin, and not as protective as proper armor, but it'll do if there's nothing else available."),
    looks_like = "steel_plate",
    categories = { "warfare" },
    color = "light_gray",
    broken_color = "dark_gray",
    durability = 300,
    item = "sheet_metal",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    flags = { "ARMOR" },
    breaks_into = { { item = "lc_steel_chunk", count = { 1, 2 } }, { item = "scrap", count = { 4, 6 } } },
    damage_reduction = { all = 4 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 300 cm weld to install
ccb.content.define_vehicle_part {
    id = "plating_ship",
    name = ccb.content.text("heavy ablative plating"),
    categories = { "warfare" },
    color = "dark_gray",
    broken_color = "light_gray",
    durability = 1600,
    item = "afs_mil_ship_plate",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 300 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal_cut_resistant", 1 }, { "vehicle_wrench_2", 1 } },
        },
    },
    flags = { "ARMOR", "NO_REPAIR" },
    breaks_into = {
        { item = "afs_material_1", count = { 8, 10 } },
        { item = "afs_material_2", count = { 4, 6 } },
        { item = "afs_material_3", count = { 0, 2 } },
        { item = "afs_material_4", count = { 0, 1 } },
    },
    damage_reduction = { all = 450 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

ccb.content.define_vehicle_part {
    id = "afs_control_station",
    name = ccb.content.text("control station"),
    looks_like = "vehicle_dashboard",
    categories = { "operations" },
    color = "red",
    broken_color = "light_gray",
    damage_modifier = 10,
    durability = 400,
    description = ccb.content.text("A large and complex dashboard mounted with steering controls and several LCD touch screens for controlling vehicle systems."),
    bonus = 10,
    item = "afs_control_station",
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
    id = "afs_mounted_external_tank",
    categories = { "movement" },
    copy_from = "external_tank_small",
    name = ccb.content.text("mounted external tank (200L)"),
    item = "55gal_drum",
    location = "center",
}

ccb.content.define_vehicle_part {
    id = "afs_lightweight_frame",
    copy_from = "frame_abstract",
    name = ccb.content.text("ultralight frame"),
    item = "afs_titanium_frame",
    color = "light_gray",
    durability = 100,
    description = ccb.content.text("An ultralight titanium framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
    breaks_into = { { item = "afs_scrap_titanium", count = { 1, 3 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "afs_lightweight_foldable_frame",
    copy_from = "afs_lightweight_frame",
    name = ccb.content.text("ultralight foldable frame"),
    item = "afs_titanium_foldable_frame",
    durability = 75,
    folded_volume = "10 L",
    folding_time = "1 minute",
    unfolding_time = "1 minute",
    description = ccb.content.text("An ultralight titanium foldable framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
}

ccb.content.define_vehicle_part {
    id = "solar_panel_v3",
    categories = { "energy" },
    copy_from = "solar_panel",
    name = ccb.content.text("quantum solar panel"),
    looks_like = "solar_panel_v2",
    proportional = { epower = 6.0 },
    item = "solar_panel_v3",
    durability = 40,
    description = ccb.content.text("An extremely high-performance solar panel.  Will recharge the vehicle's electrical power when exposed to the sun.  Clouds will slow the recharge speed.  Extremely fragile and cannot be armored."),
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
        { item = "solar_cell", count = { 2, 8 } },
    },
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
    id = "robot_cargo",
    name = ccb.content.text("robot_carrier"),
    categories = { "cargo", "passengers" },
    color = "light_gray",
    looks_like = "cargo_space",
    broken_color = "dark_gray",
    durability = 250,
    description = ccb.content.text("A cargo space for carrying robots.  'e'xamine it to capture a robot next to you, or to release the robot currently contained.  When selecting a robot to capture, choose its tile relative to you, not the part."),
    size = "200 L",
    item = "robot_carrier",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    flags = { "BOARDABLE", "CARGO", "COVERED", "CAPTURE_MONSTER_VEH" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 6, 8 } },
        { item = "mc_steel_chunk", count = { 6, 8 } },
        { item = "scrap", count = { 6, 8 } },
    },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "exo_gantry",
    name = ccb.content.text("exosuit maintenance gantry"),
    categories = { "utility" },
    color = "light_gray",
    broken_color = "light_gray",
    looks_like = "veh_tools_workshop",
    damage_modifier = 10,
    durability = 200,
    description = ccb.content.text("A gantry for supporting an exosuit upright during maintenance and repair.  Includes the specialized tools needed for complex repairs and will also charge the suit's power when active."),
    size = "200 L",
    bonus = 600,
    item = "veh_tools_workshop",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "COVERED", "RECHARGE" },
    pseudo_tools = {
        { id = "welder", hotkey = "w" },
        { id = "soldering_iron", hotkey = "s" },
        { id = "exo_repair_kit", hotkey = "e" },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 3, 6 } },
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "scrap", count = { 3, 6 } },
        { item = "welder", probability = 50 },
    },
    variants = { { symbols = "T", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "veh_tools_kitchen",
    copy_from = "veh_tools_kitchen",
    description = ccb.content.text("A table rig with a faucet for water tank access, fume hood, drawers and fixtures for storing tools, low power electric connectors and valves for fuel tank connections."),
    item = "veh_tools_kitchen",
    looks_like = "kitchen_unit",
    extend = { allowed_tools = { "afs_atompot" } },
}

ccb.content.define_vehicle_part {
    id = "ship_reactor_pdu",
    categories = { "movement" },
    color = "light_blue",
    durability = 800,
    flags = { "NO_INSTALL_HIDDEN", "NO_UNINSTALL", "NO_REPAIR", "OBSTACLE", "PERPETUAL", "REACTOR" },
    looks_like = "minireactor",
    location = "center",
    epower = "200 kW",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    item = "ship_reactor_pdu",
    description = ccb.content.text("A distribution cabinet linking to the ship's main reactor, can be used to build an external electric grid powered by the ship's surplus power."),
    variants = { { symbols = "X", broken_symbols = "O" } },
    breaks_into = {
        { item = "mc_steel_lump", count = { 3, 6 } },
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "scrap", count = { 3, 6 } },
    },
}

ccb.content.define_vehicle_part {
    id = "aerodyne_engine",
    copy_from = "helicopter_rotors",
    item = "afs_aerodyne_engine",
    description = ccb.content.text("A multi-axis aerodyne engine, powered by chemical fuel.  Allows flight within the atmosphere."),
    rotor_diameter = 1,
    bonus = 9,
    durability = 450,
    damage_modifier = 80,
    flags = { "ROTOR", "NO_REPAIR", "SMASH_REMOVE" },
    requirements = {
        removal = {
            skills = { { "mechanics", 8 } },
            duration = "1 h",
            using_requirements = "vehicle_weld_removal",
        },
    },
    breaks_into = { { item = "scrap", count = { 15, 30 } }, { item = "ch_steel_chunk", count = { 8, 16 } } },
    damage_reduction = { all = 66 },
}

ccb.content.define_vehicle_part {
    id = "engine_turbine_large",
    copy_from = "gas_turbine_engine",
    item = "afs_aerodyne_powerplant",
    description = ccb.content.text("A massive turbine engine, used to power aerodynes.  Has a prodigiously high rate of fuel consumption."),
    durability = 400,
    epower = "-10 W",
    power = "4400000 W",
    energy_consumption = "6600000 W",
    breaks_into = {
        { item = "alloy_plate", count = { 4, 6 } },
        { item = "ch_steel_lump", count = { 100, 120 } },
        { item = "ch_steel_chunk", count = { 100, 120 } },
        { item = "scrap", count = { 100, 120 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 9 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 7 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 10 } },
            duration = "60 m",
            using_requirements = {
                { "repair_welding_standard", 7 },
                { "repair_welding_alloys", 5 },
                { "vehicle_wrench_2", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    damage_reduction = { all = 70 },
}
