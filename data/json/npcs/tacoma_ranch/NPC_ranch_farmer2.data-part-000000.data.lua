local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_farmer_2",
    suffix = ccb.content.text("Farmer"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_FARMER_2",
    faction = "tacoma_commune",
}
