local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Mood",
    line = ccb.content.text("Oh it's nothing new to me.  Livin' off the land, far from everyone - it's just what I'm adjusted to.  I've kept in touch with the church folks, and that was enough.  I had a loyal companion back home, Betsey, my rottweiler.  Things have been very different since she passed away, though."),
    replies = {
        { text = ccb.content.text("What do you do now?"), next_topic = "TALK_GODCO_Russell_Mood1" },
        {
            text = ccb.content.text("Could you tell me more about Betsey?"),
            next_topic = "TALK_GODCO_Russell_Betsey",
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
    id = "TALK_GODCO_Russell_Mood1",
    line = ccb.content.text("I hunt with most of my time these days.  Whatever game I spot, I bag and donate.  Thing is, it's getting harder and harder.  Have you also noticed how corruption is slowly overtaking the natural wildlife in this God-given planet?  They think the flesh is just rotten.  No, it's mutated, become something else."),
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
    id = "TALK_GODCO_Russell_Betsey",
    line = ccb.content.text("&Russel's expression becomes somber, and he briefly stares at the wall.  \"She was my dog, had her for seventeen years.  We used to go duck-hunting, she'd swim out and get anything I shot.  She helped me track many a deer through the woods…   When <the_cataclysm> hit, she saved me from some <zombies> when we were skippin' town, but she died…  Then she came back, wasn't herself…  I had to put her down.\""),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Let's change the subject."),
            next_topic = "TALK_GODCO_Russell_2",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
