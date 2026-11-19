local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_DESCRIPTION_WEAK",
    line = ccb.content.text("The bunker has a field of solar panels nearby but some of the staff damaged them badly when they turned into those… things.  I need you to gather at least 12 panels so I can stabilize my power output."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll see what I can gather."),
            next_topic = "TALK_BALTHAZAR_MEET_ACCEPTED_MISSION_WEAK",
            actions = { actions.assign_mission("MISSION_GET_SOLAR_PANELS_BALTHAZAR") },
        },
        {
            text = ccb.content.text("What's in it for me?"),
            next_topic = "TALK_BALTHAZAR_MEET_REWARD_WEAK",
        },
        {
            text = ccb.content.text("Why don't these robots attack me?"),
            next_topic = "TALK_BALTHAZAR_MEET_ROBOT_WEAK",
        },
        {
            text = ccb.content.text("Hold on, why are you locked in here?"),
            next_topic = "TALK_BALTHAZAR_MEET_BUNKER_WEAK",
        },
        {
            text = ccb.content.text("So who are you?"),
            next_topic = "TALK_BALTHAZAR_MEET_BALTHAZAR_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_ACCEPTED_MISSION_WEAK",
    line = ccb.content.text("You'll help me?!  Thank you so, so much.  I really wasn't looking forward to dying a slow death in here.  I think the power will be enough for a while but please hurry up."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_balthazar_u_discovered_balthazar_fac", "yes"),
            },
            once = "discovered_balthazar",
        },
    },
    replies = {
        {
            text = ccb.content.text("What should I do once I bring them to you?"),
            next_topic = "TALK_BALTHAZAR_MEET_DELIVERY_WEAK",
        },
        { text = ccb.content.text("Walk away."), next_topic = "TALK_DONE" },
    },
}
