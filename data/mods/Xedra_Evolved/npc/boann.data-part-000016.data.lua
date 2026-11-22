local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TITAN_BEETLE_OFFER" },
    line = ccb.content.text("A knight must be able to triumph over all beasts.  Kill a titan stag beetle and you'll receive a magical musical instrument."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the beetle?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TITAN_BEETLE_ADVICE",
    line = ccb.content.text("Mundane weapons won't do much so try to find something that bypasses its armor.  It's also very slow so keeping your distance is easy.  Learning the weak points of smaller beetles and using high-power ammunitions can work too but expect its shell to block most shots."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the beetle?"),
            next_topic = "TALK_KILL_TITAN_BEETLE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TITAN_BEETLE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
