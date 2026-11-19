local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nether_stone",
    name = ccb.content.text("black stone"),
    description = ccb.content.text("A perfectly smooth patch of black stone, like carved and polished obsidian."),
    looks_like = "t_nether_glass_floor",
    symbol = " ",
    color = "black",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nether_water_sh",
    name = ccb.content.text("black water"),
    description = ccb.content.text("An expanse of some sort of black liquid.  The air nearby is chill, and its surface is perfectly smooth and undisturbed by ripples or wind.  You have no idea how deep it is."),
    symbol = "~",
    looks_like = "t_nether_glass_floor",
    color = "black",
    move_cost = 6,
    emissions = { "emit_cold_nether_water" },
    liquid_source = { item = "black_nether_water", minimum_temperature = 15 },
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE" },
    connect_groups = "WATER",
    connects_to = "WATER",
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_nether_water_dp",
    name = ccb.content.text("black water"),
    description = ccb.content.text("An expanse of some sort of black liquid.  The air nearby is chill, and its surface is perfectly smooth and undisturbed by ripples or wind.  You have no idea how deep it is."),
    symbol = "~",
    looks_like = "t_nether_glass_floor",
    color = "black",
    move_cost = 10,
    emissions = { "emit_cold_deep_nether_water" },
    liquid_source = { item = "black_nether_water", minimum_temperature = 15 },
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "DEEP_WATER" },
    connect_groups = "WATER",
    connects_to = "WATER",
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_grass_alien_2",
    name = ccb.content.text("alien grass"),
    description = ccb.content.text("An area of something that almost looks like grass.  The blades are rolled up into curls, similar to ferns, but they seem to all unroll at once and then roll up again in a steady pattern.  They're a color you can only describe as \"purplish-yellow\"."),
    symbol = ".",
    color = "magenta",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "ROUGH" },
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
    id = "t_grass_alien_3",
    name = ccb.content.text("alien grass"),
    description = ccb.content.text("An area of something that almost looks like grass.  The blades are less than an inch high and a blue so dark it's almost black.  When you look closer, many blades seemed to be fused together at the top, forming small clusters."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "ROUGH" },
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
    id = "t_grass_alien_4",
    name = ccb.content.text("alien grass"),
    looks_like = "t_grass_long",
    description = ccb.content.text("An area of something that almost looks like grass.  It's the familiar green of terrestrial grass, but each blade has a large pink bulb at the top that bobs and moves in the breeze."),
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE", "DIGGABLE", "FLAT", "PLOWABLE" },
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
    id = "t_vines_alien_1",
    name = ccb.content.text("alien vines"),
    description = ccb.content.text("An area of something that almost looks like vines, or perhaps tree roots.  A thick ropy cluster of white tendrils streaked with red, twining around each other and branching off in all directions before meeting up in new clusters.  Sometimes, one of the vines twitches."),
    symbol = ".",
    color = "white",
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE", "DIGGABLE", "FLAT", "PLOWABLE", "ROUGH" },
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
    id = "t_moss_alien_1",
    name = ccb.content.text("alien moss"),
    description = ccb.content.text("An area of something that almost looks like moss.  It's a pale bluish color and clumps of it seem to be very slowly moving across the ground."),
    symbol = ".",
    color = "light_cyan",
    move_cost = 1,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
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
    id = "t_moss_alien_2",
    name = ccb.content.text("alien moss"),
    description = ccb.content.text("An area of something that almost looks like moss.  It's close to an inch thick, a dark yellowish-red, and glistens wetly."),
    symbol = ".",
    color = "red",
    move_cost = 1,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAMMABLE", "FLAT", "PLOWABLE", "PAINFUL" },
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
    id = "t_tree_small_alien_1",
    name = ccb.content.text("alien tree"),
    looks_like = "t_tree_dead",
    description = ccb.content.text("A short tree, or something that's vaguely shaped like one.  It has long, needle-like leaves that twitch rhythmically and its dark reddish-purple bark(?) has a scale-like pattern, with glowing nodules irregularly spaced along its trunk.  Bluish-green globules hang from the end of some of the branches."),
    symbol = "7",
    color = "magenta",
    light_emitted = 10,
    transforms_into = "t_tree_small_alien_1_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "alien_tree_harv" },
    },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_grass_alien_2",
    },
}

ccb.content.define_terrain {
    id = "t_tree_small_alien_1_harvested",
    name = ccb.content.text("alien tree"),
    looks_like = "t_tree_dead",
    description = ccb.content.text("A tall alien plant.  It has long, needle-like leaves that twitch rhythmically and its dark reddish-purple bark(?) has a scale-like pattern, with glowing nodules irregularly spaced along its trunk."),
    symbol = "7",
    color = "light_gray",
    light_emitted = 10,
    builtin_examine = "harvested_plant",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "HARVESTED" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_grass_alien_2",
    },
}

ccb.content.define_terrain {
    id = "t_tree_small_alien_2",
    name = ccb.content.text("alien tree"),
    looks_like = "t_bamboo_tall",
    description = ccb.content.text("A tall, thin alien plant.  From a distance it seems more like a column than a tree, but when you get closer you can see that it's made up of a series of broad, serrated leaves all folded so closely together that they form a single stalk."),
    symbol = "7",
    color = "dark_gray",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_moss_alien_2",
    },
}

ccb.content.define_terrain {
    id = "t_tree_small_alien_3",
    name = ccb.content.text("alien tree"),
    looks_like = "t_tree_fungal_young",
    description = ccb.content.text("A large alien plant.  It looks like a series of bulbous mushrooms that have all grown together at the base, rising into a flaring series of branches that curve up before hanging down and ending in reddish-brown spheres."),
    symbol = "7",
    color = "light_red",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("poof!"),
        terrain = "t_grass_alien",
    },
}
