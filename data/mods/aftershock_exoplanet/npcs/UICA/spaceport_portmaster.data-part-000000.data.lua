local ccb = require("ccb")

ccb.content.define_npc {
    id = "spaceport_portmaster",
    class = "NC_AUGUSTMOON_shipping_chief",
    attitude = 0,
    mission = "SHOPKEEP",
    suffix = ccb.content.text("Portmaster"),
    chat = "TALK_SPACEPORT_PORTMASTER",
    faction = "UICA",
}
