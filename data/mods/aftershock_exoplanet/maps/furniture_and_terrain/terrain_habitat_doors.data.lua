local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_security_door_frame",
    name = ccb.content.text("open security gate"),
    description = ccb.content.text("A metal floor adorned with hazard lines indicating the presence of a security gate."),
    symbol = ".",
    looks_like = "t_door_frame",
    color = "dark_gray",
    move_cost = 2,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "SUPPORTS_ROOF" },
    bash = {
        minimum_strength = 18,
        maximum_strength = 75,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = { { item = "spike", count = { 2, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_afs_security_gate_closed",
    name = ccb.content.text("closed security gate"),
    description = ccb.content.text("An extremely resilient gate made of assorted steel, carved and pounded into shape."),
    symbol = "+",
    looks_like = "t_door_metal_c",
    color = "cyan",
    move_cost = 0,
    coverage = 95,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "DOOR", "LOCKED", "SUPPORTS_ROOF" },
    oxytorch = {
        result = "t_mdoor_frame",
        duration = "14 seconds",
        byproducts = {
            { item = "steel_plate", count = { 0, 1 } },
            { item = "ch_steel_chunk", count = { 3, 8 } },
        },
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 250,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_mdoor_lab_frame",
        drops = {
            { item = "scrap", count = { 12, 24 } },
            { item = "steel_plate", chance = 75 },
            { item = "hinge", count = { 1, 3 } },
        },
    },
}
