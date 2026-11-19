local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_FAMILY_DUPLICATES_CHRIS",
    line = ccb.content.gendered_line("*eyes you up and down with a nervous smile.  \"I almost didn't expect you to show up.\"  He hesitates, letting out a soft laugh.  \"That sounds bad.  I just mean, I can't really believe we're doing this.  Thank you… for doing this.  You ready to get Uncle Barry?\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("You got it, let's go!"),
            native_actions = { "follow_only" },
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Not yet, just give me a minute."), next_topic = "TALK_DONE" },
    },
}
