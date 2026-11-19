local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_coral_floor_no_roof",
    name = ccb.content.text("coral floor"),
    description = ccb.content.text("Thin shelves of coral latch together into a flat mosaic and portray the geometries of life."),
    symbol = ".",
    color = "white",
    move_cost = 1,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "NOCOLLIDE" },
    bash = {
        minimum_strength = 250,
        maximum_strength = 700,
        sound = ccb.content.text("boom!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_null",
        drops = { { item = "resin_chunk", count = { 10, 20 } } },
    },
}

ccb.content.define_terrain {
    id = "t_coral_wall",
    name = ccb.content.text("coral floor"),
    description = ccb.content.text("Filaments of white coral grow tall and weave themselves into a sinuous wall.  The living surface is ornately grooved, and golden light slowly flows within its gaps."),
    roof = "t_coral_floor_no_roof",
    symbol = "#",
    looks_like = "t_rock_wall",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 39,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_broken_prefab",
        drops = { { item = "resin_chunk", count = { 30, 40 } } },
    },
}
