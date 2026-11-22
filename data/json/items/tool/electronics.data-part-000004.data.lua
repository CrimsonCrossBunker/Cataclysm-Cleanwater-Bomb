local ccb = require("ccb")

ccb.content.define_item {
    id = "exodii_wrist_computer_on",
    copy_from = "exodii_wrist_computer",
    name = ccb.content.plural_text("Exodii wrist computer (on)", "Exodii wrist computers (on)"),
    looks_like = "exodii_wrist_computer",
    revert_to = "exodii_wrist_computer",
    flags = {
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
        "NO_UNLOAD",
        "WATER_BREAK",
        "ELECTRONIC",
        "TWO_WAY_RADIO",
        "TRADER_AVOID",
        "SPAWN_ACTIVE",
    },
    use_actions = {
        { kind = "link_up", charge_rate = "5 W", cable_length = 3 },
        {
            kind = "transform",
            target = "exodii_wrist_computer",
            ammo_scale = 0,
            message = "You tap the computer screen and switch off the scanner.",
            menu_text = "Turn off",
        },
    },
    tool = { turns_per_charge = 360 },
    armor = {},
    subtype_order = { "tool", "armor" },
}
