local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
    line = ccb.content.text("Probably.  They'd want to, for sure.\"  He looks thoughtful.  \"I'm sure we could use more help, but this isn't my strong suit.  Let me think about it.  If you have any ideas, run them by me."),
    on_enter = {
        { once = "chris_thinking_about_plan", actions = { actions.handler("dlg_a_dda_6a23459ec0bd") } },
    },
    replies = {
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("OK.  Let's talk about it again in a bit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN",
    line = ccb.content.text("Yeah.  I think they should cover our exit.  We've got an old truck they could set up as a platform, where Dad can put down covering fire without his knee being an issue.  Eddie can drive, instead of shoot, and Luke or Mom can be ready with some first aid supplies.  Then when we get out, we've got an easy getaway set up, and there's less chance of us getting flanked while we're in there looking for Barry.\"  He looks at you, suddenly nervous.  \"Is that a good plan?"),
    replies = {
        {
            text = ccb.content.text("Seems like a good plan to me."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
            actions = { actions.handler("dlg_a_dda_ccd3f3c98ae9") },
        },
        {
            text = ccb.content.text("I think it's better we take my vehicle, and just leave them out of it."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
            actions = { actions.handler("dlg_a_dda_f193e384473c") },
        },
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("I don't think one farmer with a hunting rifle is going to be enough to keep our backs safe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
            when = predicates.handler("dlg_p_dda_58b78813d1ec"),
        },
        {
            text = ccb.content.text("I think we need some kind of secure fallback point for the family, maybe a defensive wall?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
            when = predicates.handler("dlg_p_dda_d878d0dca848"),
        },
        {
            text = ccb.content.text("We're going to need some way to breach the tower itself, possibly some form of explosives.  Do you know anyone who could help us with that?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_been_to_migos" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "chris_planned_for_bomb" } })) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
