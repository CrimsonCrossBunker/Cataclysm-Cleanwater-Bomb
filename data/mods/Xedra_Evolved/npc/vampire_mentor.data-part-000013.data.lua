local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_WHY_BOOK" },
    line = ccb.content.text("This book contains the rituals allowing to obtain the components.  Each of them requires a complicated process to get.  I'm giving you this book so you won't come back asking for more information every two hours."),
    replies = {
        {
            text = ccb.content.text("I'll begin the search then."),
            next_topic = "TALK_VAMPIRE_MENTOR_GATHER_TIER_5",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
            actions = { actions.handler("dlg_a_xedra_evolved_ce0106b73c6d"), actions.set_actor_value("speaker", "received_mentor_book", "yes"), actions.assign_mission("GET_COMPONENTS_FOR_TIER_5") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BOOK_NEED_NEW" },
    line = ccb.content.text("I do have another copy, however you'll have to buy it at a steep price.  Each of these are written by hand these days so we can't let people treat them like disposable things."),
    replies = {
        {
            text = ccb.content.text("[$100] I'll buy the book."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_xedra_evolved_c6ce859e7ff1") },
        },
        {
            text = ccb.content.text("We?"),
            next_topic = "TALK_VAMPIRE_MENTOR_WE",
        },
        {
            text = ccb.content.text("I'll come back later for that.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
