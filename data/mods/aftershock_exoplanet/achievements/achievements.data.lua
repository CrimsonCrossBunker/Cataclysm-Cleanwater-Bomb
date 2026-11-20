local ccb = require("ccb")

ccb.content.define_achievement {
    id = "afs_alien_dawn",
    name = ccb.content.text("Alien Dawn"),
    description = ccb.content.text("At night, both water and carbon dioxide freeze in the upper atmosphere, such that every dawn is accompanied by a procession of colorful haloes over the horizon.\n<color_c_dark_gray>  - Salus IV rediscovery report 02.11.2428, submitted by Cpt.  Jean McAllister."),
    time_limit = { since = "game_start", comparison = ">=", duration = "1 day" },
    requirements = {
        {
            statistic = "num_avatar_wake_ups",
            comparison = "anything",
            description = ccb.content.text("Wake up after a night on Salus IV."),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_discontinuity_weapon",
    name = ccb.content.text("A civilized Age"),
    description = ccb.content.text("Mostly, it makes me feel very small, like when I was a kid playing with my father's tools.\n<color_c_dark_gray>  - \"Life in the Tenellus Frontier\", interview with mercenary captain, c2514."),
    requirements = {
        {
            statistic = "num_avatar_wields_archeotech_gun",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Wield a weapon from the Late Hyperspace Age."),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_plasma_weapon",
    name = ccb.content.text("Sunfire"),
    description = ccb.content.text("Now just watch this!  [STATIC]\n<color_c_dark_gray>  - unattributed comms chatter from raid on UFS Golden Sunray."),
    requirements = {
        {
            statistic = "num_avatar_wields_plasma_gun",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Obtain a plasma weapon"),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_kill_100_uica_soldiers",
    name = ccb.content.text("Disposition Matrix"),
    description = ccb.content.text("It is a necessary part of what we do.  We won't wake up in 10 years time and magically find a galaxy full of friends and 'welcome back' signs.\n<color_c_dark_gray> - unknown member of Chancellor's Haaland administration, recorded c2392."),
    requirements = {
        {
            statistic = "num_avatar_uica_soldier_kills",
            comparison = ">=",
            target = 10,
            description = ccb.content.text("Eliminate 10 UICA soldiers."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_kill_independent_merc",
    name = ccb.content.text("Rules of Engagement"),
    description = ccb.content.text("Frei en lefdet.\n<color_c_dark_gray>  - common saying between mercenaries."),
    requirements = {
        {
            statistic = "num_avatar_independent_merc_kills",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Eliminate another mercenary."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_crashed_spaceship",
    name = ccb.content.text("Falling Star"),
    description = ccb.content.text("Planet crosses into a giant scrapfield every few months, some old battlefield from when the discontinuity happened.  Locals make a great show of it, marks the start of the great hunt.\n<color_c_dark_gray>  -\"The Highlands of Aztlan\" holodoc"),
    requirements = {
        {
            statistic = "num_avatar_enters_crashed_ship",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Visit a crashed spaceship."),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_ruins",
    name = ccb.content.text("Boneyards"),
    description = ccb.content.text("We had those at home too, on summer days we'd chase frogs through the pipes and into the coolant chambers deep below them.  I remember the em-lights still glittering in the immense halls, it was like a secret night sky sealed away.\n<color_c_dark_gray>  - overheard in Port Augustmoon."),
    requirements = {
        {
            statistic = "num_avatar_enters_ruins",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Visit a ruin"),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_many_ruins",
    name = ccb.content.text("Ruins of Orion"),
    description = ccb.content.text("I try not to think about what it actually means, none of us do really.  Otherwise it would drive us mad with grief.  [Laughs] Still drives some mad though, I guess.\n<color_c_dark_gray>  - \"Life in the Tenellus Frontier\", interview with salvor guild journeyman, c2514."),
    requirements = {
        {
            statistic = "num_avatar_enters_ruins",
            comparison = ">=",
            target = 50,
            description = ccb.content.text("Visit many ruins."),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_discontinous",
    name = ccb.content.text("Discontinous"),
    description = ccb.content.text("[ ERROR: Outside Hypernet Range ]"),
    requirements = {
        {
            statistic = "avatar_max_damage",
            comparison = ">=",
            target = 2500,
            description = ccb.content.text("Receive 2500 damage in a single attack and survive (optional)."),
        },
    },
}

ccb.content.define_achievement {
    id = "afs_achievement_chimera",
    name = ccb.content.text("Chimera"),
    description = ccb.content.text("Unexplained, instinctual urges might rarely manifest after bio-modification.  In such cases we recommend the following self-centering techniques…\n<color_c_dark_gray>  - Aftercare brochure, Mercurial Genomics ltd."),
    requirements = {
        {
            statistic = "num_crosses_mutation_threshold",
            comparison = ">=",
            target = 1,
            description = ccb.content.text("Cross a threshold using genetech templates."),
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_psion",
    name = ccb.content.text("The New Sun"),
    description = ccb.content.text("There were among our men those who asked whether it was all not a dream.  How else could one explain the glimpse of things never heard of, never seen, and never even conceived of before.\n<color_c_dark_gray>  - recovered from the log of ESS Firebird."),
    requirements = {
        {
            statistic = "avatar_last_gains_mutation",
            comparison = "==",
            target = { type = "trait_id", value = "ESPER" },
            description = ccb.content.text("Gain psionic powers."),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_kill_moxie",
    name = ccb.content.text("Breaking the Ice"),
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_moxies",
    name = ccb.content.text("Salus IV Antivirus"),
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_moxies",
    name = ccb.content.text("Ned Ludd"),
    hidden_by = { "achievement_kill_10_moxies" },
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_moxies",
    name = ccb.content.text("KILL ALL MOXIES"),
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_moxies",
    name = ccb.content.text("Heat Ray"),
    hidden_by = { "achievement_kill_1000_moxies" },
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_moxies",
    name = ccb.content.text("Eradication is the Only Option"),
    hidden_by = { "achievement_kill_10000_moxies" },
    requirements = { { statistic = "num_avatar_moxie_kills", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_uplift",
    name = ccb.content.text("I killed Mufasa!"),
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_uplifts",
    name = ccb.content.text("The Food of the Gods"),
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_uplifts",
    name = ccb.content.text("Escape from the Island of Dr. Moreau"),
    hidden_by = { "achievement_kill_10_uplifts" },
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_uplifts",
    name = ccb.content.text("Infinity's Shore"),
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_uplifts",
    name = ccb.content.text("Blade Runner 2539"),
    hidden_by = { "achievement_kill_1000_uplifts" },
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_uplifts",
    name = ccb.content.text("Extinction level event"),
    hidden_by = { "achievement_kill_10000_uplifts" },
    requirements = { { statistic = "num_avatar_uplift_kills", comparison = ">=", target = 100000 } },
}
