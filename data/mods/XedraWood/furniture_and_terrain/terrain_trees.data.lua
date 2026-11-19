local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_highland_holy_tree_no_sword",
    copy_from = "t_tree_dead",
    symbol = "G",
    name = ccb.content.text("dead holy tree"),
    description = ccb.content.text("Censers and candlelamps hang from the twisted branches of this tree, which seems to have been revered in the past."),
    bash = {
        minimum_strength = 70,
        maximum_strength = 140,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 2, 6 } },
            { item = "splinter", count = { 10, 20 } },
            { item = "highland_censer", count = { 6, 12 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_amphora_plum",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("amphora plum tree"),
    description = ccb.content.text("A small tree with a height between 10 and 20 feet.  Called Amphora Plums because the fruits ferment while still on the branch.  If you look closely, you can see some unharvested plums."),
    extend = { flags = { "BROWSABLE" } },
    color = { "green", "green", "yellow_yellow", "brown" },
    transforms_into = "t_tree_amphora_plum_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "amphora_plum_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_amphora_plum_harvested",
    copy_from = "t_tree_amphora_plum",
    description = ccb.content.text("A small Amphora plum tree with a height between 10 and 20 feet."),
    transforms_into = "t_tree_amphora_plum",
    delete = { flags = { "BROWSABLE" } },
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_oxblood",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("oxblood apple tree"),
    description = ccb.content.text("A large tree in the apple family standing roughly 30 feet tall.  It produces a bruised looking blue apple like fruit, with an incredibly bitter red meat.  If you look closely, you can see some unharvested oxblood apples."),
    color = { "green", "green", "yellow_yellow", "brown" },
    extend = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_butternut_harvested",
    looks_like = "t_tree_blackjack",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "butternut_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_oxblood_harvested",
    copy_from = "t_tree_oxblood",
    description = ccb.content.text("A large tree in the apple family standing roughly 30 feet tall."),
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_oxblood",
    looks_like = "t_tree_blackjack_harvested",
}
