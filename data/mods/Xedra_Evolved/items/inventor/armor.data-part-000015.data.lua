local ccb = require("ccb")

ccb.content.define_item {
    id = "xedra_inventor_damage_reversal_device",
    name = "Injury Reset Device",
    description = "A bulky wristwatch that attaches to your arm.  Using it will revert the last injury that you have suffered.  Also tells the time.",
    symbol = "[",
    color = "light_gray",
    category = "armor",
    looks_like = "wristwatch",
    mass = "100 g",
    volume = "50 ml",
    flags = {
        "MORPHIC",
        "WATCH",
        "ALARMCLOCK",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_FRIENDLY",
        "OVERSIZE",
        "ELECTRONIC",
        "INVENTOR_CRAFTED",
        "STURDY",
        "PADDED",
    },
    materials = { "kevlar", "mc_steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
            rigid = true,
            watertight = true,
            airtight = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    tool = {
        charges_per_use = 300,
        ammo_types = { "battery" },
    },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                coverage = 50,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}
