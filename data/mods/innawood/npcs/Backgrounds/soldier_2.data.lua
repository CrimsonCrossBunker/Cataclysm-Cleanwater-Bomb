local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_SOLDIER_2_STORY1",
    line = ccb.content.text("I carried a spear.  Just a new recruit.  I wasn't even done with the basics, they actually called me out of boot camp to serve once the shit hit the fan.  I barely knew which end of the blunderbuss the bullets came out of, and they jammed me into a grass skirt and sent me out to 'assist in the evacuation efforts'.  Our orders barely made sense, our superiors were as confused as we were."),
    replies = {
        { text = ccb.content.text("What happened then?"), next_topic = "BGSS_SOLDIER_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_SOLDIER_2_STORY2",
    line = ccb.content.text("We never even made it there.  The unit got stomped by something gigantic.  I didn't even see it, just saw this huge black-and-green spiny leg slam down and crush the guy in front of me.  Then the guy behind me got sucked up into some kind of giant sweaty tube.  I don't know how I survived.  The thing rolled over, killed most of us right there.  I musta blacked out for a bit.  Came to, and while I was getting myself up, the others started getting back up.  Long story short, I lived, they didn't, and I ran."),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me all that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
