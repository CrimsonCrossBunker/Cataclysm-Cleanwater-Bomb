local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_COOKING_HEAT",
    name = ccb.content.text("Stove's Caress"),
    points = 4,
    description = ccb.content.text("Instead of simply causing a burst of heat, the Salamander can emit heat from their hands at will, allowing them to use it to cook."),
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    cost = 1,
    active = true,
    consumes_calories = true,
    activation_setup_only = true,
    cooldown = 60,
    on_activate = "salamander_cooking_heat_toggle",
    on_deactivate = "salamander_cooking_heat_toggle",
}
