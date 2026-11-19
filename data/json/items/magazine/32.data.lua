local ccb = require("ccb")

-- Audited with ImageJ.  Used the weight of a .32 Beretta M1935 magazine.
ccb.content.define_item {
    id = "ppkmag",
    looks_like = "glock17_17",
    name = ccb.content.text("PPK 8-round magazine"),
    description = ccb.content.text("A standard 8-round steel box magazine for the Walther PPK."),
    mass = "43 g",
    volume = "22 ml",
    length = "88 mm",
    price = "26 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["32"] = 8 } } },
    magazine = { ammunition = { "32" } },
}

ccb.content.define_item {
    id = "lws32mag",
    looks_like = "glock17_17",
    name = ccb.content.text("micro conceal carry magazine"),
    description = ccb.content.text("A 6 round magazine for the micro conceal carry pistol."),
    variant_kind = "gun",
    variants = {
        {
            id = "lws32mag",
            name = ccb.content.text("Seecamp LWS 32 magazine"),
            description = ccb.content.text("A 6 round magazine for the LWS 32."),
        },
    },
    mass = "30 g",
    volume = "20 ml",
    length = "81 mm",
    price = "26 USD",
    survival_price = "5 cent",
    materials = { "steel", "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["32"] = 6 } } },
    magazine = { ammunition = { "32" } },
}
