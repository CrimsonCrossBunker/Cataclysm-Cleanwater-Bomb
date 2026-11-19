local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_cartridge_charger",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit cartridge charger", "exosuit cartridge chargers"),
    description = ccb.content.text("This is a charging port designed to accept power cartridges."),
    mass = "400 g",
    volume = "500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = { "CANT_WEAR", "USE_UPS", "EXO_SMALL_GADGET" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            mass_limit = "100 g",
            capacity = "250 ml",
            allowed_items = {
                "afs_cartridge",
                "afs_compact_cartridge",
                "afs_bootleg_cartridge",
                "afs_archeotech_cartridge",
            },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}
