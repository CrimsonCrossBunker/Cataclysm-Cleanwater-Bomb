local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_SANDMAN",
    line = ccb.content.text("If you don't know who he is, I definitely can't tell you.  He talks to everyone, if you didn't hear him that means you can't be trusted, except to help me out."),
    replies = {
        { text = ccb.content.text("…<done_conversation_section>"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
    line = ccb.content.text("These cowards are afraid of me.  They won't let me into their base.  I'm going to build my new house and I won't let them in."),
    replies = {
        {
            text = ccb.content.text("You said you were building a house?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINOSAUR",
    line = ccb.content.text("No."),
    replies = {
        {
            text = ccb.content.text("I… I can see you wearing it.  Why are you wearing that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_WEARING",
        },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_WEARING",
    line = ccb.content.text("You ask me what I can see, but I don't tell you what you see.  Sometimes we have shields up, to protect ourselves."),
    replies = {
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
