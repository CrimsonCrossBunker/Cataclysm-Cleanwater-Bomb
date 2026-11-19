local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "debug_itemgroup_test",
    name = ccb.content.text("debug_item_group_test"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}
