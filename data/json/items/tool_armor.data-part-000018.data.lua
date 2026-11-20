local ccb = require("ccb")

ccb.content.define_item {
    id = "goggles_ir",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("infrared goggles", "infrared goggles"),
    description = ccb.content.text("A pair of battery-powered goggles that grant infrared vision, allowing you to see warm-blooded creatures in the dark.  Use it to turn them on."),
    flags = { "FRAGILE", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    price = "920 USD",
    survival_price = "25 USD",
    materials = { "plastic", "steel" },
    mass = "1240 g",
    volume = "1 L",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        environmental_protection = 3,
        thickness = 2,
        portions = { { encumbrance = 40, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    artifact = { enchantments = { "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "goggles_ir_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
