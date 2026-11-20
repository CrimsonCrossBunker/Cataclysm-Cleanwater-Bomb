local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_atomic_smartphone",
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
            target = "afs_atomic_smartphone_flashlight",
            message = ccb.content.text("You activate the flashlight app."),
        },
        "CAMERA",
        {
            kind = "mp3",
            target = "afs_atomic_smartphone_music",
            message = ccb.content.text("You put in the earbuds and start listening to music."),
            activate = true,
        },
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
    },
}
