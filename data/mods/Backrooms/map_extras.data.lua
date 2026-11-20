local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_teleporter_node",
    name = ccb.content.text("Red room"),
    description = ccb.content.text("There's a red room here."),
    generator = { method = "update_mapgen", id = "mx_teleporter_node" },
    symbol = "X",
    color = "red",
    visibility = "same_tile",
    flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_autodoc_room",
    name = ccb.content.text("Autodoc room"),
    description = ccb.content.text("There's an autodoc here."),
    generator = { method = "update_mapgen", id = "mx_autodoc_room" },
    symbol = "A",
    color = "pink",
    visibility = "same_tile",
    flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_casings",
    copy_from = "mx_casings",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_corpses",
    copy_from = "mx_corpses",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_collegekids",
    copy_from = "mx_collegekids",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_spider",
    copy_from = "mx_spider",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_nest_wasp_backrooms",
    name = ccb.content.text("Wasp Nest"),
    description = ccb.content.text("A wasp nest."),
    generator = { method = "update_mapgen", id = "mx_nest_wasp_backrooms" },
    z_levels = { -3, 3 },
    symbol = "W",
    color = "yellow",
    visibility = "same_tile",
    flags = { "WASP", "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_nest_dermatik_backrooms",
    name = ccb.content.text("Dermatik Nest"),
    description = ccb.content.text("A dermatik nest."),
    generator = { method = "update_mapgen", id = "mx_nest_dermatik_backrooms" },
    z_levels = { -3, 3 },
    symbol = "D",
    color = "brown",
    visibility = "same_tile",
    flags = { "WASP", "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_science",
    copy_from = "mx_science",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_crater",
    copy_from = "mx_crater",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_house_wasp",
    copy_from = "mx_house_wasp",
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_pond",
    copy_from = "mx_pond",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_military",
    copy_from = "mx_military",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_drugdeal",
    copy_from = "mx_drugdeal",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_supplydrop",
    copy_from = "mx_supplydrop",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_portal",
    copy_from = "mx_portal",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_portal_in",
    copy_from = "mx_portal_in",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_jabberwock",
    copy_from = "mx_jabberwock",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}

ccb.content.define_map_extra {
    id = "mx_helicopter",
    copy_from = "mx_helicopter",
    z_levels = { -3, 3 },
    add_flags = { "BACKROOMS" },
}
