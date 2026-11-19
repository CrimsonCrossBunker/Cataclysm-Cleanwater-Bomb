local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_pizzaiolo",
    gender = "male",
    class = "NC_SURVIVOR_CHEF",
    suffix = ccb.content.text("pizzaiolo"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_pizzaiolo_1",
    faction = "no_faction",
    missions_offered = "MISSION_pizzaiolo_1",
}
