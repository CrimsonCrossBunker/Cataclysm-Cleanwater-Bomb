local ccb = require("ccb")

ccb.content.define_item {
    id = "portable_music_player",
    name = ccb.content.plural_text("portable cassette player (off)", "portable cassette players (off)"),
    description = ccb.content.text("This battery-powered device can be used to play cassettes (and like any good survivor, you've always got your favorites at hand).  Listening to them will raise your morale slightly.  Use it to turn it on."),
    mass = "40 g",
    volume = "36 ml",
    price = "40 USD",
    survival_price = "2 cent",
    materials = { { id = "aluminum", portions = 75 }, { id = "plastic", portions = 25 } },
    ascii_picture = "mp3",
    symbol = ";",
    color = "dark_gray",
    flags = { "WATER_BREAK_ACTIVE", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        {
            kind = "mp3",
            target = "portable_music_player_on",
            message = ccb.content.text("You slip in a cassette, put on headphones, and start listening to music."),
            activate = true,
        },
    },
}

ccb.content.define_item {
    id = "portable_music_player_on",
    copy_from = "portable_music_player",
    name = ccb.content.plural_text("portable cassette player (on)", "portable cassette players (on)"),
    description = ccb.content.text("This cassette player is turned on and playing some great tunes, raising your morale steadily while on your person.  It runs through batteries quickly; you can turn it off by using it.  It also obscures your hearing."),
    revert_to = "portable_music_player",
    faults = { { group = "electronic_general" } },
    flags = { "NO_UNLOAD", "NO_RELOAD", "TRADER_AVOID", "WATER_BREAK", "ELECTRONIC", "SPAWN_ACTIVE" },
    tool = { power_draw = "1 W" },
    use_actions = {
        {
            kind = "mp3",
            target = "portable_music_player",
            message = ccb.content.text("The cassette player turns off."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}
