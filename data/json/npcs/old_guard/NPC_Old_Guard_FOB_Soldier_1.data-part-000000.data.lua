local ccb = require("ccb")

-- Generic guard for the old guard.
ccb.content.define_npc {
    id = "old_guard_fob_soldier",
    suffix = ccb.content.text("Soldier"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_OLD_GUARD_FOB_SOLDIER",
    faction = "old_guard",
}

-- EOC-specific, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "old_guard_assassin",
    suffix = ccb.content.text("Soldier"),
    class = "NC_SOLDIER",
    attitude = 10,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "old_guard",
}
