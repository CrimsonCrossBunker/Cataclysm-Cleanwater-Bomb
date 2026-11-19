local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY1",
    line = ccb.content.gendered_line("I was at school.  I'm a senior.  We'd heard about riots… it started with a kid showing videos of one of the big riots in Providence.  You've probably seen it, the one where the woman turns to the camera and you can see her whole lower lip has been ripped off, and is just flapping there?  It got so bad, they went over the PA system to tell us about Chinese drugs in the water supply.  Right… does anyone buy that explanation?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Where did things go from there?"),
            next_topic = "BGSS_HIGH_SCHOOL_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY2",
    line = ccb.content.gendered_line("I guess it got worse, because the faculty decided to put us in lockdown.  For hours.  And then the school buses showed up to evacuate us.  Eventually, they ran out of buses.  I was one of the lucky few who didn't have a bus to get on.  The soldiers weren't much older than me… they didn't look like they knew what was going on.  I lived just a few blocks away.  I snuck off.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Did you get home?"), next_topic = "BGSS_HIGH_SCHOOL_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HIGH_SCHOOL_1_STORY3",
    line = ccb.content.gendered_line("Yeah.  On the way there, I met some <zombies> for real.  They chased me, but I did pretty well in track.  I lost them… but I couldn't get home, there were just too many.  I wound up running more.  Stole a bike and ran more again.  I'm a bit better at killing those things now, but I haven't made it home yet.  I guess I'm afraid of what I'll find.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
