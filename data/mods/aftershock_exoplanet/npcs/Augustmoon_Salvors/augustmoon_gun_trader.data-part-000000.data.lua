local ccb = require("ccb")

ccb.content.define_npc {
    id = "augustmoon_gun_trader",
    suffix = ccb.content.text("gun trader"),
    class = "NC_AUGUSTMOON_GUNTRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_GUNTRADER",
    faction = "UICA",
}
