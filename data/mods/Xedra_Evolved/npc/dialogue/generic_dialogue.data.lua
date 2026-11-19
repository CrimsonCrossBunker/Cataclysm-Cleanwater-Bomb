local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_ELEMENTAL_POSITIVE",
    line = ccb.content.text("You mean the ferals?  Almost everyone left alive will try to kill you just like the zombies out there."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_ELEMENTAL_NEGATIVE",
    line = ccb.content.text("You mean the ferals?  How can you not know about the ferals?  Is this a trap?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_HOMULLUS_POSITIVE",
    line = ccb.content.text("When the world broke it seems like it broke most people's minds and locked them in on a single response to everything around them."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABOUT_FERALS_HOMULLUS_NEGATIVE",
    line = ccb.content.text("Where have you been?  It's the end of the world and most people have gone crazy!  Are you trying to distract me?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
