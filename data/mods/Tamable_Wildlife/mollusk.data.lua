local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_snail_larva",
    copy_from = "mon_snail_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a mollusk could like you."),
        pet_message = ccb.content.text("The %s slides slowly around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_snail_forest",
    copy_from = "mon_snail_forest",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant mollusk could like you."),
        pet_message = ccb.content.text("The %s slides slowly around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_snail_small",
    copy_from = "mon_snail_small",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_snail_giant",
    copy_from = "mon_snail_giant",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_slug_larva",
    copy_from = "mon_slug_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a mollusk could like you."),
        pet_message = ccb.content.text("The %s slides slowly around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_slug_forest",
    copy_from = "mon_slug_forest",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant mollusk could like you."),
        pet_message = ccb.content.text("The %s slides slowly around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_slug_small",
    copy_from = "mon_slug_small",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_slug_giant",
    copy_from = "mon_slug_giant",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}
