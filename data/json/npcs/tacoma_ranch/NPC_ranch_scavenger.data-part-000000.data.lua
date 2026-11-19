local ccb = require("ccb")

-- Mission source, shopkeep
ccb.content.define_npc {
    id = "ranch_scavenger_1",
    suffix = ccb.content.text("Scavenger Boss"),
    class = "NC_JUNK_SHOPKEEP",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_RANCH_SCAVENGER_1",
    missions_offered = "MISSION_RANCH_SCAVENGER_1",
    faction = "tacoma_commune",
}
