local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I see that badge, I think you need to keep on walking, straight off this property."),
        no = ccb.content.text("Hi, what brings you here?"),
    },
    on_enter = {
        { once = "u_met_lisa", actions = { actions.set_actor_value("speaker", "u_met_lisa_isherwood", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            when = predicates.wears("speaker", "badge_marshal"),
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("Hi, this is a nice farm, your family lives here?"),
            next_topic = "TALK_ISHERWOOD_LISA_TALK1",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, I'm looking for Jesse."),
            next_topic = "TALK_LISA_JESSE",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_about_jesse" } }) }),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, I'm looking for Chris."),
            next_topic = "TALK_LISA_CHRIS",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("I talked to Chris about rescuing Barry.  He thinks you might be able to help."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALKED_TO_LISA",
            when = predicates.handler("dlg_p_dda_c82f3dfba09e"),
        },
        {
            text = ccb.content.text("I talked to Chris about rescuing Barry.  He thinks you might be able to help."),
            next_topic = "TALK_ISHERWOOD_CHRIS_NOT_TALKED_TO_LISA",
            when = predicates.handler("dlg_p_dda_6ddab87473f0"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_TALK1",
    line = ccb.content.text("My family owns all the land around here, my parents are out in the barn and my other family is down the road."),
    replies = {
        { text = ccb.content.text("Ok, I'll go find them."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_JESSE",
    line = ccb.content.text("Mom is in her office, in the barn.  Be careful that you don't let our horses out."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_CHRIS",
    line = ccb.content.text("Chris is out hunting or something right now."),
    replies = {
        { text = ccb.content.text("Oh, ok."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Or something?"), next_topic = "TALK_LISA_CHRIS2" },
        { text = ccb.content.text("Nice talking to you, bye."), next_topic = "TALK_DONE" },
    },
}
