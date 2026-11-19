local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JESSE",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Leave our property, Marshal."),
        no = ccb.content.text("Hello.  We don't see many people these days."),
    },
    replies = {
        {
            text = ccb.content.text("Yeah, I'm a Marshal, what are you going to do about it?"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            opinion = { trust = -20, value = -20 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("Hi, it looks like you are doing well here."),
            next_topic = "TALK_ISHERWOOD_JESSE_TALK1",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
            actions = { actions.set_actor_value("speaker", "u_met_Jesse_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, Jack and Claire suggested I come down here and meet you."),
            next_topic = "TALK_MET_JACK_CLAIRE",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}
