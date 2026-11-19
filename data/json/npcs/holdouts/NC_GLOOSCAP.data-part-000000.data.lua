local ccb = require("ccb")

-- Hunter with indigenous ancestry and big ideas.
ccb.content.define_npc {
    id = "ABENAKI_Glooscap",
    unique_name = ccb.content.text("Glooscap"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GLOOSCAP",
    faction = "no_faction",
}
