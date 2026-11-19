local ccb = require("ccb")

-- A generic commanding officer for UICA ground installations.
ccb.content.define_npc {
    id = "uica_ground_officer",
    suffix = ccb.content.text("UICA Officer"),
    class = "NC_UICA_GROUND_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_OFFICER",
    faction = "UICA",
}
