local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_wood_stairs_down",
    name = ccb.content.text("wooden stairs"),
    description = ccb.content.text("A wooden staircase leading down."),
    symbol = ">",
    color = "light_red",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "GOES_DOWN", "PLACE_ITEM", "SUPPORTS_ROOF" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_open_air_rooved",
        drops = {
            { item = "2x4", count = { 0, 2 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 2, 8 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    deconstruct = {
        terrain = "t_open_air_rooved",
        drops = { { item = "nail", charges = { 4, 8 } }, { item = "2x4", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wood_stairs_up_half",
    name = ccb.content.text("half-built wooden stairs"),
    description = ccb.content.text("Half of a wooden staircase.  Some work still needs to be done before this staircase is complete."),
    symbol = "<",
    color = "light_red",
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "PLACE_ITEM" },
    deconstruct = {
        deconstruct_above = true,
        terrain = "t_floor",
        drops = { { item = "nail", charges = { 12, 20 } }, { item = "2x4", count = { 2, 6 } } },
    },
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_floor",
        drops = {
            { item = "2x4", count = { 0, 5 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wood_stairs_up_broken",
    name = ccb.content.text("broken wooden stairs"),
    description = ccb.content.text("A number of planks are missing and the structure is beginning to sag and fall apart.  It's going to need quite a bit of work to repair this staircase."),
    symbol = "<",
    color = "light_red",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "PLACE_ITEM" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 110,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_floor",
        drops = {
            { item = "2x4", count = { 0, 2 } },
            { item = "wood_panel", count = { 0, 1 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 2, 8 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wood_stairs_up",
    name = ccb.content.text("wooden stairs"),
    description = ccb.content.text("A wooden staircase leading up."),
    symbol = "<",
    color = "light_red",
    move_cost = 2,
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "FLAMMABLE_ASH", "GOES_UP", "PLACE_ITEM" },
    deconstruct = {
        deconstruct_above = true,
        terrain = "t_floor",
        drops = {
            { item = "nail", charges = { 12, 20 } },
            { item = "2x4", count = { 8, 12 } },
            { item = "wood_panel", count = { 1, 3 } },
        },
    },
    bash = {
        minimum_strength = 12,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_wood_stairs_up_broken",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "wood_panel", count = { 0, 2 } },
            { item = "nail", charges = { 1, 5 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_stairs_down",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading down."),
    symbol = ">",
    color = "yellow",
    move_cost = 2,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "GOES_DOWN", "INDOORS", "PLACE_ITEM", "SUPPORTS_ROOF" },
}

ccb.content.define_terrain {
    id = "t_stairs_down_no_roof",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading down."),
    symbol = ">",
    looks_like = "t_stairs_down",
    color = "yellow",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_DOWN", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_stairs_up",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading up."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_UP", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_manhole",
    name = ccb.content.text("manhole"),
    description = ccb.content.text("A manhole.  The heavy iron cover has been removed, revealing an entrance to the underworld of hidden tunnels beneath the streets where sewage and rainwater frolic freely.  Or maybe it just leads to a lower floor."),
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_DOWN", "PLACE_ITEM" },
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
}

ccb.content.define_terrain {
    id = "t_manhole_cover",
    name = ccb.content.text("manhole cover"),
    description = ccb.content.text("A heavy iron manhole cover, zealously blocking the entrance to a sewer or other underground area.  Impossible to lift by hand, you'll need some kind of heavy-duty prying tool."),
    symbol = "0",
    color = "dark_gray",
    move_cost = 2,
    builtin_examine = "locked_object",
    prying = {
        result = "t_manhole",
        message = ccb.content.text("You lift the manhole cover."),
        prying = {
            difficulty = 4,
            prying_level = 1,
            failure = ccb.content.text("You pry, but can't lift the manhole cover."),
        },
        byproducts = { { item = "manhole_cover", count = 1 } },
    },
    flags = { "TRANSPARENT" },
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
}

ccb.content.define_terrain {
    id = "t_ladder_up",
    name = ccb.content.text("ladder"),
    description = ccb.content.text("A ladder leading up."),
    symbol = "<",
    looks_like = "t_ladder_up_down",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_UP", "PLACE_ITEM", "DIFFICULT_Z" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 6 } }, { item = "scrap", count = { 3, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_ladder_down",
    name = ccb.content.text("ladder"),
    description = ccb.content.text("A ladder leading down."),
    symbol = ">",
    looks_like = "t_ladder_up_down",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_DOWN", "PLACE_ITEM", "DIFFICULT_Z" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_open_air_rooved",
        drops = { { item = "mc_steel_chunk", count = { 1, 6 } }, { item = "scrap", count = { 3, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_ladder_up_down",
    name = ccb.content.text("ladder"),
    description = ccb.content.text("A ladder leading up and down."),
    symbol = "H",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_UP", "GOES_DOWN", "PLACE_ITEM", "DIFFICULT_Z" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_ladder_down",
        drops = { { item = "mc_steel_chunk", count = { 1, 6 } }, { item = "scrap", count = { 3, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_scaffolding_pipe_up",
    name = ccb.content.text("scaffolding up"),
    description = ccb.content.text("Scaffolding leading up."),
    symbol = "<",
    looks_like = "t_ladder_up",
    color = "dark_gray",
    move_cost = 2,
    roof = "t_scaffolding_pipe_down",
    flags = { "TRANSPARENT", "GOES_UP", "PLACE_ITEM", "DIFFICULT_Z", "SUPPORTS_ROOF", "SINGLE_SUPPORT" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_dirt",
        drops = {
            { item = "pipe", count = { 10, 46 } },
            { item = "pipe_fittings", count = { 10, 55 } },
            { item = "2x4", count = { 1, 4 } },
            { item = "stick", count = { 0, 2 } },
            { item = "rope_30", count = { 0, 2 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_scaffolding_pipe_down",
    name = ccb.content.text("scaffolding down"),
    description = ccb.content.text("Scaffolding leading down."),
    symbol = ">",
    looks_like = "t_ladder_down",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_DOWN", "PLACE_ITEM", "DIFFICULT_Z", "SINGLE_SUPPORT" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_open_air",
    },
}

ccb.content.define_terrain {
    id = "t_scaffolding_pipe_updown",
    name = ccb.content.text("scaffolding up/down"),
    description = ccb.content.text("Scaffolding leading up and down."),
    looks_like = "t_ladder_up_down",
    symbol = "H",
    color = "dark_gray",
    move_cost = 2,
    flags = {
        "TRANSPARENT",
        "GOES_UP",
        "GOES_DOWN",
        "PLACE_ITEM",
        "DIFFICULT_Z",
        "SUPPORTS_ROOF",
        "SINGLE_SUPPORT",
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_scaffolding_pipe_down",
        drops = {
            { item = "pipe", count = { 10, 46 } },
            { item = "pipe_fittings", count = { 10, 55 } },
            { item = "2x4", count = { 1, 4 } },
            { item = "stick", count = { 0, 2 } },
            { item = "rope_30", count = { 0, 2 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_ramp_down_high",
    name = ccb.content.text("road ramp down (high end)"),
    description = ccb.content.text("The upper end of an asphalt ramp leading down."),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_ramp_down_low",
    name = ccb.content.text("road ramp down (low end)"),
    description = ccb.content.text("The lower end of an asphalt ramp leading down."),
    connect_groups = "WALL",
    connects_to = "WALL",
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "RAMP_DOWN", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_ramp_up_high",
    name = ccb.content.text("road ramp up (high end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The upper end of an asphalt ramp leading up."),
    symbol = "<",
    color = "dark_gray",
    move_cost = 2,
    flags = { "ROAD", "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_ramp_up_low",
    name = ccb.content.text("road ramp up (low end)"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("The lower end of an asphalt ramp leading up."),
    symbol = "<",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_earth_ramp_down_high",
    name = ccb.content.text("earth ramp down (high end)"),
    description = ccb.content.text("The upper end of an earth ramp leading down."),
    symbol = ">",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_earth_ramp_down_low",
    name = ccb.content.text("earth ramp down (low end)"),
    description = ccb.content.text("The lower end of an earth ramp leading down."),
    connect_groups = "WALL",
    connects_to = "WALL",
    symbol = ">",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_DOWN", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_earth_ramp_up_high",
    name = ccb.content.text("earth ramp up (high end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The upper end of an earth ramp leading up."),
    symbol = "<",
    color = "brown",
    move_cost = 2,
    flags = { "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_earth_ramp_up_low",
    name = ccb.content.text("earth ramp up (low end)"),
    description = ccb.content.text("The lower end of an earth ramp leading up."),
    symbol = "<",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_sidewalk_ramp_down_high",
    name = ccb.content.text("sidewalk ramp down (high end)"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("The upper end of a sidewalk ramp leading down."),
    symbol = ">",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_sidewalk_ramp_down_low",
    name = ccb.content.text("sidewalk ramp down (low end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The lower end of a sidewalk ramp leading down."),
    symbol = ">",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "RAMP_DOWN", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_sidewalk_ramp_up_high",
    name = ccb.content.text("sidewalk ramp up (high end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The upper end of a sidewalk ramp leading up."),
    symbol = "<",
    color = "light_gray",
    move_cost = 2,
    flags = { "ROAD", "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_sidewalk_ramp_up_low",
    name = ccb.content.text("sidewalk ramp up (low end)"),
    description = ccb.content.text("The lower end of a sidewalk ramp leading up."),
    symbol = "<",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_slope_down",
    name = ccb.content.text("downward slope"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("A downward-facing slope."),
    symbol = ">",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_DOWN", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_slope_up",
    name = ccb.content.text("upward slope"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("An upward-facing slope."),
    symbol = "<",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_UP", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_rope_up",
    name = ccb.content.text("rope leading up"),
    description = ccb.content.text("A dangling end of rope, the other end tied securely to something above you.  You could climb up it."),
    symbol = "<",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "GOES_UP", "DIFFICULT_Z" },
}

ccb.content.define_terrain {
    id = "t_low_stairs_begin",
    name = ccb.content.text("low stairs (beginning section)"),
    description = ccb.content.text("A flight of stairs leading up."),
    symbol = "<",
    color = "dark_gray_white",
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE", "PLACE_ITEM", "RAMP", "SEEN_FROM_ABOVE" },
    bash = {
        minimum_strength = 12,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_floor",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 1, 5 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_low_stairs_end",
    name = ccb.content.text("low stairs (end section)"),
    description = ccb.content.text("A flight of stairs leading up."),
    symbol = "<",
    color = "black_white",
    move_cost = 0,
    flags = { "FLAMMABLE", "PLACE_ITEM", "RAMP", "RAMP_END", "SEEN_FROM_ABOVE" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_floor",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 1, 5 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_railroad_ramp_down_high",
    name = ccb.content.text("railroad ramp down (high end)"),
    description = ccb.content.text("The upper end of a railroad ramp leading down."),
    connect_groups = "RAIL",
    connects_to = "RAIL",
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAIL", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_railroad_ramp_down_low",
    name = ccb.content.text("railroad ramp down (low end)"),
    description = ccb.content.text("The lower end of a railroad ramp leading down."),
    connect_groups = "WALL",
    connects_to = "WALL",
    symbol = ">",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAIL", "RAMP_DOWN", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_railroad_ramp_up_high",
    name = ccb.content.text("railroad ramp up (high end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The upper end of a railroad ramp leading up."),
    symbol = "<",
    color = "dark_gray",
    move_cost = 2,
    flags = { "RAIL", "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_railroad_ramp_up_low",
    name = ccb.content.text("railroad ramp up (low end)"),
    connect_groups = "RAIL",
    connects_to = "RAIL",
    description = ccb.content.text("The lower end of a railroad ramp leading up."),
    symbol = "<",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAIL" },
}

ccb.content.define_terrain {
    id = "t_concrete_ramp_down_high",
    name = ccb.content.text("concrete ramp down (high end)"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("The upper end of a concrete ramp leading down."),
    symbol = ">",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_concrete_ramp_down_low",
    name = ccb.content.text("concrete ramp down (low end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The lower end of a concrete ramp leading down."),
    symbol = ">",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD", "RAMP_DOWN", "TRANSPARENT_FLOOR", "Z_TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_concrete_ramp_up_high",
    name = ccb.content.text("concrete ramp up (high end)"),
    connect_groups = "WALL",
    connects_to = "WALL",
    description = ccb.content.text("The upper end of a concrete ramp leading up."),
    symbol = "<",
    color = "light_gray",
    move_cost = 2,
    flags = { "ROAD", "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_concrete_ramp_up_low",
    name = ccb.content.text("concrete ramp up (low end)"),
    description = ccb.content.text("The lower end of a concrete ramp leading up."),
    symbol = "<",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "ROAD" },
}
