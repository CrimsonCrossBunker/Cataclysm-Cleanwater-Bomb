local ccb = require("ccb")

-- NO_I18N
ccb.content.define_vehicle_part {
    id = "null",
    name = ccb.content.text_without_extraction("null part"),
    categories = { "other" },
    color = "red",
    broken_color = "red",
    durability = 100,
    item = "null",
    flags = { "NO_INSTALL_HIDDEN" },
    breaks_into = {},
    variants = { { symbols = "?", broken_symbols = "?" } },
}

ccb.content.define_vehicle_part {
    id = "yoke_harness",
    description = ccb.content.text("A bar and harness to attach a sufficiently large creature to a wheeled vehicle, allowing them to pull it along."),
    looks_like = "frame_wood_cross",
    categories = { "movement", "operations" },
    color = "brown",
    broken_color = "red",
    damage_modifier = 10,
    noise_factor = 5,
    fuel_type = "animal",
    durability = 20,
    item = "yoke_harness",
    m2c = 90,
    contact_area = 60,
    rolling_resistance = 1.5,
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    location = "structure",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "fabrication", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    breaks_into = "ig_vp_wood_plate",
    flags = {
        "ENGINE",
        "BOARDABLE",
        "E_STARTS_INSTANTLY",
        "ANIMAL_CTRL",
        "HARNESS_any",
        "STEERABLE",
        "UNMOUNT_ON_DAMAGE",
        "UNSTABLE_WHEEL",
        "WHEEL",
        "HUGE_OK",
    },
    damage_reduction = { all = 2 },
    variants = { { symbols = "H", broken_symbols = "M" } },
}

ccb.content.define_vehicle_part {
    id = "yoke_harness_heavyduty",
    description = ccb.content.text("A bar and harness to attach a sufficiently large creature to a wheeled vehicle, allowing them to pull it along."),
    looks_like = "yoke_harness",
    categories = { "movement", "operations" },
    color = "dark_gray",
    broken_color = "dark_gray",
    noise_factor = 10,
    fuel_type = "animal",
    durability = 600,
    item = "yoke_harness_heavyduty",
    m2c = 90,
    contact_area = 60,
    rolling_resistance = 1.5,
    wheel_offroad_rating = 0.7,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 3 },
        { flag = "ROAD", move_override = 0, move_penalty = 1 },
    },
    location = "structure",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 3, 5 } },
        { item = "mc_steel_chunk", count = { 3, 5 } },
        { item = "scrap", count = { 4, 8 } },
        { item = "splinter", count = { 5, 9 } },
    },
    flags = {
        "ENGINE",
        "BOARDABLE",
        "E_STARTS_INSTANTLY",
        "ANIMAL_CTRL",
        "HARNESS_any",
        "STEERABLE",
        "UNMOUNT_ON_DAMAGE",
        "UNSTABLE_WHEEL",
        "WHEEL",
        "HUGE_OK",
    },
    damage_reduction = { all = 20 },
    variants = { { symbols = "H", broken_symbols = "M" } },
}

-- 10 cm weld per damage quadrant to repair, 10 cm weld to install
ccb.content.define_vehicle_part {
    id = "cart_handle",
    name = ccb.content.text("cart handle"),
    looks_like = "frame_wood_horizontal",
    categories = { "movement", "operations" },
    color = "white",
    broken_color = "red",
    damage_modifier = 10,
    fuel_type = "animal",
    durability = 20,
    item = "pipe",
    m2c = 90,
    description = ccb.content.text("A metal handle, a creature with hands could use it to push a vehicle."),
    location = "structure",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "150 s",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    breaks_into = { { item = "scrap", count = { 4, 6 } } },
    flags = {
        "ENGINE",
        "BOARDABLE",
        "E_STARTS_INSTANTLY",
        "ANIMAL_CTRL",
        "HARNESS_human",
        "STEERABLE",
        "UNMOUNT_ON_DAMAGE",
        "HUGE_OK",
    },
    damage_reduction = { all = 2 },
    variants = { { symbols = "-", broken_symbols = "~" } },
}

-- 10 cm weld per damage quadrant to repair, 30 cm weld to install
ccb.content.define_vehicle_part {
    id = "bed",
    name = ccb.content.text("bed"),
    looks_like = "f_bed",
    categories = { "passengers" },
    color = "magenta",
    broken_color = "magenta",
    damage_modifier = 60,
    durability = 95,
    description = ccb.content.text("A small but comfortable bed."),
    size = "65 L",
    item = "mattress",
    comfort = 4,
    floor_bedding_warmth = 700,
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "welding_standard", 30 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 1 }, { "sewing_standard", 10 } },
        },
    },
    flags = { "BED", "BOARDABLE", "CARGO", "MOUNTABLE", "NONBELTABLE" },
    breaks_into = {
        { count = { 0, 2 }, item = "sheet_cotton" },
        { count = { 0, 5 }, item = "cotton_patchwork" },
        { count = { 9, 50 }, item = "scrap_cotton" },
        { count = { 0, 16 }, item = "hc_wire" },
        { count = { 3, 8 }, item = "scrap" },
    },
    damage_reduction = { all = 3, bash = 5 },
    variants = { { symbols = "#", broken_symbols = "*" } },
}

-- 10 cm weld per damage quadrant to repair, 10 cm weld to install
ccb.content.define_vehicle_part {
    id = "frame_handle",
    name = ccb.content.text("handle"),
    categories = { "hull" },
    color = "light_cyan",
    broken_color = "light_cyan",
    durability = 30,
    description = ccb.content.text("A pair of handles.  You can mount other items on top of it."),
    folded_volume = "750 ml",
    item = "pipe",
    location = "structure",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "welding_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "MOUNTABLE" },
    breaks_into = { { item = "mc_steel_chunk", count = { 0, 1 } }, { item = "scrap", count = { 3, 7 } } },
    damage_reduction = { all = 5 },
    variants = { { symbols = "^", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "frame_wood_handle",
    name = ccb.content.text("wooden handle"),
    looks_like = "frame_wood_cover",
    categories = { "hull" },
    color = "light_red",
    broken_color = "brown",
    durability = 150,
    description = ccb.content.text("A pair of handles.  You can mount other items on top of it."),
    item = "frame_wood",
    location = "structure",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 5, 10 } } },
    damage_reduction = { all = 4 },
    variants = { { symbols = "^", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "frame_wood_light_handle",
    name = ccb.content.text("light wooden handle"),
    looks_like = "frame_wood_light_cover",
    categories = { "hull" },
    color = "light_red",
    broken_color = "brown",
    durability = 100,
    description = ccb.content.text("A pair of handles.  You can mount other items on top of it."),
    item = "frame_wood_light",
    location = "structure",
    breaks_into = {
        { item = "splinter", count = { 5, 8 } },
        { item = "string_36", count = { 1, 3 } },
        { item = "string_6", count = { 1, 4 } },
    },
    requirements = {
        install = {
            skills = { { "fabrication", 0 } },
            duration = "10 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
        repair = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    variants = { { symbols = "^", broken_symbols = "#" } },
}

-- .5 m square sheet of metal, likely affixed with bolts in places, assume 200 cm weld to install and 50 cm weld to repair
ccb.content.define_vehicle_part {
    id = "aisle",
    name = ccb.content.text("aisle"),
    looks_like = "t_metal_floor",
    categories = { "hull", "passengers" },
    color = "white",
    durability = 400,
    item = "sheet_metal",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    flags = { "AISLE", "BOARDABLE" },
    breaks_into = {
        { item = "sheet_metal_small", count = { 0, 1 } },
        { item = "lc_steel_lump", count = { 1, 2 } },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 4, 8 } },
    },
    damage_reduction = { all = 28 },
    variants = {
        { id = "horizontal", label = "Horizontal", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "vertical", label = "Vertical", symbols = "━━┃━━━┃━", broken_symbols = "#" },
    },
}

ccb.content.define_vehicle_part {
    id = "wooden_aisle",
    copy_from = "aisle",
    name = ccb.content.text("wooden aisle"),
    color = "brown",
    broken_color = "brown",
    durability = 200,
    item = "frame_wood",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 5, 10 } } },
    damage_reduction = { all = 16 },
}

ccb.content.define_vehicle_part {
    id = "foldable_aisle",
    copy_from = "wooden_aisle",
    name = ccb.content.text("collapsible wooden aisle"),
    looks_like = "t_floor",
    folded_volume = "12500 ml",
    item = "foldwoodframe",
    breaks_into = { { item = "splinter", count = { 7, 11 } }, { item = "nail", charges = { 5, 10 } } },
    flags = { "AISLE", "BOARDABLE" },
}

-- same requirements as aisle to install but higher repair costs due to more mass
ccb.content.define_vehicle_part {
    id = "trunk_floor",
    name = ccb.content.text("floor trunk"),
    looks_like = "t_carpet_red",
    categories = { "cargo" },
    color = "white",
    durability = 400,
    description = ccb.content.text("An aisle.  A hatch lets you access a cargo space beneath it, keeping items stored here out of the way."),
    size = "87500 ml",
    item = "cargo_aisle",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "AISLE", "BOARDABLE", "CARGO", "CARGO_PASSABLE", "LOCKABLE_CARGO", "COVERED" },
    breaks_into = {
        { item = "sheet_metal_small", count = { 1, 3 } },
        { item = "lc_steel_lump", count = { 2, 4 } },
        { item = "lc_steel_chunk", count = { 2, 8 } },
        { item = "scrap", count = { 11, 17 } },
    },
    damage_reduction = { all = 28 },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "roof_cloth",
    name = ccb.content.text("cloth roof"),
    categories = { "hull" },
    broken_color = "dark_gray",
    durability = 15,
    folded_volume = "3750 ml",
    item = "sheet",
    location = "roof",
    requirements = {
        install = { duration = "5 m", components = { { { "string_6", 2 }, { "duct_tape", 25 } } } },
        repair = {
            skills = { { "tailor", 1 } },
            duration = "150 s",
            using_requirements = { { "sewing_standard", 50 }, { "fabric_standard", 1 } },
        },
    },
    flags = { "ROOF" },
    breaks_into = "ig_vp_cloth",
    variants = { { symbols = "#", broken_symbols = "#" } },
}

