local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_aphid_small",
    copy_from = "mon_aphid_small",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
    },
    starting_ammo = { fresh_honeydew = 1 },
    inheritance = { add = { flags = { "MILKABLE" } } },
}

ccb.content.define_monster {
    id = "mon_aphid",
    copy_from = "mon_aphid",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
    },
    starting_ammo = { fresh_honeydew = 2 },
    inheritance = { add = { flags = { "MILKABLE" } } },
}
