local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "open_cryo_pod2",
    layout = {
        size = { width = 1, height = 1 },
        monster_group_placements = {
            {
                group = "GROUP_CRYO_LAB",
                x = { 0 },
                y = { 0 },
                density = 0.01,
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "open_cryo_pod1",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "cryo_hacker", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "open_cryo_pod3",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "cryo_doctor", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "open_cryo_pod4",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "cryo_scientist", x = 0, y = 0 } },
    },
}
