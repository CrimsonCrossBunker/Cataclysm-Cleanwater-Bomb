local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_GRAD_STUDENT_1_STORY1",
    line = ccb.content.text("I'm not from around here… You can probably tell from the accent, I'm from another country.  I was here to complete my studies.  I was traveling to present my work when <the_cataclysm> stopped me.  I ran into a dead man who tried to kill me and bashed his head in with a rock.  I never thought I had anything like that in me."),
    replies = {
        {
            text = ccb.content.text("What did you do next?"),
            next_topic = "BGSS_GRAD_STUDENT_1_STORY2",
        },
        {
            text = ccb.content.text("What were you studying?"),
            next_topic = "BGSS_GRAD_STUDENT_1_FIELD",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GRAD_STUDENT_1_STORY2",
    line = ccb.content.text("I wandered for a little while in the woods, letting the adrenaline fade, hoping for some kind of idea what to do.  I was out in the middle of nowhere, and I didn't know the area at all.  I wasn't certain if I should head back home, or stay out where I was.  Finally, I decided to rest a while until I knew what was going on.  I was far too scared to travel in all of that."),
    replies = {
        {
            text = ccb.content.text("Something must have driven you out."),
            next_topic = "BGSS_GRAD_STUDENT_1_STORY3",
        },
        {
            text = ccb.content.text("What were you studying?"),
            next_topic = "BGSS_GRAD_STUDENT_1_FIELD",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GRAD_STUDENT_1_STORY3",
    line = ccb.content.text("Yes.  Simple hunger.  I stayed long enough to realize no one was going to come for me, then packed up what I could and headed off.  Eventually I was caught in a downpour of acid rain that ate up a lot of my gear.  I've been living the life of a hunter gatherer ever since.  Honestly, I think I eat better this way than I did as a student."),
    replies = {
        {
            text = ccb.content.text("What were you studying?"),
            next_topic = "BGSS_GRAD_STUDENT_1_FIELD",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_GRAD_STUDENT_1_FIELD",
    line = ccb.content.text("I was interested in life sciences.  It sounds more interesting than it was; most of my time was spent doing the same calculations over and over."),
    replies = {
        { text = ccb.content.text("What were you saying before?"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
