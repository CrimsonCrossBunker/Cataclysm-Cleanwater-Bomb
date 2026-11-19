local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT_NO",
    line = ccb.content.text("I really appreciate everything you've done for me, but I don't think you get it.  I can't go out there.  I will die.  I know it's horrible camping out here, but I just can't face that nightmare again."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I hope you'll reconsider eventually.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT2",
    line = ccb.content.gendered_line("Well… you have shown that you can survive out there, and you've been able to provide food, so I know you're thriving more than we are here.  All right, I'll tell you what.  I'm not going anywhere without my friends here, we've been through way too much together.  If you can convince Luo, Brandon, and Yusuke to come along, then I'll go.", { "speaker" }),
    replies = {
        { text = ccb.content.text("OK.  <done_conversation_section>"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("OK, I'll talk to them too."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUITED",
    line = ccb.content.gendered_line("Well… you have shown that you can survive out there, and you've been able to provide food, so I know you're thriving more than we are here.  All right, I'll tell you what.  I'm not going anywhere without my friends here, we've been through way too much together.  If you can convince Luo, Brandon, and Yusuke to come along, then I'll go.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("All right!  <lets_go>"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
