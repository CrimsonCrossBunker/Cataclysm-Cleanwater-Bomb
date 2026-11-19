local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Traveler",
    line = ccb.content.text("Not many travelers come through here these days.  There's not much left to wander too, besides a horde of <zombies>."),
    replies = {
        {
            text = ccb.content.text("Any old port in a storm, I guess."),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Mutant_Traveler",
    line = ccb.content.text("Not many travelers come through here these days.  There's not much left to wander too, besides a horde of <zombies>.  The people here won't be too friendly with you either, so that sucks."),
    replies = {
        { text = ccb.content.text("Sure does."), next_topic = "TALK_GODCO_Olwen_2" },
        {
            text = ccb.content.text("Why would that be?"),
            next_topic = "TALK_GODCO_Olwen_You_Mutant",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Olwen_Joinee",
    line = ccb.content.text("I suppose a lot of us are these days, with all the nasty things wandering around.  I hope you like it here, might not be the most comfortable, but it'll do for me."),
    replies = {
        {
            text = ccb.content.text("Any old port in a storm, I guess."),
            next_topic = "TALK_GODCO_Olwen_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