-- same requirements as aisle
ccb.content.define_vehicle_part {
    id = "roof",
    name = ccb.content.text("roof"),
    categories = { "hull" },
    broken_color = "dark_gray",
    durability = 240,
    item = "sheet_metal",
    location = "roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    flags = { "ROOF" },
    breaks_into = "ig_vp_sheet_metal",
    damage_reduction = { all = 20 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

-- higher reqs than roof due to extra welds for redundancy
ccb.content.define_vehicle_part {
    id = "hdroof",
    name = ccb.content.text("heavy-duty roof"),
    categories = { "hull" },
    color = "dark_gray",
    broken_color = "dark_gray",
    durability = 1000,
    item = "steel_plate",
    location = "roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 300 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 6 } },
        },
    },
    flags = { "ROOF" },
    breaks_into = "ig_vp_steel_plate",
    damage_reduction = { all = 30 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "programmable_autopilot",
    categories = { "other" },
    color = "light_blue",
    broken_color = "red",
    damage_modifier = 80,
    durability = 100,
    folded_volume = "2500 ml",
    description = ccb.content.text("A computer system hooked up to the steering and engine of a vehicle to allow it to follow simple paths."),
    item = "programmable_autopilot",
    looks_like = "cam_control",
    epower = "-15 W",
    flags = { "ENABLED_DRAINS_EPOWER", "AUTOPILOT" },
    requirements = {
        install = {
            duration = "12 m",
            skills = { { "mechanics", 5 }, { "electronics", 5 }, { "computer", 5 } },
            qualities = { { id = "SCREW", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "3 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 8 } },
        },
        removal = { skills = { { "mechanics", 3 } }, qualities = { { id = "SCREW", level = 1 } } },
    },
    breaks_into = {
        { item = "RAM", probability = 10 },
        { item = "lc_steel_lump", count = { 0, 2 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 5, 12 } },
        { item = "e_scrap", count = { 2, 5 } },
        { item = "plastic_chunk", count = { 3, 6 } },
        { item = "cable", count = { 9, 17 } },
    },
    damage_reduction = { all = 8 },
    variants = { { symbols = "A", broken_symbols = "#" } },
}

-- 40 cm weld to affix
ccb.content.define_vehicle_part {
    id = "storage_battery_mount",
    categories = { "energy" },
    broken_color = "red",
    damage_modifier = 80,
    durability = 300,
    item = "it_battery_mount",
    description = ccb.content.text("A battery case for storage batteries.  It has a charging controller chip, connecting wires, and a harness for securing a battery.  Allows quick removal or addition of a storage battery to a vehicle's power grid, if you can lift the battery."),
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "BATTERY_MOUNT" },
    breaks_into = {
        { item = "lc_steel_lump", probability = 50 },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 0, 3 } },
    },
    damage_reduction = { all = 8, bash = 10 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "handheld_battery_mount",
    categories = { "energy" },
    broken_color = "red",
    damage_modifier = 80,
    durability = 100,
    folded_volume = "300 ml",
    item = "it_handheld_battery_mount",
    description = ccb.content.text("A mount for batteries usually used in handheld tools.  It has a power converter, a charging controller chip, connecting wires, and a harness for securing a battery.  Allows quick removal or addition of such batteries to a vehicle's power grid."),
    location = "fuel_source",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "HANDHELD_BATTERY_MOUNT" },
    breaks_into = { { item = "power_supply", probability = 50 }, { item = "scrap", count = { 1, 4 } } },
    damage_reduction = { all = 4, bash = 5 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "black_box",
    item = "black_box",
    description = ccb.content.text("An armored black box, a device meant to record and preserve data of a military vehicle in the field in case it gets destroyed."),
    durability = 400,
    categories = { "other" },
    broken_color = "dark_gray",
    flags = { "NO_REPAIR" },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            qualities = { { id = "SCREW", level = 3 }, { id = "WRENCH", level = 3 } },
        },
        removal = { skills = { { "mechanics", 2 } }, using_requirements = { { "vehicle_screw", 1 } } },
    },
    breaks_into = { { item = "black_box" } },
    damage_reduction = { all = 80 },
    variants = { { symbols = ";", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "minifridge",
    delete = { flags = { "APPLIANCE", "CTRL_ELECTRONIC" } },
    copy_from = "ap_minifridge",
}

-- add looks_like so that it rotates properly in vehicles
ccb.content.define_vehicle_part {
    id = "big_portable_fridge",
    looks_like = "minifridge",
    delete = { flags = { "APPLIANCE", "CTRL_ELECTRONIC" } },
    copy_from = "ap_big_portable_fridge",
    variants = {
        { id = "up", label = "Up", symbols = "H", broken_symbols = "#" },
        { id = "down", label = "Down", symbols = "H", broken_symbols = "#" },
        { id = "left", label = "Left", symbols = "H", broken_symbols = "#" },
        { id = "right", label = "Right", symbols = "H", broken_symbols = "#" },
    },
}

ccb.content.define_vehicle_part {
    id = "minifreezer",
    delete = { flags = { "APPLIANCE", "CTRL_ELECTRONIC" } },
    copy_from = "ap_minifreezer",
}

ccb.content.define_vehicle_part {
    id = "chest_minifreezer",
    delete = { flags = { "APPLIANCE", "CTRL_ELECTRONIC" } },
    copy_from = "ap_chest_minifreezer",
}

-- add looks_like so that it rotates properly in vehicles
ccb.content.define_vehicle_part {
    id = "big_portable_freezer",
    looks_like = "minifridge",
    delete = { flags = { "APPLIANCE", "CTRL_ELECTRONIC" } },
    copy_from = "ap_big_portable_freezer",
    variants = {
        { id = "up", label = "Up", symbols = "H", broken_symbols = "#" },
        { id = "down", label = "Down", symbols = "H", broken_symbols = "#" },
        { id = "left", label = "Left", symbols = "H", broken_symbols = "#" },
        { id = "right", label = "Right", symbols = "H", broken_symbols = "#" },
    },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "washing_machine",
    looks_like = "f_washer",
    categories = { "utility" },
    color = "light_blue",
    broken_color = "light_blue",
    damage_modifier = 80,
    durability = 100,
    description = ccb.content.text("A small washing machine.  With detergent, water, and some electrical power, you could clean a lot of clothes.  'e'xamine the tile with the washing machine to use it."),
    epower = "-400 W",
    item = "washing_machine",
    size = "40 L",
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
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "soldering_standard", 8 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "WASHING_MACHINE", "COVERED", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 8, 13 } },
        { item = "lc_steel_chunk", count = { 8, 13 } },
        { item = "scrap", count = { 8, 13 } },
        { item = "hose", probability = 50 },
        { item = "scrap_copper", probability = 15 },
        { item = "cable", count = { 1, 3 } },
        { item = "copper", count = { 7, 30 } },
    },
    damage_reduction = { all = 32 },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "dishwasher",
    categories = { "utility" },
    color = "light_blue",
    broken_color = "light_blue",
    damage_modifier = 80,
    durability = 100,
    description = ccb.content.text("A small dishwasher.  With detergent, water, and some electrical power, you could clean your dishes… or something more useful like a CBM dripping with zombie gore.  'e'xamine the tile with the dishwasher to use it."),
    epower = "-400 W",
    item = "dishwasher",
    size = "40 L",
    location = "center",
    looks_like = "washing_machine",
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
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "DISHWASHER", "COVERED", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 8, 13 } },
        { item = "lc_steel_chunk", count = { 8, 13 } },
        { item = "scrap", count = { 8, 13 } },
        { item = "hose", probability = 50 },
        { item = "scrap_copper", probability = 15 },
        { item = "cable", count = { 1, 3 } },
        { item = "copper", count = { 7, 30 } },
    },
    variants = { { symbols = "d", broken_symbols = "#" } },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "autoclave",
    looks_like = "dishwasher",
    categories = { "utility" },
    color = "yellow",
    broken_color = "light_blue",
    damage_modifier = 80,
    durability = 100,
    description = ccb.content.text("This is an autoclave.  It's useful for sterilizing things like CBMs.  'e'xamine the tile with the autoclave to use it."),
    epower = "-1500 W",
    item = "vh_autoclave",
    size = "76 L",
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
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 20 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "AUTOCLAVE", "COVERED", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 8, 13 } },
        { item = "lc_steel_chunk", count = { 8, 13 } },
        { item = "scrap", count = { 8, 13 } },
        { item = "hose", probability = 50 },
        { item = "scrap_copper", probability = 15 },
        { item = "cable", count = { 1, 3 } },
        { item = "copper", count = { 7, 30 } },
    },
    variants = { { symbols = "A", broken_symbols = "#" } },
}

