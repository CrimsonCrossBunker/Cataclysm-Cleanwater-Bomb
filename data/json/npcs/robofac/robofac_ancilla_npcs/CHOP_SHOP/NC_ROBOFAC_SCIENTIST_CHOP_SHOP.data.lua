local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP" },
    line = ccb.content.text("&The scientist looks shocked to see you, and quickly tucks a large object under their lab coat.  They then address you with a quivering, yet indignant tone.  \"Wh-who are you?  How did you get in here?  You shouldn't be here.\""),
    replies = {
        {
            text = ccb.content.text("I'm here for the alien - the robot you abducted.  Where is it?"),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_EXODII_1",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_CHOP_SHOP"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_got_exodii_chop_shop_head" } })) }),
            actions = { actions.handler("w16b_a_dda_a31f883c77dc") },
        },
        {
            text = ccb.content.text("Your program has been shut down by the Hub 01 IRB.  Anything to say for yourself?"),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_KILL_ORDERS_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"),
        },
        {
            text = ccb.content.text("What is this place?  Who are you?"),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_QUESTIONS",
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_dda_26bbdddd7140") },
        },
        {
            text = ccb.content.text("I don't want any trouble.  I'm leaving."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_55aff17d03e3") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_QUESTIONS" },
    line = ccb.content.text("&They relax some, but still keep a defensive posture, tightly gripping their lab coat.  \"I'm here doing important work for the future of all mankind.  But I'm-I'm-I'm not valuable to you.  P-please, don't hurt me.  Just take the tools and the medical supplies, and go.  If you go quickly, I-I-I promise I won't call the guards.  Please.\""),
    replies = {
        {
            text = ccb.content.text("I'm here for the alien - the robot you abducted.  Where is it?"),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_EXODII_1",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_CHOP_SHOP"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_got_exodii_chop_shop_head" } })) }),
            actions = { actions.handler("w16b_a_dda_a31f883c77dc") },
        },
        {
            text = ccb.content.text("The intercom sent me.  Your program has been shut down by the IRB.  Anything to say for yourself?"),
            next_topic = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_KILL_ORDERS_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP"),
        },
        {
            text = ccb.content.text("[Move to attack]"),
            next_topic = "TALK_DONE",
            actions = { "hostile", actions.handler("w16b_a_dda_7ba43a77c10e") },
        },
        {
            text = ccb.content.text("I don't want any trouble.  I'm leaving."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_55aff17d03e3") },
        },
    },
}
