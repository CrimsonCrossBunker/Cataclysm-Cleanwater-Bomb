local ccb = require("ccb")

-- Mission source, shopkeep
ccb.content.define_npc {
    id = "ranch_bartender",
    suffix = ccb.content.text("Bartender"),
    class = "NC_BARTENDER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_RANCH_BARKEEP",
    missions_offered = "MISSION_RANCH_BARTENDER_1",
    faction = "tacoma_commune",
}
