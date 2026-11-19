local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY1",
    line = ccb.content.gendered_line("I was called in to work at the hospital.  I don't usually work there, I'm a community doctor.  I don't really love emergency medicine at the best of times, and when your patient keeps trying to rip your face off, well, it takes the last bit of fun out of it.  You might think I'm a coward, but I slipped out early on, and I've got no regrets.  There was nothing I could have done except die like everyone else.  I couldn't get out of the building, the military had blockaded us in… so I went to the most secure, quiet damned place in the building.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Where was that?"), next_topic = "BGSS_HOSPITAL_3_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY2",
    line = ccb.content.gendered_line("The morgue.  Seems like a dumb place to go at the start of a zombie apocalypse, right?  Thing is, nobody had made it to the morgue in quite a while, the bodies were reanimating too quickly and the staff were just too busy.  I was shaking and puking and I could see the world was ending… I bundled myself up, grabbed a few snacks from the pathologist's desk, and crawled into one of those drawers to contemplate the end of the world.  After breaking the handle to make sure it couldn't lock behind me, of course.  It was safe and quiet in there.  Not just my cubby, the whole morgue.  At first it was because nobody was dumb enough to come down there except me.  Later, it was because nobody was left.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Clearly you escaped at some point."),
            next_topic = "BGSS_HOSPITAL_3_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_3_STORY3",
    line = ccb.content.gendered_line("The door was good heavy steel with no window, and there was a staff room with a fully stocked fridge, so when it became clear that nothing was going to get any better on its own, I set up shop.  I stayed down there for a couple days.  I could hear explosions and screaming for the first while, then just guns and explosions, and then it got really quiet.  Eventually, I ran out of snacks, so I worked up the nerve to climb out a window and check out the city by night.  I used that place as a base for a little while, but the area around the hospital was too hot to keep it up, so I made my way out to greener pastures.  And here I am.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me that.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
