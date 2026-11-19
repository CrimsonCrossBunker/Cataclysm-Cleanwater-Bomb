local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_space_ship_hull_wall",
    name = ccb.content.text("starship hull"),
    description = ccb.content.text("A hull segment from a civilian starship.  Only sufficiently armored to defend against the vacuum and radiation of space, the only dangers you'd expect to find on the other side."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "WIRING", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_broken_treads",
    name = ccb.content.text("broken treads"),
    description = ccb.content.text("A large set of broken and frozen over vehicle treads."),
    flags = { "NOITEM", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND", "TRANSPARENT", "SHORT" },
    symbol = "#",
    color = "white",
    move_cost = 5,
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 8 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}
