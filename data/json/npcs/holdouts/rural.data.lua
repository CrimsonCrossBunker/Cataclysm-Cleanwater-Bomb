local ccb = require("ccb")

-- A rural holdout survivor living in a barn or a forest or something, all by themselves.  At some point this NPC should get special dialogue.
ccb.content.define_npc {
    id = "rural_holdout_solo",
    class = "NC_COWBOY",
    attitude = 0,
    suffix = ccb.content.text("Survivor"),
    mission = "GUARD",
    chat = "TALK_STRANGER_NEUTRAL",
    faction = "no_faction",
}
