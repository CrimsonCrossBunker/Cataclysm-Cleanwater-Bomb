local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_repair_kit",
    copy_from = "large_repairkit",
    name = ccb.content.plural_text("exosuit repair kit", "exosuit repair kits"),
    description = ccb.content.text("This is a collection of tools including a high-powered torch for working the titanium frame."),
    length = "25 cm",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "qt_steel" },
    symbol = ",",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "afs_cartridge",
                "afs_compact_cartridge",
                "afs_bootleg_cartridge",
                "afs_archeotech_cartridge",
            },
            default_magazine = "afs_cartridge",
        },
    },
    flags = { "ALLOWS_REMOTE_USE", "WATER_BREAK", "USE_UPS" },
    melee_damage = { bash = 2, cut = 6 },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "qt_steel", "lc_steel", "mc_steel", "hc_steel", "ch_steel", "qt_steel", "titanium" },
            skill = "fabrication",
            cost_scaling = 0.1,
            move_cost = 1500,
        },
    },
}
