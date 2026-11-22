local ccb = require("ccb")

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_BAT",
    name = ccb.content.text("Spirit of the Bat"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a bat."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_RAVEN",
    name = ccb.content.text("Spirit of the Raven"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a raven."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_BEAR",
    name = ccb.content.text("Spirit of the Bear"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a bear."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_DEER",
    name = ccb.content.text("Spirit of the Deer"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a deer."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_WOLF",
    name = ccb.content.text("Spirit of the Wolf"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a wolf."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_COUGAR",
    name = ccb.content.text("Spirit of the Cougar"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a cougar."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}
