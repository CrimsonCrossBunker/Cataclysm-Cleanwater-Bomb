local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_SEER",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("The song is… quiet for now.  Perhaps with time, more notes will be etched in the bones of this world."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("An acolyte should not take on too many songs at once."),
                no = ccb.content.text("That is all for now."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("There are bones to etch, songs to sing.  Wish to join me?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("Do you wish to take on more songs?"),
                    no = ccb.content.text("Do you believe you can take on the burden of additional bones?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("A song may yet be sung by you, should you wish to."),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is an additional song you could take on, if you'd like."),
                    no = ccb.content.text("I know of certain bones that could be of use, if you'd like to know more."),
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
            next_topic = "TALK_MISSION_OFFER_SEER",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
        {
            text = ccb.content.text("Perhaps another time, Seer."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}
