local ccb = require("ccb")

-- Provides hair cuts
ccb.content.define_npc {
    id = "ranch_barber",
    suffix = ccb.content.text("Barber"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_BARBER",
    faction = "tacoma_commune",
}
