local ccb = require("ccb")

-- A generic guard for uica ground installations.
ccb.content.define_npc {
    id = "uica_ground_soldier",
    suffix = ccb.content.text("UICA Installation Security"),
    class = "NC_UICA_GROUND_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_UICA_GROUND_SOLDIER",
    faction = "UICA",
}
