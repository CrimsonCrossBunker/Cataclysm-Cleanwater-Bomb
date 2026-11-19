local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_aux_power",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit auxiliary battery", "exosuit auxiliary batteries"),
    description = ccb.content.text("This is a rechargeable auxiliary power unit that attaches to an exosuit hardpoint."),
    mass = "5 kg",
    volume = "2500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = {
        "FRAGILE", "CANT_WEAR", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "WATERPROOF", "IS_UPS", "USE_UPS",
        "EXO_MEDIUM_GADGET",
    },
    max_worn = 1,
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 6000 } } },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {},
}

ccb.content.define_item {
    id = "exo_small_aux_power",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit small auxiliary battery", "exosuit small auxiliary batteries"),
    description = ccb.content.text("This is a small rechargeable auxiliary power unit that attaches to an exosuit hardpoint."),
    mass = "500 g",
    volume = "500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = {
        "FRAGILE", "CANT_WEAR", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "WATERPROOF", "IS_UPS", "USE_UPS",
        "EXO_SMALL_GADGET",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2500 } } },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {},
}
