local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_25mm_mag",
    looks_like = "stanag30",
    name = ccb.content.text("25mm 40-round magazine"),
    description = ccb.content.text("A 40-round magazine for use with 25mm firearms."),
    mass = "340 g",
    volume = "2 L",
    price = "700 USD",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_25mm = 40 } } },
    magazine = { ammunition = { "afs_25mm" }, reload_time = 60 },
}
