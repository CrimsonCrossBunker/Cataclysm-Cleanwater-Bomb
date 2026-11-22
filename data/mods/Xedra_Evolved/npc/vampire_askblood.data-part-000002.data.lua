local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_FRIEND_Liam", "TALK_FRIEND_Luo" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I drink some of your blood?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_BLOODFEED_NOPE",
            when = predicates.handler("dlg_p_xedra_evolved_6cda2b3c8c80"),
        },
    },
}
