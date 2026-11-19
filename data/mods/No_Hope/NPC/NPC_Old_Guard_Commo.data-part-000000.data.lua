local ccb = require("ccb")

-- In charge of outside communications in Necropolis
ccb.content.define_npc {
    id = "old_guard_necropolis_commo",
    suffix = ccb.content.text("SFC"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_NEC_COMMO",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_NEC_COMMO_1",
}
