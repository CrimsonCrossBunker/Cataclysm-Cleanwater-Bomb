local ccb = require("ccb")

-- Commander in Necropolis
ccb.content.define_npc {
    id = "old_guard_necropolis_cpt",
    suffix = ccb.content.text("CPT"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_NEC_CPT",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_NEC_1",
}
