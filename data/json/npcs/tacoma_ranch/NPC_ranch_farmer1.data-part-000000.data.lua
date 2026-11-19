local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_farmer_1",
    suffix = ccb.content.text("Farmer"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_FARMER_1",
    faction = "tacoma_commune",
}
