local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_augustmoon_diamond_glass",
    name = ccb.content.text("diamond-matrix glass"),
    description = ccb.content.text("The diamond cubic lattice distorts distant light sources into eight pointed stars.  The galactic core is visible through the glass, but no spacer would ever give it more than a passing glance."),
    roof = "t_metal_flat_roof",
    looks_like = "t_reinforced_glass",
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    coverage = 100,
    bash = {
        minimum_strength = 4000,
        maximum_strength = 8000,
        sound = ccb.content.text("whump!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_afs_augustmoon_diamond_glass",
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "OPENCLOSE_INSIDE",
        "BLOCK_WIND",
    },
}

ccb.content.define_terrain {
    id = "t_afs_augustmoon_hull_wall",
    name = ccb.content.text("Port Augustmoon hull"),
    description = ccb.content.text("The ancient hull of Port Augustmoon, spun into orbit several lifetimes ago."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    symbol = "#",
    bash = {
        minimum_strength = 4000,
        maximum_strength = 8000,
        sound = ccb.content.text("whump!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_afs_augustmoon_hull_wall",
    },
    color = "white",
}

ccb.content.define_terrain {
    id = "t_open_air_bay",
    copy_from = "t_open_air",
}

ccb.content.define_terrain {
    id = "t_afs_escapepod_g",
    name = ccb.content.text("escape pod guidance system"),
    description = ccb.content.text("The rudimentary descent guidance system and easy-use control console of an escape pod.  It apparently broke during the descent."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    color = "white",
    copy_from = "t_afs_space_ship_hull_wall",
    deconstruct = {
        terrain = "t_afs_space_ship_hull_wall",
        drops = {
            { item = "afs_circuitry_3", count = { 1, 2 } },
            { item = "afs_circuitry_2", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "small_lcd_screen", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 4 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_energy_storage_3", count = { 0, 1 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "afs_material_2", count = { 0, 2 } },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 40,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "cable", count = { 1, 2 } },
            { item = "plastic_chunk", count = { 6, 10 } },
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}
