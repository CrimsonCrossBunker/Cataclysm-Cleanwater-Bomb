local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "heli_crash",
    extend = { professions = { "xe_psi_hunter", "xe_psi_verdant_hand", "xe_psi_pyrokinetic_cyborg" } },
    id = "heli_crash",
}

ccb.content.define_scenario {
    copy_from = "portal_dependent",
    extend = { professions = { "xe_psi_hunter", "xe_psi_verdant_hand", "xe_psi_pyrokinetic_cyborg" } },
    id = "portal_dependent",
}
