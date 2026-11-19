local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_GUARD",
    line = {
        choices = {
            ccb.content.text("I'm not in charge here, you're looking for someone else…"),
            ccb.content.text("Stay alert, there's trouble in these woods."),
            ccb.content.text("Just on lookout, move along."),
            ccb.content.text("Don't distract me.  I'm on watch."),
            {
                when = predicates.conversation_state("daylight"),
                yes = { choices = { ccb.content.text("Hello.  Welcome to the library.") } },
                no = { choices = { ccb.content.text("Good evening.  Welcome to the library.") } },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How did you get stuck with guard duty?"),
            next_topic = "TALK_GUARD_CAMP_BACKGROUND",
        },
        { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" },
    },
}
