local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_portal_cracked_mirror",
    name = ccb.content.text("Cracked Mirror"),
    description = ccb.content.text("Nether creatures have found there way in here."),
    generator = { method = "update_mapgen", id = "mx_portal_ingress" },
    z_levels = { 0, 0 },
    symbol = "u",
    color = "dark_gray",
    visibility = "none",
    flags = { "PORTAL_STORM_DUNGEON" },
}

ccb.content.define_map_extra {
    id = "mx_portal_ingress",
    name = ccb.content.text("Ingress"),
    description = ccb.content.text("Nether creatures have found there way in here."),
    generator = { method = "update_mapgen", id = "mx_portal_ingress" },
    z_levels = { 0, 0 },
    symbol = "o",
    color = "red",
    visibility = "none",
    flags = { "PORTAL_STORM_DUNGEON" },
}

ccb.content.define_map_extra {
    id = "mx_portal_distortion_item",
    name = ccb.content.text("Distortion"),
    description = ccb.content.text("A strange item is here."),
    generator = { method = "update_mapgen", id = "mx_portal_distortion_item" },
    z_levels = { 0, 0 },
    symbol = "i",
    color = "blue",
    visibility = "none",
    flags = { "PORTAL_STORM_DUNGEON" },
}
