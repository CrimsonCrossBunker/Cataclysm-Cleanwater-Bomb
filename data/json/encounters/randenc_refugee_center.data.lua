local ccb = require("ccb")

-- Adds a random NPC to the refugee center, placed somewhere it won't intersect with beggars or other random NPCs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_RC_Shoppers_add",
    layout = {
        npc_placements = { { id = "RC_survivor_visiting", x = 20, y = 23 } },
    },
}

-- Adds a random NPC to the refugee center, placed somewhere it won't intersect with beggars or other random NPCs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_RC_Shoppers_remove",
    layout = {
        npc_removals = { { id = "RC_survivor_visiting", x = 0, y = 0 } },
    },
}

-- Adds a random NPC to the refugee center, placed somewhere it won't intersect with beggars or other random NPCs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_RC_JohnBailey_add",
    layout = {
        npc_placements = { { id = "RC_John_Bailey_visiting", x = 19, y = 21, unique_id = "John_Bailey" } },
    },
}

-- Adds a random NPC to the refugee center, placed somewhere it won't intersect with beggars or other random NPCs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_RC_JohnBailey_remove",
    layout = {
        npc_removals = { { id = "RC_John_Bailey_visiting", x = 0, y = 0, unique_id = "John_Bailey" } },
    },
}
