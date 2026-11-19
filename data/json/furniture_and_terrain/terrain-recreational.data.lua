local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_sandbox",
    name = ccb.content.text("sandbox"),
    description = ccb.content.text("Children used to play in this sandbox.  The population of lice probably diminished considerably now that they no longer do."),
    symbol = "#",
    looks_like = "t_sand",
    color = "yellow",
    move_cost = 3,
    deconstruct = {
        terrain = "t_dirt",
        drops = {
            { item = "2x4", count = 4 },
            { item = "material_sand", count = { 800, 1200 } },
            { item = "nail", charges = { 6, 10 } },
        },
    },
    flags = { "TRANSPARENT", "TINY" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 3, 8 } },
            { item = "material_sand", count = { 800, 1200 } },
            { item = "splinter", count = { 1, 3 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_slide",
    name = ccb.content.text("slide"),
    description = ccb.content.text("A children's slide.  It's too small for you to slide on comfortably."),
    symbol = "#",
    looks_like = "t_ladder_up",
    color = "light_cyan",
    move_cost = 4,
    deconstruct = {
        terrain = "t_dirt",
        drops = { { item = "sheet_metal", count = 1 }, { item = "pipe", count = { 4, 8 } } },
    },
    flags = { "TRANSPARENT", "MOUNTABLE" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("crack!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_dirt",
        drops = { { item = "pipe", count = { 2, 6 } }, { item = "scrap", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_monkey_bars",
    name = ccb.content.text("monkey bars"),
    looks_like = "t_ladder_up",
    description = ccb.content.text("A set of monkey bars to be used by children to train their arm strength, or, in happier days, to just have fun."),
    symbol = "#",
    color = "cyan",
    move_cost = 4,
    deconstruct = { terrain = "t_dirt", drops = { { item = "pipe", count = { 6, 12 } } } },
    flags = { "TRANSPARENT", "MOUNTABLE" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("crack!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_dirt",
        drops = { { item = "pipe", count = { 4, 8 } }, { item = "scrap", count = { 1, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_backboard",
    name = ccb.content.text("backboard"),
    description = ccb.content.text("A basketball backboard."),
    looks_like = "t_chainfence",
    symbol = "7",
    color = "red",
    move_cost = 0,
    deconstruct = {
        terrain = "t_pavement",
        drops = { { item = "2x4", count = 4 }, { item = "nail", charges = { 6, 10 } } },
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "WALL", "PERMEABLE" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 45,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_pavement",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 3, 8 } },
            { item = "splinter", count = { 1, 3 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_backboard_in",
    name = ccb.content.text("backboard"),
    description = ccb.content.text("A metal backboard."),
    symbol = "7",
    looks_like = "t_backboard",
    color = "red",
    move_cost = 0,
    roof = "t_flat_roof",
    bash = {
        minimum_strength = 8,
        maximum_strength = 45,
        terrain = "t_floor_waxed",
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 2, 8 } },
            { item = "mc_steel_chunk", count = { 1, 3 } },
            { item = "pipe", count = { 1, 2 } },
        },
    },
    deconstruct = {
        terrain = "t_floor_waxed",
        drops = { { item = "2x4", count = 4 }, { item = "nail", charges = { 6, 10 } } },
    },
    connect_groups = { "INDOORFLOOR", "WALL" },
    connects_to = "WALL",
    flags = { "TRANSPARENT", "WALL", "PERMEABLE", "INDOORS" },
}
