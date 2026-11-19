local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_scrap_wall_scarlet",
    name = ccb.content.text("scrap metal spire"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("This great spire of twisted metal is held together by fraying wires and large bolts.  It looks like you could climb it."),
    symbol = "-",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_nl_scrap_floor",
    flags = {
        "NOITEM",
        "SUPPORTS_ROOF",
        "WALL",
        "REDUCE_SCENT",
        "AUTO_WALL_SYMBOL",
        "MINEABLE",
        "BLOCK_WIND",
        "CLIMBABLE",
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal crying!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_broken_metal_floor",
        drops = { { item = "steel_chunk", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_scrap_scaffolding_scarlet",
    name = ccb.content.text("mass of climbable metal"),
    description = ccb.content.text("A mass of jagged metal, climbing into the sky.  It looks sharp, but also sturdy enough to climb."),
    symbol = "H",
    color = "dark_gray",
    move_cost = 2,
    flags = {
        "TRANSPARENT",
        "GOES_UP",
        "GOES_DOWN",
        "PLACE_ITEM",
        "DIFFICULT_Z",
        "SINGLE_SUPPORT",
        "SHARP",
        "ROUGH",
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = { { item = "pipe", count = { 10, 46 } }, { item = "pipe_fittings", count = { 10, 55 } } },
    },
}
