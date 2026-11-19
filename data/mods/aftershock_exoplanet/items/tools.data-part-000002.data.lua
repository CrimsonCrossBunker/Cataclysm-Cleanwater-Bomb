local ccb = require("ccb")

ccb.content.define_item {
    id = "UPS_OFF",
    copy_from = "UPS_OFF",
    description = ccb.content.text("This is a unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power armor and some guns, but drains batteries quickly.  It can be worn strapped to either leg for ease of access, and it's been waterproofed to protect the delicate electronics.  Has its own custom battery, rechargeable and with higher capacity, but not removable."),
    price = "1300 USD",
    survival_price = "1300 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    flags = {
        "RECHARGE",
        "BELTED",
        "NO_UNLOAD",
        "NO_RELOAD",
        "FRAGILE",
        "OVERSIZE",
        "WATERPROOF",
        "IS_UPS",
    },
    materials = { "aluminum", "plastic" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 2,
                coverage = 13,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "UPS_ON",
    copy_from = "UPS_ON",
    description = ccb.content.text("This is a unified power supply, or UPS.  It is a device developed jointly by military and scientific interests for use in combat and the field.  The UPS is designed to power armor and some guns, but drains batteries quickly.  It can be worn strapped to either leg for ease of access, and it's been waterproofed to protect the delicate electronics.  Has its own custom battery, rechargeable and with higher capacity, but not removable."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    flags = {
        "RECHARGE",
        "BELTED",
        "NO_UNLOAD",
        "NO_RELOAD",
        "FRAGILE",
        "OVERSIZE",
        "WATERPROOF",
        "IS_UPS",
    },
    materials = { "aluminum", "plastic" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = { "battery" } },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 2,
                coverage = 13,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}
