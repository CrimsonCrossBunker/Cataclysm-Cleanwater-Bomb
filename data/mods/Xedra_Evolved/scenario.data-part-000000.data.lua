local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "heli_crash",
    extend = {
        professions = {
            "zebra_investigator",
            "spy",
            "fbi_investigator",
            "xe_jotunn_hunter",
            "xe_troll_slayer",
            "xe_specter",
            "xe_offworld_cyborg",
            "xe_eater",
            "xe_dreamer",
            "xe_inventor",
            "xe_dreamsmith",
            "xe_hedge_mage_magic_squares",
        },
    },
    id = "heli_crash",
}
