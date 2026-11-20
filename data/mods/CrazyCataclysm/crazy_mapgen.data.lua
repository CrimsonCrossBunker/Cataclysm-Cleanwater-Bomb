local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_shia",
    layout = {
        monster_placements = { { id = "mon_shia", x = { 0, 23 }, y = { 0, 23 }, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_jackson",
    layout = {
        monster_placements = { { id = "mon_zombie_jackson", x = { 0, 23 }, y = { 0, 23 }, chance = 100 } },
    },
}

ccb.content.define_map_extra {
    id = "mx_shia",
    name = ccb.content.text("Shia LaBeouf"),
    description = ccb.content.text("Cannibal is nearby."),
    generator = { method = "update_mapgen", id = "mx_shia" },
    z_levels = { 0, 0 },
    symbol = "s",
    color = "red",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_jackson",
    name = ccb.content.text("Jackson"),
    description = ccb.content.text("It's close to midnight, and something evil's lurking in the dark."),
    generator = { method = "update_mapgen", id = "mx_jackson" },
    z_levels = { 0, 0 },
    symbol = "j",
    color = "red",
    visibility = "same_tile",
}

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "field",
    copy_from = "field",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "road",
    copy_from = "road",
    add_extras = { { extra = "mx_jackson", weight = 1 } },
}
