local ccb = require("ccb")

-- This is the first stage long arms mutation.
ccb.content.define_mutation {
    id = "SHADE_LONG_ARMS",
    name = ccb.content.text("Long Arms"),
    description = ccb.content.text("Your arms have lengthened.  You can push a target away from you."),
    types = { "ARMS" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    categories = { "GRACKEN" },
    threshold_requirements = { "THRESH_SPECIES_GRACKEN" },
    activation_setup_only = false,
    active = true,
    on_activate = "gracken_arm_push1",
}
