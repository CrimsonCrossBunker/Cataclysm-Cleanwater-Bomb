local ccb = require("ccb")

-- A rural holdout survivor trying to stay safe
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_FRIENDLY",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYFR_MAIN",
    faction = "no_faction",
}
