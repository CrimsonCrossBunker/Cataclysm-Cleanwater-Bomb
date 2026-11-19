local ccb = require("ccb")

-- A rural holdout survivor that gave up on life
ccb.content.define_npc {
    id = "RURAL_HOLDOUT_NIHILIST",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor cowboy"),
    mission = "GUARD",
    chat = "TALK_COWBOYN_MAIN",
    faction = "no_faction",
}
