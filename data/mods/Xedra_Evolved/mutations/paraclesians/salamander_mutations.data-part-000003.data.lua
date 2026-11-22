local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_HEALTH_FOR_MANA",
    name = ccb.content.text("Burning New Wood"),
    points = 6,
    description = ccb.content.text("In times of extreme need, the Salamander can fuel their powers with their own body.  Activate this to restore mana at the cost of HP."),
    prerequisites = { "SALAMANDER_BIGGER_STOMACH", "SALAMANDER_BIGGER_STOMACH2" },
    secondary_prerequisites = { "SALAMANDER_SKIN_1", "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    cost = 1000,
    consumes_calories = true,
    on_activate = "salamander_health_for_mana",
}
