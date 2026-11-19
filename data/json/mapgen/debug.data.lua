local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "debug_itemgroup_test",
    layout = {
        item_groups = { [" "] = { { group = "ammo_common_boxed", chance = 100 } } },
        fill_terrain = "t_pavement",
    },
}

ccb.content.define_overmap_terrain {
    id = "debug_itemgroup_test",
    name = ccb.content.text("debug_item_group_test"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}
