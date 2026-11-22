local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TTALK_FRIEND_FOLLOWER_RUACH_DRAIN_YES",
            when = predicates.handler("dlg_p_xedra_evolved_12ee142e1d0d"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_KINDA",
            when = predicates.handler("dlg_p_xedra_evolved_d209ac6c7dc0"),
        },
    },
}
