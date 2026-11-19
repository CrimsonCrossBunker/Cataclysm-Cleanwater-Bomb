local ccb = require("ccb")

-- Generic guard for the dinomod variant of the old guard.
ccb.content.define_npc {
    id = "old_guard_red_soldier",
    suffix = ccb.content.text("Soldier"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_RED_SOLDIER",
    faction = "old_guard",
}
