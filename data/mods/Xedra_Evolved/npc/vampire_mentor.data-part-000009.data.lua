local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER" },
    line = {
        when = predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"),
        yes = ccb.content.text("I cannot assist you until you bring back the components.  How is the search going?"),
        no = ccb.content.text("You are now ready to fully walk the path.  This time, you'll need to gather a few components before the ritual can be done.  I'll give you this book so you know what to look for."),
    },
    replies = {
        {
            text = ccb.content.text("I'll begin the search then."),
            next_topic = "TALK_VAMPIRE_MENTOR_GATHER_TIER_5",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
            actions = { actions.handler("dlg_a_xedra_evolved_ce0106b73c6d"), actions.set_actor_value("speaker", "received_mentor_book", "yes"), actions.assign_mission("GET_COMPONENTS_FOR_TIER_5") },
        },
        {
            text = ccb.content.text("A book?  You said I would only need a few components!"),
            next_topic = "TALK_VAMPIRE_MENTOR_WHY_BOOK",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
        },
        {
            text = ccb.content.text("It's progressing.  See you."),
            next_topic = "TALK_DONE",
            when = predicates.has_mission("GET_COMPONENTS_FOR_TIER_5"),
        },
        {
            text = ccb.content.text("It'll wait for now.  See you."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")),
        },
    },
}
