local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1a",
    line = {
        joined = {
            ccb.content.text("*dusts off his jacket and makes eye contact with you.  \""),
            {
                choices = {
                    ccb.content.text("Hello, nice to see you again."),
                    ccb.content.text("It's good to see you're still around."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Pablo.  What's up?"), next_topic = "TALK_REFUGEE_Pablo_2" },
        {
            text = ccb.content.text("Hi Pablo, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1_firstmeet",
    line = ccb.content.text("We don't get many new faces around here.  How can I help you?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_2",
    line = ccb.content.text("It's been a rough time, adapting to everything that's going on.  What would you like to know about?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background1",
    line = ccb.content.text("I was an accountant before.  Just finished my CPA last year and I already had a position as a manager at my firm.  Everything was looking good.  We decided we were ready for a baby.  Hindsight makes us idiots, hey?"),
    replies = {
        {
            text = ccb.content.text("How did you wind up in this place?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2",
    line = ccb.content.text("Dana and I were evacuated early, because of her pregnancy.  They took us to a concentration center, and then we got on a bus to come here.  The bus though, it was rolled over by a giant monster, and many died.  We made it out along with a few others, and we kept going until we made it here.  It wasn't much farther, and for some reason the monster didn't chase us, just kept tearing at the bus."),
    replies = {
        {
            text = ccb.content.text("What about the pregnancy?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2_pregnancy",
        },
        {
            text = ccb.content.text("What happened to the other crash survivors?"),
            next_topic = "TALK_REFUGEE_Pablo_Background2_survivors",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Pablo."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_pregnancy",
    line = ccb.content.text("The doctor did what she could but after the accident and the stress of the attack… No."),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss."),
            next_topic = "TALK_REFUGEE_Pablo_Background2_sorry",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_Background2_sorry",
    line = ccb.content.text("Thanks.  No, really, thank you.  Others have gone through so much I feel like we should suck it up, but Rhy says we should let ourselves mourn properly and she seems to know her stuff."),
}
