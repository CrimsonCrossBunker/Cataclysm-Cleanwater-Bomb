local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "wheel_mount_wood",
    categories = { "movement" },
    description = ccb.content.text("A piece of wood with holes suitable for a bike wheel."),
    color = "brown",
    location = "axle",
    damage_modifier = 40,
    folded_volume = "250 ml",
    durability = 80,
    item = "wheel_mount_wood",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "WHEEL_MOUNT_LIGHT", "NEEDS_JACKING" },
    breaks_into = { { item = "2x4", count = { 2, 5 } } },
    damage_reduction = { all = 8 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_wood_steerable",
    copy_from = "wheel_mount_wood",
    name = ccb.content.text("wooden wheel mount (steerable)"),
    extend = { flags = { "STEERABLE" } },
}

-- 25 cm weld as a conservative estimate (not much welding going on to affix bike parts).
ccb.content.define_vehicle_part {
    id = "wheel_mount_light",
    categories = { "movement" },
    description = ccb.content.text("A piece of metal with holes suitable for a bike or motorbike wheel."),
    location = "axle",
    damage_modifier = 80,
    folded_volume = "250 ml",
    durability = 120,
    item = "wheel_mount_light",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "welding_standard", 25 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "WHEEL_MOUNT_LIGHT", "NEEDS_JACKING" },
    breaks_into = { { item = "scrap", count = { 0, 1 } } },
    damage_reduction = { all = 10 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_light_steerable",
    copy_from = "wheel_mount_light",
    name = ccb.content.text("light wheel mount (steerable)"),
    extend = { flags = { "STEERABLE" } },
}

-- 100 cm weld
ccb.content.define_vehicle_part {
    id = "wheel_mount_medium",
    categories = { "movement" },
    description = ccb.content.text("A metal assembly that allows bolting a wheel onto a car.  Fit for a car wheel."),
    location = "axle",
    damage_modifier = 80,
    durability = 120,
    item = "wheel_mount_medium",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 100 }, { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "WHEEL_MOUNT_MEDIUM", "NEEDS_JACKING" },
    breaks_into = { { item = "scrap", count = { 1, 4 } }, { item = "mc_steel_chunk", count = { 2, 5 } } },
    damage_reduction = { all = 30 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_medium_steerable",
    copy_from = "wheel_mount_medium",
    name = ccb.content.text("medium wheel hub assembly (steerable)"),
    extend = { flags = { "STEERABLE" } },
}

