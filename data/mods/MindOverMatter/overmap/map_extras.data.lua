local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_alien_grass",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grass" },
    symbol = "A",
    color = "red",
    visibility = "details",
}

ccb.content.define_map_extra {
    id = "mx_alien_grass_2",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grass_2" },
    symbol = "A",
    color = "magenta",
    visibility = "outlines",
}

ccb.content.define_map_extra {
    id = "mx_alien_grass_3",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grass_3" },
    symbol = "A",
    color = "cyan",
    visibility = "details",
}

ccb.content.define_map_extra {
    id = "mx_alien_grass_4",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grass_4" },
    symbol = "A",
    color = "yellow",
    visibility = "outlines",
}

ccb.content.define_map_extra {
    id = "mx_alien_grass_5",
    name = ccb.content.text("alien flora"),
    description = ccb.content.text("A cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grass_5" },
    symbol = "A",
    color = "light_red",
    visibility = "outlines",
}

ccb.content.define_map_extra {
    id = "mx_alien_grove",
    name = ccb.content.text("alien grove"),
    description = ccb.content.text("A large cluster of alien flora."),
    generator = { method = "update_mapgen", id = "mx_alien_grove" },
    symbol = "F",
    color = "magenta",
    visibility = "vague",
}

ccb.content.define_map_extra {
    id = "mx_nether_pond",
    name = ccb.content.text("pool of dark water"),
    description = ccb.content.text("A pool of some unearthly liquid."),
    generator = { method = "update_mapgen", id = "mx_nether_pond" },
    symbol = "O",
    color = "dark_gray",
    visibility = "vague",
}

ccb.content.define_map_extra {
    id = "mx_fear_hawk_copse",
    name = ccb.content.text("Suspicious stand of trees"),
    description = ccb.content.text("A suspicious copse of trees."),
    generator = { method = "update_mapgen", id = "mx_fear_hawk_copse" },
    z_levels = { 0, 0 },
    visibility = "outlines",
}

ccb.content.define_map_extra {
    id = "mx_glass_and_crystal",
    name = ccb.content.text("crystal cluster"),
    description = ccb.content.text("A patch of crystals and black stone."),
    generator = { method = "update_mapgen", id = "mx_glass_and_crystal" },
    symbol = "C",
    color = "dark_gray",
    visibility = "vague",
}

ccb.content.define_map_extra {
    id = "mx_phavian_science",
    name = ccb.content.text("Scientists"),
    description = ccb.content.text("Several corpses of scientists are here."),
    generator = { method = "update_mapgen", id = "mx_phavian_science" },
    z_levels = { -5, 0 },
    symbol = "s",
    color = "light_blue",
    visibility = "same_tile",
    flags = { "MAN_MADE" },
}
