local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_electrokit",
    category = "armor",
    mass = "50 g",
    volume = "25 ml",
    price = "0 cent",
    survival_price = "0 cent",
    symbol = ",",
    color = "brown",
    flags = {
        "INTEGRATED", "UNBREAKABLE", "PERSONAL", "WATER_FRIENDLY", "SOFT", "NO_REPAIR",
        "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID", "USES_BIONIC_POWER",
    },
    materials = { "superalloy", "copper" },
    name = ccb.content.plural_text("integrated soldering iron", "integrated soldering iron"),
    description = ccb.content.text("Integrated soldering iron and screwdriver set."),
    qualities = { { id = "SCREW", level = 1 }, { id = "SCREW_FINE", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = { warmth = 0, environmental_protection = 0, thickness = 0.5 },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "plastic", "lead", "tin", "zinc" },
            skill = "fabrication",
            cost_scaling = 0.1,
            move_cost = 1500,
        },
    },
}
