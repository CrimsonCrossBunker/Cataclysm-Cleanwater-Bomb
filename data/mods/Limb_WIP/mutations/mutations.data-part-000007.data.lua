local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BIRD_LEGS",
    name = ccb.content.text("Avian Legs"),
    points = 0,
    visibility = 4,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your legs and feet have become bird-like, with long talons arranged three ahead and one behind.  They probably won't fit in human shoes, but they're perfect for gripping onto precarious perches."),
    active = true,
    activation_setup_only = false,
    on_activate = "activate_avian_leap",
    types = { "LEGS", "FEET" },
    threshold_requirements = { "THRESH_BIRD" },
    categories = { "BIRD" },
    restricts_gear = { "foot_l", "foot_r" },
    destroys_gear = true,
    allowed_item_flags = { "ALLOWS_TALONS" },
}
