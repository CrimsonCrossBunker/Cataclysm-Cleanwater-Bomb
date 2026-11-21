local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DEBUG_MUTATE",
    name = ccb.content.text("Debug Genetic Instability"),
    description = ccb.content.text("You just can't wait to turn into a bug!  Triggers a mutation using the normal mutation rules (requiring primer but no catalyst) every five seconds."),
    points = 99,
    debug = true,
    valid = false,
    cooldown = "5 s",
    on_process = "debug_mutate",
}
