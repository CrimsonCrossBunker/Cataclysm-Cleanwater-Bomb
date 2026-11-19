local ccb = require("ccb")

-- Copied from Beretta 12rd .40S&W magazine.
ccb.content.define_item {
    id = "p226mag_12rd_357sig",
    looks_like = "glock17_17",
    name = ccb.content.text("P226 .357 SIG 12-round magazine"),
    description = ccb.content.text("A 12-round double stack box magazine for a SIG P226 chambered for .357 SIG rounds."),
    mass = "95 g",
    volume = "77 ml",
    length = "12 cm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357sig"] = 12 } } },
    magazine = { ammunition = { "357sig" } },
}

-- Copied from Beretta 12rd .40S&W magazine.
ccb.content.define_item {
    id = "p320mag_13rd_357sig",
    looks_like = "glock17_17",
    name = ccb.content.text("P320 .357 SIG 13-round magazine"),
    description = ccb.content.text("A 13-round double stack box magazine for the SIG Sauer P320."),
    mass = "95 g",
    volume = "77 ml",
    length = "12 cm",
    price = "29 USD",
    survival_price = "1 USD",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["357sig"] = 13 } } },
    magazine = { ammunition = { "357sig" }, reload_time = 140 },
}
