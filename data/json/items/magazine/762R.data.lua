local ccb = require("ccb")

-- Audited with ImageJ.
ccb.content.define_item {
    id = "762R_clip",
    looks_like = "stanag30",
    category = "ammo",
    name = ccb.content.text("7.62x54mmR 5-round clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load five 7.62x54mmR rounds into a compatible firearm."),
    mass = "9 g",
    volume = "3 ml",
    length = "74 mm",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["762R"] = 5 } } },
    magazine = { ammunition = { "762R" } },
}

-- Audited with ImageJ.
ccb.content.define_item {
    id = "pslmag5",
    looks_like = "stanag30",
    name = ccb.content.text("PSL 5-round magazine"),
    description = ccb.content.text("A compact 5-round magazine for 7.62x54R PSL designated marksman's rifle, made of stamped sheet metal.  Not compatible with a Dragunov despite similar appearances."),
    mass = "122 g",
    volume = "131 ml",
    length = "64 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762R"] = 5 } } },
    magazine = { ammunition = { "762R" } },
}

-- Audited with ImageJ.
ccb.content.define_item {
    id = "pslmag10",
    looks_like = "stanag30",
    name = ccb.content.text("PSL 10-round magazine"),
    description = ccb.content.text("A compact 10-round magazine for 7.62x54R PSL designated marksman's rifle, made of stamped sheet metal.  Not compatible with a Dragunov despite similar appearances."),
    mass = "204 g",
    volume = "218 ml",
    length = "107 mm",
    price = "30 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762R"] = 10 } } },
    magazine = { ammunition = { "762R" } },
}
