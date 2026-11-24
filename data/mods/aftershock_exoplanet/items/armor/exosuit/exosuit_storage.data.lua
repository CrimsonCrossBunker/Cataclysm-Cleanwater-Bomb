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

ccb.content.define_item {
    id = "exo_large_holster",
    category = "exosuit",
    name = ccb.content.plural_text("quick draw holster (exosuit)", "quick draw holsters (exosuit)"),
    description = ccb.content.text("This module holds a single sidearm and will recharge an energy weapon.  Automatically opens when the exosuit's pilot reaches for it, just like in that one movie."),
    mass = "500 g",
    volume = "2500 ml",
    materials = { "plastic", "nylon" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = { "CANT_WEAR", "USE_UPS", "EXO_MEDIUM_GADGET" },
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "500 ml",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "45 cm",
            moves = 20,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 5,
                coverage = 0,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}

ccb.content.define_item {
    id = "exo_sheath",
    category = "exosuit",
    name = ccb.content.plural_text("blade sheath (exosuit)", "blade sheaths (exosuit)"),
    description = ccb.content.text("This module holds a single knife or small blade.  Automatically opens when the exosuit's pilot reaches for it."),
    mass = "500 g",
    volume = "2500 ml",
    materials = { "plastic", "nylon" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = { "CANT_WEAR", "EXO_MEDIUM_GADGET" },
    pockets = {
        {
            magazine_well = "350 ml",
            holster = true,
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "70 cm",
            moves = 10,
            allowed_flags = { "SHEATH_KNIFE" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 5,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}
