local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_AUGUSTMOON_INTRO_LOCATIONS",
    line = ccb.content.text("The main concourse is down the docking arm.  You can't miss it.  Links up to the mess hall and the commercial wing is right beyond that.  You can arrange planetary transport with the portmaster, found where the commercial wing starts."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" } },
}
