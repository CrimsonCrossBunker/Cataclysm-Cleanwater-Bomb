local ccb = require("ccb")

-- Scenario specific, should not spawn outside of trigger events.  Workaround to start a faction camp
ccb.content.define_npc {
    id = "your_follower_base_setup",
    class = "NC_BOUNTY_HUNTER",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_FACTION_CAMP_START",
    faction = "no_faction",
}

-- Scenario specific, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "your_follower",
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "your_followers",
}
