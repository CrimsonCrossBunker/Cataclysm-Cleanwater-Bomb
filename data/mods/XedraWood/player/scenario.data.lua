local ccb = require("ccb")

ccb.content.define_scenario {
    id = "evacuee",
    copy_from = "evacuee",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
        },
    },
}

ccb.content.define_scenario {
    id = "cave_lonesome",
    copy_from = "cave_lonesome",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "infected",
    copy_from = "infected",
    extend = {
        professions = { "tribal_warrior_expert", "wise_one_apprentice", "pattern_tattoo_mountain_prof" },
    },
}

ccb.content.define_scenario {
    id = "hunted_start",
    copy_from = "hunted_start",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "fungal_start",
    copy_from = "fungal_start",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
        },
    },
}

ccb.content.define_scenario {
    id = "bordered",
    copy_from = "bordered",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "ambushed",
    copy_from = "ambushed",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "summer_advanced_start",
    copy_from = "summer_advanced_start",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "wilderness",
    copy_from = "wilderness",
    extend = {
        professions = {
            "tribal_warrior_expert",
            "lizardfolk_warrior",
            "lizardfolk_hunter",
            "wise_one_apprentice",
            "pattern_tattoo_mountain_prof",
        },
    },
}

ccb.content.define_scenario {
    id = "xedrawood_wise_one_start",
    name = "Path of the Wise",
    description = "You demonstrated a connection with the unseen world from a young age, and a passing member of the Wise take an interest in you when they visited your people.  They took you with them to train as an apprentice, initiating you into the mysteries, and you studied with an eager mind.  Now you'll need to find your own way.",
    points = 8,
    start_name = "Remote dwelling",
    locations = { "sloc_wise_one_hut" },
    professions = { "wise_one_apprentice", "wise_one_forest" },
    reveal_locale = false,
    flags = { "LONE_START" },
}
