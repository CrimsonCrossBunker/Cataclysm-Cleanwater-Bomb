local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_5x50_100_mag",
    looks_like = "mp5mag",
    name = ccb.content.text("5x50mm 100-round magazine"),
    description = ccb.content.text("A 100-round box magazine for use with 5x50mm flechette firearms.  Designated as RMFB100."),
    mass = "360 g",
    volume = "630ml",
    price = "150 USD",
    survival_price = "7 USD 50 cent",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_5x50 = 100 } } },
    magazine = { ammunition = { "afs_5x50" }, reload_time = 60 },
}

ccb.content.define_item {
    id = "afs_5x50_50_mag",
    looks_like = "mp5mag",
    name = ccb.content.text("5x50mm 50-round magazine"),
    description = ccb.content.text("A 50-round box magazine for use with 5x50mm flechette firearms.  Designated as RMFB50."),
    mass = "240 g",
    volume = "315ml",
    price = "125 USD",
    survival_price = "5 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_5x50 = 50 } } },
    magazine = { ammunition = { "afs_5x50" }, reload_time = 50 },
}
