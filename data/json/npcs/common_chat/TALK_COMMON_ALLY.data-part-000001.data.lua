local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REBOOT",
    line = ccb.content.text("This character was previously put into a suspension state due to an AI bug.  If you have reason to believe the problem was fixed, you can wake them up.  Do you want to do that now?"),
    replies = {
        {
            text = ccb.content.text("Yes, wake up!"),
            next_topic = "TALK_NONE",
            native_actions = { "wake_up" },
        },
        { text = ccb.content.text("No, go back to sleep."), next_topic = "TALK_DONE" },
    },
}
