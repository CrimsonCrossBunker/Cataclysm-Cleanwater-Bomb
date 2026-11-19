local ccb = require("ccb")

ccb.content.define_item {
    id = "pellet_airgun",
    copy_from = "varmint_airgun",
    name = ccb.content.text("varmint air rifle"),
    description = ccb.content.text("A cheap varmint air rifle chambered in .177, suitable for hunting small game."),
    pockets = { { kind = "MAGAZINE", ammunition = { airgun_pellet = 1 } } },
    gun = {
        ammunition = { "airgun_pellet" },
        reload_time = 300,
        mod_locations = {
            { id = "accessories", count = 4 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "grip mount", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
