local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_BRING_BOANN_JABBERWOCK_HEART_OFFER" },
    line = ccb.content.text("Prove to me that you have the heart of a knight.  Bring me the putrid heart of a Jabberwock."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the Jabberwock?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART")),
            actions = { actions.assign_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
    line = ccb.content.text("You will need incredible melee skills to handle this or an impressive gun.  Otherwise it does not have hidden tricks or notable intelligence so it'll be a straightforward fight."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the Jabberwock?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART")),
            actions = { actions.assign_mission("MISSION_BRING_BOANN_JABBERWOCK_HEART"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
