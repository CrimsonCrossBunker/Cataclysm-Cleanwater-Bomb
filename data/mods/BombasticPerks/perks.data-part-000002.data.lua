local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_sight_beyond_sight",
    name = ccb.content.text("Sight Beyond Sight"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have an instinctive sense for the uncanny and unearthy.  Activate this perk to close your eyes and become aware of nearby Nether creatures."),
    activation_setup_only = true,
    active = true,
    flags = { "PERK" },
    on_activate = "toggle_sight_beyond_sight",
    on_deactivate = "toggle_sight_beyond_sight",
}
