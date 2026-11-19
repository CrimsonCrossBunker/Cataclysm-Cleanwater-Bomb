local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_scrapper_1",
    suffix = ccb.content.text("Scrapper"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_SCRAPPER",
    faction = "tacoma_commune",
}
