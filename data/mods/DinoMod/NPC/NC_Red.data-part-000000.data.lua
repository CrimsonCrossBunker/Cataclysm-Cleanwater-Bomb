local ccb = require("ccb")

ccb.content.define_npc {
    id = "old_guard_red",
    unique_name = ccb.content.text("Red", "NPC Name"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_OLD_GUARD_RED",
    faction = "old_guard",
    missions_offered = { "MISSION_OLD_GUARD_DINO_1" },
}
