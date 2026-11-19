local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERFIGHT",
    line = ccb.content.gendered_line("It saddens me to see a talented Kindred lose his way so greatly, but I take solace in the fact that you are unscathed.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Best not to dwell on it.  Let's move on."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERPEACE",
    line = ccb.content.text("I am glad your meeting ended without conflict.  Perhaps he's understanding the Song more and the harm his actions caused.  If so… there may be hope yet.  Never the less, his action can not go unpunished."),
    replies = {
        {
            text = ccb.content.text("A topic for another time.  Let's move on."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}