-- 300 L storage based on an average station wagon trunk being around 600 L, and our cars having two tiles.
-- 120 cm weld to install, 30 cm per damage quadrant for repair
ccb.content.define_vehicle_part {
    id = "trunk",
    name = ccb.content.text("trunk"),
    looks_like = "f_locker",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 80,
    durability = 350,
    size = "300 L",
    item = "frame",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    flags = { "CARGO", "LOCKABLE_CARGO", "COVERED", "BOARDABLE", "SIMPLE_PART", "FURNITURE_TIEDOWN" },
    breaks_into = "ig_vp_frame",
    damage_reduction = { all = 30 },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

-- 200 L storage based on an average sedan trunk being around 400 L, and our cars having two tiles.  We should get a taller trunk for SUVs and similar.
-- 120 cm weld to install, 30 cm per damage quadrant for repair
ccb.content.define_vehicle_part {
    id = "trunk_sedan",
    name = ccb.content.text("sedan trunk"),
    looks_like = "trunk",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 80,
    durability = 350,
    size = "200 L",
    item = "frame",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    flags = { "CARGO", "LOCKABLE_CARGO", "COVERED", "SIMPLE_PART", "HALF_BOARD" },
    breaks_into = "ig_vp_frame",
    damage_reduction = { all = 30 },
    variants = { { symbols = "H", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "travois",
    name = ccb.content.text("travois"),
    looks_like = "frame_wood_light_cross",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 50,
    size = "75 L",
    item = "frame_wood_light",
    location = "center",
    flags = { "CARGO", "BOARDABLE", "COVERED", "HUGE_OK", "CARGO_PASSABLE" },
    breaks_into = {
        { item = "splinter", count = { 5, 8 } },
        { item = "string_36", count = { 1, 3 } },
        { item = "string_6", count = { 1, 4 } },
    },
    requirements = {
        install = { duration = "10 m", using_requirements = { { "rope_natural_short", 1 } } },
        repair = { duration = "5 m", using_requirements = { { "adhesive", 1 } } },
    },
    damage_reduction = { all = 4 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "wood box",
    name = ccb.content.text("wooden box"),
    looks_like = "f_crate_o",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 70,
    size = "37500 ml",
    item = "frame_wood",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "COVERED", "LOCKABLE_CARGO", "CARGO_PASSABLE" },
    breaks_into = { { item = "splinter", count = { 3, 5 } }, { item = "nail", charges = { 10, 15 } } },
    damage_reduction = { all = 5 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "folding wood box",
    name = ccb.content.text("foldable wooden box"),
    looks_like = "wood box",
    categories = { "cargo" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 65,
    folded_volume = "1500 ml",
    size = "30 L",
    item = "foldwoodframe",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "COVERED", "LOCKABLE_CARGO", "CARGO_PASSABLE" },
    breaks_into = { { item = "splinter", count = { 4, 7 } }, { item = "nail", charges = { 10, 15 } } },
    damage_reduction = { all = 4 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "veh_table",
    looks_like = "f_table",
    categories = { "utility" },
    description = ccb.content.text("A very fancy table for those with fancy lives.  If times were better, it might be useful for something other than firewood."),
    color = "red",
    damage_modifier = 60,
    durability = 145,
    size = "20 L",
    item = "v_table",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "FLAT_SURF", "WORKBENCH" },
    breaks_into = {
        { item = "2x4", probability = 5 },
        { item = "splinter", count = { 4, 8 } },
        { item = "nail", charges = { 4, 7 } },
    },
    workbench = { multiplier = 1.1, mass = "150 kg", volume = "20 L" },
    damage_reduction = { all = 24 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "veh_table_wood",
    looks_like = "f_table",
    categories = { "utility" },
    description = ccb.content.text("A crude wooden table."),
    color = "red",
    damage_modifier = 60,
    durability = 145,
    size = "20 L",
    item = "w_table",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "FLAT_SURF", "WORKBENCH" },
    breaks_into = {
        { item = "2x4", probability = 5 },
        { item = "splinter", count = { 4, 8 } },
        { item = "nail", charges = { 4, 7 } },
    },
    workbench = { multiplier = 1.1, mass = "150 kg", volume = "20 L" },
    damage_reduction = { all = 16 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "veh_table_foldable",
    name = ccb.content.text("flat-packable table"),
    looks_like = "veh_table_wood",
    categories = { "utility" },
    color = "red",
    damage_modifier = 30,
    durability = 70,
    size = "20 L",
    item = "foldwoodframe",
    folded_volume = "12500 ml",
    location = "center",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "CARGO", "OBSTACLE", "FLAT_SURF" },
    breaks_into = { { item = "splinter", count = { 4, 7 } }, { item = "nail", charges = { 10, 15 } } },
    damage_reduction = { all = 16 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "workbench",
    name = ccb.content.text("workbench"),
    description = ccb.content.text("A sturdy workbench built out of metal.  It is perfect for crafting large and heavy things."),
    looks_like = "veh_table_wood",
    categories = { "utility" },
    color = "red",
    damage_modifier = 60,
    durability = 300,
    size = "30 L",
    item = "workbench",
    location = "center",
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
            duration = "3 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "CARGO", "BOARDABLE", "FLAT_SURF", "WORKBENCH" },
    breaks_into = {
        { item = "pipe", probability = 25 },
        { item = "sheet_metal", probability = 5 },
        { item = "sheet_metal_small", count = { 5, 14 } },
        { item = "lc_steel_lump", count = { 1, 3 } },
        { item = "lc_steel_chunk", count = { 7, 12 } },
        { item = "scrap", count = { 15, 30 } },
    },
    workbench = { multiplier = 1.2, mass = "300 kg", volume = "30 L" },
    damage_reduction = { all = 29 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "workbench_with_recharger",
    name = ccb.content.text("workbench with battery recharger"),
    description = ccb.content.text("A sturdy workbench built out of metal.  It is perfect for crafting large and heavy things, when unfolded.  It also has a built-in battery charger for your phone."),
    copy_from = "workbench",
    durability = 295,
    bonus = 15,
    epower = "-50 W",
    item = "workbench_with_recharger",
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
            skills = { { "mechanics", 3 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "CARGO", "MOUNTABLE", "FLAT_SURF", "WORKBENCH", "ENABLED_DRAINS_EPOWER", "RECHARGE" },
    breaks_into = {
        { item = "pipe", probability = 25 },
        { item = "sheet_metal", probability = 5 },
        { item = "sheet_metal_small", count = { 5, 14 } },
        { item = "lc_steel_lump", count = { 1, 3 } },
        { item = "lc_steel_chunk", count = { 7, 12 } },
        { item = "scrap", count = { 15, 30 } },
        { item = "plastic_chunk", probability = 50 },
        { item = "cable", count = { 1, 4 } },
        { item = "e_scrap", count = { 0, 2 } },
    },
    size = "29500 ml",
    workbench = { volume = "29 L" },
    damage_reduction = { all = 29 },
}

ccb.content.define_vehicle_part {
    id = "boat_board",
    looks_like = "t_wall_log",
    categories = { "hull" },
    color = "brown",
    damage_modifier = 50,
    durability = 40,
    item = "boat_board",
    location = "under",
    requirements = {
        install = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "FLOATS" },
    breaks_into = { { item = "splinter", count = { 10, 20 } } },
    damage_reduction = { all = 10 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "raft_board",
    looks_like = "t_wall_log",
    categories = { "hull" },
    color = "brown",
    damage_modifier = 50,
    durability = 30,
    item = "raft_board",
    location = "under",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "rope_natural_short", 2 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            qualities = { { id = "CUT", level = 2 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
    },
    flags = { "FLOATS" },
    breaks_into = { { item = "splinter", count = { 10, 20 } } },
    damage_reduction = { all = 5 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "plastic_boat_hull",
    categories = { "hull" },
    color = "brown",
    looks_like = "boat_board",
    damage_modifier = 50,
    durability = 120,
    item = "plastic_boat_hull",
    location = "under",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "40 m",
            using_requirements = { { "vehicle_screw", 1 }, { "drilling_light", 40 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "soldering_standard", 15 } },
        },
    },
    flags = { "FLOATS" },
    breaks_into = { { item = "plastic_chunk", count = { 4, 8 } } },
    damage_reduction = { all = 12, stab = 4, cut = 4 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

-- 240 cm weld to install, 60 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "metal_boat_hull",
    name = ccb.content.text("metal boat hull"),
    categories = { "hull" },
    color = "dark_gray",
    looks_like = "boat_board",
    damage_modifier = 50,
    durability = 240,
    item = "sheet_metal",
    location = "under",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 6 } },
        },
    },
    flags = { "FLOATS" },
    breaks_into = "ig_vp_sheet_metal",
    damage_reduction = { all = 28 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "carbonfiber_boat_hull",
    categories = { "hull" },
    color = "brown",
    looks_like = "boat_board",
    damage_modifier = 50,
    durability = 480,
    item = "carbonfiber_boat_hull",
    location = "under",
    requirements = {
        install = {
            skills = { { "mechanics", 6 } },
            duration = "40 m",
            using_requirements = { { "vehicle_screw", 1 }, { "drilling_light", 40 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 7 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 3 } },
        },
    },
    flags = { "FLOATS", "BOARDABLE" },
    breaks_into = { { item = "rigid_kevlar_plate", count = { 1, 3 } } },
    damage_reduction = { all = 14 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "inflatable_section",
    looks_like = "inflatable_airbag",
    categories = { "hull" },
    color = "green",
    size = "85 L",
    durability = 50,
    item = "inflatable_section",
    location = "structure",
    folded_volume = "750 ml",
    folding_time = "60 seconds",
    unfolding_tools = { "hand_pump" },
    unfolding_time = "150 seconds",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 }, { "drilling_light", 10 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "MOUNTABLE", "BOARDABLE", "CARGO", "NO_INSTALL_HIDDEN", "NO_UNINSTALL" },
    breaks_into = { { item = "plastic_chunk", count = { 10, 20 } } },
    damage_reduction = { bash = 10 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "inflatable_airbag",
    categories = { "hull" },
    color = "green",
    damage_modifier = 50,
    durability = 40,
    item = "inflatable_airbag",
    location = "under",
    folded_volume = "750 ml",
    folding_time = "60 seconds",
    unfolding_tools = { "hand_pump" },
    unfolding_time = "150 seconds",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 }, { "drilling_light", 10 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "adhesive_rubber", 2 }, { "tire_rubber", 2 } },
        },
    },
    flags = { "FLOATS", "VARIABLE_SIZE", "NO_INSTALL_HIDDEN", "NO_UNINSTALL" },
    breaks_into = { { item = "plastic_chunk", count = { 10, 20 } } },
    damage_reduction = { bash = 10 },
    variants = { { symbols = "O", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "sail",
    categories = { "movement", "operations" },
    broken_color = "red",
    damage_modifier = 50,
    durability = 20,
    power = "800 W",
    fuel_type = "wind",
    noise_factor = 1,
    m2c = 90,
    engine_exclusions = { "wind" },
    item = "sail",
    location = "engine_block",
    folded_volume = "500 ml",
    requirements = {
        install = { skills = { { "fabrication", 2 } }, duration = "30 m" },
        removal = { skills = { { "fabrication", 2 } }, duration = "60 m" },
        repair = {
            skills = { { "tailor", 1 } },
            duration = "150 s",
            using_requirements = { { "sewing_standard", 50 }, { "fabric_standard", 1 } },
        },
    },
    flags = {
        "ENGINE",
        "CONTROLS",
        "PROTRUSION",
        "E_STARTS_INSTANTLY",
        "WIND_POWERED",
        "STABLE",
        "UNMOUNT_ON_DAMAGE",
    },
    breaks_into = { { item = "splinter", count = { 2, 4 } }, { item = "cotton_patchwork", count = { 1, 3 } } },
    variants = { { symbols = "M", broken_symbols = "#" } },
}

-- 120 cm of weld to install the whole assembly
ccb.content.define_vehicle_part {
    id = "controls",
    categories = { "operations" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 250,
    description = ccb.content.text("A steering wheel, accelerator, and brake pedals."),
    bonus = 10,
    folded_volume = "1500 ml",
    item = "vehicle_controls",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 15 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = {
                { "repair_welding_standard", 3 },
                { "soldering_standard", 8 },
                { "vehicle_wrench_1", 1 },
                { "vehicle_screw", 1 },
            },
        },
    },
    flags = { "CONTROLS", "NEED_LEG", "INOPERABLE_SMALL" },
    breaks_into = {
        { item = "lc_steel_lump" },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "cable", count = { 0, 4 } },
    },
    damage_reduction = { all = 6 },
    variants = { { symbols = "$", broken_symbols = "$" } },
}

ccb.content.define_vehicle_part {
    id = "hand_controls",
    categories = { "other" },
    broken_color = "red",
    durability = 250,
    description = ccb.content.text("A pair of adjustable rods with a simple trigger.  They easily can be easily installed on top of vehicle controls and will allow a car or similar vehicle to be driven by those who can't use their legs to do so, whether due to disability or small stature.  These are designed for automobiles and will not work on bicycle style foot pedals."),
    bonus = 10,
    folded_volume = "740 ml",
    item = "hand_controls",
    flags = { "IGNORE_LEG_REQUIREMENT", "IGNORE_HEIGHT_REQUIREMENT", "ON_CONTROLS" },
    breaks_into = { { item = "scrap", count = { 0, 2 } }, { item = "pipe", count = { 0, 1 } } },
    variants = { { symbols = "/", broken_symbols = "/" } },
}

ccb.content.define_vehicle_part {
    id = "pedal_extenders",
    categories = { "other" },
    broken_color = "red",
    durability = 250,
    description = ccb.content.text("These thick rubber pads can clamp securely onto a vehicle's gas and brake pedals, allowing even very short people to drive a car."),
    bonus = 10,
    folded_volume = "2 L",
    item = "pedal_extenders",
    flags = { "IGNORE_HEIGHT_REQUIREMENT", "ON_CONTROLS" },
    breaks_into = {
        { item = "rubber_tire_chunk", count = { 0, 1 } },
        { item = "rubber_tire_chunk", count = { 0, 8 } },
        { item = "clamp", count = { 0, 1 } },
        { item = "scrap", count = { 0, 2 } },
    },
    variants = { { symbols = ",", broken_symbols = "," } },
}

ccb.content.define_vehicle_part {
    id = "pedal_extenders_makeshift",
    categories = { "other" },
    broken_color = "red",
    durability = 50,
    description = ccb.content.text("Blocks of wood, taped to the pedals to allow vehicle controls to be used even by people who are very short."),
    bonus = 10,
    folded_volume = "2 L",
    item = "pedal_extenders_makeshift",
    flags = { "IGNORE_HEIGHT_REQUIREMENT", "ON_CONTROLS" },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "350 s",
            components = { { { "duct_tape", 25 } } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "80 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 0, 4 } } },
    variants = { { symbols = ",", broken_symbols = "," } },
}

ccb.content.define_vehicle_part {
    id = "dashboard",
    categories = { "energy", "lighting" },
    description = ccb.content.text("A vehicle instrument panel with various gauges and switches."),
    color = "light_cyan",
    broken_color = "red",
    damage_modifier = 10,
    durability = 125,
    bonus = 10,
    epower = "-25 W",
    item = "vehicle_dashboard",
    requirements = {
        install = {
            skills = { { "mechanics", 1 }, { "electronics", 1 } },
            duration = "350 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "350 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "80 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "CTRL_ELECTRONIC", "DOME_LIGHT", "ENABLED_DRAINS_EPOWER", "WATCH", "ALARMCLOCK", "CABLE_PORTS" },
    breaks_into = {
        { item = "cable", count = { 0, 2 } },
        { item = "plastic_chunk", count = { 4, 8 } },
        { item = "e_scrap", count = { 1, 3 } },
        { item = "scrap", count = { 1, 2 } },
    },
    variants = { { symbols = "$", broken_symbols = "$" } },
}

-- 700 W average assuming relatively small target-actual difference
ccb.content.define_vehicle_part {
    id = "mountable_heater",
    item = "mountable_heater",
    description = ccb.content.text("Set of tubes, that move heat from the engine into the vehicle cabin, heating it up."),
    location = "on_roof",
    categories = { "utility" },
    color = "red",
    durability = 400,
    epower = "-700 W",
    bonus = 10,
    requirements = {
        install = {
            skills = { { "mechanics", 1 }, { "electronics", 1 } },
            duration = "2 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "1 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "30 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "CTRL_ELECTRONIC", "ENABLED_DRAINS_EPOWER", "SPACE_HEATER" },
    emissions = { "emit_heater_vehicle" },
    breaks_into = {
        { item = "lc_steel_lump" },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "element", count = { 0, 2 } },
    },
    damage_reduction = { all = 15 },
    variants = { { symbols = ";", broken_symbols = ":" } },
}

-- going with half energy draw based on difference between small and large space heaters
ccb.content.define_vehicle_part {
    copy_from = "mountable_heater",
    id = "mountable_heater_small",
    item = "mountable_heater_small",
    epower = "-350 W",
    folded_volume = "3750 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 1 }, { "electronics", 1 } },
            duration = "2 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "1 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "30 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "CTRL_ELECTRONIC", "ENABLED_DRAINS_EPOWER", "SPACE_HEATER" },
    emissions = { "emit_hot_air2_stream" },
    breaks_into = {
        { item = "lc_steel_lump" },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "element", probability = 80 },
    },
    damage_reduction = { all = 15 },
}

ccb.content.define_vehicle_part {
    id = "integrated_heater_small",
    copy_from = "mountable_heater_small",
    item = "pipe",
    location = "",
    name = ccb.content.text("small integrated heater"),
    extend = { flags = { "NO_INSTALL_HIDDEN" } },
    requirements = {
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            qualities = { { id = "SAW_M", level = 2 } },
        },
    },
    breaks_into = {
        { item = "lc_steel_lump", probability = 70 },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 3 } },
    },
}

ccb.content.define_vehicle_part {
    id = "mountable_cooler",
    description = ccb.content.text("A vehicle-mounted area cooler.  Install a muffler in another part of the vehicle to direct the exhaust heat to that location."),
    item = "mountable_cooler",
    location = "on_roof",
    categories = { "utility" },
    color = "light_cyan",
    durability = 400,
    epower = "-120 W",
    bonus = 10,
    requirements = {
        install = {
            skills = { { "mechanics", 1 }, { "electronics", 1 } },
            duration = "2 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "1 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "30 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "CTRL_ELECTRONIC", "ENABLED_DRAINS_EPOWER", "COOLER" },
    emissions = { "emit_cooler_vehicle" },
    exhaust = { "emit_heater_vehicle" },
    breaks_into = {
        { item = "lc_steel_lump" },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
        { item = "cable", count = { 2, 10 } },
    },
    damage_reduction = { all = 15 },
    variants = { { symbols = "C", broken_symbols = ":" } },
}

ccb.content.define_vehicle_part {
    id = "integrated_cooler",
    copy_from = "mountable_cooler",
    description = ccb.content.text("A small vehicle-mounted area cooler."),
    location = "",
    item = "integrated_cooler",
    requirements = {
        install = {
            skills = { { "mechanics", 4 }, { "electronics", 1 } },
            duration = "3 h",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 }, { "electronics", 1 } },
            duration = "3 h",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "controls_electronic",
    categories = { "energy", "lighting" },
    color = "yellow",
    broken_color = "red",
    damage_modifier = 10,
    durability = 50,
    bonus = 10,
    epower = "-25 W",
    item = "electronics_controls",
    description = ccb.content.text("Some switches and knobs to control the vehicle's electrical systems."),
    folded_volume = "750 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 3 }, { "electronics", 3 } },
            duration = "350 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "350 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "80 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 10 } },
        },
    },
    flags = { "CTRL_ELECTRONIC", "DOME_LIGHT", "ENABLED_DRAINS_EPOWER", "CABLE_PORTS" },
    breaks_into = {
        { item = "cable", count = { 0, 1 } },
        { item = "plastic_chunk", count = { 2, 4 } },
        { item = "e_scrap", count = { 1, 2 } },
    },
    damage_reduction = { all = 6 },
    variants = { { symbols = "$", broken_symbols = "$" } },
}

-- 80 cm of weld at various affix points (presuming the muffler includes the exhaust point
ccb.content.define_vehicle_part {
    id = "muffler",
    categories = { "other" },
    damage_modifier = 10,
    durability = 50,
    description = ccb.content.text("A metal pipe that somewhat reduces engine noise.  Also vents heat from an installed vehicle cooler."),
    bonus = 40,
    item = "muffler",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "45 m",
            using_requirements = { { "welding_standard", 80 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "MUFFLER" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 1, 3 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 4, 9 } },
    },
    damage_reduction = { all = 9 },
    variants = { { symbols = "/", broken_symbols = "/" } },
}

ccb.content.define_vehicle_part {
    id = "seatbelt",
    description = ccb.content.text("A length of synthetic fiber weaved into a flat band, usually used to securely fasten passenger inside vehicles."),
    categories = { "operations", "passengers" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 35,
    folded_volume = "500 ml",
    bonus = 10,
    item = "seatbelt",
    location = "on_seat",
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
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "SEATBELT", "SIMPLE_PART" },
    damage_reduction = { bash = 15 },
    variants = { { symbols = ",", broken_symbols = "," } },
}

ccb.content.define_vehicle_part {
    id = "vehicle_alarm",
    name = ccb.content.text("security system"),
    categories = { "other" },
    color = "light_red",
    broken_color = "red",
    damage_modifier = 10,
    durability = 35,
    description = ccb.content.text("A bunch of electronics that make it difficult to start the vehicle without the proper key, and that will sound an alarm if you try.  The alarm can be disabled."),
    epower = "-10 W",
    bonus = 120,
    folded_volume = "250 ml",
    item = "processor",
    location = "on_controls",
    requirements = {
        install = {
            skills = { { "mechanics", 4 }, { "electronics", 4 } },
            duration = "5 m",
            qualities = { { id = "SCREW_FINE", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 }, { "electronics", 4 } },
            duration = "5 m",
            qualities = { { id = "SCREW_FINE", level = 1 } },
        },
    },
    flags = { "ON_CONTROLS", "SECURITY", "ENABLED_DRAINS_EPOWER" },
    breaks_into = "ig_vp_device",
    variants = { { symbols = ",", broken_symbols = "," } },
}

ccb.content.define_vehicle_part {
    id = "smart_engine_controller",
    name = ccb.content.text("smart engine controller"),
    categories = { "other" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 35,
    description = ccb.content.text("Electronic module that automatically switches combustion and electric engines on and off minimizing fuel consumption and optimizing power output and battery charge rate.  Must be turned on to work.  Simplified ruleset: 1. When throttling, maximize acceleration.  2. Keep battery at 90%.  3. Minimize fuel consumption."),
    epower = "-25 W",
    folded_volume = "250 ml",
    item = "processor",
    requirements = {
        install = {
            skills = { { "mechanics", 4 }, { "electronics", 4 } },
            duration = "5 m",
            qualities = { { id = "SCREW_FINE", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 }, { "electronics", 4 } },
            duration = "5 m",
            qualities = { { id = "SCREW_FINE", level = 1 } },
        },
    },
    flags = { "ON_CONTROLS", "ENABLED_DRAINS_EPOWER", "SMART_ENGINE_CONTROLLER" },
    breaks_into = "ig_vp_device",
    variants = { { symbols = "'", broken_symbols = "'" } },
}

ccb.content.define_vehicle_part {
    id = "seatbelt_heavyduty",
    description = ccb.content.text("A harness made of five belts meant to be mounted on vehicle to fasten a passenger securely to their seat."),
    categories = { "operations", "passengers" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 100,
    folded_volume = "1 L",
    bonus = 25,
    item = "five-point_harness",
    location = "on_seat",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "SEATBELT", "SIMPLE_PART" },
    damage_reduction = { bash = 15 },
    variants = { { symbols = ",", broken_symbols = "," } },
}

ccb.content.define_vehicle_part {
    id = "v_curtain",
    name = ccb.content.text("curtain"),
    looks_like = "t_door_curtain_c",
    categories = { "other" },
    color = "dark_gray",
    damage_modifier = 1,
    durability = 200,
    bonus = 25,
    item = "sheet",
    location = "on_windshield",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "tailor", 1 } },
            duration = "150 s",
            using_requirements = { { "sewing_standard", 50 }, { "fabric_standard", 1 } },
        },
    },
    flags = {
        "OPENABLE",
        "OPENCLOSE_INSIDE",
        "OPAQUE",
        "CURTAIN",
        "MULTISQUARE",
        "NEEDS_WINDOW",
        "SIMPLE_PART",
    },
    breaks_into = {
        { item = "sheet_cotton", count = { 1, 3 } },
        { item = "cotton_patchwork", count = { 5, 11 } },
        { item = "scrap_cotton", count = { 8, 19 } },
    },
    variants = { { symbols = "\"", broken_symbols = "0" } },
}

