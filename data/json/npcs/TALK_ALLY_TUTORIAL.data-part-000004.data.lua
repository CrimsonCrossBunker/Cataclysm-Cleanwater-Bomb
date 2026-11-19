local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL_MEDIC",
    line = {
        joined = {
            {
                when = predicates.has_trait("interlocutor", "PROF_MED"),
                yes = ccb.content.text("Hey, I'm a doctor!  I know how to treat trauma.  You give me some bandages or a bottle of antiseptic, I'm get you fixed when I see you hurting."),
                no = ccb.content.text("Yeah, I can perform first aid.  You give me some bandages or a bottle of antiseptic, I'll treat your wounds as best I can."),
            },
            ccb.content.text("  But remember, I like you, but I like me more - so I'm going to use those items on myself first, then you, then any of your other friends."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Tell me how I give you medical supplies."),
            next_topic = "TALK_ALLY_TUTORIAL_MULE",
        },
    },
}
