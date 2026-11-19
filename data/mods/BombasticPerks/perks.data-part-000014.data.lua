local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_frakenstein",
    name = ccb.content.text("Playing God"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've been dissecting critters since high school.  Last night a voice gave you an idea for how to bring them back to life.  Activate the perk to gain insight into the nature of life itself!"),
    active = true,
    flags = { "PERK" },
    on_activate = "frankenstein_insight",
}
