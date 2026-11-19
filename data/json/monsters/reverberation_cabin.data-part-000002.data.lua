local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_WHO",
    line = {
        choices = {
            ccb.content.text("&The creature releases a slow, tired sigh.  \"Like you, but not.  We can escape.  Please, we must sleep.  It is the only way.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Lay beside the creature]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
        },
        { text = ccb.content.text("[Move away]"), next_topic = "TALK_DONE" },
    },
}
