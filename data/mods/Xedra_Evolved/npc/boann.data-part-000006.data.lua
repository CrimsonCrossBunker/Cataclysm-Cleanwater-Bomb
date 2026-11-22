local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DOGTHING_OFFER" },
    line = ccb.content.text("A dog-like being has been found nearby.  Whatever it is, it's not a dog.  Kill it, and I will teach you how to see beyond barriers."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the dog?"),
            next_topic = "TALK_KILL_DOGTHING_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DOGTHING_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DOGTHING_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DOGTHING_ADVICE",
    line = ccb.content.text("Do not be deceived by its looks.  It is not a regular dog.  Be very careful as we do not know what it can do."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the dog?"),
            next_topic = "TALK_KILL_DOGTHING_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DOGTHING_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DOGTHING_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
