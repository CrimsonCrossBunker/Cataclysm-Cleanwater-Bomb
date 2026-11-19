local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PARACLESIAN_FAE_SIGHT_2",
    name = ccb.content.text("Wyrd Sight"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "PARACLESIAN_FAE_SIGHT_1" },
    description = ccb.content.text("You can sense other nearby creatures from the Bright Lands.  Activate to enable your fae senses."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_ARVORE", "THRESH_IERDE", "THRESH_HOMULLUS", "THRESH_SALAMANDER", "THRESH_SYLPH",
        "THRESH_UNDINE", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
        "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_SELKIE",
        "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    activation_setup_only = true,
    active = true,
    on_activate = "enable_form_effect",
    on_deactivate = "disable_form_effect",
}
