local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CLAIRE",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Is that a U.S. Marshal's badge you're wearing?"),
        no = ccb.content.text("Hi, what brings you here?"),
    },
    replies = {
        {
            text = ccb.content.text("Yes, I'm a marshal."),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CLAIRE",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Hi, nice farm you have here."),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TALK1",
            actions = {
                actions.set_actor_value("speaker", "u_met_Claire_Isherwood", "yes"),
                actions.set_actor_value("speaker", "u_met_an_isherwood", "yes"),
            },
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hi, Jack suggested I stop by and say hello."),
            next_topic = "TALK_ISHERWOOD_CLAIRE_TALK3",
            actions = { actions.set_actor_value("speaker", "u_met_Claire_Isherwood", "yes") },
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Let's trade."),
            actions = { "start_trade" },
            next_topic = "TALK_ISHERWOOD_CLAIRE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text("Hey, when would more of this stuff be ready?"),
            next_topic = "TALK_ISHERWOOD_CLAIRE_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}
