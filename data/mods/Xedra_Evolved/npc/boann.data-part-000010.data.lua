local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_ARMORED_CENTIPEDE_OFFER" },
    line = ccb.content.text("A knight must know how to triumph despite their foe's armor.  Kill an armored centipede and I'll grant you an insignia, so you might be recognized as one of my knights."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the centipede?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_ARMORED_CENTIPEDE_ADVICE",
    line = ccb.content.text("Study the weak spots of weaker centipedes, it'll give you an advantage.  Its armor isn't as effective against blunt and piercing weapon than it is against slashing weapons and bullets."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the centipede?"),
            next_topic = "TALK_KILL_ARMORED_CENTIPEDE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_ARMORED_CENTIPEDE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
