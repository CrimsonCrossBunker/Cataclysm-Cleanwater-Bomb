local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_door_stone_c",
    looks_like = "t_door_metal_c",
    name = ccb.content.text("closed stone door"),
    description = ccb.content.text("A heavy stone door.  It is currently closed."),
    symbol = "+",
    color = "cyan",
    move_cost = 0,
    coverage = 95,
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "DOOR", "BLOCK_WIND", "SUPPORTS_ROOF" },
    open = "t_door_stone_o",
    bash = {
        minimum_strength = 80,
        maximum_strength = 250,
        sound = ccb.content.text("rock shattering!"),
        failure_sound = ccb.content.text("crash!"),
        terrain = "t_mdoor_frame",
        drops = { { item = "rock", count = { 10, 25 } }, { item = "rock_large", count = { 3, 8 } } },
    },
}

ccb.content.define_terrain {
    id = "t_door_stone_o",
    name = ccb.content.text("open stone door"),
    description = ccb.content.text("A heavy stone door.  It is currently open."),
    symbol = "'",
    looks_like = "t_door_metal_o",
    color = "cyan",
    move_cost = 2,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "SUPPORTS_ROOF" },
    close = "t_door_stone_c",
    bash = {
        minimum_strength = 80,
        maximum_strength = 250,
        sound = ccb.content.text("rock shattering!"),
        failure_sound = ccb.content.text("crash!"),
        terrain = "t_mdoor_frame",
        drops = { { item = "rock", count = { 10, 25 } }, { item = "rock_large", count = { 3, 8 } } },
    },
}
