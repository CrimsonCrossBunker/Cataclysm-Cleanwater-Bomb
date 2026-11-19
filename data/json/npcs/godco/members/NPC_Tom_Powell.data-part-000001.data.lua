local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet2",
    line = ccb.content.text("Hey, that's nice of you to ask.  The people here are barely holding on.  Malnutrition, sleepless nights, odd sounds from the woods, everyone turns a little mad in these circumstances.  It's not their fault, I know, but they did get what they wanted."),
    replies = {
        { text = ccb.content.text("Please continue."), next_topic = "TALK_GODCO_Tom_Firstmeet3" },
        {
            text = ccb.content.text("No rest for the weary.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet3",
    line = ccb.content.text("The sky has broken!  They received a rather passive-aggressive sign from God!  The wait is finally over.  Well, not for me.  So much is left unanswered, and I know for a fact the answer's out there."),
    replies = {
        {
            text = ccb.content.text("Perhaps it's not worth finding out."),
            next_topic = "TALK_GODCO_Tom_Firstmeet4",
        },
        {
            text = ccb.content.text("Try not to get stuck in the past.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet4",
    line = ccb.content.text("Perhaps.  You don't wanna think about the stuff I'm thinking about, it would spiral a newbie independent thinker into madness.  I don't blame you for saying that."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_2",
    line = ccb.content.text("I'm currently in the middle of solving a pointless mystery for my own entertainment.  Of course I have time!"),
    replies = {
        {
            text = ccb.content.text("Maybe I could help you with that mystery?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Sorry Tom.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Story",
    line = ccb.content.text("I haven't got a story.  I'm an independent thinker.  Living out here, away from the Man."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Background",
    line = ccb.content.text("I was nobody but an ordinary office drone.  Lived the average suburban life, prepping for the inevitable.  Had the bright idea of purchasing a Last Man On Earth shelter, but I decided to settle for less when I found out it cost five times my annual salary.  That's how I ended up in a religious campground with my family and a survival kit."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Family",
    line = ccb.content.text("All of us are here; me, Felicity, and Olwen.  We're so lucky, I feel like crying tears of joy every time I see them."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about Felicity?"),
            next_topic = "TALK_GODCO_Tom_Felicity",
        },
        {
            text = ccb.content.text("Could you tell me about Olwen?"),
            next_topic = "TALK_GODCO_Tom_Olwen",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Stillwater is a legitimate publishing firm, operating in Rhode Island.
ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Felicity",
    line = ccb.content.text("She's my wife, we've been married for a while now.  We used to live in Rhode Island, worked at a publishing firm, Stillwater.  She's always wanted to be a writer, that's why we moved away.  We've been a bit distant as of late, I don't think she's taking the \"whole end-of-the-world\" thing too well."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
