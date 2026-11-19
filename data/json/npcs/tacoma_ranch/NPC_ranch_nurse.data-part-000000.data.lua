local ccb = require("ccb")

-- Mission source for clinic.  Provides medical attention.
ccb.content.define_npc {
    id = "ranch_nurse_1",
    suffix = ccb.content.text("Nurse"),
    gender = "female",
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_NURSE",
    missions_offered = "MISSION_RANCH_NURSE_1",
    faction = "tacoma_commune",
}
