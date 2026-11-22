local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GET_SHADOW_SINGULARITY_PIECE_OFFER" },
    line = ccb.content.text("There is a shadow that haunts the night.  Bring me proof that you killed it and I'll grant you the right to bear my banner."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GET_SHADOW_SINGULARITY_PIECE_ADVICE",
    line = ccb.content.text("To encounter it, stand alone or accompanied by at most two allies in a field or a forest at night.  It might take multiple nights for it to show itself so prepare something to do while you wait.  Light massively weaken it so ensure the battlefield is well lit.  Separate it from its minions, as it can create more than you'll manage to kill and heal its wounds over time.  It is also particularly resilient against bullets so engage in melee if you manage to get close enough."),
    replies = {
        {
            text = ccb.content.text("I'll do it."),
            next_topic = "TALK_GET_SHADOW_SINGULARITY_PIECE_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_GET_SHADOW_SINGULARITY_PIECE_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
