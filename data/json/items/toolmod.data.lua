local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "mod_battery",
    abstract = true,
    name = ccb.content.text_without_extraction("base toolmod"),
    mass = "142 g",
    volume = "250 ml",
    materials = { "plastic", "ceramic" },
    symbol = ";",
    color = "dark_gray",
    price = "1 USD",
    toolmod = { compatible_ammo = { "battery" } },
}

ccb.content.define_item {
    id = "battery_ups",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("UPS conversion mod", "UPS conversion mods"),
    description = ccb.content.text("A device that replaces conventional battery connections with a connector port that can plug into a UPS.  Any device modified with this can be used without a battery as long as you have a charged UPS with you."),
    flags = { "USE_UPS", "NO_UNLOAD" },
    toolmod = {},
}

ccb.content.define_item {
    id = "battery_bionic",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("bionic power conversion mod", "bionic power conversion mods"),
    description = ccb.content.text("A kit that replaces conventional battery connections with the circuitry and cables required to draw power from a Standard Neurobionics Interface (SNI).  Any device modified with this is powered by your own bionic power storage instead of conventional batteries."),
    flags = { "USES_BIONIC_POWER", "NO_UNLOAD" },
    toolmod = {},
}

ccb.content.define_item {
    id = "magazine_battery_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("battery compartment mod", "battery compartment mods"),
    description = ccb.content.text("A battery compartment mod that allows using vehicle batteries and small storage batteries in regular tools."),
    color = "light_green",
    toolmod = {
        compatible_ammo = { "battery" },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_items = {
                    "small_storage_battery",
                    "medium_storage_battery",
                    "battery_car",
                    "battery_motorbike",
                },
            },
        },
        magazine_adapters = {
            {
                ammo_type = "battery",
                magazines = {
                    "small_storage_battery",
                    "medium_storage_battery",
                    "battery_car",
                    "battery_motorbike",
                },
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "pseudo_magazine_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.text_without_extraction("pseudo magazine mod"),
    description = ccb.content.text_without_extraction("For containing pseudo magazines, obviously."),
    color = "light_green",
    flags = { "PSEUDO", "DEBUG_ONLY" },
    toolmod = {
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                default_magazine = "pseudo_magazine",
                allowed_items = { "pseudo_magazine" },
            },
        },
    },
}

ccb.content.define_item {
    id = "magazine_battery_light_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("light battery mod", "light battery mods"),
    description = ccb.content.text("A battery compartment mod that allows the use of light and ultra-light batteries in tools that otherwise could not."),
    color = "light_green",
    toolmod = {
        compatible_ammo = { "battery" },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
                default_magazine = "light_minus_battery_cell",
            },
        },
    },
}

ccb.content.define_item {
    id = "magazine_battery_medium_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("medium battery mod", "medium battery mods"),
    description = ccb.content.text("A battery compartment mod that allows the use of medium batteries in tools that otherwise could not."),
    color = "light_green",
    toolmod = {
        compatible_ammo = { "battery" },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_flags = { "BATTERY_MEDIUM" },
                default_magazine = "medium_battery_cell",
            },
        },
    },
}

ccb.content.define_item {
    id = "magazine_battery_heavy_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("tool battery mod", "tool battery mods"),
    description = ccb.content.text("A battery compartment mod that allows the use of tool batteries in tools that otherwise could not."),
    color = "light_green",
    toolmod = {
        compatible_ammo = { "battery" },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_flags = { "BATTERY_HEAVY" },
                default_magazine = "heavy_battery_cell",
            },
        },
    },
}
