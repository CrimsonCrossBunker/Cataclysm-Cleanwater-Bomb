local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_8x40_speedloader5",
    looks_like = "38_speedloader",
    name = ccb.content.text("RMGS5 8x40mm speedloader"),
    description = ccb.content.text("This speedloader, made by Rivtech for use with the RM99 revolver, can hold 5 rounds of 8x40mm caseless rounds and quickly reload a compatible revolver."),
    mass = "92 g",
    volume = "250 ml",
    price = "80 USD",
    survival_price = "2 USD 50 cent",
    materials = { "superalloy", "plastic" },
    symbol = "#",
    color = "dark_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["8x40mm"] = 5 } } },
    magazine = { ammunition = { "8x40mm" }, capacity = 5 },
}
