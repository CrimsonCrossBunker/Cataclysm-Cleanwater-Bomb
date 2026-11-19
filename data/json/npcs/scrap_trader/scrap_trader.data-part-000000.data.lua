local ccb = require("ccb")

ccb.content.define_npc {
    id = "NPC_scrap_trader",
    class = "SCRAP_MERCHANT",
    gender = "male",
    suffix = ccb.content.text("scrapper"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_SCRAP_TRADER",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_SCRAP_TRADER_GET_25_MAGNETRON",
}
