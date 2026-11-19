local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_2_IDEAS1",
    line = ccb.content.text("Well, I assume you know about the riots and the freakin' nightmare monsters walking the earth beside zombies, right?  If you're asking what I think caused it all, well, I dunno.  My best guess it was some huge  overreach, maybe some kind of experimental weapon that got away.  They tried to lie so much at the start about everything that was going on, I don't think any of it measures up.  They were trying to cover something up.  As for the real end times, maybe the rest of the world tried to contain it.  I heard about all kinds of wild stuff.  To me that seems like somewhere else trying to get whatever is going on here contained.  Maybe it even worked.  It's bad now but it's not like it was."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
