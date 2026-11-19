local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_5_WASPS",
    line = ccb.content.gendered_line("Well, excuse me if I didn't stop to fucking ask what kind of killer bugs they were.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Sorry.  Could you tell me more about them?"),
            next_topic = "BGSS_EVACUEE_5_BEES",
        },
        { text = ccb.content.text("Right.  Sorry."), next_topic = "TALK_FRIEND_CONVERSATION" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_5_IDEAS1",
    line = ccb.content.text("Okay listen.  Don't believe that government stuff.  There's a common thread to all of it: the riots, the military failing to contain it, even the giant monsters they said were appearing in the last few days and had to be wiped out with nukes."),
    replies = {
        { text = ccb.content.text("You've got my attention."), next_topic = "CWH_EVACUEE_5_IDEAS2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_5_IDEAS2",
    line = ccb.content.gendered_line("You ever see the Matrix?  This is it.  In real life.  To keep us locked in here, the creators of the simulation have to make sure we're just the right level of miserable.  I think their algorithms got messed up though, and went into overdrive, because all this is a little implausible.  Still, I guess we're still jacked in, so maybe it's working.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
