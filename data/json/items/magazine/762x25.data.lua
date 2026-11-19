local ccb = require("ccb")

-- Audited from schematics.
ccb.content.define_item {
    id = "tokarevmag",
    looks_like = "glock17_17",
    name = ccb.content.text("Tokarev 8-round magazine"),
    description = ccb.content.text("A standard 8-round magazine for the Tokarev handgun."),
    variant_kind = "gun",
    variants = {
        {
            id = "tokarevmag",
            name = ccb.content.text("TT-33 8-round magazine"),
            description = ccb.content.text("A standard 8-round magazine for the Tokarev TT-33."),
        },
    },
    mass = "56 g",
    volume = "55 ml",
    length = "106 mm",
    price = "13 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762x25"] = 8 } } },
    magazine = { ammunition = { "762x25" } },
}
