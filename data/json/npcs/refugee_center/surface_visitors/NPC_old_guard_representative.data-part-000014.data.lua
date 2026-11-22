local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0",
    line = ccb.content.text("The cargo?  That's the kind of optional information worth a small supplement."),
    replies = {
        {
            text = ccb.content.text("This wasn't the deal and you're starting to wear my nerves thin asshole, tell me or I'll make you pick your teeth off the floor."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "failed_representative_cargo_trial" } })),
            trial = { kind = "intimidate", difficulty = 50, modifiers = { { score = "FEAR", scale = 2 }, { score = "TRUST", scale = -2 } } },
            success = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1" },
            failure = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_INTIMIDATE_FAILURE", actions = { actions.set_actor_value("speaker", "failed_representative_cargo_trial", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Come on, you already got what you wanted, are you really trying to fleece me?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "failed_representative_cargo_trial" } })),
            trial = { kind = "persuade", difficulty = 50, modifiers = { { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 2 } } },
            success = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1" },
            failure = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_PERSUADE_FAILURE", actions = { actions.set_actor_value("speaker", "failed_representative_cargo_trial", "yes") } },
        },
        {
            text = ccb.content.text("[25 merch] This better be worth."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1",
            when = predicates.has_inventory("speaker", "FMCNote", 25),
            actions = { actions.transfer_items("FMCNote", 25) },
            failure_topic = "TALK_DONE",
            failure_explanation = ccb.content.text("You don't have enough."),
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_INTIMIDATE_FAILURE",
    line = ccb.content.text("& He tenses and grits his teeth for a moment before regaining his composure.  \"No, we both know you won't.  Let's pretend this never happened, offer's still up.\""),
    replies = { { text = ccb.content.text("Fine…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_PERSUADE_FAILURE",
    line = ccb.content.text("What are you talking about, I'm not \"fleecing\" anyone, you're free to make the retrieval with the information you have, all I'm offering is purely optional information for a reasonable price."),
    replies = { { text = ccb.content.text("Fine…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1",
    line = ccb.content.text("Fine.  The heli was transporting a few sets of those combat exoskeletons back from a DoubleTech testing site way out west, the ones they were showing on TV before all this, I'm sure a guy like you could put those to good use.  I won't risk my life for one but if you succeed and would like to trade them you know where to find me."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
