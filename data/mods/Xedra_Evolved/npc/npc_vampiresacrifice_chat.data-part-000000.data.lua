local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION",
            when = predicates.handler("dlg_p_xedra_evolved_f7e025645017"),
            actions = { actions.handler("dlg_a_xedra_evolved_f3e3449167a9") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE_MISSION_2",
            when = predicates.handler("dlg_p_xedra_evolved_0ed2fb4e6714"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_SACRIFICE",
            when = predicates.handler("dlg_p_xedra_evolved_6ccc3d78c9e3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can you tell me how much do you like me?"),
            next_topic = "TALK_FRIEND_FOLLOWER_NOT_SACRIFICE",
            when = predicates.handler("dlg_p_xedra_evolved_fe36e8fba264"),
        },
    },
}