ccb.content.define_vehicle_part {
    id = "aisle_curtain",
    name = ccb.content.text("aisle curtain"),
    looks_like = "v_curtain",
    categories = { "other" },
    color = "dark_gray",
    damage_modifier = 1,
    durability = 200,
    bonus = 25,
    item = "sheet",
    location = "on_ceiling",
    requirements = {
        install = {
            skills = { { "mechanics", 1 }, { "tailor", 1 } },
            duration = "5 m",
            using_requirements = {
                { "rope_natural_short", 1 },
                { "vehicle_screw", 1 },
                { "sewing_standard", 1 },
            },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "tailor", 1 } },
            duration = "150 s",
            using_requirements = { { "sewing_standard", 50 }, { "fabric_standard", 1 } },
        },
    },
    flags = { "OPENABLE", "OPAQUE", "OPENCLOSE_INSIDE", "CURTAIN", "MULTISQUARE", "SIMPLE_PART" },
    breaks_into = {
        { item = "sheet_cotton", count = { 1, 3 } },
        { item = "cotton_patchwork", count = { 5, 11 } },
        { item = "scrap_cotton", count = { 8, 19 } },
    },
    variants = { { symbols = "\"", broken_symbols = "0" } },
}

ccb.content.define_vehicle_part {
    id = "water_wheel",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 50,
    epower = "80 W",
    item = "water_wheel",
    location = "center",
    flags = { "WATER_WHEEL", "OBSTACLE" },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "250 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "250 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "20 s",
            using_requirements = { { "rope_natural_short", 1 } },
        },
    },
    breaks_into = {
        { item = "splinter", count = { 40, 60 } },
        { item = "mc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 6, 15 } },
        { item = "cable", count = { 30, 60 } },
        { item = "nail", charges = { 21, 35 } },
        { item = "nuts_bolts", count = { 3, 6 } },
    },
    damage_reduction = { all = 15, stab = 6, cut = 8 },
    variants = { { symbols = "*", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "xl_water_wheel",
    looks_like = "water_wheel",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 80,
    epower = "180 W",
    item = "xl_water_wheel",
    location = "center",
    flags = { "WATER_WHEEL", "OBSTACLE", "EXTRA_DRAG" },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "750 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "750 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 s",
            using_requirements = { { "rope_natural_short", 2 } },
        },
    },
    breaks_into = {
        { item = "splinter", count = { 60, 100 } },
        { item = "lc_steel_lump", count = { 1, 3 } },
        { item = "lc_steel_chunk", count = { 4, 9 } },
        { item = "scrap", count = { 20, 35 } },
        { item = "cable", count = { 75, 134 } },
        { item = "nail", charges = { 80, 130 } },
        { item = "nuts_bolts", count = { 5, 12 } },
    },
    damage_reduction = { all = 16, stab = 6, cut = 8 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "solar_panel",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 20,
    epower = "50 W",
    item = "solar_panel",
    location = "on_roof",
    requirements = {
        install = {
            skills = { { "electronics", 2 }, { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = {
                { "vehicle_wrench_2", 1 },
                { "drilling_standard", 20 },
                { "vehicle_bolt_install_simple", 1 },
            },
        },
        removal = {
            skills = { { "electronics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "electronics", 6 } },
            duration = "50 m",
            using_requirements = { { "vehicle_screw", 1 }, { "solar_panel", 1 }, { "soldering_standard", 8 } },
        },
    },
    flags = { "SOLAR_PANEL" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 4 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 4 } },
        { item = "solar_cell", count = { 1, 4 } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

-- 20 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "wind_turbine",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 15,
    epower = "1 W",
    item = "wind_turbine",
    location = "on_roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "150 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "150 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 2 }, { "soldering_standard", 4 } },
        },
    },
    flags = { "WIND_TURBINE" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 6 } },
        { item = "e_scrap", count = { 2, 4 } },
        { item = "splinter", count = { 2, 8 } },
        { item = "cable", count = { 27, 38 } },
        { item = "nail", charges = { 2, 6 } },
    },
    damage_reduction = { all = 8 },
    variants = { { symbols = "T", broken_symbols = "X" } },
}

-- 30 cm weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "xl_wind_turbine",
    looks_like = "wind_turbine",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 70,
    epower = "3 W",
    item = "xl_wind_turbine",
    location = "on_roof",
    power = "-3000 W",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "450 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "450 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 10 } },
        },
    },
    flags = { "WIND_TURBINE", "EXTRA_DRAG" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "scrap", count = { 10, 20 } },
        { item = "e_scrap", count = { 8, 16 } },
        { item = "splinter", count = { 25, 50 } },
        { item = "cable", count = { 100, 167 } },
        { item = "nail", charges = { 8, 15 } },
        { item = "nuts_bolts", count = { 4, 7 } },
    },
    damage_reduction = { all = 9 },
    variants = { { symbols = "Y", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "reinforced_solar_panel",
    description = ccb.content.text("A solar panel that has been covered with a pane of reinforced glass to protect the delicate solar cells from zombies or errant baseballs.  The glass causes this panel to produce slightly less power than a normal panel."),
    copy_from = "solar_panel",
    color = "light_blue",
    broken_color = "light_gray",
    proportional = { epower = 0.9 },
    damage_modifier = 80,
    durability = 300,
    item = "reinforced_solar_panel",
    requirements = {
        repair = {
            skills = { { "electronics", 6 } },
            duration = "50 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel", 1 },
                { "soldering_standard", 8 },
                { "repair_welding_standard", 1 },
            },
        },
    },
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 7 } },
        { item = "lc_steel_chunk", count = { 4, 7 } },
        { item = "scrap", count = { 4, 7 } },
        { item = "solar_cell", count = { 1, 4 } },
    },
    damage_reduction = { all = 12 },
}

