local ccb = require("ccb")

ccb.content.define_npc {
    id = "old_guard_rep",
    suffix = ccb.content.text("Representative"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_REP",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_REP_1",
}
