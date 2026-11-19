local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1a",
    line = {
        joined = {
            ccb.content.text("*seems to look past you for a while before realizing you are there.  \""),
            {
                choices = {
                    ccb.content.text("Hi."),
                    ccb.content.text("Hello."),
                    ccb.content.text("Hm?  Oh, hi."),
                    ccb.content.text("…Hi."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Stan.  What's up?"), next_topic = "TALK_REFUGEE_Stan_2" },
        { text = ccb.content.text("Hi Stan.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1_firstmeet",
    line = ccb.content.text("Huh?  Sorry, yes, nice to meet you too."),
    replies = {
        { text = ccb.content.text("You seem distracted."), next_topic = "TALK_REFUGEE_Stan_2" },
        {
            text = ccb.content.text("I just wanted to say hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_2",
    line = ccb.content.text("I'm sorry, I've been through some hard stuff.  I'm not really myself lately."),
    replies = {
        {
            text = ccb.content.text("Sorry to hear that.  I'll leave you be."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_Background",
    line = ccb.content.text("No, I don't particularly want to talk about it, but I can I guess.  Before <the_cataclysm> I was an insurance adjuster.  My husband Boris and I were evacuated with my brother Garry, and from our evacuation center we caught a commissioned bus out here.  The bus was attacked by a monster, we lived.  Not everyone on the bus did.  We lost people dear to us, now we're stuck here with little to do but think about it."),
    replies = {
        { text = ccb.content.text("Tell me about Boris."), next_topic = "TALK_REFUGEE_Stan_Boris" },
        { text = ccb.content.text("Tell me about Garry."), next_topic = "TALK_REFUGEE_Stan_Garry" },
        {
            text = ccb.content.text("I'm sorry for your loss.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry to hear that.  I'll leave you be."),
            next_topic = "TALK_DONE",
        },
    },
}
