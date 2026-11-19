local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BARKEEP_INFORMATION",
    line = ccb.content.text("If what you want are jobs and opportunities, you'll probably be better off asking to my other patrons.  Have regulars from well across the state, I'm sure some can offer what you want.\"\n\n \"Really, I just tend the bar and don't ask many questions.  Things tend work out better that way."),
    replies = {
        {
            text = ccb.content.text("I'll ask around, thank you."),
            next_topic = "TALK_ANCILLA_BARKEEP",
        },
    },
}
