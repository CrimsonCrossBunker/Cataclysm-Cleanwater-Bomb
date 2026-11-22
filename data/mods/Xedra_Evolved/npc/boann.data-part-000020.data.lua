local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_STAR_CROWN_HOUND_OFFER" },
    line = ccb.content.text("Knight, I ask you to kill a star-crowned hound.  This will be a difficult challenge but I trust that you will prevail against this mighty foe.  Kill it and a necklace that will amplify your magical abilities will be yours."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the hound?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
        },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
        },
        {
            text = ccb.content.text("I'm not sure if I want to do it.  See you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
    line = ccb.content.text("It is strong but slow, so disengaging is possible.  It will summon hounds, but they quickly fade away so they aren't that much of an issue compared to it.  Stand away from corners in walls as it can teleport to them.  It has no armor against fire, electricity and blunt weapons but it quickly heals all its wounds so continuous heavy damage is the key to kill it.  If you cannot manage to injure it, do not hesitate to withdraw and try another way to kill it."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where's the hound?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
            when = predicates.negate(predicates.has_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN")),
            actions = { actions.assign_mission("MISSION_KILL_STAR_CROWN_HOUND_FOR_BOANN"), actions.handler("dlg_a_xedra_evolved_cc650a073f83") },
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
