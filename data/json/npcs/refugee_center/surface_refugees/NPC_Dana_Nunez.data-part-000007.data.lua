local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking_revival",
    line = ccb.content.text("Sorry, not quite yet.  Landough was in pretty rough shape.  No fault of yours, it was no good having him cooped up in a dank fridge for that long… and I think my apprentice baker may have fucked with him before the Cataclysm too.  He'd better hope he's a zombie now, because if I see him alive… anyway, it's gonna take a few more feeds before I can get him ready for prime time, check back in a couple days."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Situation",
    line = ccb.content.text("Things are tense at the best of times.  We didn't choose this crowd, so not all of us really get along.  I like Jenny and Fatima, and the three of us are kind of lucky to have friends here, but that doesn't make up for us being a bunch of unfamiliar faces crammed into a tiny space.  Someone's gonna murder someone soon, mark my words."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}
