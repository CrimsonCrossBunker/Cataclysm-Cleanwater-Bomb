local ccb = require("ccb")

-- Can purchase wood
ccb.content.define_npc {
    id = "ranch_woodcutter_1",
    suffix = ccb.content.text("Lumberjack"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_WOODCUTTER",
    faction = "tacoma_commune",
}
