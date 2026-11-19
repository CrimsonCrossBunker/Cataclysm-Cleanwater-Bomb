local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_STORM_CLARITY",
    line = ccb.content.text("&You open your inner eye and in its light you see the truth.  This *is* you.  Was you.  Might be you.  You know it like you know yourself.  Whatever game it's playing, its intentions are not malicious.  They are your own."),
    replies = {
        {
            text = ccb.content.text("What do I need to do?"),
            next_topic = "TALK_PORTAL_STORM_I_NEED_TO_DO",
        },
        { text = ccb.content.text("Leave me alone."), next_topic = "TALK_PORTAL_STORM_IGNORE" },
    },
}
