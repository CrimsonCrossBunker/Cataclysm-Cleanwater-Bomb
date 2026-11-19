local ccb = require("ccb")

-- A generic hostile guard for the Free Merchants faction.  For where the player shouldn't venture.'
ccb.content.define_npc {
    id = "hostile_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 10,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "free_merchants",
}
