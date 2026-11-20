local ccb = require("ccb")

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
    flags = { "WATER_BREAK" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "battery_car",
                "battery_motorbike",
                "small_storage_battery",
                "medium_storage_battery",
                "storage_battery",
            },
        },
    },
    tool = { ammo_types = { "battery" } },
    use_actions = { { kind = "link_up", cable_length = 2, charge_rate = "300 W" } },
}
