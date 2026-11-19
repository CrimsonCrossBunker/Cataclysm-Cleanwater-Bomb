local ccb = require("ccb")

-- Appears in the refugee center as a guard with custom dialogue.
ccb.content.define_npc {
    id = "evac_guard2",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_EVAC_GUARD2",
    faction = "free_merchants",
}
