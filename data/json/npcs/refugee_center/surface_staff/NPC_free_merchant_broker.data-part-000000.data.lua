local ccb = require("ccb")

-- Appears in the refugee center as a bulk trader.  Promotes production of nonperishable food.
ccb.content.define_npc {
    id = "evac_broker",
    suffix = ccb.content.text("Broker"),
    class = "NC_TEAMSTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_FREE_MERCHANT_STOCKS",
    faction = "free_merchants",
    missions_offered = "MISSION_BROKER_1",
}
