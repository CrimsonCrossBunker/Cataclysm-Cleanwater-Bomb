local ccb = require("ccb")

ccb.content.define_item {
    id = "nailmag",
    looks_like = "stanag30",
    name = ccb.content.text("coilgun 50-round makeshift magazine"),
    description = ccb.content.text("An improvised magazine for use with a coilgun.  Little more than a metal box, a spring, and some duct tape, it is awkward to reload."),
    mass = "60 g",
    volume = "250 ml",
    price = "19 USD 20 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { nail = 50 } } },
    magazine = { ammunition = { "nail" }, reload_time = 300 },
}
