local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LUKE_CHRIS2",
    line = ccb.content.text("Well, he doesn't agree that what we're doing here will last.  He thinks things will only get worse.\"  Luke shrugs, as if to say he doesn't have a strong opinion on the matter.  \"It's tough to get the adults to listen though, much less agree with his solution.  You can go talk to him more about it if you want."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LUKE_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_LUKE",
    line = ccb.content.text("You won't find any help here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
