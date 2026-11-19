local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_1",
    line = ccb.content.text("Not in the mood to dance, huh?  Or perhaps you should try wearing something less encumbering.  You know, if you want to."),
    replies = {
        {
            text = ccb.content.text("I'll consider it.  Thanks for the tunes."),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        { text = ccb.content.text("Thanks, later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_2",
    line = ccb.content.text("Ah yes, that's the spirit!  This place could sure use more dancing."),
    replies = {
        { text = ccb.content.text("Cheers!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_3",
    line = ccb.content.gendered_line("Oh my, am I dealing with a professional dancer here?  Sweet moves, friend.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_4",
    line = ccb.content.text("Oh my oh my.  That was impressive!  Sweet moves!"),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_5",
    line = ccb.content.gendered_line("Daym.  You're probably the best dancer I've ever had the honor of meeting.  Well done.  Well done indeed.", { "speaker" }),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance_6",
    line = ccb.content.text("Oh wow.  I didn't even know the human body could move like that.  I don't know what to say.  That was amazing!"),
    replies = {
        { text = ccb.content.text("Thanks!"), next_topic = "TALK_REFUGEE_Draco_7" },
        { text = ccb.content.text("Cheers!  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
