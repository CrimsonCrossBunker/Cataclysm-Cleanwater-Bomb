local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_MIGO_BASE",
    line = ccb.content.text("They made their way to this weird spire like structure, I've never seen anything like it, it glistened in the sun like something organic.  I think they could be holding Barry there, I've seen them arrive and leave with other humans."),
    replies = {
        {
            text = ccb.content.text("I might be able to help you get Barry back, but we've got to plan this out."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY",
            when = predicates.handler("dlg_p_dda_4018badfc82f"),
            actions = { actions.offer_mission("MISSION_ISHERWOOD_CHRIS_1") },
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
