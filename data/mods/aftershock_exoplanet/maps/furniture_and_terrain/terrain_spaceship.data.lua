local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_intermodal_crate_scripted_source",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit.  Any items placed inside will be taken with you to and from Port Augustmoon."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SMALL_HIDE" },
}

ccb.content.define_terrain {
    id = "t_intermodal_crate_scripted_destination",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SMALL_HIDE" },
}

ccb.content.define_terrain {
    id = "t_intermodal_crate",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "MOUNTABLE", "SHORT", "SMALL_HIDE", "PLACE_ITEM", "CONTAINER" },
}

ccb.content.define_terrain {
    id = "t_afs_shuttlepod_g",
    name = ccb.content.text("shuttle pod guidance system"),
    description = ccb.content.text("The complex controls of a shuttlepod.  Doesn't seem to be working right now."),
    roof = "t_metal_flat_roof",
    looks_like = "f_console_broken",
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
