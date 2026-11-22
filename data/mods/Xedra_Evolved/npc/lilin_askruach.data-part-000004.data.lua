local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TTALK_FRIEND_FOLLOWER_RUACH_DRAIN_YES",
    line = {
        when = predicates.has_effect("interlocutor", "effect_lilin_ruach_drain_side_effects"),
        yes = ccb.content.text("Already needing more?  I suppose that if you really need it, then you can take some more from me."),
        no = ccb.content.text("Sure!  Anything to help you feel better."),
    },
    replies = {
        {
            text = ccb.content.text("[Take some ruach] Thank you.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
            actions = { actions.handler("w16b_a_xedra_evolved_b286adc5eda4") },
        },
        {
            text = ccb.content.text("[Take some ruach] Thank you.  See you later."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_xedra_evolved_b286adc5eda4") },
        },
        {
            text = ccb.content.text("I changed my mind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_KINDA",
    line = {
        when = predicates.has_effect("interlocutor", "effect_lilin_ruach_drain_side_effects"),
        yes = ccb.content.text("This soon?  Fine, you can have some more.  But next time I'd prefer you ask someone else."),
        no = ccb.content.text("Yeah, you can.  but you better not take any more than you need."),
    },
    replies = {
        {
            text = ccb.content.text("[Take some ruach] Thank you.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
            actions = { actions.handler("w16b_a_xedra_evolved_b286adc5eda4") },
        },
        {
            text = ccb.content.text("[Take some ruach] Thank you.  See you later."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_xedra_evolved_b286adc5eda4") },
        },
        {
            text = ccb.content.text("I changed my mind."),
            next_topic = "TALK_DONE",
        },
    },
}
