local ccb = require("ccb")

-- weld repairs would mostly be the frame and springs of the seat, so low 6 cm cost per quadrant
ccb.content.define_vehicle_part {
    id = "seat",
    breaks_into = "ig_vp_seat",
    broken_color = "red",
    categories = { "operations", "passengers" },
    color = "red",
    comfort = 2,
    damage_modifier = 60,
    damage_reduction = { all = 2, bash = 5 },
    description = ccb.content.text("A soft car seat made from synthetic fabric."),
    durability = 300,
    flags = { "SEAT", "BOARDABLE", "CARGO", "BELTABLE" },
    floor_bedding_warmth = 200,
    item = "seat",
    location = "center",
    looks_like = "reclining_seat",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "repair_welding_standard", 1 }, { "sewing_standard", 8 } },
        },
    },
    size = "40 L",
    cargo_passable_size = "100 L",
    variant_bases = {
        { id = "windshield", label = "Windshield" },
        { id = "swivel_chair", label = "Swivel Chair" },
    },
    variants = {
        { id = "front", label = "Front", symbols = "#", broken_symbols = "*" },
        { id = "vertical", label = "Vertical", symbols = "#", broken_symbols = "*" },
        { id = "vertical_left", label = "Left Vertical", symbols = "#", broken_symbols = "*" },
        { id = "vertical_right", label = "Right Vertical", symbols = "#", broken_symbols = "*" },
        { id = "left", label = "Left", symbols = "#", broken_symbols = "*" },
        { id = "right", label = "Right", symbols = "#", broken_symbols = "*" },
        { id = "rear", label = "Rear", symbols = "#", broken_symbols = "*" },
    },
}

ccb.content.define_vehicle_part {
    id = "seat_leather",
    breaks_into = "ig_vp_seat_leather",
    copy_from = "seat",
    item = "seat_leather",
    description = ccb.content.text("A soft car seat covered with leather."),
    variant_bases = { { id = "windshield", label = "Windshield" } },
}

ccb.content.define_vehicle_part {
    id = "reclining_seat",
    copy_from = "seat",
    comfort = 3,
    description = ccb.content.text("A soft seat with an adjustable backrest, making it a reasonably comfortable place to sleep."),
    durability = 100,
    size = "50 L",
    floor_bedding_warmth = 350,
    name = ccb.content.text("reclining bucket seat"),
    extend = { flags = { "BED" } },
    variant_bases = { { id = "windshield", label = "Windshield" } },
}

ccb.content.define_vehicle_part {
    id = "reclining_seat_leather",
    breaks_into = "ig_vp_seat_leather",
    copy_from = "reclining_seat",
    item = "seat_leather",
    looks_like = "seat_leather",
    name = ccb.content.text("reclining leather bucket seat"),
    variant_bases = { { id = "windshield", label = "Windshield" } },
}

ccb.content.define_vehicle_part {
    id = "seat_back",
    copy_from = "seat",
    comfort = 3,
    description = ccb.content.text("A wide, flat seat like you'd find in the back of a sedan, upholstered with soft nylon."),
    floor_bedding_warmth = 500,
    item = "seat_bench",
    size = "50 L",
    extend = { flags = { "BED" } },
}

ccb.content.define_vehicle_part {
    id = "seat_back_leather",
    copy_from = "seat_back",
    breaks_into = "ig_vp_seat_leather",
    item = "seat_bench_leather",
    description = ccb.content.text("A wide, flat seat like you'd find in the back of a sedan, upholstered with leather."),
    looks_like = "seat_leather",
}

-- weld repairs would mostly be the frame, so low 4 cm cost per quadrant
ccb.content.define_vehicle_part {
    id = "saddle",
    copy_from = "seat",
    floor_bedding_warmth = 50,
    durability = 80,
    description = ccb.content.text("A padded wedge that you straddle, like a bicycle or motorcycle."),
    folded_volume = "1250 ml",
    comfort = 1,
    item = "saddle",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "200 s",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 1 }, { "sewing_standard", 4 } },
        },
    },
    breaks_into = { { item = "leather", probability = 50 }, { item = "scrap", count = { 1, 2 } } },
    size = "0 ml",
    extend = { flags = { "NONBELTABLE" } },
    delete = { flags = { "BELTABLE", "CARGO" } },
    variant_bases = {},
    variants = {
        { id = "pedal", label = "Pedals", symbols = "#", broken_symbols = "*" },
        { id = "motor", label = "Motorcycle", symbols = "#", broken_symbols = "*" },
        { id = "scooter", label = "Scooter", symbols = "#", broken_symbols = "*" },
    },
}

ccb.content.define_vehicle_part {
    id = "folding_seat",
    copy_from = "saddle",
    name = ccb.content.text("cloth seat"),
    floor_bedding_warmth = 0,
    durability = 20,
    description = ccb.content.text("A simple fabric seat, suspended from the frame itself."),
    item = "sheet",
    folded_volume = "1000 ml",
    location = "on_frame",
    requirements = {
        repair = {
            skills = { { "tailor", 2 } },
            duration = "200 s",
            using_requirements = { { "sewing_standard", 4 } },
        },
    },
    breaks_into = { { item = "cotton_patchwork", count = { 1, 6 } } },
    extend = { flags = { "BELTABLE" } },
    delete = { flags = { "NONBELTABLE" } },
    variants = { { symbols = "#", broken_symbols = "*" } },
}

-- more metal here so bigger weld cost - 20 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "metal_bench",
    copy_from = "seat_back",
    breaks_into = "ig_vp_steel_plate",
    comfort = 0,
    floor_bedding_warmth = 0,
    description = ccb.content.text("A steel bench with ankle and wrist restraints built in.  It looks very uncomfortable."),
    durability = 450,
    item = "steel_plate",
    name = ccb.content.text("steel bench"),
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_lc_steel", 2 } },
        },
    },
}
