local ccb = require("ccb")

-- A generic guard for port augustmoon.
ccb.content.define_npc {
    id = "augustmoon_security",
    suffix = ccb.content.text("Augustmoon Security"),
    class = "NC_UICA_NAVAL_POLICE",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_AUGUSTMOON_SECURITY",
    faction = "UICA",
}
