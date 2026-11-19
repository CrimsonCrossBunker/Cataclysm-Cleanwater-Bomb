local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_parents_where",
    line = ccb.content.text("I don't know.  They were going to a contract deal before the riots broke out, at one of military bases I think.  I don't know what happened to them from there."),
    replies = {
        {
            text = ccb.content.text("I'll let you know if anything turns up."),
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
        {
            text = ccb.content.text("I'll let you know if anything turns up.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_knife",
    line = ccb.content.text("Aren't you a bit too old not to realize how dangerous the world is for a kid like me?  I know how to handle one without hurting myself!  My dad taught me everything, he's a real pro."),
    replies = { { text = ccb.content.text("That makes sense."), next_topic = "TALK_GODCO_chloe_idle_chat" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_loss",
    line = ccb.content.text("They're not dead."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_nochat",
    line = ccb.content.text("I don't wanna talk about it right now."),
    replies = {
        {
            text = ccb.content.text("Alright, let's change the subject."),
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_angry",
    line = ccb.content.text("I said to get lost, <name_b>!  I can't believe you really think everything's alright, after all the shit you've done."),
    replies = { { text = ccb.content.text("Alright <name_b>, I'll leave."), next_topic = "TALK_DONE" } },
}
