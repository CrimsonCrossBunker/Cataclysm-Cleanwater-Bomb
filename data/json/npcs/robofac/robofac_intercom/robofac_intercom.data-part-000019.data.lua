local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_NEUTRAL",
    line = ccb.content.text("&The intercom goes quiet for a moment.  You hear a brief exchange on the other end, and then the microphone squeals as the voice gets closer again.  \"As additional payment for helping resolve the situation, feel free to keep the modular defense system.  The core armor platform is solid, and we have been iterating on supplementary pieces that we would be willing to trade to you.\""),
    replies = {
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
        {
            text = ccb.content.text("I've always wanted to be a lab rat."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        { text = ccb.content.text("If you say so."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}
