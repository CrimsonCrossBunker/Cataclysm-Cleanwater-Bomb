local ccb = require("ccb")

-- ids are legacy, they're actually electrokinetic
ccb.content.define_item {
    id = "pyrokinetic_flashlight",
    name = ccb.content.plural_text("everglow matrix flashlight (off)", "everglow matrix flashlights (off)"),
    description = ccb.content.text("A household flashlight enhanced with matrix technology.  It is slightly dimmer but will last significantly longer."),
    materials = { "plastic", "aluminum", "nether_crystal" },
    symbol = ";",
    color = "blue",
    mass = "280 g",
    volume = "270 ml",
    length = "14 cm",
    price = "15 USD",
    survival_price = "5 USD",
    flags = { "BELT_CLIP", "WATER_BREAK_ACTIVE" },
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
            message = ccb.content.text("You turn the flashlight on."),
            target = "pyrokinetic_flashlight_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "pyrokinetic_flashlight_on",
    copy_from = "pyrokinetic_flashlight",
    name = ccb.content.plural_text("everglow matrix flashlight (on)", "everglow matrix flashlights (on)"),
    revert_to = "pyrokinetic_flashlight",
    light = 225,
    flags = { "CHARGEDIM", "TRADER_AVOID", "BELT_CLIP", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = { power_draw = "390 mW" },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the flashlight off."),
            target = "pyrokinetic_flashlight",
            ammo_scale = 0,
        },
    },
}

ccb.content.define_item {
    id = "pyrokinetic_lamp",
    name = ccb.content.plural_text("everglow matrix lamp (covered)", "everglow matrix lamps (covered)"),
    description = ccb.content.text("Powered by matrix technology, this lamp will shed a bluish light for far longer than a standard battery-powered lamp.  Activate to open the lid."),
    mass = "1438 g",
    volume = "1 L",
    price = "1 kUSD 750 USD",
    survival_price = "40 USD",
    melee_damage = { bash = 8 },
    materials = { "plastic", "aluminum", "nether_crystal" },
    symbol = ",",
    color = "red",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_cell",
        },
    },
    flags = { "LEAK_DAM", "ALLOWS_REMOTE_USE", "WATER_BREAK_ACTIVE" },
    tool = { ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "transform",
            target = "pyrokinetic_lamp_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
            message = ccb.content.text("You open the lamp's cover."),
            menu_text = ccb.content.text("Open cover"),
        },
    },
}

ccb.content.define_item {
    id = "pyrokinetic_lamp_on",
    name = ccb.content.plural_text("everglow matrix lamp (uncovered)", "everglow matrix lamps (uncovered)"),
    copy_from = "pyrokinetic_lamp",
    description = ccb.content.text("Powered by matrix technology, this lamp will shed a reddish light for far longer than a standard battery-powered lamp.  Activate to close the lid."),
    light = 150,
    flags = { "LEAK_DAM", "ALLOWS_REMOTE_USE", "CHARGEDIM", "TRADER_AVOID", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = { power_draw = "250 mW" },
    use_actions = {
        {
            kind = "transform",
            target = "pyrokinetic_lamp",
            message = ccb.content.text("You close the lamp's cover."),
            menu_text = ccb.content.text("Close cover"),
        },
    },
}
