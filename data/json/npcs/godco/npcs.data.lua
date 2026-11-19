local ccb = require("ccb")

ccb.content.define_npc {
    id = "FM_caravan_guard_predatory",
    suffix = ccb.content.text("guard"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_GUARD_PREDATORY",
    faction = "free_merchants",
}
