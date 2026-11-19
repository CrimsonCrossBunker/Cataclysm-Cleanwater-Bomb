local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER_SWAMPER",
    line = ccb.content.text("If you are ready to be of service to the great eaters, go and find meat and bring it back.  There is always need for more."),
    replies = {
        {
            text = ccb.content.text("Happy to be of service to the great eaters.  I'm in."),
            next_topic = "TALK_MISSION_ACCEPTED_SWAMPER",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED_SWAMPER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED_SWAMPER",
    line = ccb.content.text("Excellent.  Make it happen."),
    replies = {
        {
            text = ccb.content.text("Consider it done.  But I also wanted to ask…"),
            next_topic = "TALK_SWAMPER",
        },
        {
            text = ccb.content.text("Where should I start?"),
            next_topic = "TALK_MISSION_ADVICE_SWAMPER",
        },
        {
            text = ccb.content.text("Can you share some equipment to aid me in this?"),
            next_topic = "TALK_SHARE_EQUIPMENT_SWAMPER",
        },
        { text = ccb.content.text("I'm off then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE_SWAMPER",
    line = ccb.content.text("The great eaters are not picky, any pure meat will do, but mutant and tainted meat are not good enough."),
    replies = {
        {
            text = ccb.content.text("So, meat from a creature that isn't a zombie, or a giant monster.  Got it."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT_SWAMPER",
    line = ccb.content.text("Of course, you should find everything you need here."),
    replies = { { text = ccb.content.text("That explains the knives then."), next_topic = "TALK_NONE" } },
}
