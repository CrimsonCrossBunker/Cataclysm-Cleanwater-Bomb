local ccb = require("ccb")

ccb.content.define_item {
    id = "smart_watch",
    name = ccb.content.plural_text("smart watch", "smart watches"),
    category = "clothing",
    ascii_picture = "smart_watch",
    volume = "125 ml",
    description = ccb.content.text("A touchscreen watch that comes with many uses, such as a calendar, alarm, and even a fitness app, for when you want to check your health on the go!"),
    mass = "61 g",
    color = "light_gray",
    price = "100 USD",
    survival_price = "1 USD 50 cent",
    materials = { { id = "plastic", portions = 75 }, { id = "aluminum", portions = 25 } },
    flags = {
        "WATCH", "ALARMCLOCK", "BELTED", "FRAGILE", "ALLOWS_NATURAL_ATTACKS", "OVERSIZE", "USE_UPS",
        "NO_UNLOAD", "NO_RELOAD", "WATER_BREAK", "CALORIE_BURN", "ELECTRONIC",
    },
    faults = { { group = "electronic_general" } },
    symbol = "[",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 20 } } },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = {
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
    },
}

ccb.content.define_item {
    id = "smart_watch_music",
    copy_from = "smart_watch",
    name = ccb.content.plural_text("smart watch - music", "smart watches - music"),
    description = ccb.content.text("This smart watch is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_watch",
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "200 mW" },
    armor = {},
    use_actions = {
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}
