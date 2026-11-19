local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("I don't have any jobs for you."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("I don't have any more jobs for you."),
                no = ccb.content.text("I don't have any more jobs for you."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("I have other jobs for you.  Want to hear about them?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("I have more jobs for you.  Want to hear about them?"),
                    no = ccb.content.text("I have other jobs for you.  Want to hear about them?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("I have a job for you.  Want to hear about it?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("I just have one job for you.  Want to hear about it?"),
                    no = ccb.content.text("I just have one job for you.  Want to hear about it?"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Oh, okay."),
            next_topic = "TALK_NONE",
            when = predicates.available_missions("interlocutor", 0, 0),
        },
        {
            text = ccb.content.text("Never mind, I'm not interested."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_ASSIGNED",
    line = {
        when = predicates.assigned_missions(0, 0),
        yes = ccb.content.text("You're not working on anything for me now."),
        no = {
            when = predicates.assigned_missions(2),
            yes = ccb.content.text("Which job?"),
            no = ccb.content.text("What about it?"),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}
