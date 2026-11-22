local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_WOLF_FORM",
    name = ccb.content.text("Shape of the Pack Hunter"),
    points = 6,
    description = ccb.content.text("You can transform yourself into a wolf and stalk your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_wolf_form_on",
    on_deactivate = "vampire_wolf_form_off",
}
