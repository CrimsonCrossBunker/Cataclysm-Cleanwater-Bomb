local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A2",
    line = ccb.content.gendered_line("You again.  Any good news?  Haven't heard any in a long time.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_Story",
        },
        { text = ccb.content.text("No, I don't have any."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_A1_Job",
    line = ccb.content.text("We're just trying to find a safe place right now.  I think there's a FEMA camp nearby that should have room for us."),
    replies = {
        {
            text = ccb.content.text("That's it?  What's your story?"),
            next_topic = "TALK_CARAVAN_REFUGEE_A_Story",
        },
        {
            text = ccb.content.text("Good luck with that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
