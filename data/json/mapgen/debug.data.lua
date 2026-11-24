local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "debug_itemgroup_test",
    tiles = { { point = { 0, 0, 0 }, terrain = "debug_itemgroup_test", locations = { "land" } } },
    occurrences = { 0, 0 },
    flags = { "SHOULD_NOT_SPAWN" },
}

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
