local ccb = require("ccb")

-- Values copied from .44 Speedloader.
ccb.content.define_item {
    id = "500_speedloader5",
    looks_like = "glock17_17",
    name = ccb.content.text(".500 5-round speedloader"),
    description = ccb.content.text("This speedloader can hold 5 rounds of .500 and quickly reload a compatible revolver."),
    mass = "28 g",
    volume = "25 ml",
    price = "25 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["500"] = 5 } } },
    magazine = { ammunition = { "500" } },
}
