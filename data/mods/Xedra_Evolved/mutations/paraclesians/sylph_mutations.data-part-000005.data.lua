local ccb = require("ccb")

-- This should have a mana cost here instead of within the EoC once that's possible.
ccb.content.define_mutation {
    id = "SYLPH_FLY_AT_WILL",
    name = ccb.content.text("Surmounting the Clouds"),
    points = 10,
    description = ccb.content.text("Born of the winds, the Sylph can walk on them as easily as the ground.  While this trait is active, the Sylph will not fall and may walk on the air as they like.  It requires 3 mana per turn to fuel their steps."),
    prerequisites = { "SYLPH_JUMP_HIGH" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    active = true,
    activation_setup_only = true,
    cooldown = "1 s",
    on_activate = "sylph_fly_at_will",
    on_process = "sylph_fly_at_will",
}
