local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
