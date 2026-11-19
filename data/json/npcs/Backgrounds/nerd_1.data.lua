local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY1",
    line = ccb.content.gendered_line("I was at school for <the_cataclysm>.  Funny thing, actually: I was gearing up to run a zombie survival RPG with my friends on the weekend.  Ha, I didn't think it'd turn into a LARP!  Okay….  No, that wasn't funny.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("How did you survive school?"),
            next_topic = "BGSS_NERD_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY2",
    line = ccb.content.gendered_line("Well, I may be a huge <freaking> nerd, but I'm not an idiot.  Plus I'm genre savvy.  We'd already heard about people coming back from the dead, actually that's why I was doing the RPG.  When the cops came to put the school on lockdown I managed to slip out the back.  I live a long way out of town, but there was no way I was going to take a bus home, so I walked.  Two hours.  Heard a lot of sirens, and I even saw jets overhead.  It was getting late when I got back, but my mom and dad weren't back from work yet.  I stayed there, hoping they'd come.  I sent texts but got no reply.  After a few days, well… the news got worse and worse, then it stopped completely.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What about your parents?"), next_topic = "BGSS_NERD_1_PARENTS" },
        { text = ccb.content.text("What got you out of there?"), next_topic = "BGSS_NERD_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_PARENTS",
    line = ccb.content.gendered_line("I'm not stupid.  I know they're gone.  Who knows where… maybe in an evac shelter, maybe in a FEMA camp.  Most of everyone is dead.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What got you out of the house?"),
            next_topic = "BGSS_NERD_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY3",
    line = ccb.content.gendered_line("Eventually the zombies came.  I figured they would.  Before the net cut out, there were plenty of videos online making it clear enough what was going on.  I'd picked out some good gear and loaded my bag up with supplies….  When they started knocking at the door, I slipped out the back and took to the street.  And here I am.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("What about your parents?"), next_topic = "BGSS_NERD_1_PARENTS" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