ccb.content.define_vehicle_part {
    id = "solar_panel_v2",
    copy_from = "solar_panel",
    description = ccb.content.text("An electronic device that can convert solar radiation into electric power.  This one is a high-performance type made with monocrystalline silicon cells."),
    item = "solar_panel_v2",
    proportional = { epower = 2.0 },
    requirements = {
        install = {
            skills = { { "electronics", 2 }, { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = {
                { "vehicle_wrench_2", 1 },
                { "drilling_standard", 20 },
                { "vehicle_bolt_install_simple", 1 },
            },
        },
        removal = {
            skills = { { "electronics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "electronics", 8 } },
            duration = "75 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v2", 1 },
                { "soldering_standard", 16 },
            },
        },
    },
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 4 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 4 } },
        { item = "solar_cell_v2", count = { 1, 6 } },
    },
}

ccb.content.define_vehicle_part {
    id = "reinforced_solar_panel_v2",
    copy_from = "solar_panel_v2",
    looks_like = "reinforced_solar_panel",
    description = ccb.content.text("An advanced solar panel that has been covered with a pane of reinforced glass to protect the delicate solar cells from zombies or errant baseballs.  The glass causes this panel to produce slightly less power than a normal advanced panel."),
    color = "light_blue",
    broken_color = "light_gray",
    proportional = { epower = 0.9 },
    damage_modifier = 80,
    durability = 300,
    item = "reinforced_solar_panel_v2",
    requirements = {
        repair = {
            skills = { { "electronics", 8 } },
            duration = "75 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v2", 1 },
                { "soldering_standard", 16 },
                { "repair_welding_standard", 1 },
            },
        },
    },
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 7 } },
        { item = "lc_steel_chunk", count = { 4, 7 } },
        { item = "scrap", count = { 4, 7 } },
        { item = "solar_cell", count = { 1, 6 } },
    },
    damage_reduction = { all = 10 },
}

-- 40 cm of weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "compact_ASRG_containment",
    name = ccb.content.text("advanced Stirling radioisotope generator"),
    looks_like = "f_compact_ASRG_containment",
    categories = { "energy" },
    color = "green_white",
    broken_color = "blue",
    damage_modifier = 80,
    durability = 400,
    description = ccb.content.text("A rather heavy brick of metal housing an ASRG, formerly designed by NASA and repurposed for terrestrial use.  Will provide about 130 W, basically forever as far as you're concerned.  Even though the alpha radiation these run off of isn't very dangerous in case of a breach, this unit appears to be armored to take a beating and is a good deal heavier owing to its composite plating."),
    epower = "130 W",
    location = "center",
    item = "compact_ASRG_containment",
    requirements = {
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "25 m",
            using_requirements = { { "repair_welding_standard", 4 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "OBSTACLE", "RADIOACTIVE", "COVERED", "PERPETUAL", "REACTOR" },
    breaks_into = {
        { item = "scrap", count = { 4, 16 } },
        { item = "mc_steel_chunk", count = { 1, 6 } },
        { item = "plutonium", count = { 0, 2 } },
        { item = "lead", count = { 12, 18 } },
    },
    damage_reduction = { all = 58 },
    variants = { { symbols = "0", broken_symbols = "#" } },
}

-- 10 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "water_faucet",
    looks_like = "f_sink",
    categories = { "utility" },
    damage_modifier = 10,
    description = ccb.content.text("A water faucet.  You can use it to access the water from vehicle tanks."),
    durability = 45,
    folded_volume = "250 ml",
    item = "water_faucet",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    pseudo_tools = { { id = "water_faucet" } },
    breaks_into = { { item = "scrap", count = { 1, 3 } } },
    damage_reduction = { all = 6 },
    variants = { { symbols = "u", broken_symbols = "-" } },
}

-- 10 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "towel_hanger",
    categories = { "utility" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 10,
    description = ccb.content.text("A towel hanger with towels.  You can use it to dry yourself."),
    durability = 45,
    folded_volume = "2500 ml",
    item = "towel_hanger",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = { skills = { { "mechanics", 1 } }, qualities = { { id = "WRENCH", level = 1 } } },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    pseudo_tools = { { id = "towel", hotkey = "t" } },
    breaks_into = { { item = "scrap", count = { 1, 3 } }, { item = "cotton_patchwork", count = { 1, 6 } } },
    variants = { { symbols = "h", broken_symbols = "-" } },
}

ccb.content.define_vehicle_part {
    id = "plating_wood",
    name = ccb.content.text("wooden armor"),
    categories = { "warfare" },
    color = "brown",
    broken_color = "brown",
    durability = 250,
    item = "wood_plate",
    location = "armor",
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
    flags = { "ARMOR" },
    breaks_into = {
        { item = "splinter", count = { 4, 8 } },
        { item = "string_36", count = { 2, 3 } },
        { item = "string_6", count = { 3, 6 } },
        { item = "nail", charges = { 1, 3 } },
    },
    damage_reduction = { all = 16, cut = 8, stab = 8 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 240 cm weld to install, 60 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "plating_steel",
    categories = { "warfare" },
    color = "light_cyan",
    broken_color = "light_cyan",
    durability = 660,
    item = "steel_plate",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 6 } },
        },
    },
    flags = { "ARMOR" },
    breaks_into = "ig_vp_steel_plate",
    damage_reduction = { all = 56 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 240 cm weld to install, 50 cm weld and 1 superalloy sheet per damage quadrant
ccb.content.define_vehicle_part {
    id = "plating_superalloy",
    categories = { "warfare" },
    color = "dark_gray",
    broken_color = "dark_gray",
    durability = 780,
    bonus = 50,
    item = "alloy_plate",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 5 } },
        },
    },
    flags = { "ARMOR", "SHOCK_RESISTANT" },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    damage_reduction = { all = 70 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 240 cm weld to install, 60 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "plating_spiked",
    categories = { "warfare" },
    color = "red",
    broken_color = "red",
    damage_modifier = 150,
    durability = 620,
    item = "spiked_plate",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "ARMOR", "SHARP" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 1, 2 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 5, 8 } },
        { item = "spike", count = { 1, 2 } },
    },
    damage_reduction = { all = 48 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 300 cm weld to install, 80 cm weld per damage quadrant
ccb.content.define_vehicle_part {
    id = "plating_hard",
    categories = { "warfare" },
    color = "cyan",
    broken_color = "cyan",
    durability = 780,
    item = "hard_plate",
    location = "armor",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 300 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal_cut_resistant", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 8 } },
        },
    },
    flags = { "ARMOR" },
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 5, 8 } },
        { item = "scrap", count = { 6, 12 } },
    },
    damage_reduction = { all = 70 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

-- 300 cm weld to install
ccb.content.define_vehicle_part {
    id = "plating_military",
    categories = { "warfare" },
    color = "green",
    broken_color = "green",
    durability = 700,
    item = "mil_plate",
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
        { item = "ch_steel_lump", count = { 4, 6 } },
        { item = "ch_steel_chunk", count = { 4, 6 } },
        { item = "scrap", count = { 4, 6 } },
        { item = "ceramic_armor", count = { 0, 4 } },
    },
    damage_reduction = { all = 60, bullet = 105 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

ccb.content.define_vehicle_part {
    id = "horn_bicycle",
    categories = { "other" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 75,
    description = ccb.content.text("A simple bulb horn found on many bicycles.  Honk honk."),
    folded_volume = "250 ml",
    bonus = 45,
    item = "horn_bicycle",
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
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "HORN" },
    breaks_into = {
        { item = "scrap_aluminum", probability = 10 },
        { item = "plastic_chunk", probability = 35 },
    },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "horn_car",
    categories = { "other" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 100,
    description = ccb.content.text("A car horn meant to be attached to a car's electrical system."),
    bonus = 100,
    item = "horn_car",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 1 } },
        },
    },
    flags = { "HORN" },
    breaks_into = { { item = "scrap", count = { 0, 2 } }, { item = "plastic_chunk", count = { 1, 2 } } },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "horn_big",
    categories = { "other" },
    broken_color = "red",
    damage_modifier = 10,
    durability = 125,
    description = ccb.content.text("A very loud horn, usually found on large trucks like semis."),
    bonus = 120,
    item = "horn_big",
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
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 2 } },
        },
    },
    flags = { "HORN" },
    breaks_into = {
        { item = "lc_steel_chunk", probability = 50 },
        { item = "scrap", count = { 0, 2 } },
        { item = "plastic_chunk", count = { 1, 2 } },
    },
    variants = { { symbols = "*", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "beeper",
    categories = { "other" },
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 90,
    description = ccb.content.text("An electronic noise maker.  It will automatically make noise when you drive in reverse, alerting things behind you to move out of the way."),
    bonus = 40,
    folded_volume = "250 ml",
    item = "beeper",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "150 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 1 } },
        },
    },
    flags = { "BEEPER", "ODDTURN" },
    breaks_into = "ig_vp_device",
    variants = { { symbols = "*", broken_symbols = "*" } },
}

