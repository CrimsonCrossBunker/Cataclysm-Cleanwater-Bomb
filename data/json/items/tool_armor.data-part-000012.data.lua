local ccb = require("ccb")

ccb.content.define_item {
    id = "goggles_nv",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("light amp goggles", "light amp goggles"),
    description = ccb.content.text("A pair of battery-powered goggles that use a infrared LED in conjunction with a IR camera, allowing you to see in the dark.  Use it to turn them on."),
    flags = { "FRAGILE", "OUTER", "ELECTRONIC", "MUNDANE" },
    faults = { { group = "electronic_general" } },
    price = "300 USD",
    survival_price = "30 USD",
    materials = { "plastic", "steel" },
    mass = "600 g",
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
    artifact = { enchantments = { "nvg_bad" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "goggles_nv_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
