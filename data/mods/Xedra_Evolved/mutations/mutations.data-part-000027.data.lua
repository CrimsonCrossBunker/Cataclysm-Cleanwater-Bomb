local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_SHADOW_FORM",
    points = 10,
    name = ccb.content.text("Shape of the Shadowed Path"),
    description = ccb.content.text("You can shroud your body and what you are carrying with shadows, amplifying your combat ability but preventing communication and using other powers until you return to your normal form.  It also costs blood for every second you spend in that state."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_shadow_form_on",
    on_process = "vampire_shadow_form_process",
    on_deactivate = "vampire_shadow_form_off",
}
