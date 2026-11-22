local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_JUMP_HIGH",
    name = ccb.content.text("Updraft Leap"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph can leap straight into the air, riding the wind currents for a few seconds before descending to the earth."),
    prerequisites = { "SYLPH_GLIDING" },
    secondary_prerequisites = { "SYLPH_SKIN_2", "SYLPH_SKIN_3" },
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = false,
    on_activate = "sylph_jump_high",
}