-- 150 cm weld
ccb.content.define_vehicle_part {
    id = "wheel_mount_heavy",
    categories = { "movement" },
    description = ccb.content.text("A heavy metal assembly that allows bolting a wheel onto a car.  Fit for a large car wheel."),
    location = "axle",
    damage_modifier = 80,
    durability = 120,
    item = "wheel_mount_heavy",
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 150 }, { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "20 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "WHEEL_MOUNT_HEAVY", "NEEDS_JACKING" },
    breaks_into = { { item = "scrap", count = { 1, 4 } }, { item = "mc_steel_chunk", count = { 3, 7 } } },
    damage_reduction = { all = 40 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_heavy_steerable",
    copy_from = "wheel_mount_heavy",
    name = ccb.content.text("heavy wheel hub assembly (steerable)"),
    extend = { flags = { "STEERABLE" } },
}

ccb.content.define_vehicle_part {
    id = "rail_wheel",
    item = "wheel_rail",
    description = ccb.content.text("A strong rail wheel.  A flange helps keep it on a rail, but makes it perform terribly when not on a rail."),
    location = "under",
    durability = 7000,
    damage_modifier = 70,
    breaks_into = { { item = "scrap", count = { 4, 6 } }, { item = "ch_steel_chunk", count = { 2, 3 } } },
    rolling_resistance = 0.25,
    wheel_offroad_rating = 0.05,
    wheel_terrain_modifiers = { { flag = "RAIL", move_override = 2, move_penalty = 8 } },
    categories = { "movement" },
    contact_area = 80,
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "RAIL" },
    damage_reduction = { all = 66 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "rail_wheel_steerable",
    copy_from = "rail_wheel",
    name = ccb.content.text("rail wheel (steerable)"),
    extend = { flags = { "STEERABLE" } },
}

ccb.content.define_vehicle_part {
    id = "rail_wheel_small_pair",
    name = ccb.content.text("small rail wheels (pair)"),
    description = ccb.content.text("A pair of small rail wheels.  It fits small railroad rails found in places like amusement parks.  Mostly for hobby purposes rather than transportation.  You can't steer it."),
    item = "wheel_rail_small_pair",
    copy_from = "rail_wheel",
    damage_modifier = 50,
    breaks_into = { { item = "scrap", count = { 2, 3 } }, { item = "ch_steel_chunk", count = { 1, 2 } } },
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
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    damage_reduction = { all = 60 },
    variants = { { symbols = "=", broken_symbols = "x" } },
}

-- really big steel drum, assuming 100 cm of weld per quadrant of damage.
ccb.content.define_vehicle_part {
    id = "roller_drum",
    item = "hd_steel_drum",
    description = ccb.content.text("A large cylinder fashioned out of plates of hardened steel, normally found on road rollers.  Its massive weight is meant to, slowly, roll over asphalt and other surfaces, levelling them out."),
    location = "center",
    categories = { "movement" },
    color = "light_red",
    durability = 2500,
    damage_modifier = 500,
    breaks_into = {
        { item = "mc_steel_lump", count = { 25, 75 } },
        { item = "mc_steel_chunk", count = { 30, 90 } },
        { item = "scrap", count = { 50, 150 } },
    },
    rolling_resistance = 30.0,
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 10 } },
        },
    },
    flags = { "ARMOR", "OBSTACLE", "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "STEERABLE" },
    wheel_offroad_rating = 0.01,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 6 },
        { flag = "ROAD", move_override = 0, move_penalty = 10 },
    },
    contact_area = 1200,
    damage_reduction = { all = 20, bash = 80, cut = 140, stab = 110, bullet = 65 },
    variants = { { symbols = "B", broken_symbols = "E" } },
}

