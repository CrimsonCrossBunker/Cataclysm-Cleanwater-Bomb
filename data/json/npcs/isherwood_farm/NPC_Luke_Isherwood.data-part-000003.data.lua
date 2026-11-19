local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_BOOKS_BARRY",
    line = ccb.content.text("*winces a little at the name.  \"Yeah.  Because of Barry.\"  You can see he'd rather not pursue the topic."),
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
    id = "TALK_ISHERWOOD_LUKE_BOOKS2",
    line = ccb.content.text("*smiles.  \"Bit early to tell, but I've been doing some night time reading and trying a few things out.\""),
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
    id = "TALK_ISHERWOOD_LUKE_BOOKS3",
    line = ccb.content.text("*smiles brightly.  \"Real great, thanks!  I've learned a lot from them already.  Tried my hand at some basic stuff, it's fun to learn new things.\""),
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
