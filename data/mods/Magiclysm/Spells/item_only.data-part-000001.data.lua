local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "ring_of_flight_spell",
    name = ccb.content.text_without_extraction("Flight"),
    description = ccb.content.text_without_extraction("You can fly."),
    message = "",
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_ring_of_flight",
    shape = "blast",
    min_duration = 90000,
    max_duration = 90000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mbracer_blinding_strike_spell",
    name = ccb.content.text_without_extraction("The Blinding Strike"),
    description = ccb.content.text_without_extraction("Your attacks are much faster."),
    message = "",
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "effect_bracers_of_the_blinding_strike",
    shape = "blast",
    min_duration = 1500,
    max_duration = 1500,
}
