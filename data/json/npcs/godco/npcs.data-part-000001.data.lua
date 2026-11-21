local ccb = require("ccb")

ccb.content.define_npc {
    id = "FM_caravan_merchant_godco_predatory",
    suffix = ccb.content.text("merchant"),
    class = "NC_TRADER_PREDATORY",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_CARAVAN_MERCHANT_PREDATORY_1",
    faction = "free_merchants",
    on_death = "godco_trader_mission_deathfail",
}
