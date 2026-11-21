local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_extra_life",
    name = ccb.content.text("Living on a Prayer"),
    points = 0,
    description = ccb.content.text("You're like a cat, and it always seemed to you like you've had nine lives.  When things get rough, by pure luck or divine intervention, you can get out of it."),
    categories = { "perk" },
    on_process = "extra_life_addup",
}
