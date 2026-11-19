local ccb = require("ccb")

-- A rural holdout survivor willing to trade items
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_TRADER",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYT_MAIN",
    missions_offered = "MISSION_COWBOYT_SHOTGUN",
    faction = "no_faction",
}