-- Based roughly on a quarter of a 2 m x 1.2 m pickup truck bed, assuming a reasonable amount of piling up (about 80 cm, ie. sticking up around 20 cm over the sides if really stacked).  Could definitely use more subtypes.
-- 240 cm weld to install, 60 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "cargo_space",
    name = ccb.content.text("cargo space"),
    looks_like = "box",
    categories = { "cargo" },
    broken_color = "dark_gray",
    durability = 250,
    size = "1000 L",
    cargo_passable_size = "500 L",
    item = "cargo_rack",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 12 } },
        },
    },
    flags = { "BOARDABLE", "CARGO", "COVERED", "HUGE_OK", "FURNITURE_TIEDOWN", "CARGO_PASSABLE_BY_STORED" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 12, 19 } },
        { item = "mc_steel_chunk", count = { 7, 12 } },
        { item = "scrap", count = { 14, 25 } },
        { item = "rope_6", count = { 0, 2 } },
        { item = "string_36", count = { 10, 25 } },
        { item = "string_6", count = { 15, 28 } },
    },
    damage_reduction = { all = 28 },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

-- 240 cm weld to install, 60 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "livestock_stall",
    categories = { "passengers", "cargo" },
    looks_like = "cargo_space",
    broken_color = "dark_gray",
    durability = 250,
    description = ccb.content.text("A cargo space for carrying livestock."),
    size = "200 L",
    item = "livestock_carrier",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 240 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 12 } },
        },
    },
    flags = { "BOARDABLE", "CARGO", "COVERED", "CAPTURE_MONSTER_VEH", "HUGE_OK" },
    breaks_into = {
        { item = "mc_steel_lump", count = { 6, 8 } },
        { item = "mc_steel_chunk", count = { 6, 8 } },
        { item = "scrap", count = { 6, 8 } },
    },
    damage_reduction = { all = 30 },
    variants = { { symbols = "=", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "animal_compartment",
    copy_from = "livestock_stall",
    durability = 125,
    description = ccb.content.text("A large locker for transporting smaller animals."),
    size = "50 L",
    item = "animal_locker",
    flags = { "CARGO", "COVERED", "CAPTURE_MONSTER_VEH", "OBSTACLE" },
    breaks_into = { { item = "lc_steel_chunk", count = { 1, 2 } }, { item = "scrap", count = { 3, 4 } } },
}

-- Standby power is negligible
ccb.content.define_vehicle_part {
    id = "recharge_station",
    description = ccb.content.text("A universal recharging station designed to operate on vehicle power.  While on, it will steadily charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space.  The system can only be installed onto existing storage compartments, and is controlled from a dashboard or electronics control unit."),
    categories = { "utility" },
    color = "light_green",
    broken_color = "blue",
    damage_modifier = 10,
    durability = 20,
    bonus = 600,
    item = "recharge_station",
    location = "on_cargo",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 8 } },
        },
    },
    flags = { "INTERNAL", "RECHARGE" },
    folded_volume = "2 L",
    breaks_into = {
        { item = "lc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 1, 2 } },
        { item = "cable", count = { 1, 2 } },
    },
    damage_reduction = { all = 10 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- Sub-milliwatt power consumption when idle; delivers 15 watts when charging.
ccb.content.define_vehicle_part {
    id = "battery_charger",
    description = ccb.content.text("A small device for recharging batteries, given a source of electricity.  It will slowly charge all rechargeable batteries (battery cells, lead-acid batteries, etc) placed directly within its storage space.  It can only be installed onto existing vehicle's storage compartments, and is controlled from a dashboard or electronics control unit."),
    durability = 5,
    bonus = 15,
    item = "battery_charger",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 4 } },
        },
    },
    folded_volume = "250 ml",
    breaks_into = "ig_vp_device",
    copy_from = "recharge_station",
}

ccb.content.define_vehicle_part {
    id = "stereo",
    categories = { "other" },
    color = "red",
    damage_modifier = 0,
    durability = 60,
    damage_reduction = { bash = 5 },
    description = ccb.content.text("A stereo system.  When turned on, it plays music, improving your mood."),
    epower = "-50 W",
    bonus = 80,
    item = "stereo",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "STEREO", "ENABLED_DRAINS_EPOWER", "SIMPLE_PART" },
    breaks_into = "ig_vp_device",
    variants = { { symbols = "&", broken_symbols = "&" } },
}

ccb.content.define_vehicle_part {
    id = "chimes",
    categories = { "other" },
    color = "red",
    damage_modifier = 0,
    durability = 40,
    description = ccb.content.text("A stereo system with loudspeakers and a built-in set of simple melodies that it will play.  Commonly used by ice cream trucks to draw the attention of children in the days when children wanted ice cream more than brains.  When turned on, it makes noise, attracting neighborhood children."),
    epower = "-50 W",
    item = "chimes",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 1 } },
        },
    },
    flags = { "CHIMES", "ENABLED_DRAINS_EPOWER" },
    location = "on_roof",
    breaks_into = {
        { item = "scrap", count = { 3, 5 } },
        { item = "cable", count = { 1, 2 } },
        { item = "e_scrap", count = { 1, 2 } },
        { item = "scrap_aluminum", probability = 80 },
        { item = "plastic_chunk", count = { 0, 2 } },
    },
    variants = { { symbols = "&", broken_symbols = "&" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "jumper_cable",
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    epower = "1 kW",
    durability = 120,
    item = "jumper_cable",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    breaks_into = { { item = "cable", count = { 4, 10 } }, { item = "plastic_chunk", count = { 1, 2 } } },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "extension_cable",
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    epower = "1 kW",
    durability = 120,
    item = "extension_cable",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    breaks_into = { { item = "cable", count = { 15, 30 } }, { item = "plastic_chunk", count = { 2, 3 } } },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "long_extension_cable",
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    epower = "1 kW",
    durability = 120,
    item = "long_extension_cable",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    breaks_into = { { item = "cable", count = { 45, 90 } }, { item = "plastic_chunk", count = { 4, 6 } } },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "jumper_cable_heavy",
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 120,
    epower = "5 kW",
    item = "jumper_cable_heavy",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    breaks_into = { { item = "cable", count = { 33, 65 } }, { item = "plastic_chunk", count = { 4, 8 } } },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "hd_tow_cable",
    categories = { "other" },
    color = "light_blue",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 120,
    item = "hd_tow_cable",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "TOW_CABLE" },
    breaks_into = {
        { item = "ch_steel_lump", count = { 5, 10 } },
        { item = "ch_steel_chunk", count = { 7, 14 } },
        { item = "scrap", count = { 17, 34 } },
        { item = "grip_hook", probability = 80 },
        { item = "cable", count = { 1, 2 } },
    },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

-- Epower for POWER_TRANSFER stuff is how much percentage-wise loss there is in transmission
ccb.content.define_vehicle_part {
    id = "jumper_cable_debug",
    categories = { "other" },
    color = "yellow",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 120,
    item = "jumper_cable_debug",
    requirements = { removal = { duration = "5 s" } },
    flags = { "NO_INSTALL_HIDDEN", "UNMOUNT_ON_DAMAGE", "POWER_TRANSFER" },
    breaks_into = { { item = "jumper_cable_debug" } },
    variants = { { symbols = "{", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "seat_wood_flimsy",
    name = ccb.content.text("flimsy wooden seat"),
    looks_like = "seat",
    categories = { "operations", "passengers" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 20,
    durability = 75,
    description = ccb.content.text("A place to sit, barely."),
    item = "frame_wood_light",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "rope_natural_short", 2 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            qualities = { { id = "CUT", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
    },
    flags = { "SEAT", "BOARDABLE", "BELTABLE" },
    breaks_into = {
        { item = "splinter", count = { 4, 7 } },
        { item = "string_36", count = { 3, 6 } },
        { item = "string_6", count = { 9, 18 } },
    },
    damage_reduction = { all = 6 },
    variants = { { symbols = "#", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "seat_wood",
    name = ccb.content.text("wooden seat"),
    looks_like = "seat",
    categories = { "operations", "passengers" },
    color = "brown",
    broken_color = "brown",
    damage_modifier = 60,
    durability = 125,
    description = ccb.content.text("A place to sit."),
    comfort = 1,
    item = "frame_wood",
    location = "center",
    size = "40 L",
    cargo_passable_size = "100 L",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "SEAT", "BOARDABLE", "BELTABLE", "CARGO" },
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 6, 12 } } },
    damage_reduction = { all = 8 },
    variants = { { symbols = "#", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "seat_wood_bench",
    name = ccb.content.text("wooden bench"),
    copy_from = "seat_wood",
    durability = 150,
    size = "65 L",
    description = ccb.content.text("A benchlike place to sit."),
}

ccb.content.define_vehicle_part {
    id = "roof_wood",
    name = ccb.content.text("wooden roof"),
    categories = { "hull" },
    broken_color = "dark_gray",
    durability = 130,
    item = "frame_wood",
    location = "roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "ROOF" },
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 6, 12 } } },
    damage_reduction = { all = 16 },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "plating_chitin",
    name = ccb.content.text("chitin plating"),
    categories = { "warfare" },
    color = "yellow",
    durability = 200,
    item = "chitin_plate",
    location = "armor",
    requirements = {
        install = { skills = { { "mechanics", 2 } }, duration = "10 m" },
        removal = { skills = { { "mechanics", 2 } }, duration = "5 m" },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "ARMOR" },
    breaks_into = {
        { item = "chitin_piece", count = { 4, 8 } },
        { item = "meal_chitin_piece", count = { 2, 6 } },
        { item = "rope_6", probability = 75 },
        { item = "string_36", count = { 2, 4 } },
        { item = "string_6", count = { 7, 14 } },
    },
    damage_reduction = { all = 20 },
    variants = { { symbols = ")", broken_symbols = ")" } },
}

ccb.content.define_vehicle_part {
    id = "plating_acidchitin",
    copy_from = "plating_chitin",
    name = ccb.content.text("biosilicified chitin plating"),
    proportional = { durability = 1.1 },
    item = "acidchitin_plate",
    breaks_into = {
        { item = "acidchitin_piece", count = { 6, 19 } },
        { item = "meal_chitin_piece", count = { 2, 6 } },
        { item = "rope_6", probability = 75 },
        { item = "string_36", count = { 2, 4 } },
        { item = "string_6", count = { 7, 14 } },
    },
    damage_reduction = { all = 24 },
}

ccb.content.define_vehicle_part {
    id = "door_motor",
    name = ccb.content.text("door motor"),
    categories = { "other" },
    color = "light_green",
    damage_modifier = 10,
    durability = 50,
    description = ccb.content.text("A small electric motor.  Installed on the same frame as a door or curtain, it will allow you to remotely open the door or curtain from the vehicle controls."),
    item = "motor_tiny",
    folded_volume = "250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "BOARD_INTERNAL", "DOOR_MOTOR", "UNMOUNT_ON_DAMAGE" },
    breaks_into = {
        { item = "scrap", count = { 1, 3 } },
        { item = "cable", count = { 1, 3 } },
        { item = "e_scrap", probability = 75 },
        { item = "bearing", count = { 0, 2 } },
    },
    damage_reduction = { all = 12 },
    variants = { { symbols = "*", broken_symbols = "#" } },
}

-- 120 cm weld to install the whole assembly, 30 cm weld per damage quadrant for repair
ccb.content.define_vehicle_part {
    id = "drive_by_wire_controls",
    categories = { "operations" },
    color = "light_red",
    broken_color = "red",
    damage_modifier = 10,
    durability = 200,
    description = ccb.content.text("A sophisticated set of electronic controls that allow you to control the vehicle from a vehicle remote while you are not in it."),
    folded_volume = "2500 ml",
    item = "drive_by_wire_controls",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 6 }, { "soldering_standard", 5 } },
        },
    },
    flags = { "CONTROLS", "REMOTE_CONTROLS" },
    breaks_into = {
        { item = "motor_tiny" },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "scrap", count = { 1, 3 } },
    },
    variants = { { symbols = "$", broken_symbols = "$" } },
}

