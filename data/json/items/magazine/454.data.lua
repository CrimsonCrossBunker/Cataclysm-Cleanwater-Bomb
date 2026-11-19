local ccb = require("ccb")

-- Values copied from .44 Speedloader.
ccb.content.define_item {
    id = "454_speedloader5",
    looks_like = "38_speedloader",
    name = ccb.content.text(".454 5-round speedloader"),
    description = ccb.content.text("This speedloader can hold 5 rounds of .454, .45 Colt or .410 bore and quickly reload a compatible revolver."),
    mass = "28 g",
    volume = "25 ml",
    price = "22 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["454"] = 5, ["45colt"] = 5, ["410shot"] = 5 },
        },
    },
    magazine = { ammunition = { "454", "45colt", "410shot" } },
}
