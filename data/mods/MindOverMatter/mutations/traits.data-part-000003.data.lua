local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PSI_TORRENTIAL_CHANNELING",
    name = ccb.content.text("Torrential Channeling"),
    points = 0,
    description = ccb.content.text("You can draw deeply on the Nether, increasing the strength of your powers but making making them harder to initiate and control."),
    active = true,
    activation_setup_only = true,
    valid = false,
    purifiable = false,
    on_activate = "activate_psi_torrential_channeling",
    on_deactivate = "deactivate_psi_torrential_channeling",
}
