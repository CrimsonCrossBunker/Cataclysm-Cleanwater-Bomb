local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_BAT_FORM",
    name = ccb.content.text("Shape of the Night Flier"),
    points = 8,
    description = ccb.content.text("You can transform yourself into a bat and take wing on the night air."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_bat_form_on",
    on_deactivate = "vampire_bat_form_off",
}
