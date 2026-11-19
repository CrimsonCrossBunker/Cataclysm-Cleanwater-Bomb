local ccb = require("ccb")

-- Someone helps you test the game.
ccb.content.define_npc {
    id = "NPC_debug",
    suffix = ccb.content.text("Debug"),
    class = "NC_NONE",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "no_faction",
    on_death = "prevent_debug_npc_death",
}
