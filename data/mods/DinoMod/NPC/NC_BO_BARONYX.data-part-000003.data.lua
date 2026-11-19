local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_SWAMPER",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("The eaters have fed.  They will be hungry again in time."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("You know what to do."),
                no = ccb.content.text("That is all for now."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("The great eaters must be fed.  Are you ready?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is still more work to do.  Are you ready?"),
                    no = ccb.content.text("There is meat ready for the feeding.  Are you ready to gather it?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("The eaters are hungry."),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is more meat needed."),
                    no = ccb.content.text("I know of eaters ready for meat."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_NONE",
            when = predicates.available_missions("interlocutor", 0, 0),
        },
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_MISSION_OFFER_SWAMPER",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
        {
            text = ccb.content.text("Maybe another time CEO Baronyx."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}
