local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_lighthouse_girl",
    unique_name = ccb.content.text("Angelina Frolova"),
    gender = "female",
    class = "NC_NONE",
    attitude = 1,
    mission = "GUARD_PATROL",
    chat = "TALK_lighthouse_girl_start",
    faction = "fisherman_family",
}
