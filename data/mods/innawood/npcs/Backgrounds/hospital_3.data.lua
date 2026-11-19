local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY1",
    line = ccb.content.text("I was called in to work healing the sick.  Not my usual thing, but things were bad and they needed help and I had the right background.  I don't really love emergency medicine at the best of times, and when your patient keeps trying to rip your face off, well, it takes the last bit of fun out of it.  You might think I'm a coward, but I slipped out early on, and I've got no regrets.  There was nothing I could have done except die like everyone else.  I couldn't get away, the men with spears had blockaded us in… so I went to the most secure, quiet damned place I knew."),
    replies = {
        { text = ccb.content.text("Where was that?"), next_topic = "BGSS_HOSPITAL_3_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY2",
    line = ccb.content.text("The area for the dead.  Seems like a dumb place to go at the start of a zombie apocalypse, right?  Thing is, nobody had made it there in quite a while, the bodies were reanimating too quickly and people were just too busy.  I was shaking and puking and I could see the world was ending… I bundled myself up, grabbed a few snacks, and crawled in among the dead to contemplate the end of the world.  It was safe and quiet there.  At first it was because nobody was dumb enough to come there except me.  Later, it was because nobody was left."),
    replies = {
        {
            text = ccb.content.text("Clearly you escaped at some point."),
            next_topic = "BGSS_HOSPITAL_3_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY3",
    line = ccb.content.text("I stayed there for a couple days.  I could hear explosions and screaming for the first while, then just explosions, and then it got really quiet.  Eventually, I ran out of food, so I worked up the nerve to climb a tree and check out the area by night.  I used that place as a base for a little while, but the area nearby was too hot to keep it up, so I made my way out to greener pastures.  And here I am."),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
