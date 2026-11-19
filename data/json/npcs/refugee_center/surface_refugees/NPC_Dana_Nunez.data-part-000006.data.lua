local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking",
    replies = {
        {
            text = ccb.content.text("Thanks, can we talk about something else?"),
            next_topic = "TALK_REFUGEE_Dana_1",
        },
        {
            text = ccb.content.text("I'll look into that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- see above for responses to buy bread at original price.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
    line = ccb.content.text("Sorry, it's not something I can bend on.  I don't make a big profit off this, I use what I get to make more bread.  If I cut you a deal, I'll run out of supplies."),
    replies = {
        {
            text = ccb.content.text("Thanks, but I think I'll pass.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
    line = ccb.content.text("Oh, fine.  Six cups of flour, or one merch.  I'm not going any lower, I got a business to run here."),
    replies = {
        {
            text = ccb.content.text("You know, I think I changed my mind.  <done_conversation_section>"),
            next_topic = "TALK_REFUGEE_Dana_1",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_sorry",
    line = ccb.content.text("That's kind of you to say.  I'm doing my best to move on… it hurts, but in the scale of things it could be worse.  Pablo and I still have each other, that's a lot more than most."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Dana."), next_topic = "TALK_DONE" },
    },
}
