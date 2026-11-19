local ccb = require("ccb")

-- Audited with ImageJ used on schematics.
ccb.content.define_item {
    id = "makarovmag",
    looks_like = "glock17_17",
    name = ccb.content.text("Makarov 8-round magazine"),
    description = ccb.content.text("A standard 8-round magazine for the Makarov pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "makarovmag",
            name = ccb.content.text("PM 8-round magazine"),
            description = ccb.content.text("A standard 8-round magazine for the Makarov pistol."),
        },
    },
    mass = "32 g",
    volume = "34 ml",
    length = "10 cm",
    price = "23 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["9x18"] = 8 } } },
    magazine = { ammunition = { "9x18" } },
}
