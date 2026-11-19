local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_pigeon_passenger_chick",
    copy_from = "mon_generic_chick",
    description = ccb.content.text("A tiny darkly-colored chick, it could be from a number of different species if it weren't for the third eye below the center of its forehead."),
    upgrade = { grow_at_age = 10, monster = "mon_pigeon_passenger" },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
}
