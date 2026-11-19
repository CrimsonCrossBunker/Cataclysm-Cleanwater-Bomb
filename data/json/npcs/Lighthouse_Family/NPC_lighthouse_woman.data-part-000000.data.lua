local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_lighthouse_woman",
    unique_name = ccb.content.text("Heather Frolova"),
    gender = "female",
    class = "NC_NONE",
    attitude = 1,
    mission = "GUARD_PATROL",
    chat = "TALK_lighthouse_woman_start",
    faction = "fisherman_family",
}
