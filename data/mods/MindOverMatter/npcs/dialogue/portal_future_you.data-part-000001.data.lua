local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_SENSE_FAIL" },
    line = ccb.content.text("&You extend your senses, alert for danger, and are immediately almost blinded.  In the heart of the portal storm, there's danger everywhere.  In the air and ground, in the things half-glimpsed that vanish when you look at them, and in yourself, just waiting for the right conditions to be unleashed.  If there's anything sinister in the voice's offer, you cannot tell."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_SENSE_SUCCEED" },
    line = ccb.content.text("&You extend your senses, alert for danger.  Shutting out the ever-present danger of the post-Cataclysmic world and the portal storm, you focus on your immediate surroundings.  There is danger there, but not directly.  Whatever the outcome of its offer, it is not meant as a trap."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_STORM_DANGER_sense_hostility" },
    line = ccb.content.text("&You focus on the voice, trying to determine its intentions, and are surprised.  The voice, at least, does not mean you any harm.\n\nAs you withdraw your senses, however, you can't help but realize that in these circumstances, that doesn't necessarily mean you won't come to any harm."),
    replies = {
        {
            text = ccb.content.text("*Close your inner eye*"),
            next_topic = "TALK_PORTAL_STORM_CONVERSATION",
        },
    },
}
