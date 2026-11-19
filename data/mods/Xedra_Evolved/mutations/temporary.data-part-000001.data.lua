local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LUCID_DREAM",
    name = ccb.content.text("Sleeper"),
    active = true,
    points = 99,
    description = ccb.content.text("You still sleep, yet your dreams still can impact the world.  Activate to wake up."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "end_lucid_dream",
}
