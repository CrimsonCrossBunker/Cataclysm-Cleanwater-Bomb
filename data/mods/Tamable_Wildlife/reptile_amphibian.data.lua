local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_pattern_bigfrog",
    copy_from = "mon_pattern_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_pattern_giganfrog",
    copy_from = "mon_pattern_giganfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strange_bigfrog",
    copy_from = "mon_strange_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strange_giganfrog",
    copy_from = "mon_strange_giganfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strange_megafrog",
    copy_from = "mon_strange_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_foul_bigfrog",
    copy_from = "mon_foul_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_foul_giganfrog",
    copy_from = "mon_foul_giganfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_foul_megafrog",
    copy_from = "mon_foul_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_odd_bigfrog",
    copy_from = "mon_odd_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_odd_giganfrog",
    copy_from = "mon_odd_giganfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_odd_megafrog",
    copy_from = "mon_odd_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_vocal_bigfrog",
    copy_from = "mon_vocal_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_jumbo_bigfrog",
    copy_from = "mon_jumbo_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_shift_bigfrog",
    copy_from = "mon_shift_bigfrog",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_leo_frog",
    copy_from = "mon_leo_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_pattern_frog",
    copy_from = "mon_pattern_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_bullfrog_frog",
    copy_from = "mon_bullfrog_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strange_frog",
    copy_from = "mon_strange_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_fowler_toad",
    copy_from = "mon_fowler_toad",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_foul_toad",
    copy_from = "mon_foul_toad",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_freedom_toad",
    copy_from = "mon_freedom_toad",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_odd_toad",
    copy_from = "mon_odd_toad",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_peeper_frog",
    copy_from = "mon_peeper_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_vocal_frog",
    copy_from = "mon_vocal_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_gray_frog",
    copy_from = "mon_gray_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_shift_frog",
    copy_from = "mon_shift_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_mink_frog",
    copy_from = "mon_mink_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_tail_frog",
    copy_from = "mon_tail_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_pickerel_frog",
    copy_from = "mon_pickerel_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_palette_frog",
    copy_from = "mon_palette_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_green_frog",
    copy_from = "mon_green_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wood_frog",
    copy_from = "mon_wood_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spade_frog",
    copy_from = "mon_spade_frog",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_leo_worm",
    copy_from = "mon_leo_worm",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_green_worm",
    copy_from = "mon_green_worm",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wood_worm",
    copy_from = "mon_wood_worm",
    pet = {
        food = { "CATTLEFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s hops around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_s",
    copy_from = "mon_rattlesnake_s",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake",
    copy_from = "mon_rattlesnake",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_gartersnake_baby",
    copy_from = "mon_gartersnake_baby",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_gartersnake",
    copy_from = "mon_gartersnake",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wormsnake_baby",
    copy_from = "mon_wormsnake_baby",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wormsnake",
    copy_from = "mon_wormsnake",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_turtle_painted_baby",
    copy_from = "mon_turtle_painted_baby",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_turtle_painted",
    copy_from = "mon_turtle_painted",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_turtle_snapping_common_baby",
    copy_from = "mon_turtle_snapping_common_baby",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_turtle_snapping_common",
    copy_from = "mon_turtle_snapping_common",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_skink_fivelined_baby",
    copy_from = "mon_skink_fivelined_baby",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_skink_fivelined",
    copy_from = "mon_skink_fivelined",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big_s",
    copy_from = "mon_rattlesnake_big_s",
    pet = {
        food = { "CATFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It lets you pat its head and seems friendly."),
        pet_message = ccb.content.text("The %s slithers around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big",
    copy_from = "mon_rattlesnake_big",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_giant",
    copy_from = "mon_rattlesnake_giant",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_mega",
    copy_from = "mon_rattlesnake_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}
