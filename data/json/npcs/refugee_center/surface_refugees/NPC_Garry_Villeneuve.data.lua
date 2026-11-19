local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_1a",
    line = {
        joined = {
            ccb.content.text("*smiles at you briefly.  He looks like he hasn't been eating well.  \""),
            {
                choices = {
                    ccb.content.text("Hello again."),
                    ccb.content.text("Well, hello."),
                    ccb.content.text("Good to see you again."),
                },
            },
            ccb.content.text("\""),
        },
    },
    replies = {
        { text = ccb.content.text("Hi, Garry.  What's up?"), next_topic = "TALK_REFUGEE_Garry_2" },
        { text = ccb.content.text("Hi Garry.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  Are you staying here, or something?"),
    replies = {
        {
            text = ccb.content.text("No, I'm a traveler.  What's up with you?"),
            next_topic = "TALK_REFUGEE_Garry_2",
        },
        {
            text = ccb.content.text("Nope, in fact I'm leaving right now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_2",
    line = ccb.content.text("Doing my best to keep going in the face of… everything.  Not getting far."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_Background",
    line = ccb.content.text("Before the apocalypse I was an electrician.  Boris here is my brother-in-law, and we were a decent contractor team.  When the evacuations sounded, we left together with our…\" he swallows and coughs before continuing, \"with our families.  We got stuck into a crowded evac shelter, then onto a crowded bus.  Then… everything went wrong.  The bus was attacked, destroyed.  Nearly everyone died.  A few of us made it back… not enough."),
    replies = {
        {
            text = ccb.content.text("You lost someone…"),
            next_topic = "TALK_REFUGEE_Garry_Background_loss",
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_Background_loss",
    line = ccb.content.text("Yes.  My wife, Linda… thrown from the bus.  She didn't make it.  And… and my nephew, Ash, Boris and Stan's son.  We got him here, but there wasn't anything we could do.\"  He gestures for a moment as if trying to explain it without words, then shrugs.  \"Internal injuries."),
    replies = {
        {
            text = ccb.content.text("Do you want to tell me about Linda?"),
            next_topic = "TALK_REFUGEE_Garry_Background_Linda",
        },
        {
            text = ccb.content.text("Tell me about Ash."),
            next_topic = "TALK_REFUGEE_Garry_Background_Ash",
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_Background_Linda",
    line = ccb.content.text("*looks unsure, then sighs softly.  \"I don't know what to say.  She was my second wife; my first wife passed away about fifteen years ago.  I've gone through this before, and it was bad enough then.\"  He stares at the floor for a moment.  \"We don't have any touchstones anymore, you know?  I've got Boris and Stan, but they can't support me, and what else is there?\"  He looks back up at you, appearing to remember the conversation.  \"Sorry, you were asking about Linda.  She was wonderful, always surprising me.  One of those people you just couldn't predict, so much fun and full of life.  Really into rock climbing.  I always used to be afraid she'd hurt herself in a climbing accident.\"  He laughs, a single harsh sound more like a cough.  \"Funny how life throws you curveballs.\""),
    replies = {
        {
            text = ccb.content.text("Tell me about Ash."),
            next_topic = "TALK_REFUGEE_Garry_Background_Ash",
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_Background_Ash",
    line = ccb.content.text("*smiles for a moment, his face returning to what it must have looked like before everything.  \"God, that kid was funny.  Such a little nerd.  He'd come bombing into any conversation to interrupt and tell you about whatever his latest obsession was, didn't matter what else was going on.  We'd have to remind him to go to the bathroom sometimes.\"  Garry looks around, swallowing hard for a second, and wipes his hands across his face.  \"It's so damn quiet here without him.\""),
    replies = {
        {
            text = ccb.content.text("Do you want to tell me about Linda?"),
            next_topic = "TALK_REFUGEE_Garry_Background_Linda",
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

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Garry_Situation",
    line = ccb.content.text("It's tense here, but I don't know.  Stan, Boris and I have been pretty insular.  I guess we'd better get to know some of the others here eventually.\"  He looks around the room, his eyes dull.  \"It feels it should be a temporary stop, but it's starting to look like we'll be here for the long term.  If we live that long."),
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
