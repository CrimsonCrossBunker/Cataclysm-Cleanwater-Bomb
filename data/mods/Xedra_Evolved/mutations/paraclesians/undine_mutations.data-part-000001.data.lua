local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_ESCAPE_GRABS",
    name = ccb.content.text("Flow Like Water"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("With the Undine's more fluid skin has come more fluid motion.  Activate this trait to immediately escape a grab and suffer less damage from falls for a few seconds."),
    prerequisites = { "UNDINE_SKIN_2", "UNDINE_SKIN_3" },
    categories = { "UNDINE" },
    purifiable = false,
    active = true,
    activation_setup_only = false,
    cost = 2,
    consumes_water = true,
    on_activate = "undine_escape_grabs",
}
