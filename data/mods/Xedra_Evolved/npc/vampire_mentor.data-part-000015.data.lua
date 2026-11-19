local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_ASSISTANCE" },
    line = ccb.content.text("No thanks.  I am here to help others, not because I need help."),
    replies = {
        {
            text = ccb.content.text("Then I'd like your help as a mentor."),
            next_topic = "TALK_VAMPIRE_MENTOR_MENTORING",
        },
        {
            text = ccb.content.text("Then I'd like your help as a vampire slayer."),
            next_topic = "TALK_VAMPIRE_MENTOR_KILLING_HELP",
        },
        { text = ccb.content.text("Got it.  See you."), next_topic = "TALK_DONE" },
    },
}
