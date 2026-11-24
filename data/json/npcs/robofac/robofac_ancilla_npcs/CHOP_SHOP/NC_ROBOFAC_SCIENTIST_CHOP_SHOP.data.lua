local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    name = ccb.content.text("Hub Scientist"),
    job_description = ccb.content.text("A Hub 01 scientist."),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_worn",
    carry = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_carry",
    weapon = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP_wield",
    skills = { { skill = "firstaid", bonus = 8 }, { skill = "electronics", bonus = 8 } },
}

ccb.content.define_npc {
    id = "robofac_chop_shop_scientist_1",
    unique_name = ccb.content.text("Michael Harlow"),
    suffix = ccb.content.text("Hub Scientist"),
    class = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    attitude = 1,
    mission = "GUARD",
    chat = "NC_ROBOFAC_SCIENTIST_CHOP_SHOP",
    faction = "robofac_auxiliaries_chop_shop",
    on_death = "robofac_chop_shop_scientist_death",
}

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
