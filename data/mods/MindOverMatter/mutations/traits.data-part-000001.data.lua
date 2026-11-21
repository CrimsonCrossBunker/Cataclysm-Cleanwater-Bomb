local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PSI_EXTENDED_CHANNELING",
    name = ccb.content.text("Extended Channeling"),
    points = 0,
    description = ccb.content.text("You can take more time and care in channeling your powers.  It will take 5x as long to evoke them, but it will be much easier to activate them and you will be less likely to gain Nether Attunement while doing so."),
    active = true,
    activation_setup_only = true,
    valid = false,
    purifiable = false,
    on_activate = "toggle_psi_extended_channeling",
    on_deactivate = "toggle_psi_extended_channeling",
}
