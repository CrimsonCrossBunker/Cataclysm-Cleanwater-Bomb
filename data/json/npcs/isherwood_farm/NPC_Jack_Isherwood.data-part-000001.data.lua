local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Is that a U.S. Marshal's badge you're wearing?"),
        no = ccb.content.gendered_line("Hello traveler, what brings you here?", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("Yes, I'm a marshal."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_JACK",
            actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_JACK",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("I'm here to deliver some resources."),
            next_topic = "TALK_ISHERWOOD_JACK_RESOURCES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_scavenge_for_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("This is a lot of land, you been here since the collapse?"),
            next_topic = "TALK_ISHERWOOD_JACK_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Jack_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Have anything to trade?"),
            next_topic = "TALK_ISHERWOOD_JACK",
            actions = { "start_trade" },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hey, when would more of this stuff be ready?"),
            next_topic = "TALK_ISHERWOOD_JACK_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}
