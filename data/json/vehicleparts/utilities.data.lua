local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "veh_forge",
    breaks_into = {
        { count = { 4, 5 }, item = "mc_steel_lump" },
        { count = { 4, 6 }, item = "mc_steel_chunk" },
        { count = { 4, 6 }, item = "scrap" },
    },
    categories = { "utility" },
    color = "red",
    damage_modifier = 10,
    damage_reduction = { all = 29 },
    description = ccb.content.text("An electric forge for metalworking, powered by the vehicle's batteries.  With a hammer and other tools, you could use this for metalworking.  If you attempt to craft an item that needs a forge, you will be given the option of selecting it as a tool."),
    durability = 80,
    flags = { "CARGO", "OBSTACLE" },
    pseudo_tools = { { id = "forge" } },
    item = "forgerig",
    location = "center",
    looks_like = "f_forge_rock",
    name = ccb.content.text("vehicle electric forge"),
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
            using_requirements = { { "repair_welding_standard", 2 }, { "soldering_standard", 15 } },
        },
    },
    size = "50 L",
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "veh_kiln",
    breaks_into = {
        { count = { 4, 5 }, item = "mc_steel_lump" },
        { count = { 4, 6 }, item = "mc_steel_chunk" },
        { count = { 4, 6 }, item = "scrap" },
    },
    categories = { "utility" },
    color = "red",
    damage_modifier = 10,
    damage_reduction = { all = 25 },
    description = ccb.content.text("A electric kiln for baking brick or clay, powered by the vehicle's batteries.  You could use this to harden bricks or clay.  If you attempt to craft an item that needs a kiln, you will be given the option of selecting it as a tool."),
    durability = 80,
    flags = { "CARGO", "OBSTACLE" },
    pseudo_tools = { { id = "kiln" } },
    item = "kilnrig",
    location = "center",
    looks_like = "f_kiln_empty",
    name = ccb.content.text("vehicle electric kiln"),
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
            using_requirements = { { "repair_welding_standard", 2 }, { "soldering_standard", 10 } },
        },
    },
    size = "50 L",
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "veh_binoculars",
    name = ccb.content.text("binoculars"),
    looks_like = "binoculars",
    categories = { "passengers" },
    color = "dark_gray",
    damage_modifier = 1,
    durability = 50,
    description = ccb.content.text("Binoculars secured near the seat."),
    item = "binoculars",
    folded_volume = "500 ml",
    flags = { "ENHANCED_VISION", "SIMPLE_PART" },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "vehicle_screw", 1 }, { "adhesive", 2 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "3 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    breaks_into = { { item = "plastic_chunk", count = { 2, 5 } } },
    variants = { { symbols = "8", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "drum_concrete_mix",
    name = ccb.content.text("concrete mixer drum"),
    item = "30gal_barrel",
    description = ccb.content.text("A plastic 100-liter drum of a portable concrete mixer."),
    categories = { "utility" },
    location = "center",
    folded_volume = "113560 ml",
    color = "light_blue",
    broken_color = "light_blue",
    durability = 150,
    flags = { "OBSTACLE", "NO_INSTALL_HIDDEN" },
    pseudo_tools = { { id = "concrete_mix_tool" } },
    breaks_into = { { item = "plastic_chunk", count = { 10, 100 } } },
    variants = { { symbols = "U", broken_symbols = "u" } },
}

-- aem lambrecht weather backpack can run for 8 days on a full charge
ccb.content.define_vehicle_part {
    id = "veh_mobile_weather_station",
    name = ccb.content.text("mobile weather station"),
    item = "mobile_weather_station",
    fuel_type = "battery",
    categories = { "utility" },
    color = "yellow",
    broken_color = "red",
    epower = "-1 W",
    durability = 50,
    description = ccb.content.text("A mobile weather station.  Its instruments are deployed on its tall telescoping stand."),
    folded_volume = "89 L",
    breaks_into = { { item = "plastic_chunk", count = { 14, 20 } }, { item = "scrap", count = { 2, 3 } } },
    requirements = {
        install = { duration = "1200 s" },
        removal = { duration = "1200 s" },
        repair = {
            skills = { { "electronics", 5 } },
            duration = "600 s",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    damage_reduction = { bash = 1 },
    size = "10 ml",
    flags = { "CARGO", "OBSTACLE", "MWS", "ENABLED_DRAINS_EPOWER", "NO_INSTALL_HIDDEN" },
    pseudo_tools = { { id = "mws_weather_sensor_array", hotkey = "a" } },
    variants = { { symbols = "T", broken_symbols = "#" } },
}

-- 4x power drain to account for other equipment
ccb.content.define_vehicle_part {
    id = "veh_xedra_mobile_weather_station",
    name = ccb.content.text("mobile hazardous environment weather station"),
    item = "xedra_mobile_weather_station",
    fuel_type = "battery",
    categories = { "utility" },
    color = "black",
    broken_color = "red",
    epower = "-4 W",
    durability = 50,
    description = ccb.content.text("A mobile hazardous environment weather station.  Its instruments are deployed on its tall telescoping stand."),
    folded_volume = "90 L",
    breaks_into = { { item = "plastic_chunk", count = { 14, 20 } }, { item = "scrap", count = { 2, 3 } } },
    requirements = {
        install = { duration = "1200 s" },
        removal = { duration = "1200 s" },
        repair = {
            skills = { { "electronics", 7 } },
            duration = "600 s",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    damage_reduction = { bash = 1 },
    size = "10 ml",
    flags = { "CARGO", "OBSTACLE", "MWS", "ENABLED_DRAINS_EPOWER", "ADVANCED_MWS", "NO_INSTALL_HIDDEN" },
    pseudo_tools = {
        { id = "mws_advanced_weather_sensor_array", hotkey = "a" },
        { id = "mws_HE_sensor_array", hotkey = "b" },
    },
    variants = { { symbols = "T", broken_symbols = "#" } },
}

-- 4x power drain to account for other equipment
ccb.content.define_vehicle_part {
    id = "veh_robofac_mobile_weather_station",
    name = ccb.content.text("mobile HEW-NRE station"),
    item = "robofac_mobile_weather_station",
    fuel_type = "battery",
    categories = { "utility" },
    color = "brown",
    broken_color = "red",
    epower = "-4 W",
    durability = 50,
    description = ccb.content.text("A mobile hazardous environment weather station.  Its instruments are deployed on its tall telescoping stand."),
    folded_volume = "90 L",
    breaks_into = { { item = "plastic_chunk", count = { 14, 20 } }, { item = "scrap", count = { 2, 3 } } },
    requirements = {
        install = { duration = "1200 s" },
        removal = { duration = "1200 s" },
        repair = {
            skills = { { "electronics", 7 } },
            duration = "600 s",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    damage_reduction = { bash = 1 },
    size = "10 ml",
    flags = { "CARGO", "OBSTACLE", "MWS", "ENABLED_DRAINS_EPOWER", "ADVANCED_MWS", "NO_INSTALL_HIDDEN" },
    pseudo_tools = {
        { id = "mws_advanced_weather_sensor_array", hotkey = "a" },
        { id = "mws_HE_sensor_array", hotkey = "b" },
    },
    variants = { { symbols = "T", broken_symbols = "#" } },
}
