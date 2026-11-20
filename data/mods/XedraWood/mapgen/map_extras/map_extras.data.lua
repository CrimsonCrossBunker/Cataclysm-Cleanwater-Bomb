local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_witchwood_grove",
    name = ccb.content.text("witchwood grove"),
    description = ccb.content.text("A grove of witchwood trees."),
    generator = { method = "update_mapgen", id = "mx_witchwood_grove" },
    symbol = "F",
    color = "cyan",
    visibility = "details",
}

ccb.content.define_map_extra {
    id = "mx_warped_tree_grove",
    name = ccb.content.text("dead grove"),
    description = ccb.content.text("A grove of strange trees, all dead."),
    generator = { method = "update_mapgen", id = "mx_warped_tree_grove" },
    z_levels = { 0, 0 },
    symbol = "T",
    color = "light_gray",
    visibility = "details",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_campfire_remnants",
    name = ccb.content.text("campfire remains"),
    description = ccb.content.text("The remnants of a campfire, long gone to ash."),
    generator = { method = "update_mapgen", id = "mx_campfire_remnants" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "light_gray",
    visibility = "details",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_nest_claw_hunter",
    name = ccb.content.text("claw hunter nest"),
    description = ccb.content.text("A nest of claw hunters.  Watch out."),
    generator = { method = "update_mapgen", id = "mx_nest_claw_hunter" },
    symbol = "D",
    color = "yellow",
    visibility = "details",
}

ccb.content.define_map_extra {
    id = "mx_nest_claw_runner",
    name = ccb.content.text("claw runner nest"),
    description = ccb.content.text("A claw runner nest."),
    generator = { method = "update_mapgen", id = "mx_nest_claw_runner" },
    symbol = "D",
    color = "yellow",
    visibility = "details",
}

ccb.content.define_map_extra {
    id = "mx_tanglevine_patch",
    name = ccb.content.text("Tanglevines"),
    description = ccb.content.text("A patch of tanglevines is growing here."),
    generator = { method = "update_mapgen", id = "mx_tanglevine_patch" },
    z_levels = { -2, 0 },
    symbol = "t",
    color = "green",
    visibility = "none",
    flags = { "WILDERNESS" },
}

ccb.content.define_map_extra {
    id = "mx_giant_snake_nest",
    name = ccb.content.text("Giant snakes"),
    description = ccb.content.text("This is the lair of a giant serpent."),
    generator = { method = "update_mapgen", id = "mx_giant_snake_nest" },
    z_levels = { 0, 0 },
    symbol = "s",
    color = "green",
    visibility = "details",
    flags = { "WILDERNESS" },
}
