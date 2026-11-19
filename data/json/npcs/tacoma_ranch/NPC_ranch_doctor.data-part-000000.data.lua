local ccb = require("ccb")

-- Provides advanced medical attention.
ccb.content.define_npc {
    id = "ranch_doctor",
    suffix = ccb.content.text("Doctor"),
    class = "NC_DOCTOR",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_DOCTOR",
    faction = "tacoma_commune",
}
