local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_You_Mutant",
    line = ccb.content.text("Well, this is a really xenophobic bunch, and regard some of your, changes, as a curse brought on by God.  I'm cool with you though, not like some of these other <name_b>.  There are a few who wouldn't mind you, though."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        { text = ccb.content.text("In that case, I'd better get going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Angry",
    line = ccb.content.text("You've been quite the <name_b> as of late, and I'm sick of it.  Now go away."),
    replies = { { text = ccb.content.text("Alright, I'll leave."), next_topic = "TALK_DONE" } },
}
