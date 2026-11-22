local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_DREAMFORGED_AUTOMATON_OFFER" },
    line = ccb.content.text("A rampaging automaton has been spotted.  Destroy it, and you'll be granted a great weapon."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the automaton?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_DREAMFORGED_AUTOMATON_ADVICE",
    line = ccb.content.text("My scouts mentioned that it relies on electricity to attack.  Find a way to shield yourself against that, and it'll be much easier to kill.  They also mentioned how damaged the automaton's exposed insides are, so I wouldn't attempt to use weapons that only damage the insides if I were you."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the automaton?"),
            next_topic = "TALK_KILL_DREAMFORGED_AUTOMATON_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_DREAMFORGED_AUTOMATON_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
