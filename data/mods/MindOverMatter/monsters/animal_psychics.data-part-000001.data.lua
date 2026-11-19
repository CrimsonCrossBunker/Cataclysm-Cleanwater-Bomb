local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_cockatrice_chick",
    copy_from = "mon_generic_chick",
    description = ccb.content.text("A strange tiny chick, it could be from a number of different species if it weren't for the patches of scales between its feathers."),
    name = ccb.content.plural_text("strange chick", "strange chicks"),
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    upgrade = { grow_at_age = 12, monster = "mon_cockatrice" },
    inheritance = { add = { flags = { "CANPLAY" } } },
}
