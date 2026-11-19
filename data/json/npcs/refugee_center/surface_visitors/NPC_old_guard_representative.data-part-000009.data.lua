local ccb = require("ccb")

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
