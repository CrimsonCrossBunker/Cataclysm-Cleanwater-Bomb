local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_IMPOSSIBLE",
            when = predicates.all({ predicates.has_trait("speaker", "LILIN_TRAITS"), predicates.any({ predicates.has_trait("interlocutor", "LILIN_TRAITS"), predicates.has_trait("interlocutor", "BLOOD_OF_SAINTS") }), predicates.negate(predicates.has_trait("speaker", "TURN_INTO_OWL_TRAITS")), predicates.negate(predicates.has_trait("speaker", "LILIN_WAR_OWL_FORM_TRAITS")) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_NOPE",
            when = predicates.handler("dlg_p_xedra_evolved_cc4fda4d8531"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_OWL_FORM",
            when = predicates.all({ predicates.has_trait("speaker", "LILIN_TRAITS"), predicates.any({ predicates.has_trait("speaker", "TURN_INTO_OWL_TRAITS"), predicates.has_trait("speaker", "LILIN_WAR_OWL_FORM_TRAITS") }) }),
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_NOPE",
    line = ccb.content.text("Nope.  I'm not giving you any of mine.  Find someone else if you want some."),
    replies = {
        {
            text = ccb.content.text("Got it.  Can we talk about something else?"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text("Got it.  See you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_IMPOSSIBLE",
    line = ccb.content.text("(you sense that you won't be able to drain this person's ruach, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}

-- separate dialogue to include a more explicit message about why the follower cannot be drained.
ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_OWL_FORM",
    line = ccb.content.text("(you sense that you won't be able to drain this person's ruach while you are maintaining your owl transformation, so you decide to not ask your question)"),
    replies = {
        { text = ccb.content.text("(Ask them about something else)"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text("(Go do something else)"), next_topic = "TALK_DONE" },
    },
}
