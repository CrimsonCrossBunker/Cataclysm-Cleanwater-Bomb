local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "BEM_DRUGRUNNER_1" },
    line = ccb.content.gendered_line("&This visitor seems way more watchful than normal.  You notice zip bags peeking out from <mypossesivepronoun> overcoat, they are clearly pushing something.  It doesn't take much longer for them to notice you in kind.\n\"You want something?  Or just gawking?\"", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sure, let see what you offer."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}
