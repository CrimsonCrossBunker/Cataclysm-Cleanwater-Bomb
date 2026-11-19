local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_crayfish_giant_larva",
    copy_from = "mon_crayfish_giant_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant crustacean could like you.  It swims around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s swims around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_giant_crayfish",
    copy_from = "mon_giant_crayfish",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_crayfish_mega",
    copy_from = "mon_crayfish_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}
