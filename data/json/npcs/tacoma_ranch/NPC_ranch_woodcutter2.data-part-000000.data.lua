local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_woodcutter_2",
    suffix = ccb.content.text("Woodworker"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_WOODCUTTER_2",
    faction = "tacoma_commune",
}
