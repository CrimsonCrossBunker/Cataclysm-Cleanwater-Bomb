local ccb = require("ccb")

-- weld repairs would involve patching up holes, for a small tank assume 5 cm squares (20 cm weld total)
ccb.content.define_vehicle_part {
    id = "tank_little",
    name = ccb.content.text("vehicle tank (2 L)"),
    item = "metal_tank_little",
    location = "fuel_source",
    broken_color = "red",
    durability = 75,
    description = ccb.content.text("A storage space for holding liquids."),
    categories = { "movement" },
    damage_modifier = 80,
    folded_volume = "2 L",
    breaks_into = { { item = "scrap", count = { 1, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_1", 1 }, { "drilling_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 26, stab = 8 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "tank_small",
    name = ccb.content.text("vehicle tank (10 L)"),
    item = "jerrycan",
    location = "fuel_source",
    broken_color = "red",
    durability = 100,
    description = ccb.content.text("A storage space for holding liquids."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = { { item = "plastic_chunk", count = { 10, 40 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "vehicle_wrench_1", 1 }, { "drilling_standard", 20 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 9, stab = 0 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "tank_medium",
    name = ccb.content.text("vehicle tank (20 L)"),
    item = "jerrycan_big",
    location = "fuel_source",
    broken_color = "red",
    durability = 120,
    description = ccb.content.text("A storage space for holding liquids."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "lc_steel_lump", count = { 1, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 40 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "22 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 28, stab = 10 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "tank",
    name = ccb.content.text("vehicle tank (60 L)"),
    item = "metal_tank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A storage space for holding liquids."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "fridgetank",
    item = "fridgetank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A 60 L refrigerated tank.  When turned on, it will cool the liquid inside, extending the time until the food spoils."),
    categories = { "cargo" },
    damage_modifier = 80,
    epower = "-40 W",
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "FLUIDTANK", "FRIDGE", "ENABLED_DRAINS_EPOWER" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "fridgetank_large",
    item = "fridgetank_large",
    location = "fuel_source",
    broken_color = "red",
    durability = 170,
    description = ccb.content.text("A 100 L refrigerated tank.  When turned on, it will cool the liquid inside, extending the time until the food spoils."),
    categories = { "cargo" },
    damage_modifier = 80,
    epower = "-80 W",
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "110 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "65 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "FLUIDTANK", "FRIDGE", "ENABLED_DRAINS_EPOWER" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "heattank",
    item = "heattank",
    copy_from = "fridgetank",
    epower = "-60 W",
    flags = { "FLUIDTANK", "HEATED_TANK", "ENABLED_DRAINS_EPOWER" },
}

-- 45 cm weld install. weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "external_tank_small",
    name = ccb.content.text("external tank (100 L)"),
    item = "30gal_drum",
    location = "structure",
    broken_color = "red",
    durability = 160,
    description = ccb.content.text("A storage space for holding liquids, mounted outside your vehicle's armor and vulnerable to damage."),
    categories = { "movement" },
    damage_modifier = 80,
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "PROTRUSION", "UNMOUNT_ON_DAMAGE", "FLUIDTANK" },
    damage_reduction = { all = 30, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "afs_small_roof_external_tank",
    copy_from = "external_tank_small",
    name = ccb.content.text("roof-mounted tank (100 L)"),
    looks_like = "afs_roof_external_tank",
    location = "on_roof",
    extend = { flags = { "ON_ROOF" } },
}

ccb.content.define_vehicle_part {
    id = "external_tank",
    copy_from = "external_tank_small",
    name = ccb.content.text("external tank (200 L)"),
    item = "55gal_drum",
    damage_reduction = { all = 30, stab = 12 },
}

ccb.content.define_vehicle_part {
    id = "afs_roof_external_tank",
    copy_from = "external_tank_small",
    name = ccb.content.text("roof-mounted tank (200 L)"),
    item = "55gal_drum",
    location = "on_roof",
    extend = { flags = { "ON_ROOF" } },
}

ccb.content.define_vehicle_part {
    id = "tank_barrel",
    item = "wooden_barrel",
    location = "center",
    categories = { "movement" },
    color = "brown",
    broken_color = "brown",
    durability = 120,
    description = ccb.content.text("A storage space for holding liquids, mounted inside the cargo or passenger space."),
    damage_modifier = 80,
    breaks_into = {
        { item = "splinter", count = { 3, 8 } },
        { item = "2x4", count = { 2, 8 } },
        { item = "scrap", count = { 1, 3 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 18, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- 50 cm weld install. weld repairs would involve patching up holes, for a medium-large tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "tank_30gal_drum",
    item = "30gal_drum",
    location = "fuel_source",
    categories = { "movement" },
    color = "dark_gray",
    broken_color = "red",
    durability = 160,
    description = ccb.content.text("A storage space for holding liquids, mounted inside the cargo or passenger space."),
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "FLUIDTANK" },
    damage_reduction = { all = 30, stab = 12 },
    variants = { { symbols = "0", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "tank_55gal_drum",
    copy_from = "tank_30gal_drum",
    item = "55gal_drum",
    breaks_into = {
        { item = "lc_steel_lump", count = { 4, 4 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 10 } },
    },
    flags = { "FLUIDTANK", "OBSTACLE", "AIRCRAFT_REPAIRABLE_NOPROF" },
    damage_reduction = { all = 30, stab = 12 },
}

-- 80 cm weld install. weld repairs would involve patching up holes, for a medium tank assume 10 cm squares (40 cm weld total)
ccb.content.define_vehicle_part {
    id = "fuel_bunker",
    item = "fuel_bunker",
    location = "fuel_source",
    categories = { "movement" },
    color = "brown",
    broken_color = "brown",
    looks_like = "tank",
    durability = 150,
    description = ccb.content.text("A bin for holding solid fuel."),
    damage_modifier = 80,
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 2 } },
        { item = "lc_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 80 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    damage_reduction = { all = 24, stab = 18 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- 1 gallon tank.
ccb.content.define_vehicle_part {
    id = "small_pressure_tank",
    item = "small_propane_tank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A tank for pressurized gasses."),
    folded_volume = "2 L",
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "ch_steel_lump", count = { 2, 2 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "GASTANK" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- 10 gallon tank.
ccb.content.define_vehicle_part {
    id = "medium_pressure_tank",
    item = "medium_propane_tank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A tank for pressurized gasses."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "ch_steel_lump", count = { 2, 2 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "4 m",
            using_requirements = { { "repair_welding_standard", 2 } },
        },
    },
    flags = { "GASTANK" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- 20 gallon tank.
ccb.content.define_vehicle_part {
    id = "large_pressure_tank",
    item = "large_propane_tank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A tank for pressurized gasses."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "ch_steel_lump", count = { 2, 2 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    flags = { "GASTANK" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

-- 100 gallon ASME tank.
ccb.content.define_vehicle_part {
    id = "xl_pressure_tank",
    item = "xl_propane_tank",
    location = "fuel_source",
    broken_color = "red",
    durability = 150,
    description = ccb.content.text("A tank for pressurized gasses."),
    categories = { "movement" },
    damage_modifier = 80,
    breaks_into = {
        { item = "ch_steel_lump", count = { 2, 2 } },
        { item = "ch_steel_chunk", count = { 1, 2 } },
        { item = "scrap", count = { 1, 5 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "90 m",
            using_requirements = { { "vehicle_wrench_2", 1 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "45 m",
            qualities = { { id = "WRENCH", level = 2 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_standard", 4 } },
        },
    },
    flags = { "GASTANK" },
    damage_reduction = { all = 28, stab = 12 },
    variants = { { symbols = "O", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "tank_55gal_drum_aluminum",
    copy_from = "tank_55gal_drum",
    item = "55gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 25 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "tank_30gal_drum_aluminum",
    copy_from = "tank_30gal_drum",
    item = "30gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 13 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "external_tank_small_aluminum",
    copy_from = "external_tank_small",
    name = ccb.content.text("external aluminum tank (100 L)"),
    looks_like = "afs_roof_external_tank",
    item = "30gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 13 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "afs_small_roof_external_tank_aluminum",
    copy_from = "afs_small_roof_external_tank",
    name = ccb.content.text("roof-mounted aluminum tank (100 L)"),
    item = "30gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 13 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "external_tank_aluminum",
    copy_from = "external_tank",
    name = ccb.content.text("external aluminum tank (200 L)"),
    item = "55gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 25 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "afs_roof_external_tank_aluminum",
    copy_from = "afs_roof_external_tank",
    name = ccb.content.text("roof-mounted aluminum tank (200 L)"),
    item = "55gal_drum_aluminum",
    breaks_into = { { item = "scrap_aluminum", count = { 4, 25 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 50 }, { "drilling_standard", 50 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_alloys", 4 } },
        },
    },
}
