local ccb = require("ccb")

ccb.content.define_npc {
    id = "augustmoon_outfitter",
    suffix = ccb.content.text("outfitter clerk"),
    class = "NC_AUGUSTMOON_OUTFITTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_OUTFITTER",
    faction = "UICA",
}
