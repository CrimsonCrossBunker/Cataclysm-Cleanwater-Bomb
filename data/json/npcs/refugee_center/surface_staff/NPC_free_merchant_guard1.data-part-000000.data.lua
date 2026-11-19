local ccb = require("ccb")

-- Appears in the refugee center as a guard with custom dialogue.
ccb.content.define_npc {
    id = "evac_guard1",
    suffix = ccb.content.text("Guard"),
    class = "NC_FREE_MERCH_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_EVAC_GUARD1",
    missions_offered = "MISSION_EVAC_SMOKER_GET_CIGARETTES",
    faction = "free_merchants",
}
