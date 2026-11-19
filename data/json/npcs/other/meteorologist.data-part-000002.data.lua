local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety",
    line = ccb.content.gendered_line("Help?  Help with what?  Oh, yes, yes.  If you know a place with many survivors, can you take me there?  I doubt I can survive alone…", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            next_topic = "TALK_DONE",
            actions = { "follow_only", actions.set_first_topic("TALK_meteorologist_safety_lead") },
        },
        { text = ccb.content.text("Want to travel with me?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_NONE",
        },
    },
}
