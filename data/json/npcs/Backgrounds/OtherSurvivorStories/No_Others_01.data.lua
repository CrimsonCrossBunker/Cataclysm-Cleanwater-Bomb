local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BOSS_No_Others_01_Story1",
    line = ccb.content.gendered_line("Sorry, but until I met you, I thought I might be the only one left.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Oh well.  Let's hope we find others."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
