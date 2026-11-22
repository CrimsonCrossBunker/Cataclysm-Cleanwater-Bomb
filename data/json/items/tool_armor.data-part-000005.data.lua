local ccb = require("ccb")

ccb.content.define_item {
    id = "smart_watch_adv_music",
    copy_from = "smart_watch_adv",
    name = ccb.content.plural_text("advanced smart watch - music", "advanced smart watches - music"),
    description = ccb.content.text("This advanced smart watch is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "smart_watch_adv",
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "200 mW" },
    armor = {},
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_adv",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
        { kind = "link_up", cable_length = 3, charge_rate = "20 W" },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "smart_watch_adv",
    copy_from = "smart_watch",
    name = ccb.content.plural_text("advanced smart watch", "advanced smart watches"),
    description = "A touchscreen watch that comes with many uses, such as a calendar, alarm, and even a fitness app, for when you want to check your health on the go!  This is a more expensive model, featuring a shock-resistant and waterproof case and a bunch of additional sensors.",
    price = "700 USD",
    survival_price = "10 USD",
    e_port = "phone",
    e_ports_banned = { "USB-A", "memory card", "camera" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 30 },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "64 GB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "FITNESS_CHECK",
        "WEATHER_TOOL",
        "PORTABLE_GAME",
        {
            kind = "mp3",
            target = "smart_watch_adv_music",
            activate = true,
            message = "You put in the earbuds and start listening to music.",
        },
        { kind = "link_up", charge_rate = "20 W", cable_length = 3 },
    },
    tool = { transfer_rate = "30 MB" },
    armor = {},
    subtype_order = { "tool", "armor" },
    inheritance = {
        add = {
            flags = { "WATER_FRIENDLY", "THERMOMETER", "HYGROMETER", "BAROMETER", "CAN_USE_IN_DARK" },
        },
        remove = {
            flags = { "WATER_BREAK", "FRAGILE" },
        },
    },
}
