local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_ACCUSE",
    line = ccb.content.gendered_line("If I were Malsumis you would be in terrible danger my friend.  But Glooscap would stop me.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Fight me Malsumis!"),
            native_actions = { "insult_combat" },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[SKILLED LIAR] Then you're definitely not Malsumis and everything is cool.  So Malsumis wants to kill everybody right?  I guess they're feeling pretty great right now huh?"),
            next_topic = "TALK_GLOOSCAP_MYTH_KILL_EVERYBODY",
            when = predicates.has_trait("speaker", "SKILLED LIAR"),
        },
        {
            text = ccb.content.text("Haha, good one Glooscap.  So funny.  Love that.  Let's move on."),
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("This is awkward.  I need to leave."), next_topic = "TALK_DONE" },
    },
}
