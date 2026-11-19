local ccb = require("ccb")

-- A generic guard for the Free Merchants faction.
ccb.content.define_npc {
    id = "guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GUARD",
    faction = "free_merchants",
}

-- Night shift guard for the Free Merchants faction.
ccb.content.define_npc {
    id = "night_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD_NIGHT",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GUARD",
    faction = "free_merchants",
}
