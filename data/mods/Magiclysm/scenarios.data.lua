local ccb = require("ccb")

ccb.content.define_scenario {
    id = "lost_faith",
    name = "Lost Faith",
    surround_groups = { { group = "GROUP_BLACK_ROAD", expected_points = 70.0 } },
    flags = { "LONE_START" },
    points = 2,
    description = "You've been preaching your faith for a long time, but the recent events have begun to make you doubt it.  Wandering in your temple, you just found books that may restore your faith or shatter it completely.",
    start_name = "Sanctuary",
    locations = { "sloc_church" },
    professions = { "priest", "shinto_priest", "imam", "rabbi", "guru", "preacher" },
}

ccb.content.define_scenario {
    id = "magic_basement",
    name = "The Wizard's Apprentice",
    flags = { "LONE_START" },
    points = 3,
    description = "You have been an apprentice to a wizard for some time now, working on a prototype device that could perhaps be used to escape from the Cataclysm.  Something went wrong with the maiden voyage though, and your teacher teleported his insides into his outsides.  Now you have to figure out how to survive on your own.  At least he left his notebook…",
    start_name = "Wizard's Secret Basement Study",
    locations = { "sloc_magic_basement" },
    professions = {
        "wizard_novice",
        "novice_necromancer",
        "novice_earthshaper",
        "novice_technomancer",
        "novice_stormshaper",
        "academy_wizard",
        "academy_wizard_stormshaper",
    },
}

ccb.content.define_scenario {
    id = "last_mage_on_earth_start",
    name = "Last Mage on Earth",
    flags = { "LONE_START" },
    points = 3,
    description = "When the chaos that led up to the Cataclysm began, your teacher told you about a secret hideout they had prepared in the event of a terrible disaster and suggested that you go wait there for a couple weeks to wait out the worst of the riots.  As it turned out, things got much worse than you imagined, and as the weeks turned into months and your teacher grew more and more agitated, they prepared a ritual that they hoped would turn back time and allow you to return to the weeks before the Cataclysm to warn the world.\n\nWhile waiting in the library for the ritual to conclude, you just heard a scream from the ritual room and some rustling elsewhere in the shelter.  You're not sure you're so safe here anymore…",
    start_name = "Last Mage On Earth shelter",
    locations = { "sloc_last_mage_on_earth" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 20, day = 60, season = "summer", year = 1 },
    professions = {
        "wizard_novice",
        "novice_necromancer",
        "novice_earthshaper",
        "novice_technomancer",
        "novice_stormshaper",
        "academy_wizard",
        "academy_wizard_stormshaper",
    },
}

ccb.content.define_scenario {
    id = "lake_retreat",
    name = "The Wizard's Vacation",
    flags = { "LONE_START" },
    points = 3,
    description = "You have been an apprentice to a wizard for some time now, you've saved for years for your dream vacation at a secluded wizard tower.  Your journey of self-discovery is interrupted by the Cataclysm.  Now you have to figure out how to survive on your own.",
    start_name = "Wizard's Retreat Vacation",
    locations = { "sloc_lake_retreat" },
    professions = {
        "wizard_novice",
        "novice_necromancer",
        "novice_earthshaper",
        "novice_technomancer",
        "novice_stormshaper",
        "academy_wizard",
        "academy_wizard_stormshaper",
    },
    reveal_locale = false,
}

ccb.content.define_scenario {
    id = "Exile",
    name = "Exile",
    flags = { "LONE_START" },
    points = 1,
    description = "You are an exile, whether because of people shunning you because of who you are or from a personal choice.  The dead aren't willing to leave you be.",
    start_name = "Exiled",
    locations = {
        "sloc_hermit_shack",
        "sloc_cabin",
        "sloc_lmoe",
        "sloc_lighthouse_ground",
        "sloc_lighthouse_small_ground",
        "sloc_cabin_lake",
    },
    professions = {
        "druid",
        "novice_necromancer",
        "ranger",
        "vengpreacher",
        "techno_prepper",
        "fleshmender",
        "moose_rider",
        "wild_druid",
        "archer_druid",
        "magic_grim_reaper",
        "academy_wizard",
        "academy_wizard_stormshaper",
    },
    reveal_locale = false,
}

ccb.content.define_scenario {
    copy_from = "alcatraz",
    extend = { professions = { "convict_arsonist", "convict_ecoterrorist", "storm_police" } },
    id = "alcatraz",
}

ccb.content.define_scenario {
    copy_from = "prisonbreak",
    extend = { professions = { "convict_arsonist", "convict_ecoterrorist", "storm_police" } },
    id = "prisonbreak",
}

ccb.content.define_scenario {
    copy_from = "overrun",
    extend = { professions = { "whitedeath_expy" } },
    id = "overrun",
}

ccb.content.define_scenario {
    copy_from = "heli_crash",
    extend = { professions = { "whitedeath_expy", "elven_ceremonial_guard" } },
    id = "heli_crash",
}

ccb.content.define_scenario {
    copy_from = "presort",
    extend = {
        professions = {
            "magic_vamp",
            "biomancer_musician",
            "magic_knifethrower",
            "freezing_dancer",
            "magic_maid",
        },
    },
    id = "presort",
}

ccb.content.define_scenario {
    copy_from = "Mansion",
    extend = {
        professions = { "magic_vamp", "biomancer_musician", "freezing_dancer", "magic_maid", "magic_burglar" },
    },
    id = "Mansion",
}

ccb.content.define_scenario {
    copy_from = "Mine_bottom",
    extend = { professions = { "magic_miner" } },
    id = "Mine_bottom",
}

ccb.content.define_scenario {
    copy_from = "portal_dependent",
    extend = { professions = { "dimensionalist" } },
    id = "portal_dependent",
}
