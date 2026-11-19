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