ccb.content.define_vehicle_part {
    id = "cam_control",
    categories = { "operations" },
    color = "light_blue",
    broken_color = "blue",
    damage_modifier = 20,
    durability = 200,
    description = ccb.content.text("An LCD attached to one or more cameras.  When turned on, it lets you see from the cameras, but drains power from the vehicle's batteries.  You can 'e'xamine the tile to access the controls, or use the vehicle control key (default '^')."),
    folded_volume = "2500 ml",
    item = "camera_control",
    epower = "-20 W",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 2 } },
        },
    },
    flags = { "VISION", "CAMERA", "CAMERA_CONTROL", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "e_scrap", count = { 4, 10 } },
        { item = "plastic_chunk", count = { 2, 8 } },
        { item = "cable", count = { 1, 2 } },
    },
    variants = { { symbols = "#", broken_symbols = "#" } },
}

-- Cameras without a DVR can run on under 10 W
ccb.content.define_vehicle_part {
    id = "omnicam",
    categories = { "operations" },
    description = ccb.content.text("A security camera you could connect to a display.  Image quality is quite low, but the field of vision is great."),
    color = "light_red",
    broken_color = "red",
    damage_modifier = 10,
    durability = 100,
    folded_volume = "2 L",
    bonus = 24,
    item = "omnicamera",
    epower = "-10 W",
    location = "on_roof",
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
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "VISION", "CAMERA", "ENABLED_DRAINS_EPOWER" },
    breaks_into = {
        { item = "e_scrap", count = { 3, 7 } },
        { item = "cable", count = { 1, 3 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "lens", probability = 35 },
    },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "omnicamera_reinforced",
    copy_from = "omnicam",
    categories = { "operations" },
    description = ccb.content.text("A security camera with a cage built around it to protect it from damage without reducing its effectiveness."),
    durability = 300,
    item = "omnicamera_reinforced",
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
        { item = "e_scrap", count = { 3, 7 } },
        { item = "cable", count = { 1, 3 } },
        { item = "plastic_chunk", count = { 4, 10 } },
        { item = "lens", probability = 35 },
        { item = "scrap", count = { 1, 3 } },
    },
    variants = { { symbols = "o", broken_symbols = "#" } },
}

-- 120 cm weld to install the whole assembly, 30 cm weld per damage quadrant for repair
ccb.content.define_vehicle_part {
    id = "robot_controls",
    categories = { "operations" },
    description = ccb.content.text("A set of servos, microcontrollers, and other devices, to allow a vehicle to drive itself, or you to drive it remotely using a controller.  Its AI is not functional, but it should still have some sort of maintenance mode."),
    color = "white",
    damage_modifier = 10,
    durability = 300,
    item = "robot_controls",
    folded_volume = "1250 ml",
    location = "center",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "20 m",
            using_requirements = { { "repair_welding_standard", 3 }, { "soldering_standard", 3 } },
        },
    },
    flags = { "REMOTE_CONTROLS", "OBSTACLE", "CABLE_PORTS" },
    breaks_into = {
        { item = "motor_tiny", count = { 1, 3 } },
        { item = "lc_steel_chunk", count = { 1, 3 } },
        { item = "e_scrap", count = { 1, 5 } },
    },
    variants = { { symbols = "&", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "vehicle_clock",
    name = ccb.content.text("makeshift clock"),
    categories = { "other" },
    broken_color = "dark_gray",
    durability = 20,
    description = ccb.content.text("A clock, so you know what time it is."),
    folded_volume = "250 ml",
    item = "wristwatch",
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
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "WATCH", "ALARMCLOCK", "SIMPLE_PART" },
    breaks_into = { { item = "scrap", probability = 50 } },
    damage_reduction = { bash = 5 },
    variants = { { symbols = ":", broken_symbols = ";" } },
}

ccb.content.define_vehicle_part {
    id = "leather_funnel",
    looks_like = "funnel",
    categories = { "other" },
    color = "brown",
    damage_modifier = 5,
    durability = 80,
    description = ccb.content.text("A funnel that will collect rainwater into the tank beneath it."),
    bonus = 200,
    item = "leather_funnel",
    location = "on_roof",
    folded_volume = "250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "3 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "FUNNEL" },
    breaks_into = { { item = "leather", count = { 1, 2 } } },
    variants = { { symbols = "V", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "birchbark_funnel",
    looks_like = "funnel",
    categories = { "other" },
    color = "white",
    damage_modifier = 5,
    durability = 60,
    description = ccb.content.text("A funnel that will collect rainwater into the tank beneath it."),
    bonus = 240,
    item = "birchbark_funnel",
    location = "on_roof",
    folded_volume = "250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "3 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "FUNNEL" },
    breaks_into = { { item = "birchbark", count = { 1, 2 } } },
    variants = { { symbols = "V", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "makeshift_funnel",
    looks_like = "funnel",
    categories = { "other" },
    color = "yellow",
    damage_modifier = 5,
    durability = 80,
    description = ccb.content.text("A funnel that will collect rainwater into the tank beneath it."),
    bonus = 200,
    item = "makeshift_funnel",
    location = "on_roof",
    folded_volume = "250 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "3 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "FUNNEL" },
    breaks_into = { { item = "plastic_chunk", count = { 1, 2 } } },
    variants = { { symbols = "V", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "funnel",
    categories = { "other" },
    color = "yellow",
    damage_modifier = 5,
    durability = 200,
    description = ccb.content.text("A funnel that will collect rainwater into the tank beneath it."),
    bonus = 300,
    item = "funnel",
    location = "on_roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "6 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "3 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "FUNNEL" },
    breaks_into = { { item = "plastic_chunk", count = { 1, 2 } } },
    variants = { { symbols = "V", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "metal_funnel",
    looks_like = "funnel",
    categories = { "other" },
    damage_modifier = 30,
    durability = 300,
    description = ccb.content.text("A funnel that will collect rainwater into the tank beneath it."),
    bonus = 400,
    item = "metal_funnel",
    location = "on_roof",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "welding_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "2 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "1 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "FUNNEL" },
    breaks_into = { { item = "scrap", count = { 8, 12 } } },
    damage_reduction = { all = 12 },
    variants = { { symbols = "V", broken_symbols = "*" } },
}

-- 100 cm weld to install, 30 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "vehicle_scoop",
    categories = { "utility" },
    broken_color = "dark_gray",
    durability = 100,
    description = ccb.content.text("An assembly of motors and sheet metal that allows a vehicle to clean the road surface by removing debris and contaminants.  Use the vehicle controls to turn it on or off.  When turned on, it will scoop up loose items that it travels over until it's full."),
    epower = "-10 W",
    size = "100 L",
    damage_modifier = 10,
    item = "v_scoop_item",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 100 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_1", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "12 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "SCOOP", "CARGO", "ENABLED_DRAINS_EPOWER" },
    location = "under",
    breaks_into = {
        { item = "sheet_metal_small", count = { 4, 8 } },
        { item = "scrap", count = { 21, 42 } },
        { item = "bearing", count = { 1, 3 } },
        { item = "e_scrap", count = { 2, 6 } },
        { item = "cable", count = { 100, 200 } },
        { item = "plastic_chunk", count = { 1, 2 } },
        { item = "nuts_bolts", count = { 2, 5 } },
    },
    damage_reduction = { all = 24 },
    variants = { { symbols = "R", broken_symbols = ";" } },
}

ccb.content.define_vehicle_part {
    id = "water_purifier",
    name = ccb.content.text("water purifier"),
    categories = { "utility" },
    color = "blue",
    broken_color = "light_blue",
    damage_modifier = 40,
    durability = 200,
    description = ccb.content.text("A water purifier, powered by the vehicle's batteries.  You can use it to purify water in a container or in the vehicle's tanks.  'e'xamine the tile with the purifier to use it."),
    item = "water_purifier",
    location = "on_cargo",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "30 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 2 } },
        },
    },
    flags = {},
    pseudo_tools = { { id = "water_purifier", hotkey = "p" } },
    breaks_into = {
        { item = "scrap", count = { 1, 3 } },
        { item = "glass_shard", count = { 2, 5 } },
        { item = "cable", count = { 0, 2 } },
        { item = "hose", probability = 25 },
    },
    damage_reduction = { all = 26 },
    variants = { { symbols = "&", broken_symbols = "*" } },
}

-- ~8 hp for a moldboard plow depth of 8 inches
-- 200 cm weld to install and 60 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "plow",
    categories = { "utility" },
    color = "blue",
    broken_color = "light_blue",
    damage_modifier = 40,
    durability = 200,
    description = ccb.content.text("A plow.  Use the vehicle controls to turn it on or off.  When turned on, it will create a furrow in any dirt it travels over, making it suitable for planting seeds.  It should be placed in front of any seed drills on the vehicle."),
    item = "v_plow_item",
    location = "structure",
    power = "-6000 W",
    transform_terrain = { pre_flags = { "PLOWABLE" }, post_terrain = "t_dirtmound" },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "TRANSFORM_TERRAIN", "PLOW", "EXTRA_DRAG" },
    breaks_into = {
        { item = "ch_steel_lump", count = { 4, 7 } },
        { item = "ch_steel_chunk", count = { 21, 40 } },
        { item = "scrap", count = { 108, 215 } },
        { item = "nuts_bolts", count = { 7, 15 } },
        { item = "pipe_fittings", probability = 30 },
        { item = "rubber_tire_chunk", probability = 35 },
        { item = "chunk_rubber", count = { 8, 19 } },
        { item = "shredded_rubber", count = { 8, 20 } },
    },
    damage_reduction = { all = 46 },
    variants = { { symbols = "&", broken_symbols = "*" } },
}

