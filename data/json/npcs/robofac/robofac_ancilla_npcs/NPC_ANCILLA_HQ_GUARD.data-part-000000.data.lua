local ccb = require("ccb")

-- Generic Mercenary Guard for the ancilla hq.
ccb.content.define_npc {
    id = "ancilla_hq_guard",
    suffix = ccb.content.text("mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_ANCILLA_HQ_GUARD",
    faction = "robofac_auxiliaries",
}
