local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_TWO_MARCH_LORDS_OFFER" },
    line = ccb.content.text("Prove your allegiance to me.  Kill two March Lords so all will see your defense of this world."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_TWO_MARCH_LORDS_ADVICE",
    line = ccb.content.text("They are fearsome opponents and have warriors at their command but lack long-range attacks.  You can find them in the border patrol offices or during one of their rare hunts amidst the mists."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_KILL_TWO_MARCH_LORDS_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_TWO_MARCH_LORDS_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
