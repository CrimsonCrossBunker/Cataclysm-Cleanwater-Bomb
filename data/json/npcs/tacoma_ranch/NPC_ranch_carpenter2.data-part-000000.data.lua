local ccb = require("ccb")

-- Construction skill trainer
ccb.content.define_npc {
    id = "ranch_construction_2",
    suffix = ccb.content.text("Carpenter"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_CONSTRUCTION_2",
    faction = "tacoma_commune",
}
