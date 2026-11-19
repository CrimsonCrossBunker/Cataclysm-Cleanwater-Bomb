local ccb = require("ccb")

-- constructed from a 1 meter armor sheet in most cases, affixed along two edges = 200 cm weld to install.
ccb.content.define_vehicle_part {
    abstract = "ram_blaze",
    categories = { "warfare" },
    location = "structure",
    damage_modifier = 150,
    description = ccb.content.text("A reinforced ram.  Place at the edge of vehicle to reduce damage taken in collisions, and to increase damaged delivered in collisions, if the ram is the first vehicle part to collide."),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 5 } },
        },
    },
    flags = { "PROTRUSION", "OBSTACLE" },
    variants = {
        { id = "front", label = "Front", symbols = "^^<vvv>^", broken_symbols = "*" },
        { id = "rear", label = "Rear", symbols = "vv>^^^<v", broken_symbols = "*" },
        { id = "left", label = "Left", symbols = "<<v>>>^<", broken_symbols = "*" },
        { id = "right", label = "Right", symbols = ">>^<<<v>", broken_symbols = "*" },
    },
}

ccb.content.define_vehicle_part {
    id = "ram_alloy",
    copy_from = "ram_blaze",
    name = ccb.content.text("superalloy ram"),
    item = "alloy_plate",
    color = "dark_gray",
    broken_color = "dark_gray",
    durability = 860,
    bonus = 50,
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 87 },
    extend = { flags = { "SHOCK_RESISTANT" } },
}

ccb.content.define_vehicle_part {
    id = "ram_hardsteel",
    copy_from = "ram_blaze",
    name = ccb.content.text("heavy steel ram"),
    item = "hard_plate",
    color = "cyan",
    broken_color = "cyan",
    durability = 860,
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    damage_reduction = { all = 87 },
}

ccb.content.define_vehicle_part {
    id = "ram_military",
    copy_from = "ram_blaze",
    name = ccb.content.text("military composite ram"),
    item = "mil_plate",
    color = "green",
    broken_color = "green",
    durability = 875,
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
        { item = "ceramic_armor", count = { 0, 4 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "20 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {},
    },
    extend = { flags = { "NO_REPAIR" } },
    damage_reduction = { all = 75, bullet = 131 },
}

ccb.content.define_vehicle_part {
    id = "ram_spiked",
    copy_from = "ram_blaze",
    name = ccb.content.text("spiked ram"),
    item = "spiked_plate",
    color = "red",
    broken_color = "red",
    durability = 775,
    damage_modifier = 200,
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
        { item = "spike", count = { 0, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "45 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 60 },
}

ccb.content.define_vehicle_part {
    id = "ram_steel",
    copy_from = "ram_blaze",
    name = ccb.content.text("steel ram"),
    item = "steel_plate",
    color = "light_cyan",
    broken_color = "light_cyan",
    durability = 825,
    breaks_into = "ig_vp_steel_plate",
    damage_reduction = { all = 70 },
    requirements = {
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 6 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "ram_wood",
    copy_from = "ram_blaze",
    name = ccb.content.text("wooden ram"),
    item = "wood_plate",
    color = "brown",
    broken_color = "brown",
    durability = 312,
    breaks_into = "ig_vp_wood_plate",
    requirements = {
        install = {
            skills = { { "fabrication", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 20, cut = 10, stab = 10 },
}

ccb.content.define_vehicle_part {
    id = "ram_chitin",
    copy_from = "ram_blaze",
    name = ccb.content.text("chitin ram"),
    item = "chitin_plate",
    color = "yellow",
    looks_like = "ram_wood",
    durability = 250,
    breaks_into = { { item = "chitin_piece", count = { 5, 15 } } },
    damage_reduction = { all = 25 },
}

ccb.content.define_vehicle_part {
    id = "ram_acidchitin",
    copy_from = "ram_chitin",
    name = ccb.content.text("biosilicified chitin ram"),
    item = "acidchitin_plate",
    proportional = { durability = 1.1 },
    breaks_into = { { item = "chitin_piece", count = { 6, 19 } } },
    damage_reduction = { all = 30 },
}

ccb.content.define_vehicle_part {
    id = "ram_mattress",
    copy_from = "ram_blaze",
    name = ccb.content.text("tied mattress"),
    item = "mattress",
    color = "white",
    damage_modifier = 50,
    durability = 40,
    description = ccb.content.text("A mattress, strapped onto the vehicle.  It could serve to blunt any impact."),
    breaks_into = {
        { item = "sheet_cotton", count = { 5, 6 } },
        { item = "cotton_patchwork", count = { 8, 15 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "rope_natural_short", 2 } },
        },
        removal = { skills = { { "mechanics", 0 } }, duration = "5 m", using_requirements = {} },
    },
    damage_reduction = { bash = 20 },
    extend = { flags = { "OPAQUE" } },
    variants = { { symbols = "=", broken_symbols = "*" } },
}

-- 120 cm weld to affix it to a vehicle
ccb.content.define_vehicle_part {
    id = "tearer",
    copy_from = "ram_blaze",
    description = ccb.content.text("This menacing-looking attachment is meant to be powered by a vehicle's engine.  Upon doing so, the circular blades of this device will rotate rapidly; anything in front of it is likely to be ripped to shreds.  It is sturdy enough to withstand multiple impacts, and is designed to detach if it would take a hit that would break it."),
    item = "tearer",
    color = "dark_gray",
    broken_color = "dark_gray",
    durability = 450,
    power = "-1750 W",
    damage_modifier = 500,
    breaks_into = {},
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    extend = { flags = { "SHARP", "UNMOUNT_ON_DAMAGE" } },
    delete = { flags = { "OBSTACLE" } },
    damage_reduction = { all = 40 },
    variants = { { symbols = "*", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    copy_from = "ram_blaze",
    id = "blade",
    damage_modifier = 250,
    durability = 200,
    description = ccb.content.text("A blade, welded to the vehicle, for cutting up zombies."),
    item = "blade",
    folded_volume = "750 ml",
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
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    extend = { flags = { "SHARP" } },
    delete = { flags = { "OBSTACLE" } },
    breaks_into = { { item = "mc_steel_chunk", probability = 50 } },
}

ccb.content.define_vehicle_part {
    copy_from = "blade",
    id = "spike",
    damage_modifier = 300,
    durability = 250,
    color = "white",
    broken_color = "white",
    description = ccb.content.text("A metal spike, welded to the vehicle, to increase injury when crashing into things."),
    item = "spike",
    folded_volume = "250 ml",
    breaks_into = { { item = "mc_steel_chunk", count = { 1, 2 } } },
    damage_reduction = { all = 12 },
    variants = { { symbols = ".", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "spike_wood",
    copy_from = "spike",
    name = ccb.content.text("wooden spike"),
    color = "brown",
    broken_color = "brown",
    damage_modifier = 115,
    durability = 150,
    description = ccb.content.text("A wooden spike, attached to the vehicle, to increase injury when crashing into things."),
    item = "pointy_stick",
    folded_volume = "1250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 3, 7 } } },
    damage_reduction = { all = 0 },
}
