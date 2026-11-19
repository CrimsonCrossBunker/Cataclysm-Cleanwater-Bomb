local ccb = require("ccb")

ccb.content.define_item {
    id = "hk_g80mag",
    looks_like = "stanag30",
    name = ccb.content.text("H&K G80 20-round magazine"),
    description = ccb.content.text("A magazine for the H&K G80 railgun which can hold up to 20 ferromagnetic projectiles."),
    mass = "168 g",
    volume = "250 ml",
    price = "80 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["12mm"] = 20 } } },
    magazine = { ammunition = { "12mm" } },
}
