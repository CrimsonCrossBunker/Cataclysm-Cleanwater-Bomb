local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_REMOVE_STUN",
    name = ccb.content.text("Effortlessly-Rising Smoke"),
    points = 5,
    description = ccb.content.text("Like smoke rising to the sky, the Salamander cannot be kept down.  This trait may be activated to immediately clear the Stunned, Dazed, or Downed effects."),
    prerequisites = { "SALAMANDER_REDUCED_MOVE_COST" },
    active = true,
    categories = { "SALAMANDER" },
    purifiable = false,
    cost = 75,
    consumes_calories = true,
    on_activate = "salamander_remove_stun",
}
