local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_tree_witchwood",
    name = ccb.content.text("witchwood tree"),
    looks_like = "t_tree_apple",
    description = ccb.content.text("The silvery bark and striking dark-blue leaves mark this as a witchwood tree.  It bears no fruit or nuts, but your fingers tingle slightly when you touch the bark."),
    symbol = "7",
    color = { "light_gray", "blue", "light_gray", "dark_gray" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    transforms_into = "t_tree_witchwood_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "harvest_witchwood" },
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_tree_witchwood_harvested",
    copy_from = "t_tree_witchwood",
    name = ccb.content.text("witchwood tree"),
    looks_like = "t_tree_apple_harvested",
    description = ccb.content.text("The silvery bark and striking dark-blue leaves mark this as a witchwood tree.  It bears no fruit or nuts, but your fingers tingle slightly when you touch the bark.  A large amount of the bark is missing, and taking any more will harm the tree."),
    symbol = "7",
    color = { "light_gray", "blue", "light_gray", "dark_gray" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_witchwood",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "harvest_witchwood" },
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
    },
}
