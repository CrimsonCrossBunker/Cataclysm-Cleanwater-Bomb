local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
    line = ccb.content.text("Can you think of anything else we might need, or should we put this into action?"),
    replies = {
        {
            text = ccb.content.text("Let's go get your uncle back."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_be75d0d448ce") },
        },
        {
            text = ccb.content.text("I've changed my mind.  I think it's better we take my vehicle, and just leave them out of it."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("I'm a bit worried about defenses.  Do you folks have any armor or equipment to help keep yourselves safe?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
            when = predicates.handler("w16b_p_dda_80c4c2e841bf"),
        },
        {
            text = ccb.content.text("I think we need some kind of secure fallback point for the family, maybe a defensive wall?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
            when = predicates.handler("w16b_p_dda_c2662bc2e1a2"),
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
