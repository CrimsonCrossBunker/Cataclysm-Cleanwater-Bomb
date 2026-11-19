local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_5x50_100_mag",
    copy_from = "stanag30",
    looks_like = "mp5mag",
    name = ccb.content.text("5x50mm 100-round magazine"),
    description = ccb.content.text("A 100-round box magazine for use with 5x50mm flechette firearms.  Designated as RMFB100."),
    mass = "360 g",
    volume = "630 ml",
    price = "150 USD",
    survival_price = "7 USD 50 cent",
    materials = { "superalloy", "plastic" },
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { fcl_5x50 = 100 } } },
    magazine = { ammunition = { "fcl_5x50" }, reload_time = 60 },
}

ccb.content.define_item {
    id = "fcl_5x50_50_mag",
    copy_from = "fcl_5x50_100_mag",
    name = ccb.content.text("5x50mm 50-round magazine"),
    description = ccb.content.text("A 50-round box magazine for use with 5x50mm flechette firearms.  Designated as RMFB50."),
    mass = "240 g",
    volume = "315 ml",
    price = "125 USD",
    survival_price = "5 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { fcl_5x50 = 50 } } },
    magazine = { reload_time = 50 },
}
