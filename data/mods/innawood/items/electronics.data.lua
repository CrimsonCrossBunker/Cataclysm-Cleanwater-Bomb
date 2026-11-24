local ccb = require("ccb")

ccb.content.define_item {
    id = "makeshift_hand_crank_charger",
    category = "tools",
    name = ccb.content.plural_text("makeshift hand-crank charger", "makeshift hand-crank chargers"),
    description = ccb.content.text("A makeshift hand-powered battery charger based on homopolar generator."),
    mass = "8000 g",
    volume = "7 L",
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { "wood", "copper", "steel" },
    symbol = ":",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT", "BATTERY_HEAVY" },
            default_magazine = "battery_car_clay",
        },
    },
    tool = { ammo_types = { "battery" } },
    use_actions = { "HAND_CRANK" },
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
                allowed_items = { "small_storage_battery", "battery_car", "battery_motorbike", "battery_car_clay" },
            },
        },
        magazine_adapters = {
            {
                ammo_type = "battery",
                magazines = { "small_storage_battery", "battery_car", "battery_motorbike", "battery_car_clay" },
            },
        },
    },
}

-- this tool is small and has no actual battery compartment, but can connect to large batteries.
ccb.content.define_item {
    id = "electrolysis_kit",
    name = ccb.content.plural_text("electrolysis kit", "electrolysis kits"),
    description = ccb.content.text("A set of wiring and electrodes for applying a direct current, usually to a liquid.  Useful for crafting.  Load with a storage battery or 12V vehicle battery to use."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "7 USD 50 cent",
    materials = { "steel", "copper", "plastic" },
    symbol = ";",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "battery_car", "battery_car_clay", "battery_motorbike", "small_storage_battery",
                "medium_storage_battery", "storage_battery",
            },
        },
    },
    tool = { ammo_types = { "battery" } },
    use_actions = { { kind = "link_up", cable_length = 2, charge_rate = "300 W" } },
}
