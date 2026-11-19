local ccb = require("ccb")

-- Generic random survivor related to lighthouse family
ccb.content.define_npc {
    id = "NPC_survivor_lighthouse",
    class = "NC_NONE",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_LIGHTHOUSE_SURVIVOR",
    faction = "fisherman_family",
}
