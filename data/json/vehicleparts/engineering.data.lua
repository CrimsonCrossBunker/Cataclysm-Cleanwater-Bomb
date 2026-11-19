local ccb = require("ccb")

-- 30 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "crane_medium",
    name = ccb.content.text("boom crane"),
    item = "cantilever_medium",
    location = "structure",
    categories = { "utility" },
    broken_color = "light_blue",
    durability = 200,
    description = ccb.content.text("A rigid steel boom crane.  If it is in your line of sight and within two tiles of another vehicle, you will automatically use it when you want to jack up the other vehicle to change its wheels.  To use it to lift a heavy component like an engine that you are installing or removing, the crane must have line of sight to where it is going and it must be within four tiles of it."),
    breaks_into = { { item = "pipe", count = { 8, 32 } }, { item = "scrap", count = { 8, 24 } } },
    qualities = { { "LIFT", 40 }, { "JACK", 40 } },
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "PROTRUSION" },
    pseudo_tools = { { id = "crane_pseudo_item" } },
    damage_reduction = { all = 48 },
    variants = { { symbols = "=", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "crane_medium_internal",
    categories = { "utility" },
    copy_from = "crane_medium",
    name = ccb.content.text("internal boom crane"),
    location = "center",
    delete = { flags = { "PROTRUSION" } },
    extend = { flags = { "OBSTACLE" } },
}

-- 30 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "crane_small",
    name = ccb.content.text("telescopic crane"),
    item = "cantilever_small",
    location = "center",
    categories = { "utility" },
    broken_color = "light_blue",
    durability = 100,
    description = ccb.content.text("An extendable cantilever crane.  If it is in your line of sight and within two tiles of another vehicle, you will automatically use it when you want to jack up the other vehicle to change its wheels.  To use it to lift a heavy component like an engine that you are installing or removing, the crane must have line of sight to where it is going and it must be within four tiles of it."),
    folded_volume = "3 L",
    breaks_into = { { item = "pipe", count = { 2, 8 } }, { item = "scrap", count = { 2, 6 } } },
    qualities = { { "LIFT", 7 }, { "JACK", 7 } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "PROTRUSION" },
    pseudo_tools = { { id = "crane_pseudo_item" } },
    damage_reduction = { all = 42 },
    variants = { { symbols = "=", broken_symbols = "*" } },
}

-- 30 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "crane_tiny",
    item = "pallet_lifter",
    location = "center",
    categories = { "utility" },
    broken_color = "light_blue",
    durability = 100,
    description = ccb.content.text("A small pallet lifter.  If it is in your line of sight and within two tiles of another vehicle, you will automatically use it when you want to jack up the other vehicle to change its wheels.  To use it to lift a heavy component like an engine that you are installing or removing, the crane must have line of sight to where it is going and it must be within four tiles of it."),
    folded_volume = "3 L",
    breaks_into = { { item = "pipe", count = { 1, 4 } }, { item = "scrap", count = { 2, 6 } } },
    qualities = { { "LIFT", 1 }, { "JACK", 1 } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "PROTRUSION" },
    damage_reduction = { all = 40 },
    variants = { { symbols = "=", broken_symbols = "*" } },
}

-- 30 cm of weld per quadrant of damage, 60 cm of weld to install
ccb.content.define_vehicle_part {
    id = "forklift_fork",
    name = ccb.content.text("forklift arms"),
    item = "frame",
    location = "structure",
    categories = { "utility" },
    damage_modifier = 200,
    durability = 300,
    description = ccb.content.text("A pair of forklift arms.  If it is in your line of sight and within two tiles of another vehicle, you will automatically use it when you want to jack up the other vehicle to change its wheels.  To use it to lift a heavy component like an engine that you are installing or removing, the crane must have line of sight to where it is going and it must be within four tiles of it."),
    size = "12500 ml",
    breaks_into = "ig_vp_frame",
    qualities = { { "LIFT", 2 }, { "JACK", 6 } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 60 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    flags = { "CARGO", "PROTRUSION" },
    pseudo_tools = { { id = "crane_pseudo_item" } },
    damage_reduction = { all = 42 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

-- 40 cm of weld per quadrant of damage and 100 cm weld to install
ccb.content.define_vehicle_part {
    id = "rockwheel",
    item = "v_rockwheel_item",
    location = "structure",
    categories = { "utility" },
    looks_like = "crane_medium",
    durability = 300,
    description = ccb.content.text("A large metal disc, powered by the vehicle's engines.  Use the vehicle controls to turn it on or off.  When turned on, it will stop the vehicle unless it has a strong engine.  When turned on, it will dig a shallow pit in dirt.  Mount it on the edge of your vehicle."),
    power = "-70000 W",
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
    },
    transform_terrain = { pre_flags = { "DIGGABLE" }, post_terrain = "t_pit_shallow" },
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 100 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "PROTRUSION", "EXTRA_DRAG", "ROCKWHEEL", "TRANSFORM_TERRAIN" },
    damage_reduction = { all = 132 },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

-- 30 cm of weld per quadrant of damage and 120 cm weld to install
ccb.content.define_vehicle_part {
    id = "air_jack",
    item = "v_airjack_item",
    location = "under",
    categories = { "utility" },
    broken_color = "light_blue",
    looks_like = "crane_small",
    durability = 200,
    description = ccb.content.text("An extendable metal pylon used to replace a portable jack.  If mounted to a vehicle, it could be used to lift it up."),
    breaks_into = {
        { item = "pipe", count = { 4, 12 } },
        { item = "scrap", count = { 8, 24 } },
        { item = "jack", count = { 1, 1 } },
    },
    qualities = { { "SELF_JACK", 17 } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "PROTRUSION", "SELF_JACK" },
    damage_reduction = { all = 36 },
    variants = { { symbols = "[", broken_symbols = "/" } },
}

-- 20 cm of weld per quadrant of damage and 30 cm to install
ccb.content.define_vehicle_part {
    id = "motorcycle_kickstand",
    item = "v_motorcycle_kickstand_item",
    description = ccb.content.text("A kickstand to keep a bike from falling over.  You could use this to lean a small vehicle forward or backward to change a tire."),
    categories = { "utility" },
    broken_color = "light_blue",
    durability = 200,
    breaks_into = { { item = "pipe", count = { 1, 3 } }, { item = "scrap", count = { 1, 3 } } },
    qualities = { { "SELF_JACK", 1 } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "welding_standard", 30 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "SELF_JACK" },
    damage_reduction = { all = 5 },
    variants = { { symbols = "[", broken_symbols = "/" } },
}

ccb.content.define_vehicle_part {
    id = "solar_reflector",
    name = ccb.content.text("solar reflector"),
    categories = { "utility" },
    color = "yellow",
    broken_color = "dark_gray",
    description = ccb.content.text("A faceted reflector dish that concentrates sunlight for cooking.  Only works outdoors in strong direct sunlight."),
    item = "solar_cooker",
    location = "on_roof",
    durability = 30,
    damage_modifier = 10,
    flags = { "FLAT_SURF" },
    pseudo_tools = { { id = "fake_solar_cooker" } },
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
    },
    breaks_into = { { item = "scrap", count = { 2, 4 } }, { item = "sheet_metal_small", count = { 1, 2 } } },
    variants = { { symbols = ")", broken_symbols = "x" } },
}
