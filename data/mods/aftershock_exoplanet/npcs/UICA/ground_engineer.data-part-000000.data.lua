local ccb = require("ccb")

-- A generic commanding officer for UICA ground installations.
ccb.content.define_npc {
    id = "uica_ground_engineer",
    suffix = ccb.content.text("UICA Engineer"),
    class = "NC_UICA_GROUND_ENGINEER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_ENGINEER",
    faction = "UICA",
}
