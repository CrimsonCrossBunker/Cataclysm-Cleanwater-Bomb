local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_FIVE_MI_GO_GUARDS_OFFER" },
    line = ccb.content.text("A knight must be able to face harsh conditions.  Kill five Mi-Go guards and you'll receive an object able to refuel your magical energy."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the guards?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
    line = ccb.content.text("Something to protect yourself from the fumes and heat is a must.  They are smart enough to feel fear, so if they're injured enough they'll stop attacking and try to flee."),
    replies = {
        {
            text = ccb.content.text("I'll do it. Where's the guards?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_FIVE_MI_GO_GUARDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
