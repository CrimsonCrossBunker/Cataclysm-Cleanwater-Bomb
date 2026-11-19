local ccb = require("ccb")

-- barren in winter
ccb.content.define_terrain {
    id = "t_tree_young",
    name = ccb.content.text("young tree"),
    looks_like = "t_tree",
    description = ccb.content.text("A relatively young sapling of an indeterminate species.  It could take decades before reaching maturity, so there's no use waiting around."),
    symbol = "1",
    color = { "green", "green", "green", "brown" },
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "YOUNG", "REDUCE_SCENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 1, 5 } }, { item = "withered", count = { 2, 6 } } },
    },
}
