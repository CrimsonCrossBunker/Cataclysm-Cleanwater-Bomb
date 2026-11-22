local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_EXODII_1" },
    line = ccb.content.text("&The scientist frowns, and you see tears well up in their eyes.  They set the object they were hiding in front of them - the head of some otherworldly robot - and put their hands up in resignation.  \"Abduct?  No, please, i-i-it was a killer robot.  And it is valuable to me.  Please, no.  Don't take it.  You'll just set humanity back - months of progress lost.  This isn't valuable to scrappers - just to science.  P-please, just take the tools, the medical supplies, whatever you want, and go.  And p-please, don't hurt me."),
    replies = {
        {
            text = ccb.content.text("Give me that now, and I'll go in peace."),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_EXODII_2",
            actions = { actions.handler("dlg_a_dda_26eafe050b55"), actions.set_actor_value("speaker", "dialogue_got_exodii_chop_shop_head", "yes") },
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_dda_243d28d9cb71") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_EXODII_2" },
    line = ccb.content.text("&The scientist starts to sob.  \"Fine, take it.  P-please don't hurt me.  I-I-I have children."),
    replies = {
        {
            text = ccb.content.text("[Take the head and go]"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_dda_685ad03514ae") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_KILL_ORDERS_1" },
    line = ccb.content.text("&The scientist scowls, swallows, and visibly tenses up.  \"No.  No, they wouldn't.  I send weekly reports.  Detailed reports.  I follow all of their protocols.  This can't be.  Please, I'm begging you, tell them I'm making progress.  That I'm still following the same protocols.  This is impossible.  Please!\""),
    replies = {
        {
            text = ccb.content.text("The IRB has hired me to execute you, and to end your unethical program."),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_KILL_ORDERS_2",
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_dda_638146741a89") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_KILL_ORDERS_2" },
    line = ccb.content.text("&The scientist grasps their hands together and curls their shoulder up.  They start to sob.  \"Un-unethical?  No.  P-p-please don't hurt me.  Take the supplies.  Take whatever you want.  I-I-I have children.  Please!\""),
    replies = {
        {
            text = ccb.content.text("[Stay silent and decide what to do]"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("dlg_a_dda_fcae718a6085") },
        },
    },
}
