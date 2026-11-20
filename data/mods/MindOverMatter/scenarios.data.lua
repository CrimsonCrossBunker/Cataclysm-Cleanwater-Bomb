local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "heli_crash",
    extend = { professions = { "psi_telekinetic_testsubject", "psi_telepath_interrogater" } },
    id = "heli_crash",
}

ccb.content.define_scenario {
    copy_from = "portal_dependent",
    extend = { professions = { "psi_new_psychic", "psi_telekinetic_testsubject", "psi_teleporter_slider" } },
    id = "portal_dependent",
}

ccb.content.define_scenario {
    id = "hunted_forever_start",
    copy_from = "hunted_forever_start",
    name = "Challenge - Mindhunter",
    points = -10,
    forced_traits = { "HAS_NEMESIS" },
    description = "Since the start of the Cataclysm, something has been hunting you relentlessly.  You can try to fight it, but each time it falls it will rise again, its powers growing stronger and stronger.  The only escape is for you to die.",
}
