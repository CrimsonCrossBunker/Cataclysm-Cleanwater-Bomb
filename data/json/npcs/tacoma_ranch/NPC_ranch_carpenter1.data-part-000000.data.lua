local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_construction_1",
    suffix = ccb.content.text("Carpenter"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_CONSTRUCTION_1",
    faction = "tacoma_commune",
}
