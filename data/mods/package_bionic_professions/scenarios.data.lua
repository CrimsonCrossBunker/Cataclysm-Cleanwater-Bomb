local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "alone",
    id = "alone",
    extend = { professions = { "bionic_prepper" } },
}

ccb.content.define_scenario {
    copy_from = "fungal_start",
    id = "fungal_start",
    blacklist_professions = true,
    extend = { professions = { "bionic_patient" } },
}

ccb.content.define_scenario {
    copy_from = "heli_crash",
    id = "heli_crash",
    extend = { professions = { "bio_soldier", "bio_sniper", "bionic_spy" } },
}

ccb.content.define_scenario {
    copy_from = "Mine_bottom",
    id = "Mine_bottom",
    extend = { professions = { "bionic_worker", "drone_op" } },
}

ccb.content.define_scenario {
    copy_from = "mutant",
    id = "mutant",
    extend = { professions = { "broken_cyborg", "faulty_bionic", "cykotic" } },
}

ccb.content.define_scenario {
    copy_from = "overrun",
    id = "overrun",
    extend = { professions = { "bio_soldier", "bio_sniper" } },
}

ccb.content.define_scenario {
    copy_from = "patient",
    id = "patient",
    extend = { professions = { "bionic_patient", "broken_cyborg" } },
}

ccb.content.define_scenario {
    copy_from = "presort",
    id = "presort",
    extend = { professions = { "bio_gangster" } },
}

ccb.content.define_scenario {
    id = "cyberpunk",
    name = "High Tech, Low Life",
    description = "Before the world ended, bionics were reserved for the rich and the famous.  You might not have been either, but you wanted in.  Hidden offices sequestered away in basements, anesthetic smuggled out of hospitals, and desperate people with little to lose could get you what you wanted.  If you went too deep, however, your augmentation may have come at a price…",
    flags = { "CITY_START", "LONE_START" },
    points = 2,
    start_name = "Shady Basement",
    locations = { "sloc_basement_bionic" },
    professions = { "cyberjunkie", "faulty_bionic", "cykotic", "razorgirl", "bionic_installer" },
}
