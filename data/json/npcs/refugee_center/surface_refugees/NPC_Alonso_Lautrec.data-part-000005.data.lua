local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_CalledOut3",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Fine.  As a favor to you, I'll be a guy from Brooklyn."),
        no = ccb.content.text("Alonso thanks you for your kindness, and will remain his glorious self."),
    },
    replies = { { text = ccb.content.text("Thanks.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Background",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("I'm tryin' ta forget, y'know?  Don't like thinkin' about the past.  Better to plan for the future, even if the future looks grim."),
        no = ccb.content.text("Alonso has many a tale to tell, all slow and drawn-out like, a sensual seduction of the -- how you say?  Ears.  There are dark days ahead, but perhaps together we can bring a little light?  Or at least a little heat.  This is a science joke I make for you.  Friction, it is the joke."),
    },
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
    id = "TALK_REFUGEE_Alonso_Pants1",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Yeah, I fucked up and got drunk at a kiddy party I crashed, broke into a van with the party clown I was seein' (hey don't judge me, it took me a long time to make that happen, clowns are very givin' lovers) and I lost my pants, includin' all my money and all my triple magnum condoms I stole off a dead priest at a bar.  I'd be mad, but at least I'm safe, I made it here.  But I got no game here y'know?  I look like the clown when I should be knee deep in hotness here.  Look around, it's straight hotties!"),
        no = ccb.content.text("Why were you looking though?  I kid, I know she is hard to miss!  In English, the special package she is a woman no?  No.  I see.  And so do you it seems.  Yes.  There was such a clown, a clown of enormous physical beauty.  The pale, perfect skin, the ruby red lips, amazing hair, and what a sense of humor.  I laugh still, though I have lost everything.  My pants, my money, my many illegal imported triple magnum condoms I stole from a priest.  All lost to that one beautiful night.  The candles, the balloons, the singing.  It was the most romantic children's birthday party you could hope to imagine.  I would do it all again, and there was so much we did.  It was the end of that party, but the beginning of something beautiful, for several hours in that open minivan we found.  But you do not want to hear of such pleasures, I do not want to get you excited, for what can I do when I look so foolish, and lack the protection needed for more serious excitement.  Though and you must understand, Alonso's tongue is good for more than just the telling of long and saucy stories yes?"),
    },
    replies = {
        { text = ccb.content.text("Can I help you out?"), next_topic = "TALK_MISSION_LIST" },
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
    id = "TALK_REFUGEE_Alonso_Situation",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Could be better.  I don't really got any friends here in the center, but seeing travelers like you always brightens my day."),
        no = ccb.content.text("Here in the center, Alonso is a bit lonely.  We get a few brave, strong travelers like yourself, though, and seeing them brightens Alonso's day.  Normally I am more popular, but something seems to be troubling the spirits of these people during these terrible times."),
    },
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
