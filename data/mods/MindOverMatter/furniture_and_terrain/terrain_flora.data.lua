local ccb = require("ccb")

-- barren in winter
ccb.content.define_terrain {
    id = "t_tree_hawk_nest",
    name = ccb.content.text("oak tree"),
    description = ccb.content.text("A massive deciduous tree belonging to the 'Quercus' genus, commonly found throughout the New England region.  If you look closely, you can see some acorns the squirrels haven't gotten yet.  If you look near the top, you can see a gigantic birds nest.  There are large bones sticking out of the edges of the nest."),
    symbol = "7",
    color = { "green", "green", "brown_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT" },
    transforms_into = "t_tree_harvested",
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "oak_harv" } },
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
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}
