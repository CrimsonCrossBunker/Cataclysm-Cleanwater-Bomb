local ccb = require("ccb")

-- Missing feature to allow survivors to climb to increase overmap vision range.
ccb.content.define_terrain {
    id = "t_outcrop",
    name = ccb.content.text("outcrop"),
    description = ccb.content.text("An assortment of various large, sharp rocks that jut out from the surrounding terrain.  Could be as a surface for a number of things or climbed on if worn with proper footwear."),
    symbol = "O",
    color = "dark_gray",
    looks_like = "f_boulder_large",
    move_cost = 8,
    coverage = 100,
    flags = { "BLOCK_WIND", "BUTCHER_EQ", "FLAT_SURF", "MINEABLE", "ROUGH", "SEEN_FROM_ABOVE", "UNSTABLE" },
    bash = {
        minimum_strength = 64,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        terrain = "t_rock_floor",
        minimum_strength_supported = 100,
        bash_below = false,
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sanddune",
    name = ccb.content.text("dune"),
    description = ccb.content.text("A huge sand dune that is continually reshaped by the wind.  Climbing it will be troublesome."),
    symbol = "~",
    color = "yellow",
    looks_like = "t_sandmound",
    move_cost = 6,
    coverage = 60,
    flags = { "TRANSPARENT", "UNSTABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_sand",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_desertpavement",
    name = ccb.content.text("desert pavement"),
    description = ccb.content.text("Not that kind of pavement!  Naturally occurring pockets of densely packed rock fragments that is easier to traverse than sand, with the right footwear."),
    symbol = ".",
    color = "dark_gray",
    looks_like = "t_railroad_rubble",
    move_cost = 2,
    flags = { "DIGGABLE", "FLAT", "ROUGH", "TRANSPARENT" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 100,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        terrain = "t_rock_floor",
        minimum_strength_supported = 100,
        bash_below = true,
        drops = { { item = "rock", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_searth",
    name = ccb.content.text("scorched earth"),
    description = ccb.content.text("Cracked and dry soil that doesn't look like it will be capable of supporting anything in your lifetime."),
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_mudcrack",
    name = ccb.content.text("mudcrack"),
    description = ccb.content.text("Large continuous cracks mark what once was a bottom of a body of water.  With the proper tools, you could extract clay from here."),
    symbol = ".",
    looks_like = "t_dirt",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_sandstone",
    name = ccb.content.text("sandstone"),
    description = ccb.content.text("A wall of yellowish brown sandstone."),
    symbol = "#",
    color = "yellow",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    roof = "t_searth",
    looks_like = "t_adobe_brick_wall",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("wham!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_searth",
        terrain_from_above = "t_searth",
    },
}

ccb.content.define_terrain {
    id = "t_grass_fake",
    name = ccb.content.text("artificial grass"),
    description = ccb.content.text("A carpet of synthetic fibers made to resemble natural grass."),
    symbol = ".",
    color = "green",
    looks_like = "t_grass",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_grass_fake_white",
    name = ccb.content.text("white artificial grass"),
    description = ccb.content.text("A carpet of synthetic fibers made to resemble natural grass.  Covered in white latex-based paint, it is used to mark lines in recreational sports."),
    symbol = ".",
    color = "white",
    looks_like = "t_grass_white",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_dead",
    name = ccb.content.text("withered shrub"),
    description = ccb.content.text("A small shrub that has withered away."),
    symbol = "#",
    color = "brown",
    move_cost = 8,
    coverage = 40,
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "THIN_OBSTACLE", "PLACE_ITEM", "SHRUB", "SHORT" },
    looks_like = "t_shrub",
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_searth",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "stick", count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_cactus_cholla",
    name = ccb.content.text("buckhorn cholla"),
    description = ccb.content.text("A shrub-like cactus belonging to the 'Cylindropuntia' genus, commonly found throughout the deserts of North America.  If you look closely, you can see some unharvested cholla buds hiding behind clusters of stiff spines."),
    symbol = "#",
    color = "green",
    move_cost = 8,
    coverage = 40,
    looks_like = "f_mutcactus_test",
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "THIN_OBSTACLE", "PLACE_ITEM", "SHARP" },
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "spring" }, harvest = "cactus_harv" } },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_searth",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}
