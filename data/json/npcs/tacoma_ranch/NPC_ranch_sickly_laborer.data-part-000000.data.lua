local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_ill_1",
    suffix = ccb.content.text("Laborer"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_ILL_1",
    faction = "tacoma_commune",
}
