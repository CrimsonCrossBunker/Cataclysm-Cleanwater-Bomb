local ccb = require("ccb")

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
