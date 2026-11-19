local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_firstmeet",
    line = ccb.content.text("Oh.  I see now.  You have different sexual traits than Billy, likely due to a mutation or cybernetic enhancement, useful in mating rituals, the act of reproduction, and establishing social hierarchies.  Very good, I accept that you are either not Billy or have changed enough that we can establish a new relationship beyond violence, for example based around the gathering of food, mating, or shared hobbies such as badminton or photography.  How do you wish to proceed with our relationship not-Billy?"),
    replies = {
        {
            text = ccb.content.text("I'd like to understand more about you first.  Are you human, more or less?"),
            next_topic = "TALK_sadie_what",
        },
        {
            text = ccb.content.text("You are aware of the Cataclysm?"),
            next_topic = "TALK_sadie_cataclysm",
        },
        {
            text = ccb.content.text("I am your new friend and I'm here to help you."),
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_what",
    line = ccb.content.text("Yes, much of what you see is human I think.  I don't have the proper equipment to be entirely sure and I have some strange memories.  My beacon has already told you that I am Sadie.  Beyond that I don't know much to tell you.  I know a great deal about medicine.  I have some strange responses to physical stimuli that I don't completely understand.  I think I must be a medical experiment of some kind.  My chest hurts in a really yummy way."),
    replies = {
        { text = ccb.content.text("Can I help you?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("I should go."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_ask_past",
    line = ccb.content.text("I have so many memories, but they feel like they belong to other people?  And animals too I think?  It makes me dizzy and I have to sit down."),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_Sadie_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_cataclysm",
    line = ccb.content.text("I don't know her."),
    replies = {
        {
            text = ccb.content.text("Yes.  Let's talk about something else."),
            next_topic = "TALK_Sadie_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_sadie_ask_mood",
    line = ccb.content.text("Things stay pretty much the same here.  Sometimes I feel bad, and that feels good, and sometimes I feel good, and that feels good too.  Overall things are better than you might expect, but this may be a common experience, in which case things are exactly as you might expect.  Does that make sense?"),
    replies = { { text = ccb.content.text("Perfect sense."), next_topic = "TALK_Sadie_1" } },
}
