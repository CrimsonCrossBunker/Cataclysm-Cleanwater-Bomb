local ccb = require("ccb")

ccb.content.define_item {
    id = "3x35_150_mag",
    looks_like = "fnp90mag",
    name = ccb.content.text("3x35mm 150-round magazine"),
    description = ccb.content.text("A 150-round box magazine for use with 3x35mm flechette coilguns.  Marketed as GGS150."),
    mass = "360 g",
    volume = "630ml",
    price = "150 USD",
    materials = { "ceramic", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3x35"] = 150 } } },
    magazine = { ammunition = { "3x35" }, reload_time = 60 },
}

ccb.content.define_item {
    id = "3x35_75_mag",
    looks_like = "fnp90mag",
    name = ccb.content.text("3x35mm 75-round magazine"),
    description = ccb.content.text("A 75-round box magazine for use with 3x35mm flechette coilguns.  Marketed as GGS75."),
    mass = "240 g",
    volume = "315ml",
    price = "125 USD",
    materials = { "ceramic", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["3x35"] = 75 } } },
    magazine = { ammunition = { "3x35" }, reload_time = 50 },
}
