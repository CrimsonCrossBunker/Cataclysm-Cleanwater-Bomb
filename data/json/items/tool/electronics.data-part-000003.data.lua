local ccb = require("ccb")

ccb.content.define_item {
    id = "exodii_wrist_computer",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.plural_text("Exodii wrist computer", "Exodii wrist computers"),
    description = ccb.content.text("A small device that resembles a wrist-mounted industrial computer.  It's operated with a pressure-activated resistance touchscreen, made annoyingly difficult to use by its thick plastic screen protector.  The alien glyphs on the analog screen mean nothing to you.  Thankfully, Rubik showed you how to use the two-way radio and the \"wobble door scanner\", which can locate entrances to so-called \"labyrinths\"."),
    price = "12 USD",
    survival_price = "10 USD",
    materials = { "plastic", "aluminum" },
    mass = "750 g",
    volume = "750 ml",
    faults = { { group = "electronic_general" } },
    flags = {
        "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE", "NO_UNLOAD", "WATER_BREAK",
        "ELECTRONIC", "TWO_WAY_RADIO", "TRADER_AVOID",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 734 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        sided = true,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 10,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = {
        { kind = "link_up", cable_length = 3, charge_rate = "5 W" },
        {
            kind = "transform",
            message = ccb.content.text("You tap the computer screen and switch on the scanner."),
            target = "exodii_wrist_computer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
