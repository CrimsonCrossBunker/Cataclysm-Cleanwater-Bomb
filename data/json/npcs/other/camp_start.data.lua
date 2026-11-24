local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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

ccb.content.define_dialogue_topic {
    id = "TALK_FACTION_CAMP_START",
    line = ccb.content.gendered_line("Hey, I did some surveying and I believe this is a good spot to set up at.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Let's stay here, then.  I trust your decisions."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0a469b3f65f6"),
            actions = { "start_camp", "follow" },
        },
    },
}
