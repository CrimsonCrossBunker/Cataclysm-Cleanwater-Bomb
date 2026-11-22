local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_1",
    line = {
        joined = {
            ccb.content.text("*sits in a surprisingly well-built room made of lovingly assembled cardboard boxes.  The area is quite clean and cozy.  The whole building is built on top of cargo pallets, insulated with scraps, and waterproofed with plastic.  It shows an unexpected amount of design prowess.  \"Hello, my noble knight errant,\" Dave intones, his voice solemn."),
            {
            when = predicates.any_equal({ "finished", { scope = "speaker", key = "dialogue_dave_u_cardboard_gift" } }),
            yes = ccb.content.text("  \"We hope our gift to you will help repay our great debt.\""),
            no = ccb.content.text("  \"We owe you a great debt for your actions of the past.  Some day, we shall repay it.  Until then, you are welcome here, now and always.\""),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi Dave.  You seem different."),
            next_topic = "TALK_DINODAVE_Different",
        },
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("You said something about a gift?"),
            next_topic = "TALK_DINODAVE_Gift_Given",
            when = predicates.handler("dlg_p_dda_e94432d8e8ca"),
            actions = { actions.set_actor_value("speaker", "dialogue_dave_u_cardboard_gift", "finished") },
        },
    },
}
