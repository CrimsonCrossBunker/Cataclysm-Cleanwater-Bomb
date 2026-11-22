local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_TRIFFID_HEART_OFFER" },
    line = ccb.content.text("I want you to brave the harshest environments.  Bring me a chunk of a triffid heart and I'll grant you a powerful set of armor."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the triffids?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_TRIFFID_HEART_ADVICE",
    line = ccb.content.text("Tear gas is deadly to them.  In addition, they don't get along with anything that isn't a triffid."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the triffids?"),
            next_topic = "TALK_GET_TRIFFID_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_TRIFFID_HEART_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Can I see the other quests first?"),
            next_topic = "TALK_QUEST_LIST",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}
