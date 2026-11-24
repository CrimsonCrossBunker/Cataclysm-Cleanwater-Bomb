local ccb = require("ccb")

-- Obsoleted during 0.H, if I am still obsolete at the time of 0.I stable please migrate me.
ccb.content.define_furniture {
    id = "f_mutant_tree_adult",
    name = ccb.content.text("mutant tree"),
    description = ccb.content.text("This bizarre tree spreads its twisted branches at odd angles toward the sky.  If you squint, it almost looks like a human figure with its arms raised to catch the sun."),
    symbol = "7",
    color = "light_green",
    required_strength = -1,
    move_cost_mod = 0,
    flags = {
        "PLANT",
        "SEALED",
        "TRANSPARENT",
        "CONTAINER",
        "NOITEM",
        "TINY",
        "DONT_REMOVE_ROTTEN",
        "GROWTH_HARVEST",
        "MUTANT_TREE",
        "TREE",
        "OBSTACLE",
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 50,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "stick_long", count = { 1, 2 } },
            { item = "bone", count = { 1, 2 } },
            { item = "splinter", count = { 1, 5 } },
            { item = "twig", count = { 2, 5 } },
            { item = "leaves", count = { 5, 25 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    plant = { transform = "f_null", base = "f_null" },
}

-- Obsoleted during 0.H, if I am still obsolete at the time of 0.I stable please migrate me.
ccb.content.define_furniture {
    id = "f_mutant_tree_sapling",
    name = ccb.content.text("mutant sapling"),
    description = ccb.content.text("A twisted and gnarled little tree.  Its shape is at once alien and familiar."),
    symbol = "1",
    color = "green",
    move_cost_mod = 1,
    required_strength = -1,
    flags = {
        "PLANT",
        "SEALED",
        "TRANSPARENT",
        "CONTAINER",
        "NOITEM",
        "TINY",
        "DONT_REMOVE_ROTTEN",
        "GROWTH_MATURE",
        "SMALL_HIDE",
        "YOUNG",
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 50,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "stick_long", count = { 0, 2 } },
            { item = "bone", count = { 1, 2 } },
            { item = "splinter", count = { 0, 2 } },
            { item = "twig", count = { 1, 3 } },
            { item = "leaves", count = { 5, 20 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    plant = { transform = "f_mutant_tree_adult", base = "f_null" },
}

-- Obsoleted during 0.H, if I am still obsolete at the time of 0.I stable please migrate me.
ccb.content.define_furniture {
    id = "f_mutant_tree_sprout",
    name = ccb.content.text("sprout"),
    description = ccb.content.text("A tiny little sprout that has just begun to grow."),
    symbol = "^",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = {
        "PLANT",
        "SEALED",
        "TRANSPARENT",
        "CONTAINER",
        "NOITEM",
        "TINY",
        "DONT_REMOVE_ROTTEN",
        "GROWTH_SEEDLING",
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 10,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
    plant = { transform = "f_mutant_tree_sapling", base = "f_null" },
}
