local ccb = require("ccb")

ccb.content.define_npc {
    id = "bunker_merchant",
    suffix = ccb.content.text("Merchant"),
    class = "NC_BUNKER_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_BUNKER_MERCHANT",
    faction = "wasteland_scavengers",
}
