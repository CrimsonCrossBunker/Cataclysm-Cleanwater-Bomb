local ccb = require("ccb")

-- A rural holdout survivor completely unwilling to talk
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_HOSTILE",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "NULL",
    chat = "TALK_COWBOYHO_MAIN",
    faction = "no_faction",
}
