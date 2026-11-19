local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_second_chance_limiter",
    name = ccb.content.text_without_extraction("Second Chance Limiter"),
    points = 0,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You used up your second chance perk and it won't work again."),
}
