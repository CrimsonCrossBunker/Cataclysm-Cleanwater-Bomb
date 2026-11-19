local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_cartridge",
    looks_like = "light_battery_cell",
    name = ccb.content.text("power cartridge"),
    description = ccb.content.text("A standard-design power cell compatible with most common energy weapons.  Can be recharged by connecting to a power source."),
    mass = "50 g",
    volume = "250 ml",
    price = "500 USD",
    survival_price = "500 USD",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "NO_UNLOAD", "RECHARGE", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    magazine = { ammunition = { "battery" }, capacity = 1500, reload_time = 3 },
}

ccb.content.define_item {
    id = "afs_compact_cartridge",
    copy_from = "afs_cartridge",
    name = ccb.content.text("compact power cartridge"),
    description = ccb.content.text("A compact power cell compatible with most common energy weapons.  Can be recharged by connecting to a power source."),
    mass = "20 g",
    volume = "75 ml",
    price = "250 USD",
    survival_price = "250 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 500 } } },
    magazine = { capacity = 500 },
}

ccb.content.define_item {
    id = "afs_bootleg_cartridge",
    copy_from = "afs_cartridge",
    name = ccb.content.text("bootleg power cartridge"),
    description = ccb.content.text("A functional but poorly-built power cell compatible with most common energy weapons.  It cannot be recharged."),
    mass = "75 g",
    price = "50 USD",
    survival_price = "50 USD",
    flags = { "NO_UNLOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 600 } } },
    magazine = { capacity = 600, reload_time = 5 },
}

ccb.content.define_item {
    id = "afs_archeotech_cartridge",
    copy_from = "afs_cartridge",
    name = ccb.content.text("chromoelectric cartridge"),
    description = ccb.content.text("A thin strip of transuranic metal, glowing a somber blue from within its shielded glass prison.  A rare and sought-after relic, it could be used to momentarily power all sorts of technology from the late Hyperspace Era."),
    mass = "100 g",
    price = "100 kUSD",
    survival_price = "100 kUSD",
    flags = { "NO_UNLOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 15000 } } },
    magazine = { capacity = 15000, count = 15000, reload_time = 5, default_ammo = "afs_battery_plus" },
}
