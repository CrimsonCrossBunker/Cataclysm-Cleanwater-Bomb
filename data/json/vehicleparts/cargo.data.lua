local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "cargo_bag",
    name = ccb.content.text("storage bag"),
    categories = { "cargo" },
    broken_color = "dark_gray",
    damage_modifier = 60,
    durability = 15,
    folded_volume = "1 L",
    size = "15 L",
    item = "bag_canvas",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "COVERED", "CARGO_PASSABLE" },
    breaks_into = "ig_vp_cloth",
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "metal_tray",
    name = ccb.content.text("metal tray"),
    categories = { "cargo" },
    broken_color = "dark_gray",
    damage_modifier = 60,
    durability = 75,
    size = "15 L",
    item = "sheet_metal",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_bolt_install_simple", 1 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 }, { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "CARGO_PASSABLE", "FLAT_SURF" },
    breaks_into = "ig_vp_sheet_metal",
    variants = { { symbols = "T", broken_symbols = "#" } },
}

-- weld together the edges of the basket, assume roughly 60 cm length each for 120 total, 30 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    abstract = "basketlg_abstract",
    categories = { "cargo" },
    looks_like = "basketsm",
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 75,
    size = "150 L",
    item = "basket",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 }, { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "CARGO" },
    damage_reduction = { all = 6 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    copy_from = "basketlg_abstract",
    id = "basketlg",
    description = ccb.content.text("A large wire basket from a shopping cart."),
    variant_bases = { { id = "cart", label = "Cart" } },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- weld together the edges of the basket, assume roughly 60 cm length, but only on one side, still 30 cm per repair.
ccb.content.define_vehicle_part {
    id = "basketlg_external",
    name = ccb.content.text("external wire basket"),
    looks_like = "basketlg",
    item = "basket",
    location = "structure",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    durability = 75,
    description = ccb.content.text("Storage space, mounted outside your vehicle's armor and vulnerable to damage."),
    size = "50 L",
    damage_modifier = 60,
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "welding_standard", 60 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "UNMOUNT_ON_DAMAGE", "CARGO", "PROTRUSION", "CARGO_PASSABLE" },
    damage_reduction = { all = 6 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- weld together the edges of the basket, assume roughly 60 cm length each, 30 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "basketlg_folding",
    description = ccb.content.text("A large wire basket from a shopping cart, modified to be foldable."),
    looks_like = "basketlg",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 75,
    size = "150 L",
    folded_volume = "6 L",
    item = "folding_basket",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 120 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 }, { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "CARGO" },
    damage_reduction = { all = 4 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- 10 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    abstract = "basketsm_abstract",
    looks_like = "basketlg",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 75,
    folded_volume = "1500 ml",
    size = "20 L",
    item = "bike_basket",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 }, { "fabrication", 1 } },
            duration = "2 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "CARGO", "CARGO_PASSABLE" },
    damage_reduction = { all = 6 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    copy_from = "basketsm_abstract",
    id = "basketsm",
    description = ccb.content.text("A simple bike basket.  It is small and foldable."),
    variant_bases = { { id = "bike_rear", label = "Bike Rear" }, { id = "wheelchair", label = "Wheelchair" } },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- weld one edge of the bike basket, assume roughly 20 cm, or 10 cm per repair
ccb.content.define_vehicle_part {
    id = "basketsm_external",
    name = ccb.content.text("external bike basket"),
    looks_like = "basketsm",
    item = "bike_basket",
    location = "structure",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    durability = 75,
    description = ccb.content.text("Storage space, mounted outside your vehicle's armor and vulnerable to damage."),
    size = "15 L",
    damage_modifier = 60,
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "welding_standard", 20 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "2 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "UNMOUNT_ON_DAMAGE", "CARGO", "PROTRUSION", "CARGO_PASSABLE" },
    damage_reduction = { all = 6 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    abstract = "box_abstract",
    name = ccb.content.text("box"),
    categories = { "cargo" },
    looks_like = "f_crate_o",
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 100,
    size = "68750 ml",
    item = "frame",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "2 m",
            using_requirements = { { "repair_welding_lc_steel", 1 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "COVERED", "LOCKABLE_CARGO", "CARGO_PASSABLE" },
    breaks_into = "ig_vp_frame",
    damage_reduction = { all = 28 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    copy_from = "box_abstract",
    id = "box",
    variant_bases = { { id = "wheelbarrow", label = "Wheelbarrow" } },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- Volume based off of:
-- https://www.uline.com/Product/Detail/H-7938BL/Trash-Cans-with-Wheels/Uline-Trash-Can-with-Wheels-95-Gallon-Black?pricode=WB3072&utm_source=Bing&utm_medium=pla&utm_term=H-7938BL&utm_campaign=Facilities%2BMaintenance&utm_source=Bing&utm_medium=pla&utm_term=H-7938BL&utm_campaign=Facilities%2BMaintenance&msclkid=d3c8827d02691eb87066e72c65ff5790
ccb.content.define_vehicle_part {
    copy_from = "box_abstract",
    id = "integrated_trashcan",
    name = ccb.content.text("industrial trash can"),
    categories = { "cargo" },
    looks_like = "f_recycle_bin",
    color = "light_gray",
    broken_color = "light_gray",
    size = "359614 ml",
    item = "trashcan_large",
    extend = { flags = { "NO_INSTALL_HIDDEN" } },
    delete = { flags = { "CARGO_PASSABLE" } },
    variant_bases = { { id = "trash can", label = "Trash Can" } },
    variants = { { symbols = ")", broken_symbols = "#" } },
}

-- assume 1 m sq cargo space affixed on one edge, 100 cm weld and 50 cm weld to repair each damage quadrant
ccb.content.define_vehicle_part {
    id = "cargo_space_external",
    name = ccb.content.text("external cargo rack"),
    item = "cargo_rack",
    location = "structure",
    categories = { "cargo" },
    broken_color = "dark_gray",
    durability = 250,
    description = ccb.content.text("Storage space, mounted outside your vehicle's armor and vulnerable to damage."),
    size = "250 L",
    breaks_into = {},
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "12 m",
            using_requirements = { { "welding_standard", 100 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "6 m",
            using_requirements = { { "repair_welding_standard", 5 } },
        },
    },
    flags = { "UNMOUNT_ON_DAMAGE", "CARGO", "PROTRUSION", "COVERED", "BOARDABLE", "HUGE_OK", "CARGO_PASSABLE" },
    damage_reduction = { all = 26 },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

-- 20 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "bike_rack",
    item = "bike_rack",
    location = "on_frame",
    categories = { "cargo" },
    broken_color = "dark_gray",
    durability = 150,
    description = ccb.content.text("A collection of pipes and frames for supporting a bike or other small vehicle and carrying it on your vehicle.  Move a single tile wide vehicle so that all of that vehicle's tiles are next to bike racks, and then 'e'xamine any bike rack to mount that vehicle onto the bike rack.  'e'xamine the bike rack to unmount the carried vehicle."),
    breaks_into = {
        { item = "mc_steel_lump", count = { 6, 8 } },
        { item = "mc_steel_chunk", count = { 6, 8 } },
        { item = "scrap", count = { 6, 8 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "BIKE_RACK_VEH", "MULTISQUARE" },
    damage_reduction = { all = 10 },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "mounted_spare_tire",
    item = "mounted_spare_tire",
    location = "structure",
    categories = { "other" },
    broken_color = "dark_gray",
    durability = 75,
    description = ccb.content.text("Spare tire stored on an external carrier rig."),
    damage_modifier = 60,
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
    },
    flags = { "UNMOUNT_ON_DAMAGE", "PROTRUSION", "CARGO_PASSABLE" },
    damage_reduction = { all = 10 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- https://www.magliner.com/extruded-aluminum-nose-flush-mount-300248
-- Rated for 500 lbs but LIFT/JACK 1 is 1000kg.  Volume of the nose plate's bounding box is about 12.5L.
ccb.content.define_vehicle_part {
    copy_from = "box_abstract",
    id = "nose_plate",
    name = ccb.content.text("nose plate"),
    looks_like = "forklift_fork",
    item = "nose_plate",
    color = "light_gray",
    variants = { { symbols = "L", broken_symbols = "#" } },
    flags = { "BOARDABLE", "CARGO", "CARGO_PASSABLE", "FURNITURE_TIEDOWN", "FURNITURE_LIFT_ASSIST" },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
    },
    description = ccb.content.text("An L-shaped aluminum plate with straps and skid runners.  This could help you move furniture or appliances more safely, but Jevons' Paradox also applies to throwing your back out."),
    breaks_into = {
        { item = "sheet_aluminum_small", count = { 2, 4 } },
        { item = "seatbelt", count = { 0, 2 } },
    },
    qualities = { { "LIFT", 1 }, { "JACK", 1 } },
    folded_volume = "7 L",
    size = "15000 ml",
}
