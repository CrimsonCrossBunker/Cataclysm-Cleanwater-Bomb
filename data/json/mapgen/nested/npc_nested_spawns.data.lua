local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "NPC_lighthouse_man_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "NPC_lighthouse_man", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "NPC_meteorologist_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "NPC_meteorologist", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_start_add",
    layout = {
        nested = { { id = "4x4_planksandtools", x = { 3 }, y = { 3 } } },
        faction_areas = { { id = "your_followers", x = { 1, 23 }, y = { 1, 23 } } },
        npc_placements = {
            { id = "your_follower_base_setup", x = 10, y = 10 },
            { id = "your_follower", x = 1, y = 5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "scenario_spawn_liam",
    layout = {
        faction_areas = { { id = "your_followers", x = { 1, 23 }, y = { 1, 23 } } },
        npc_placements = { { id = "starting_follower_liam", x = 17, y = 13 } },
    },
}
