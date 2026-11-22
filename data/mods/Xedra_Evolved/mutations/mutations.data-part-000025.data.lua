local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_MIST_FORM",
    name = ccb.content.text("Shape of the Billowing Mists"),
    points = 8,
    description = ccb.content.text("You can transform yourself into a cloud of mist and flee any dangers."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_mist_form_on",
    on_deactivate = "vampire_mist_form_off",
}