ccb.content.define_vehicle_part {
    id = "wheel",
    item = "wheel",
    description = ccb.content.text("A car wheel."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 200,
    damage_modifier = 50,
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 8, 19 } },
        { item = "shredded_rubber", count = { 8, 20 } },
    },
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 153,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "10 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_MEDIUM" },
    damage_reduction = { bash = 20 },
    variants = { { symbols = "0", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_slick",
    copy_from = "wheel",
    item = "wheel_slick",
    description = ccb.content.text("A wide, smooth wheel intended for racing.  The slick surface provides better speed on pavement but penalizes off-road speed."),
    wheel_offroad_rating = 0.3,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 5 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 180,
    damage_reduction = { bash = 12 },
}

ccb.content.define_vehicle_part {
    id = "wheel_armor",
    item = "wheel_armor",
    description = ccb.content.text("A wide military-grade wheel."),
    location = "under",
    looks_like = "wheel",
    categories = { "movement" },
    color = "green",
    durability = 800,
    damage_modifier = 50,
    breaks_into = {
        { item = "mc_steel_lump", count = { 2, 3 } },
        { item = "mc_steel_chunk", count = { 2, 3 } },
        { item = "scrap", count = { 2, 3 } },
    },
    rolling_resistance = 0.6,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 480,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "20 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "20 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_HEAVY", "RESIST_RUNOVER_DAMAGE" },
    damage_reduction = { all = 60, cut = 30, stab = 16 },
    variants = { { symbols = "0", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_barrow",
    item = "wheel_barrow",
    description = ccb.content.text("A small wheel from a common garden wheelbarrow."),
    location = "under",
    looks_like = "wheel_bicycle",
    categories = { "movement" },
    color = "dark_gray",
    durability = 70,
    damage_modifier = 50,
    folded_volume = "2250 ml",
    breaks_into = {
        { item = "mc_steel_lump" },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "chunk_rubber", count = { 4, 15 } },
        { item = "shredded_rubber", count = { 4, 10 } },
    },
    rolling_resistance = 1.62,
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    contact_area = 30,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE", "STEERABLE", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { bash = 10 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_bicycle",
    item = "wheel_bicycle",
    description = ccb.content.text("A thin bicycle wheel."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 40,
    damage_modifier = 50,
    folded_volume = "3500 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 4, 13 } },
        { item = "shredded_rubber", count = { 5, 12 } },
    },
    rolling_resistance = 0.45,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 40,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { bash = 6 },
    variants = {
        { id = "front", label = "Front", symbols = "|\\-/|\\-/", broken_symbols = "x" },
        { id = "rear", label = "Rear", symbols = "|\\-/|\\-/", broken_symbols = "x" },
    },
}

ccb.content.define_vehicle_part {
    id = "wheel_bicycle_or",
    copy_from = "wheel_bicycle",
    item = "wheel_bicycle_or",
    description = ccb.content.text("A wide, studded bicycle wheel intended for off-road biking."),
    contact_area = 36,
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
}

ccb.content.define_vehicle_part {
    id = "wheel_caster",
    item = "wheel_caster",
    description = ccb.content.text("A set of small wheels mounted on pivots, like you'd find on a rolling office chair."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 70,
    damage_modifier = 50,
    folded_volume = "1250 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    rolling_resistance = 29.0,
    wheel_offroad_rating = 0.1,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 6 },
        { flag = "ROAD", move_override = 0, move_penalty = 3 },
    },
    contact_area = 4,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "soldering_standard", 15 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE" },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_caster_large",
    item = "wheel_caster_large",
    description = ccb.content.text("A set of medium wheels mounted on pivots, like you'd find on a shopping cart."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 70,
    damage_modifier = 50,
    folded_volume = "3150 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    rolling_resistance = 14.0,
    wheel_offroad_rating = 0.4,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 6 },
        { flag = "ROAD", move_override = 0, move_penalty = 3 },
    },
    contact_area = 12,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "soldering_standard", 15 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE" },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_10",
    item = "wheel_10",
    description = ccb.content.text("A set of solid-rubber wheels, like you'd find on small industrial equipment."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 120,
    folded_volume = "4000 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 5 } },
        { item = "scrap", count = { 1, 5 } },
        { item = "plastic_chunk", count = { 1, 5 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 3, 12 } },
        { item = "shredded_rubber", count = { 12, 30 } },
    },
    rolling_resistance = 29.0,
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    contact_area = 4,
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE" },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_skateboard",
    name = ccb.content.text("skateboard wheels"),
    description = ccb.content.text("A set of four small wheels, for a skateboard."),
    item = "wheel_skateboard",
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 70,
    damage_modifier = 50,
    folded_volume = "1250 ml",
    folding_time = "0 seconds",
    unfolding_time = "0 seconds",
    rolling_resistance = 1.5,
    wheel_offroad_rating = 0.3,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 6 },
        { flag = "ROAD", move_override = 0, move_penalty = 3 },
    },
    contact_area = 4,
    requirements = {
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "1 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        install = {
            skills = { { "mechanics", 0 } },
            duration = "1 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
    },
    flags = { "WHEEL", "NEEDS_WHEEL_MOUNT_SKATEBOARD", "STABLE", "STEERABLE" },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_skateboard",
    name = ccb.content.text("skateboard trucks"),
    description = ccb.content.text("A pair metal skateboard trucks, for attaching wheels to."),
    item = "wheel_mount_skateboard",
    location = "axle",
    categories = { "movement" },
    damage_modifier = 80,
    folded_volume = "200 ml",
    folding_time = "0 seconds",
    unfolding_time = "0 seconds",
    durability = 120,
    flags = { "WHEEL_MOUNT_SKATEBOARD" },
    requirements = {
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "3 m",
            qualities = { { id = "WRENCH", level = 2 }, { id = "SCREW", level = 1 } },
        },
        install = {
            skills = { { "mechanics", 0 } },
            duration = "3 m",
            qualities = { { id = "WRENCH", level = 2 }, { id = "SCREW", level = 1 } },
        },
    },
    breaks_into = { { item = "scrap", count = { 0, 1 } }, { item = "scrap_aluminum", count = { 0, 2 } } },
    damage_reduction = { all = 10 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_motorbike",
    item = "wheel_motorbike",
    description = ccb.content.text("A small wheel from a motorcycle."),
    location = "under",
    looks_like = "wheel",
    categories = { "movement" },
    color = "dark_gray",
    durability = 90,
    damage_modifier = 50,
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 3 } },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 8, 19 } },
        { item = "shredded_rubber", count = { 8, 20 } },
    },
    rolling_resistance = 1.9,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 66,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { bash = 10 },
    variants = {
        { id = "front", label = "Front", symbols = "o", broken_symbols = "x" },
        { id = "rear", label = "Rear", symbols = "o", broken_symbols = "x" },
    },
}

