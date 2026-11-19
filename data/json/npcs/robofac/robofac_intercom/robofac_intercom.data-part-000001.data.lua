local ccb = require("ccb")

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_INTERCOM_INTRO_SILENCE", line = ccb.content.text("&The intercom is silent.") }

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_CYBORG_SILENCE",
    line = ccb.content.text("&The intercom is silent."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRO_2",
    line = ccb.content.text("I promise you, there is nothing you can do for us.  Now leave, before I'm forced to-\"  They stop suddenly.  You hear a short, muffled conversation from the other end.  There's a brief pause.  \"Alright.  We might be able to gain some mutual benefit.  It's a dangerous task, but if you complete it then we would be willing to open up limited trading access."),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        {
            text = ccb.content.text("Risk my neck for the privilege of trading with you?  Maybe another time."),
            next_topic = "TALK_DONE",
        },
    },
}
