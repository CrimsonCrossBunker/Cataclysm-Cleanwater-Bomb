local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_raketa30mag",
    looks_like = "shotbelt_20",
    name = ccb.content.text("Raketa 30-round shotgun magazine"),
    description = ccb.content.text("A removable 30-round horizontal magazine, for use with the Raketa shotgun."),
    variant_kind = "gun",
    mass = "460 g",
    volume = "1 L",
    materials = { "plastic" },
    symbol = "=",
    color = "dark_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 30 } } },
    magazine = { ammunition = { "shot" }, reload_time = 180 },
}

ccb.content.define_item {
    id = "afs_shot_speedloader8",
    looks_like = "38_speedloader",
    name = ccb.content.text("Drotik speedloader"),
    description = ccb.content.text("This speedloader holds up to eight 12ga shotgun shells, intended for use with the Drotik."),
    mass = "150 g",
    volume = "350 ml",
    materials = { "superalloy", "plastic" },
    symbol = "o",
    color = "dark_gray",
    flags = { "SPEEDLOADER" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { shot = 8 } } },
    magazine = { ammunition = { "shot" }, capacity = 8 },
}