ccb.content.define_vehicle_part {
    id = "wheel_motorbike_or",
    copy_from = "wheel_motorbike",
    item = "wheel_motorbike_or",
    description = ccb.content.text("A motorbike wheel, studded for improved off-road performance."),
    contact_area = 60,
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 3 } },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 9, 25 } },
        { item = "shredded_rubber", count = { 8, 20 } },
    },
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    damage_reduction = { bash = 10, cut = 8, stab = 4 },
}

ccb.content.define_vehicle_part {
    id = "wheel_small",
    looks_like = "wheel",
    item = "wheel_small",
    description = ccb.content.text("A pretty small wheel.  Probably from one of those Segway things.  It is not very menacing."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 70,
    damage_modifier = 50,
    folded_volume = "2250 ml",
    breaks_into = {
        { item = "mc_steel_lump" },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 2, 12 } },
        { item = "shredded_rubber", count = { 5, 15 } },
    },
    rolling_resistance = 1.5,
    wheel_offroad_rating = 0.3,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 5 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 30,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_WHEEL_MOUNT_LIGHT" },
    variant_bases = { { id = "scooter", label = "Scooter" } },
    variants = {
        { id = "front", label = "Front", symbols = "o", broken_symbols = "x" },
        { id = "rear", label = "Rear", symbols = "o", broken_symbols = "x" },
    },
}

