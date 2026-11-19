local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_door_metal_elocked_xedra3",
    name = ccb.content.text("electronic locked metal door"),
    description = ccb.content.text("An extremely resilient door made of assorted steel, carved and pounded into shape.  It is locked by an electronic keypad."),
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
            { item = "mc_steel_chunk", count = { 3, 8 } },
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
    examine_handler = "examine_t_door_metal_elocked_xedra3",
}
