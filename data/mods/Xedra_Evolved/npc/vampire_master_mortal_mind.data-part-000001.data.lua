local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MASTER_MORTAL_MIND",
    line = ccb.content.text("[You ponder your options and think about the blood you have in you]\n\nYou could spend a little blood to slightly influence their opinion of you.\n\nYou could spend more blood to make them your friend.\n\nOr you could spend a massive amount of blood to turn them into a renfield, a human obsessed with serving their vampire masters.  In this case the master is you."),
    replies = {
        {
            text = ccb.content.text("[Spend a little blood to make them like you a bit more]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
            actions = { actions.handler("dlg_a_xedra_evolved_de526d4c4753") },
            opinion = { trust = 1, value = 1 },
        },
        {
            text = ccb.content.text("[Spend a moderate amount of blood to make them your friend]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
            actions = { actions.handler("dlg_a_xedra_evolved_f1354bc7dded") },
            opinion = { trust = 3, fear = -1, value = 3, anger = -2 },
        },
        {
            text = ccb.content.text("[Spend a massive amount of blood to make them your renfield]"),
            next_topic = "TALK_YOUR_NEW_RENFIELD",
            when = predicates.handler("dlg_p_xedra_evolved_5f31aeb28f16"),
            actions = { actions.handler("dlg_a_xedra_evolved_1f9c71875b83"), actions.replace_mutation("interlocutor", "RENFIELD"), "follow" },
            opinion = { trust = 30, fear = -5, value = 30, anger = -30 },
        },
        {
            text = ccb.content.text("[Don't spend any blood]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_a18ecb6198e3"),
        },
        {
            text = ccb.content.text("[You do not have enough blood in you to manipulate someone's mind]"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_xedra_evolved_ea187e67e5c3"),
        },
    },
}