-- ~1.5 hp for seed drill depth of 1.5 inches
-- 200 cm weld to install and 60 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "seed_drill",
    categories = { "utility" },
    color = "blue",
    broken_color = "light_blue",
    damage_modifier = 40,
    durability = 200,
    description = ccb.content.text("A seed drill.  Use the vehicle controls to turn it on or off.  You can load it with seeds by examining it.  When turned on, it will drop seeds as the vehicle moves, or plant them in furrowed dirt.  It should be placed behind any plows on the vehicle, and any wheels should be placed so they won't run over the plants."),
    item = "v_planter_item",
    location = "structure",
    size = "12500 ml",
    power = "-1200 W",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "PLANTER", "PROTRUSION", "CARGO", "EXTRA_DRAG", "CARGO_PASSABLE" },
    breaks_into = {
        { item = "sheet_metal_small", count = { 3, 6 } },
        { item = "scrap", count = { 10, 21 } },
        { item = "nuts_bolts", count = { 3, 6 } },
        { item = "rubber_tire_chunk", probability = 80 },
        { item = "chunk_rubber", count = { 16, 38 } },
        { item = "shredded_rubber", count = { 16, 40 } },
    },
    damage_reduction = { all = 16 },
    variants = { { symbols = "8", broken_symbols = "*" } },
}

-- 200 cm weld to install and 60 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "seed_drill_advanced",
    categories = { "utility" },
    color = "blue",
    broken_color = "light_blue",
    damage_modifier = 40,
    durability = 200,
    description = ccb.content.text("A seed drill.  Use the vehicle controls to turn it on or off.  You can load it with seeds by examining it.  When turned on, it will drop seeds as the vehicle moves, or plant them in furrowed dirt.  It should be placed behind any plows on the vehicle, and any wheels should be placed so they won't run over the plants."),
    item = "v_planter_item_advanced",
    location = "structure",
    power = "-700 W",
    epower = "-1 W",
    size = "17500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = {
        "PLANTER",
        "PROTRUSION",
        "CARGO",
        "ADVANCED_PLANTER",
        "EXTRA_DRAG",
        "CARGO_PASSABLE",
        "ENABLED_DRAINS_EPOWER",
    },
    breaks_into = {
        { item = "cable", count = { 1, 2 } },
        { item = "e_scrap", count = { 4, 10 } },
        { item = "plastic_chunk", count = { 1, 2 } },
        { item = "sheet_metal_small", count = { 3, 6 } },
        { item = "scrap", count = { 10, 21 } },
        { item = "nuts_bolts", count = { 3, 6 } },
        { item = "rubber_tire_chunk", probability = 80 },
        { item = "chunk_rubber", count = { 16, 38 } },
        { item = "shredded_rubber", count = { 16, 40 } },
    },
    damage_reduction = { all = 18 },
    variants = { { symbols = "8", broken_symbols = "*" } },
}

-- about 2 hp
-- 200 cm weld to install and 60 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "reaper",
    categories = { "utility" },
    broken_color = "light_blue",
    damage_modifier = 120,
    bonus = 7,
    power = "-1500 W",
    durability = 200,
    description = ccb.content.text("An automatic reaper.  Use the vehicle controls to turn it on or off.  When on, it will cut down plants that it travels over.  It should be placed in front of any plows in the vehicle for efficient operation.  It does not include cargo space, so harvested plants will end up on the ground."),
    item = "v_reaper_item",
    location = "structure",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "REAPER", "PROTRUSION", "EXTRA_DRAG" },
    breaks_into = {
        { item = "ch_steel_lump", count = { 3, 5 } },
        { item = "ch_steel_chunk", count = { 4, 8 } },
        { item = "sheet_metal_small", count = { 3, 6 } },
        { item = "scrap", count = { 15, 30 } },
        { item = "nuts_bolts", count = { 3, 6 } },
        { item = "rubber_tire_chunk", probability = 80 },
        { item = "chunk_rubber", count = { 16, 38 } },
        { item = "shredded_rubber", count = { 16, 40 } },
    },
    damage_reduction = { all = 10 },
    variants = { { symbols = "/", broken_symbols = "*" } },
}

-- No need to mention re drag - already provided by EXTRA_DRAG flag.
-- 200 cm weld to install and 60 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "reaper_advanced",
    categories = { "utility" },
    broken_color = "light_blue",
    damage_modifier = 120,
    bonus = 7,
    power = "-2000 W",
    durability = 200,
    description = ccb.content.text("An automatic reaper.  Use the vehicle controls to turn it on or off.  When on, it will cut down plants and store them in the vehicle's cargo.  It should be placed in front of any plows in the vehicle for efficient operation.  It has internal cargo space for collecting the harvest."),
    item = "v_reaper_item_advanced",
    location = "structure",
    size = "87500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 5 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 6 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    flags = { "REAPER", "CARGO", "EXTRA_DRAG" },
    breaks_into = {
        { item = "motor_small" },
        { item = "cable", count = { 1, 2 } },
        { item = "e_scrap", count = { 4, 10 } },
        { item = "plastic_chunk", count = { 1, 3 } },
        { item = "ch_steel_lump", count = { 3, 5 } },
        { item = "ch_steel_chunk", count = { 4, 8 } },
        { item = "sheet_metal_small", count = { 3, 6 } },
        { item = "scrap", count = { 15, 30 } },
        { item = "nuts_bolts", count = { 3, 6 } },
        { item = "rubber_tire_chunk", probability = 80 },
        { item = "chunk_rubber", count = { 16, 38 } },
        { item = "shredded_rubber", count = { 16, 40 } },
    },
    damage_reduction = { all = 12 },
    variants = { { symbols = "=", broken_symbols = "*" } },
}

ccb.content.define_vehicle_part {
    id = "cargo_lock",
    name = ccb.content.text("cargo lock"),
    categories = { "cargo" },
    color = "dark_gray",
    durability = 25,
    folded_volume = "250 ml",
    item = "cargo_lock",
    location = "on_lockable_cargo",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "12 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "12 m",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "6 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "CARGO_LOCKING", "INTERNAL", "SIMPLE_PART" },
    breaks_into = { { item = "clockworks", probability = 15 }, { item = "scrap", probability = 75 } },
    damage_reduction = { all = 60 },
    variants = { { symbols = "+", broken_symbols = "+" } },
}

-- 60 cm weld to install and 15 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "turret_mount",
    categories = { "warfare" },
    damage_modifier = 80,
    durability = 320,
    description = ccb.content.text("A rotating, universal mount for a weapon.  If your hands are empty, you can stand on the same tile as a turret mount and 'f'ire the weapon."),
    folded_volume = "2500 ml",
    item = "turret_mount",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 30 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "3 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "TURRET_MOUNT" },
    breaks_into = {
        { item = "cable", count = { 4, 7 } },
        { item = "e_scrap", count = { 1, 2 } },
        { item = "plastic_chunk", count = { 1, 2 } },
        { item = "bearing", count = { 1, 3 } },
        { item = "mc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 6, 12 } },
        { item = "nuts_bolts", count = { 3, 6 } },
    },
    damage_reduction = { all = 54 },
    variants = { { symbols = "X", broken_symbols = "X" } },
}

ccb.content.define_vehicle_part {
    id = "door_lock",
    variants = { { symbols = "*", broken_symbols = "*" } },
    categories = { "other" },
    color = "light_blue",
    durability = 25,
    folded_volume = "250 ml",
    item = "door_lock",
    requirements = {
        install = {
            skills = { { "mechanics", 2 }, { "traps", 1 } },
            duration = "24 m",
            qualities = { { id = "SCREW", level = 1 }, { id = "DRILL", level = 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "24 m",
            qualities = { { id = "SCREW", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 }, { "traps", 1 } },
            duration = "12 m",
            using_requirements = { { "soldering_standard", 3 } },
        },
    },
    flags = { "BOARD_INTERNAL", "DOOR_LOCKING", "UNMOUNT_ON_DAMAGE", "SIMPLE_PART" },
    breaks_into = { { item = "clockworks", probability = 30 }, { item = "scrap", probability = 75 } },
    damage_reduction = { all = 60 },
}

ccb.content.define_vehicle_part {
    id = "controls_turret",
    categories = { "warfare" },
    description = ccb.content.text("A set of motors, cameras, and various electronic modules banded together to allow for tracking targets, friend-or-foe identification, and firing the connected turret in full automatic mode."),
    color = "yellow",
    broken_color = "red",
    damage_modifier = 10,
    durability = 50,
    epower = "-250 W",
    item = "turret_controls",
    folded_volume = "750 ml",
    flags = { "ENABLED_DRAINS_EPOWER", "TURRET_CONTROLS", "UNMOUNT_ON_DAMAGE" },
    requirements = {
        install = {
            duration = "40 m",
            skills = { { "mechanics", 3 }, { "electronics", 3 } },
            qualities = { { id = "SCREW", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "3 m",
            using_requirements = { { "adhesive", 1 }, { "soldering_standard", 5 } },
        },
        removal = { skills = { { "mechanics", 3 } }, qualities = { { id = "SCREW", level = 1 } } },
    },
    breaks_into = "ig_vp_device",
    variants = { { symbols = "$", broken_symbols = "$" } },
}

-- 240 cm weld to install, 60 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "aluminum_boat_hull",
    categories = { "hull" },
    color = "dark_gray",
    looks_like = "boat_board",
    damage_modifier = 50,
    durability = 200,
    item = "aluminum_boat_hull",
    location = "under",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "50 m",
            using_requirements = { { "welding_alloys", 240 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_alloys", 6 } },
        },
    },
    flags = { "FLOATS" },
    breaks_into = { { item = "scrap_aluminum", count = { 6, 14 } } },
    damage_reduction = { all = 18 },
    variants = { { symbols = "o", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "plugged_3in_ordnance_rifle",
    name = ccb.content.text("plugged 3-inch ordnance rifle"),
    description = ccb.content.text("Unfortunately, some responsible killjoy poured concrete in the barrel of this historic cannon to make it safe for display."),
    durability = 400,
    damage_modifier = 80,
    location = "on_roof",
    categories = { "warfare" },
    item = "cannon_3in_ordnance",
    color = "dark_gray",
    broken_color = "dark_gray",
    breaks_into = {
        { item = "scrap", count = 72 },
        { item = "mc_steel_chunk", count = 30 },
        { item = "mc_steel_lump", count = 10 },
    },
    requirements = {
        install = { duration = "100 s", skills = { { "mechanics", 3 }, { "launcher", 1 } } },
        removal = { duration = "50 s", skills = { { "mechanics", 2 } } },
    },
    flags = {},
    variants = { { symbols = "t", broken_symbols = "#" } },
}
