local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_2",
    line = ccb.content.text("&<mypronoun> seems completely lost to the present, but you can't help but notice <mypossesivepronoun> gear is caked with mud and broken twigs.  It doesn't look like you'll be getting much conversation from this one."),
    replies = {
        {
            text = ccb.content.text("Press on in search of a reaction."),
            next_topic = "BEM_JABBERWOCK_3",
        },
        {
            text = ccb.content.text("Try to find someone more interested in conversation."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_3",
    line = ccb.content.gendered_line("&Continued prodding manages to extract a baffling response from your interlocutor \"I- I've seen it, the god of our new world, a god of flesh and bone.\" <mypronoun> says with a maddened glare, as though this were some sort of shocking revelation.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Show your map to the mercenary, and have them mark where they saw this \"god\"."),
            next_topic = "BEM_JABBERWOCK_4",
        },
        {
            text = ccb.content.text("Yeah I'm sure I have seen that one too.  Try to stay safe."),
            next_topic = "TALK_DONE",
        },
    },
}
