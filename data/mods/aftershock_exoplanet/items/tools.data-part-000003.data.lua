local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_atomic_smartphone_music",
    copy_from = "afs_atomic_smartphone",
    name = ccb.content.plural_text("atomic smartphone - music", "atomic smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "afs_atomic_smartphone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "mp3",
            target = "afs_atomic_smartphone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}

ccb.content.define_item {
    id = "afs_wraitheon_smartphone",
    name = ccb.content.plural_text("Wraitheon executive's smartphone", "Wraitheon executive's smartphones"),
    copy_from = "afs_atomic_smartphone",
    description = ccb.content.text("Your custom crafted atomic smartphone.  Most notably a confidential executive-level override program allows you to remotely control most robots."),
    price = "200 kUSD",
    survival_price = "2 kUSD 500 USD",
    materials = { "superalloy", "aluminum" },
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
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "afs_atomic_wraitheon_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
        },
        "CAMERA",
        {
            kind = "mp3",
            target = "afs_atomic_wraitheon_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "ROBOTCONTROL",
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
    },
}

ccb.content.define_item {
    id = "afs_atomic_wraitheon_music",
    copy_from = "afs_wraitheon_smartphone",
    name = ccb.content.plural_text("Wraitheon executive's smartphone - music", "Wraitheon executive's smartphones - music"),
    description = ccb.content.text("This phone is playing music, steadily raising your morale.  You can't hear anything else while you're listening."),
    revert_to = "afs_atomic_smartphone",
    inheritance = { add = { flags = { "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    tool = {},
    use_actions = {
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "mp3",
            target = "afs_wraitheon_smartphone",
            message = ccb.content.text("You stop listening to music and take your earbuds out."),
            activate = false,
        },
    },
    tick_actions = { "MP3_ON" },
}
