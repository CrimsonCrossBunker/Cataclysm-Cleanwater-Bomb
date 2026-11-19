local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ASKED_ABOUT_SAFE_CONTENTS",
    line = ccb.content.text("As I said, that's the thing I need.  You don't need to know what's that exactly.  Just grab all things you find in the safe, and call it a day."),
    replies = {
        { text = ccb.content.text("That's weird."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_ASKED_ABOUT_WHAT_FOR_DO_YOU_NEED_IT",
    line = ccb.content.text("Let's say that's none of your <freaking> business.  Other questions?"),
    replies = {
        { text = ccb.content.text("That's weird."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("I have a bad feeling about this.  Sorry, I'll pass."),
            next_topic = "TALK_DONE",
        },
    },
}
