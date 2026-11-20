local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone", "atomic smartphones"),
    description = ccb.content.text("Never charge your phone again with the Rivtech atomic smartphone.  Rated for 10 million years of use, this cutting-edge gadget had been on public markets for less than a week when the Cataclysm hit, and their eye-watering price made them a rarity.  It includes an alarm clock, a high-resolution camera, and a bright flashlight."),
    mass = "300 g",
    volume = "50 ml",
    price = "2 kUSD",
    survival_price = "25 USD",
    materials = { "plastic", "aluminum" },
    looks_like = "cell_phone",
    symbol = ";",
    color = "light_green",
    flags = { "WATCH", "ALARMCLOCK", "NO_UNLOAD", "NO_RELOAD", "CALORIES_INTAKE" },
    pockets = {
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    tool = { transfer_rate = "45 MB" },
    use_actions = {
        {
            kind = "transform",
            target = "fcl_atomic_smartphone_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
        },
        "CAMERA",
        {
            kind = "mp3",
            target = "fcl_atomic_smartphone_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
    },
}

ccb.content.define_item {
    id = "fcl_atomic_smartphone_music",
    copy_from = "fcl_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone - music", "atomic smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "fcl_atomic_smartphone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "mp3",
            target = "fcl_atomic_smartphone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}
