local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Mood",
    line = ccb.content.text("This uncertainty is eating me inside, to be frank with you.  I'm a simple man: I tend my farm, I scare off vermin, but even I can see somethin' ain't right here.  I've talked to my wife, I had a word with Damien, they told me to have more faith in God.  It's the last sliver of hope I have left, and I was told that's enough."),
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
    id = "TALK_GODCO_Darryl_Story",
    line = ccb.content.text("Well, I'd rather not get into my life before all this.  I have a farm to maintain, after all.  Would be nice, sharing our tales while sipping cold brew beer.  Not at a time like this.  Now if you'll excuse me, I'll be back to work."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll leave you to it."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Farm",
    line = ccb.content.text("Took us three days and four hard-working hands to clear this humble little land.  It's a far-cry from my old garden, it really is.  I heard theories, from Tom of course, that really messed with my head.  You can never know what's in one of them toxic clouds, can ya?  I suspect goo-puker blood.  That putrid oil is a sure way to make any soil infertile, or so that nitwit says.  Here I go again, ramblin' once more.  One of my bad habits."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll leave you to it."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Darryl_Trade",
    line = ccb.content.text("Huh, never would have thought you were interested in the fine art of farming.  Sure, I've got seeds I can say goodbye to… if you have the appropriate money of course."),
    replies = {
        { text = ccb.content.text("Let's trade, then."), next_topic = "TALK_GODCO_Darryl_Trade2" },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
