local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_catoblepas_lair",
    name = ccb.content.text("Catoblepas Lair"),
    description = ccb.content.text("There are catoblepases lairing here."),
    generator = { method = "update_mapgen", id = "mx_catoblepas_lair" },
    z_levels = { 0, 0 },
    symbol = "C",
    color = "brown",
    visibility = "none",
}
