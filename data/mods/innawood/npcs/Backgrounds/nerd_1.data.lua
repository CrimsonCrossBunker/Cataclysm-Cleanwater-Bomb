local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY1",
    line = ccb.content.text("I was being taught during <the_cataclysm>.  Funny thing, actually: I was working on a long zombie survival story to tell my friends that weekend.  Ha, I didn't think it'd be so realistic!  Okay….  No, that wasn't funny."),
    replies = {
        {
            text = ccb.content.text("How did you survive school?"),
            next_topic = "BGSS_NERD_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY2",
    line = ccb.content.text("Well, I may be a huge <freaking> nerd, but I'm not an idiot.  Plus I'm genre savvy.  We'd already heard about people coming back from the dead, actually that's why I was going to tell the story.  When the men with yellow pistols came to tie us up and make us do things I managed to slip into the woods.  I live a long way away, but there was no way I was going to ride a horse, so I walked.  Two hours.  Heard a lot of screaming, and I even saw a giant eyeball flying overhead.  It was getting late when I got back, but my mom and dad weren't there yet.  I stayed there, hoping they'd come.  After a few days, well… I knew they weren't coming."),
    replies = {
        { text = ccb.content.text("What about your parents?"), next_topic = "BGSS_NERD_1_PARENTS" },
        { text = ccb.content.text("What got you out of there?"), next_topic = "BGSS_NERD_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_PARENTS",
    line = ccb.content.text("I'm not stupid.  I know they're gone.  Who knows where… maybe somewhere safe, maybe one of the camps.  Most of everyone is dead."),
    replies = {
        { text = ccb.content.text("What brought you here?"), next_topic = "BGSS_NERD_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_NERD_1_STORY3",
    line = ccb.content.text("Eventually a giant murderous insect came.  I figured they would.  I'd heard stories.  I'd picked out some good gear and loaded my basket up with supplies….  When it came crashing through the woods I ran the other way.  And here I am."),
    replies = {
        { text = ccb.content.text("What about your parents?"), next_topic = "BGSS_NERD_1_PARENTS" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
