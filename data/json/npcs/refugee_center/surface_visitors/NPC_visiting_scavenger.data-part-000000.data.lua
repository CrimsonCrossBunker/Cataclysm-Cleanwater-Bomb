local ccb = require("ccb")

-- A random scavenger visiting the refugee center to check it out, just like you.
ccb.content.define_npc {
    id = "RC_survivor_visiting",
    suffix = ccb.content.text("Survivor"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_RC_SURVIVOR_1",
    faction = "no_faction",
}
