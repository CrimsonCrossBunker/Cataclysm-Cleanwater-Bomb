local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_bat",
    copy_from = "mon_bat",
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It flies around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s flies around your leg."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_bear_cub",
    copy_from = "mon_bear_cub",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_bear",
    copy_from = "mon_bear",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_beaver",
    copy_from = "mon_beaver",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_black_rat",
    copy_from = "mon_black_rat",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_boar_wild_piglet",
    copy_from = "mon_boar_wild_piglet",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_boar_wild",
    copy_from = "mon_boar_wild",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_bobcat",
    copy_from = "mon_bobcat",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  Or maybe it just tolerates your presence better.  It's hard to tell with felines."),
        pet_message = ccb.content.text("The %s softly purrs as you pet it.  It demands more."),
    },
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_chipmunk",
    copy_from = "mon_chipmunk",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_cougar_kitten",
    copy_from = "mon_cougar_kitten",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to tolerate you!  Or maybe it just won't eat you for now.  This is not a housecat."),
        pet_message = ccb.content.text("The %s softly chuffs as you pet it.  It brushes against you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_cougar",
    copy_from = "mon_cougar",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_deer_fawn",
    copy_from = "mon_deer_fawn",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s seems to be happy while you pat their head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_deer",
    copy_from = "mon_deer",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_fox_gray",
    copy_from = "mon_fox_gray",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_fox_red",
    copy_from = "mon_fox_red",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_groundhog",
    copy_from = "mon_groundhog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_hare",
    copy_from = "mon_hare",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_lemming",
    copy_from = "mon_lemming",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_mink",
    copy_from = "mon_mink",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  Or maybe it just tolerates your presence better.  It's hard to tell with these creatures."),
        pet_message = ccb.content.text("The %s softly purrs as you pet it.  It demands more."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

-- To be removed when baby moose are implemented so that they can only be tamed while young.
ccb.content.define_monster {
    id = "mon_moose",
    copy_from = "mon_moose",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s seems to be happy while you pat their head."),
    },
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_muskrat",
    copy_from = "mon_muskrat",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_opossum",
    copy_from = "mon_opossum",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_skunk",
    copy_from = "mon_skunk",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s smacks its lips repetitively as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_otter",
    copy_from = "mon_otter",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  Or maybe it just tolerates your presence better.  It's hard to tell with these creatures."),
        pet_message = ccb.content.text("The %s softly purrs as you pet it.  It demands more."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_raccoon",
    copy_from = "mon_raccoon",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}

ccb.content.define_monster {
    id = "mon_sewer_rat",
    copy_from = "mon_sewer_rat",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_sheep_lamb",
    copy_from = "mon_sheep_lamb",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s seems to be happy while you pat their head."),
    },
}

ccb.content.define_monster {
    id = "mon_goat_kid",
    copy_from = "mon_goat_kid",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s seems to be happy while you pat their head."),
    },
}

ccb.content.define_monster {
    id = "mon_squirrel",
    copy_from = "mon_squirrel",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_squirrel_red",
    copy_from = "mon_squirrel_red",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s lets out a happy squeak as you give its head a small scritch."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_weasel",
    copy_from = "mon_weasel",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  Or maybe it just tolerates your presence better.  It's hard to tell with these creatures."),
        pet_message = ccb.content.text("The %s softly purrs as you pet it.  It demands more."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wolf",
    copy_from = "mon_wolf",
    inheritance = { add = { flags = { "CANPLAY", "DOGFOOD", "PET_MOUNTABLE" } } },
}

-- A wolf pup that's raised with humans displays signs of both attachment and affection towards their owners, these feelings last into adulthood.
ccb.content.define_monster {
    id = "mon_wolf_pup",
    copy_from = "mon_wolf_pup",
    pet = {
        food = { "DOGFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s happily wags its tail while you pat its head."),
    },
    inheritance = { add = { flags = { "CANPLAY", "DOGFOOD" } } },
}

ccb.content.define_monster {
    id = "mon_reindeer",
    copy_from = "mon_reindeer",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_tusked_moose_calf",
    copy_from = "mon_tusked_moose_calf",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_moose_calf",
    copy_from = "mon_moose_calf",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_reindeer_fawn",
    copy_from = "mon_reindeer_fawn",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s seems to be happy while you pat their head."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}
