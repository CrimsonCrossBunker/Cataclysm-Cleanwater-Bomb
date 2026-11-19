local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_5_IDEAS1",
    line = ccb.content.text("Okay listen.  Don't believe the lies.  There's a common thread to all of it: the riots, the violent goons failing to contain it, even the giant monsters they said were appearing in the last few days and had to be wiped out with fire."),
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
    line = ccb.content.text("This isn't happening, we're in a dream.  To keep us locked in here, the evil creators of the dream have to make sure we're just the right level of miserable while they slowly eat us.  I think their algorithms got messed up though, and went into overdrive, because all this is a little implausible.  Still, I guess we're still in the dream, so maybe it's working."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
