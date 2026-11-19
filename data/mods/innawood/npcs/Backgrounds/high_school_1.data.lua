local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY1",
    line = ccb.content.text("I was in classes.  We'd heard about riots… all kinds of nasty stories, like the one where the woman is biting this guy's face, and her whole lower lip has been ripped off, and is just flapping there?  It got so bad, the teachers told us there were drugs in the water and we should pray.  Right… does anyone buy that explanation?"),
    replies = {
        {
            text = ccb.content.text("Where did things go from there?"),
            next_topic = "BGSS_HIGH_SCHOOL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY2",
    line = ccb.content.text("I guess it got worse, because the teachers decided to tie us up and drink.  For hours.  And then a bunch of sweaty men with spears came to take us to the camps.  They took us away in batches and I was in on the of the last batches and they didn't come back for us.  The men with spears weren't much older than me… they didn't look like they knew what was going on.  I lived nearby.  I snuck off."),
    replies = {
        { text = ccb.content.text("Did you get home?"), next_topic = "BGSS_HIGH_SCHOOL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY3",
    line = ccb.content.text("Yeah.  On the way there, I met some <zombies> for real.  They chased me, but I am very fast.  I lost them… but I couldn't get home, there were just too many.  I wound up running more.  I'm a bit better at killing those things now, but I haven't made it home yet.  I guess I'm afraid of what I'll find."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
