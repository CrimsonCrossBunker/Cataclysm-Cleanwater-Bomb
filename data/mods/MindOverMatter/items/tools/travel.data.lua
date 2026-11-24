local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_transporter_beacon",
    name = ccb.content.plural_text("transporter beacon", "transporter beacons"),
    description = ccb.content.text("A pyramidal object with a matrix crystal on top, surrounded by several chunks of the otherworldly boulders you've found dotting the landscape.  You could place it somewhere and after you've configured it, use a transporter remote to teleport yourself to its location."),
    mass = "2500 g",
    volume = "2000 ml",
    length = "40 cm",
    materials = {
        { id = "plastic", portions = 60 },
        { id = "steel", portions = 5 },
        { id = "alien_liquid", portions = 5 },
        { id = "nether_crystal", portions = 15 },
    },
    symbol = "A",
    color = "blue",
    tool = {},
}

ccb.content.define_item {
    id = "psionic_transporter_remote",
    name = ccb.content.plural_text("transporter remote", "transporter remotes"),
    description = ccb.content.text("A blocky item, like an old feature cellphone crossed with a radio.  A matrix channeling array is stick out of the side like an antenna.  There is a small screen on the front, currently off."),
    mass = "500 g",
    volume = "350 ml",
    length = "15 cm",
    materials = {
        { id = "plastic", portions = 75 },
        { id = "steel", portions = 5 },
        { id = "alien_liquid", portions = 5 },
        { id = "nether_crystal", portions = 5 },
    },
    price = "90 USD",
    survival_price = "1 USD",
    symbol = ";",
    color = "blue",
    flags = { "WATER_BREAK", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "psionic_transporter_remote_on",
            message = ccb.content.text("You turn the transporter remote on and the screen begins displaying coordinates."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "psionic_transporter_remote_broken",
    name = ccb.content.plural_text("transporter remote (burned out)", "transporter remote (burned out)"),
    description = ccb.content.text("A blocky item, like an old feature cellphone crossed with a radio.  A matrix channeling array was sticking out of the side like an antenna, but it's now cracked and probably useless.  There is a small screen on the front, obviously burned out.  Parts of the plastic casing are warped as though the plastic had frozen and cracked."),
    copy_from = "psionic_transporter_remote",
    pockets = {},
    flags = { "TRADER_AVOID" },
    tool = {},
    use_actions = {},
}

ccb.content.define_item {
    id = "psionic_transporter_remote_on",
    copy_from = "psionic_transporter_remote",
    name = ccb.content.plural_text("transporter remote (searching)", "transporter remote (searching)"),
    description = "A blocky item, like an old feature cellphone crossed with a radio.  A matrix channeling array is sticking out of the side like an antenna.  There is a small screen on the front, currently running what looks like a series of mathematical calculations.",
    symbol = ";",
    color = "blue",
    mass = "500 g",
    volume = "350 ml",
    length = "15 cm",
    price = "90 USD",
    survival_price = "1 USD",
    revert_to = "psionic_transporter_remote",
    flags = { "TRADER_AVOID", "WATER_BREAK", "ELECTRONIC", "SPAWN_ACTIVE" },
    materials = {
        { id = "plastic", portions = 85 },
        { id = "steel", portions = 10 },
        { id = "nether_crystal", portions = 5 },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "light_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    use_actions = {
        {
            kind = "transform",
            target = "psionic_transporter_remote",
            ammo_scale = 0,
            message = "You turn off the %s.",
            menu_text = "Turn off",
        },
    },
    tool = {
        charges_per_use = 1,
        power_draw = "25000 mW",
        ammo_types = { "battery" },
    },
}
