local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_84k_20mag",
    looks_like = "glock17_17",
    name = ccb.content.text("84k 10mm 20-round magazine"),
    description = ccb.content.text("A 20-round magazine for use with the Seyfert 84k."),
    mass = "70 g",
    volume = "103 ml",
    length = "114 mm",
    price = "24 USD",
    materials = { "plastic", "superalloy" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_10mm = 20 } } },
    magazine = { ammunition = { "afs_10mm" } },
}

ccb.content.define_item {
    id = "afs_marsec_14mag",
    looks_like = "glock17_17",
    name = ccb.content.text("MarSec 14-round magazine"),
    description = ccb.content.text("A magazine for the MarSec handguns.  It holds 14 rounds."),
    mass = "70 g",
    volume = "103 ml",
    length = "114 mm",
    price = "32 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_10mm = 14 } } },
    magazine = { ammunition = { "afs_10mm" }, reload_time = 140 },
}

ccb.content.define_item {
    id = "afs_silvergram_22mag",
    looks_like = "glock17_17",
    name = ccb.content.text("Silvergram 22-round magazine"),
    description = ccb.content.text("A transparent polymer 22-round magazine for Silvergram pattern smart pistols."),
    mass = "70 g",
    volume = "103 ml",
    length = "114 mm",
    price = "24 USD",
    materials = { "plastic", "superalloy" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { afs_10mm_smart = 22 } } },
    magazine = { ammunition = { "afs_10mm_smart" } },
}
