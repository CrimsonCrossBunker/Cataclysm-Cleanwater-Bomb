local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_rifle_storage",
    copy_from = "back_holster",
    looks_like = "slingpack",
    color = "light_gray",
    symbol = "[",
    name = ccb.content.plural_text("large storage pouch (exosuit)", "large storage pouches (exosuit)"),
    description = ccb.content.text("A hardpoint for storing a rifle.  Activate to holster/draw a gun."),
    mass = "500 g",
    volume = "2 L",
    materials = { "qt_steel" },
    flags = { "WATER_FRIENDLY", "BELTED", "EXO_LARGE_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_melee_storage",
    copy_from = "bscabbard",
    looks_like = "bscabbard",
    color = "light_gray",
    symbol = "[",
    name = ccb.content.plural_text("scabbard (exosuit)", "scabbard (exosuit)"),
    description = ccb.content.text("A metallic scabbard mountable on an exosuit hardpoint.  Can be activated to sheath or draw a sword."),
    mass = "500 g",
    volume = "2 L",
    materials = { "qt_steel" },
    flags = { "WATER_FRIENDLY", "BELTED", "EXO_MEDIUM_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_large_storage",
    copy_from = "backpack_tactical_large",
    looks_like = "backpack",
    color = "light_gray",
    symbol = "[",
    name = ccb.content.plural_text("large storage pack (exosuit)", "large storage packs (exosuit)"),
    description = ccb.content.text("A large storage pack, mountable on a hardpoint."),
    mass = "2250 g",
    volume = "15 L",
    materials = { "kevlar", "plastic" },
    flags = { "WATER_FRIENDLY", "BELTED", "EXO_LARGE_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_medium_storage",
    copy_from = "fanny",
    looks_like = "holster",
    color = "green",
    symbol = "[",
    name = ccb.content.plural_text("medium pouch (exosuit)", "medium pouches (exosuit)"),
    description = ccb.content.text("A medium storage pouch, mountable on a hardpoint."),
    mass = "275 g",
    volume = "2500 ml",
    materials = { "nylon", "plastic" },
    flags = { "WATER_FRIENDLY", "BELTED", "EXO_MEDIUM_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_small_storage",
    copy_from = "leather_pouch",
    looks_like = "holster",
    symbol = "[",
    color = "green",
    name = ccb.content.plural_text("small pouch (exosuit)", "small pouches (exosuit)"),
    description = ccb.content.text("A small storage pouch, mountable on a hardpoint."),
    mass = "125 g",
    volume = "1050 ml",
    materials = { "nylon", "plastic" },
    flags = { "WATER_FRIENDLY", "BELTED", "EXO_SMALL_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_large_ammo_pouch",
    copy_from = "tacvest",
    looks_like = "tacvest",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("large ammo pouches (exosuit)", "large ammo pouches (exosuit)"),
    description = ccb.content.text("A set of pouches that attach to a hardpoint."),
    mass = "1750 g",
    volume = "1050 ml",
    materials = { "nylon" },
    flags = { "WATER_FRIENDLY", "EXO_MEDIUM_GADGET" },
    armor = {},
}

ccb.content.define_item {
    id = "exo_small_ammo_pouch",
    copy_from = "legrig",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("small ammo pouches (exosuit)", "small ammo pouches (exosuit)"),
    description = ccb.content.text("A set of pouches that attach to a hardpoint."),
    flags = { "WATER_FRIENDLY", "EXO_SMALL_GADGET" },
    armor = {},
}
