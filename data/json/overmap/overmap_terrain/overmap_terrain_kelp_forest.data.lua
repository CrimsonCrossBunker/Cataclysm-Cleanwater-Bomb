local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_kelp_forest",
    copy_from = "generic_ocean",
    name = ccb.content.text("kelp forest"),
    symbol = "~",
    color = "green",
    extend = { flags = { "REQUIRES_PREDECESSOR" } },
}

ccb.content.define_overmap_terrain {
    id = "kelp_forest_core",
    copy_from = "generic_kelp_forest",
}

ccb.content.define_overmap_terrain {
    id = "kelp_forest_end",
    copy_from = "generic_kelp_forest",
    delete = { flags = { "NO_ROTATE" } },
}
