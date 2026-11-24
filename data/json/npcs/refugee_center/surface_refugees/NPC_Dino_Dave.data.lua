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

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different",
    line = ccb.content.text("*nods deeply.  \"We are, for where we once were in chaos, now we are at peace.  In time, this shall bring wisdom, but we must ponder on these great changes.\""),
    replies = {
        {
            text = ccb.content.text("Were you like this, uh, before?  Did you use to have a doctor or anything?"),
            next_topic = "TALK_DINODAVE_Different2",
        },
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different2",
    line = ccb.content.text("We were… I… we can scarcely remember those times.\"  Dave looks pained.  \"No, we had no doctor.  We didn't need one.  We had a job and… and… we don't like to talk about this."),
    replies = {
        {
            text = ccb.content.text("Come on, Dave.  We're friends.  I won't use this against you or anything."),
            next_topic = "TALK_DINODAVE_Different3",
        },
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Different3",
    line = ccb.content.text("*winces.  \"It is true.  You have earned some truth, but we… we find it hard to give.  We had a job, an education.  Prestige.  It is all very faint now.\"  He touches a stainless steel ring on his pinky finger, looking lost in thought.  \"We don't know why that man left, and this one remains.  Perhaps that is some wisdom that will come with time, or perhaps it is a door best left closed.\""),
    replies = {
        {
            text = ccb.content.text("How are things going up here on the roof?"),
            next_topic = "TALK_DINODAVE_Roof",
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Roof",
    line = ccb.content.text("*gestures about his new home.  \"We have everything we wanted.  They cannot see us here, and our mind is at peace.  We go outside as we need, and the safety we have received here stays with us, as long as we are careful about it.  In time, perhaps we will again have need of your noble services.\""),
    replies = {
        {
            text = ccb.content.text("You seem different."),
            next_topic = "TALK_DINODAVE_Different",
        },
        {
            text = ccb.content.text("You know, this place is surprisingly nice, for a cardboard fortress."),
            next_topic = "TALK_DINODAVE_Cardboard",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "finished", { scope = "speaker", key = "dialogue_dave_u_cardboard_gift" } })), predicates.negate(predicates.any_equal({ "in_progress", { scope = "speaker", key = "dialogue_dave_u_cardboard_gift" } })) }),
            actions = { actions.set_actor_value("speaker", "dialogue_dave_u_cardboard_gift", "in_progress"), actions.handler("dlg_a_dda_0e3c1ae98309") },
        },
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Cardboard",
    line = ccb.content.text("*bows deeply.  \"Thank you.  Our expertise with the most sacred of materials comes from a past long gone.\"  He gazes off into the distance, lost in thought.  You wait, but he doesn't talk again."),
    replies = { { text = ccb.content.text("Uh, you there?"), next_topic = "TALK_DINODAVE_Gift" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift",
    line = ccb.content.text("You've given us an idea, a way we could repay a small fraction of your aid.  Come back in a day, and your blessing will be here for you."),
    replies = {
        {
            text = ccb.content.text("See you in a day, then."),
            next_topic = "TALK_DINODAVE_Gift_Bye",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift_Bye",
    line = ccb.content.text("Make sure you don't let the sandman in.  He can't be trusted."),
    replies = {
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift_Given",
    line = ccb.content.text("Indeed, my knight.  I was hesitant to grant you this power, but you have proven your worth and fealty many times over.  Make sure it does not fall into the wrong hands.  May it help you on your journey."),
    replies = {
        {
            text = ccb.content.text("[Take the gift.]"),
            next_topic = "TALK_DINODAVE_Gift_Bye",
            actions = { actions.handler("dlg_a_dda_4db2f5d30388") },
        },
    },
}
