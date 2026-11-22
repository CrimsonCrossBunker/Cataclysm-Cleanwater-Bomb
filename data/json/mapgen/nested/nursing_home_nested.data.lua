local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nursing_home_receptionist",
    layout = {
        size = { width = 1, height = 1 },
        computer_placements = {
            {
                x = 0,
                y = 0,
                name = "Shady Hills: Receptionist",
                chat_topics = { "COMP_NURSING_HOME_RECEPTIONIST" },
                dialogue_on_access = true,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nursing_home_recep_manager",
    layout = {
        size = { width = 1, height = 1 },
        computer_placements = {
            {
                x = 0,
                y = 0,
                name = "Shady Hills: Reception Manager",
                chat_topics = { "COMP_NURSING_HOME_RECEP_MANAGER" },
                dialogue_on_access = true,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nursing_home_coo",
    layout = {
        size = { width = 1, height = 1 },
        computer_placements = {
            {
                x = 0,
                y = 0,
                name = "Shady Hills: SVP Operations",
                chat_topics = { "COMP_NURSING_HOME_COO" },
                dialogue_on_access = true,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nursing_home_sci",
    layout = {
        size = { width = 1, height = 1 },
        computer_placements = {
            {
                x = 0,
                y = 0,
                name = "Shady Hills: Research & Development",
                chat_topics = { "COMP_NURSING_HOME_SCI" },
                dialogue_on_access = true,
            },
        },
    },
}
