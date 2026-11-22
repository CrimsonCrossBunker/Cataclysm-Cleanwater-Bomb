local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM",
    name = ccb.content.text("Mien of the Mannequin"),
    points = 8,
    description = ccb.content.text("You may transform yourself into a doll in truth, ignoring the needs of the flesh and making most monsters less likely to attack you.  However, your stiff limbs will inhibit your movement."),
    prerequisites = { "BEAUTIFUL2", "BEAUTIFUL3" },
    secondary_prerequisites = { "HOMULLUS_SKIN_3" },
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    active = true,
    activation_setup_only = true,
    on_activate = "homullus_doll_form_toggle",
    on_process = "homullus_doll_form_process",
    on_deactivate = "homullus_doll_form_toggle",
}
