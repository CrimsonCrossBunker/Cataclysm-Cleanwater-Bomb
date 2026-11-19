local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE2",
    line = ccb.content.text("*speaks in a quiet monotone, like he's reading off a page.  \"Barry and Carlos went to hunt down something that killed our livestock, they tracked it into the forest.  It grabbed Barry and ran off, you might be able to get Carlos to tell you the story, if he can bring himself to share what happened.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_CLAIRE",
    line = ccb.content.text("Yeah, I could use some help getting materials.  I want to outfit that old building across the road with some kilns.  We want to make our own jars and pottery so we aren't dependent on scavenging."),
    replies = {
        {
            text = ccb.content.text("That is a good idea, what do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
