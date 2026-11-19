local ccb = require("ccb")

-- Audited with dimensions/weight from vendor.
ccb.content.define_item {
    id = "ai_338mag",
    looks_like = "stanag30",
    name = ccb.content.text("AI .338 Lapua 5-round magazine"),
    description = ccb.content.text("A single-stack, 5-round steel box magazine, produced by the British precision rifle company, Accuracy International.  Magazines such as this one have been regarded as the gold standard for marksman rifle magazines, with this particular one being compatible with both the .338 Lapua and .300 Winchester Magnum cartridges."),
    mass = "215 g",
    volume = "164 ml",
    length = "94 mm",
    price = "106 USD 14 cent",
    survival_price = "1 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["338lapua"] = 5, ["300"] = 5 } } },
    magazine = { ammunition = { "338lapua", "300" } },
}

-- Audited with ImageJ.  Weight from ratio method.
ccb.content.define_item {
    id = "ai_338mag_10",
    looks_like = "stanag30",
    name = ccb.content.text("AI .338 Lapua 10-round magazine"),
    description = ccb.content.text("A double-stack, 10-round steel box magazine, produced by the British precision rifle company, Accuracy International.  Magazines such as this one have been regarded as the gold standard for marksman rifle magazines, with this particular one being compatible with both the .338 Lapua and .300 Winchester Magnum cartridges."),
    mass = "298 g",
    volume = "233 ml",
    length = "95 mm",
    price = "168 USD 56 cent",
    survival_price = "1 USD 50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["338lapua"] = 10, ["300"] = 10 } } },
    magazine = { ammunition = { "338lapua", "300" } },
}

-- Audited with ImageJ.  Weight from vendor.
ccb.content.define_item {
    id = "mrad_338lapua_mag",
    looks_like = "stanag30",
    name = ccb.content.text("Barrett .338 Lapua 10-round magazine"),
    description = ccb.content.text("A standard 10-round box magazine which can hold up to 10 .338 Lapua rounds, and is compatible with appropriately chambered Barrett rifles."),
    mass = "195 g",
    volume = "245 ml",
    length = "10 cm",
    price = "80 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["338lapua"] = 10 } } },
    magazine = { ammunition = { "338lapua" } },
}
