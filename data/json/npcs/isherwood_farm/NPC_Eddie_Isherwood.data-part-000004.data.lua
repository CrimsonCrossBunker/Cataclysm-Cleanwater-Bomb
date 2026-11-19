local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_MarshalOff_GoAway",
    line = ccb.content.text("I feel like maybe you didn't hear me right.  Get.  Off.  My.  Land."),
    replies = {
        {
            text = ccb.content.text("You can't make me."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            native_actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_Marshal",
    line = ccb.content.text("*spits on the ground.  \"Didn't much care for the government and the cops before everything happened, care for them quite a bit less now.  We've had a run-in or two with the folks calling themselves the 'Old Guard'.  That's all I care to say about it.  They'll never be welcome on my land and I don't believe for a second that they didn't cause all this in the first place.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_EDDIE_TOPICS",
        },
        {
            text = ccb.content.text("Thanks for telling me.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_RESTOCK",
    line = ccb.content.text("If the cows don't get anything nasty it should be around <restock_time_point>."),
    replies = { { text = ccb.content.text("Cheers, bye."), next_topic = "TALK_DONE" } },
}