ccb.content.define_vehicle_part {
    id = "wheel_tricycle",
    item = "wheel_tricycle",
    description = ccb.content.text("A set of hard plastic wheels with one larger than the other two.  Proudly made in the USA by Double Dango Productions."),
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 30,
    damage_modifier = 50,
    breaks_into = { { item = "plastic_chunk", count = { 1, 3 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    rolling_resistance = 10.0,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 10,
    flags = { "STABLE", "STEERABLE", "WHEEL", "NEEDS_JACKING" },
    damage_reduction = { bash = 8 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_unicycle",
    name = ccb.content.text("unicycle wheel"),
    item = "wheel_bicycle",
    location = "under",
    looks_like = "wheel_bicycle",
    categories = { "movement" },
    color = "dark_gray",
    durability = 40,
    damage_modifier = 50,
    folded_volume = "3500 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 4, 13 } },
        { item = "shredded_rubber", count = { 5, 12 } },
    },
    rolling_resistance = 0.45,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 20,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE", "STEERABLE", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { bash = 8 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_wheelchair",
    item = "wheel_wheelchair",
    name = ccb.content.text("wheelchair wheels"),
    description = ccb.content.text("A pair of wheels for a wheelchair."),
    location = "under",
    looks_like = "wheel_bicycle",
    categories = { "movement" },
    color = "dark_gray",
    durability = 40,
    damage_modifier = 50,
    folded_volume = "6250 ml",
    breaks_into = {
        { item = "mc_steel_lump", probability = 50 },
        { item = "mc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "chunk_rubber", count = { 6, 20 } },
        { item = "shredded_rubber", count = { 10, 24 } },
    },
    rolling_resistance = 1.95,
    wheel_offroad_rating = 0.3,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 5 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 40,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "NEEDS_JACKING", "STABLE", "STEERABLE", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { bash = 6 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_wide",
    item = "wheel_wide",
    description = ccb.content.text("A wide wheel.  \\o/ This wide.  Provides more traction and better off-road performance."),
    location = "under",
    looks_like = "wheel",
    categories = { "movement" },
    color = "dark_gray",
    durability = 400,
    damage_modifier = 50,
    breaks_into = {
        { item = "mc_steel_lump", count = { 2, 3 } },
        { item = "mc_steel_chunk", count = { 2, 3 } },
        { item = "scrap", count = { 2, 3 } },
        { item = "rubber_tire_chunk", count = { 1, 3 } },
        { item = "chunk_rubber", count = { 8, 24 } },
        { item = "shredded_rubber", count = { 8, 20 } },
    },
    rolling_resistance = 0.575,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 360,
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "15 m",
            using_requirements = { { "vehicle_fasten", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "10 m",
            using_requirements = { { "adhesive_rubber", 1 }, { "tire_rubber", 1 } },
        },
    },
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_MEDIUM" },
    damage_reduction = { bash = 25 },
    variants = { { symbols = "O", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_wide_or",
    copy_from = "wheel_wide",
    item = "wheel_wide_or",
    description = ccb.content.text("A wide wheel.  \\o/ This wide.  It's studded to provide better grip off-road at the cost of some performance on pavement."),
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    contact_area = 320,
    damage_reduction = { bash = 20, cut = 15, stab = 10 },
}

ccb.content.define_vehicle_part {
    id = "wheel_wood",
    item = "wheel_wood",
    description = ccb.content.text("A handmade wooden cart wheel."),
    location = "under",
    categories = { "movement" },
    color = "brown",
    broken_color = "brown",
    durability = 30,
    damage_modifier = 50,
    breaks_into = { { item = "2x4", count = { 0, 4 } }, { item = "nail", charges = { 5, 15 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "50 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    rolling_resistance = 2.15,
    wheel_offroad_rating = 0.1,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 6 },
        { flag = "ROAD", move_override = 0, move_penalty = 3 },
    },
    contact_area = 60,
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_JACKING", "NEEDS_WHEEL_MOUNT_LIGHT" },
    damage_reduction = { all = 14 },
    variants = { { symbols = "|", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_wood_b",
    copy_from = "wheel_wood",
    item = "wheel_wood_b",
    description = ccb.content.text("A handmade wooden cart wheel with metal bands for durability."),
    breaks_into = {
        { item = "2x4", count = { 0, 4 } },
        { item = "nail", charges = { 5, 15 } },
        { item = "scrap", count = { 1, 2 } },
    },
    rolling_resistance = 2.05,
    proportional = { durability = 2, damage_modifier = 2 },
    damage_reduction = { all = 20 },
}

ccb.content.define_vehicle_part {
    id = "wheel_mount_concrete_mix",
    description = ccb.content.text("A set of two small wheel mounts from a concrete mixer."),
    categories = { "movement" },
    location = "axle",
    damage_modifier = 80,
    folded_volume = "500 ml",
    durability = 240,
    item = "wheel_mount_concrete_mix",
    flags = { "WHEEL_MOUNT_CONCRETE_MIX", "NEEDS_JACKING", "NO_INSTALL_HIDDEN" },
    breaks_into = { { item = "scrap", count = { 1, 8 } } },
    damage_reduction = { all = 10 },
    variants = { { symbols = "-", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "wheel_set_concrete_mix",
    description = ccb.content.text("A set of two small wheels from a concrete mixer."),
    looks_like = "wheel",
    item = "wheel_set_concrete_mix",
    location = "under",
    categories = { "movement" },
    color = "dark_gray",
    durability = 140,
    damage_modifier = 50,
    folded_volume = "5500 ml",
    breaks_into = {
        { item = "mc_steel_lump" },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 6 } },
    },
    rolling_resistance = 1.5,
    wheel_offroad_rating = 0.3,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 5 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 60,
    flags = { "WHEEL", "UNSTABLE_WHEEL", "NEEDS_WHEEL_MOUNT_CONCRETE_MIX", "NO_INSTALL_HIDDEN" },
    variants = { { symbols = "o", broken_symbols = "x" } },
}
