local ccb = require("ccb")

ccb.content.define_item {
    id = "vr_laptop",
    category = "tools",
    name = ccb.content.plural_text("portable virtual reality rig", "portable virtual reality rigs"),
    description = ccb.content.text("A portable virtual reality rig with glasses for the HUD and the computing functions wrapped around the torso.  When powered on it will provide an overlay on everything you experience."),
    symbol = ",",
    color = "dark_gray",
    materials = { "glass", "titanium" },
    copy_from = "sunglasses",
    flags = { "WATCH", "SKINTIGHT" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "1 TB",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 2, ammo_types = { "battery" } },
    armor = { portions = { { covers = { "eyes", "torso" } } } },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        {
            kind = "transform",
            target = "vr_laptop_holosuite",
            message = ccb.content.text("The holosuite comes to life around you."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
