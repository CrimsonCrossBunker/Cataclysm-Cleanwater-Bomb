local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
