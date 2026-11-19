local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_ACCEPT",
    line = {
        choices = {
            ccb.content.text("Splendid!  With it, we will be one step closer of breaking the vampires' monopoly on agelessness!  Bring it here, and I'll prepare it for Leonard.  This rejuvenation will be very beneficial to his health and ability to flee this place alongside us if vampires or something else wreck it down."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_REFUSE",
    line = {
        choices = {
            ccb.content.text("I get it.  Who wants to search for a needle of a plant in a state-wide haystack for little personal gain?  However, If you somehow find this elder ginseng I'll gladly buy it."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_FIND_GINSENG_COMPLETE",
    line = {
        choices = {
            ccb.content.text("Thanks so much for this ginseng!  With it, I'll take less than an hour to make the potion.  We do not have more demand for elder ginseng for now, but I again thank you for this service."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
