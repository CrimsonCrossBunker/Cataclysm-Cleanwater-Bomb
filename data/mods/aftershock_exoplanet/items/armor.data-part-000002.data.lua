local ccb = require("ccb")

-- generic name and description
ccb.content.define_item {
    id = "afs_wrist_computer",
    category = "armor",
    name = ccb.content.plural_text("IX-2110 computer", "IX-2110 computers"),
    description = ccb.content.text("The original Imagos IX-2110, a general use wrist computer originally designed to support operations within hazardous environments.  Among the most successful pieces of technology ever created, millions of these were produced and sold to the explorers that first tamed the stars during the early Hyperspace Era.  The slow attrition of technological prowess since the Discontinuity has left slightly slower than its modern counterparts."),
    variant_kind = "generic",
    variants = {
        { id = "old" },
        {
            id = "standard",
            name = ccb.content.plural_text("IX-2330S computer", "IX-2330S computers"),
            weight = 0,
            description = ccb.content.text("A rugged and radiation shielded wirst computer specifically designed to support salvage operations.  It can perform general computing tasks and might be used to interface with most ancient computer systems."),
            color = "dark_gray",
        },
    },
    mass = "315 g",
    volume = "1200 ml",
    price = "260 USD",
    accuracy = -1,
    materials = { "steel", "plastic" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATCH", "BELTED", "STURDY", "WATER_FRIENDLY" },
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
    qualities = { { id = "HACK", level = 1 } },
    subtype_order = { "tool", "armor" },
    tool = { transfer_rate = "45 MB", charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = { { encumbrance = 2, coverage = 14, covers = { "arm_l", "arm_r" } } },
        warmth = 10,
        thickness = 2,
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "PORTABLE_GAME",
        { kind = "link_up", cable_length = 5, charge_rate = "140 W" },
    },
}
