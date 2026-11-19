local ccb = require("ccb")

-- Appears in the refugee center as a trader.
ccb.content.define_npc {
    id = "scavenger_hunter",
    suffix = ccb.content.text("Hunter"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_EVAC_HUNTER",
    faction = "no_faction",
}
