local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BOSS_Lapin_01_Story1",
    line = ccb.content.text("Actually, yeah.  It's a long shot but we could follow it if you like.  I ran into another survivor once - don't think she made it, she was heading to a nearby mall, and that place was overrun.  She mentioned seeing a guy taking care of his cabin in the woods though.  Said she thought about checking on him, but that was when things were all going nuts, and she decided against it.  I got some directions and never followed through on it."),
    replies = {
        {
            text = ccb.content.text("Let's see how to get there and go check on the guy."),
            next_topic = "BOSS_Lapin_01_Story2",
            when = predicates.handler("dlg_p_dda_ff5d62955c4b"),
            actions = { actions.assign_mission("directions_lapin") },
            switch = true,
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BOSS_Lapin_01_Story2",
    line = ccb.content.text("*shows you on your map where to find it.  \"This looks right to me.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "directions_lapin",
    name = ccb.content.text("Check out that cabin in the woods"),
    description = ccb.content.text("Maybe still a guy in a cabin in the woods."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Cabin_Lapin", terrain = "cabin_lapin", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_lapin",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Maybe still a guy in a cabin in the woods."),
        offer = ccb.content.text("Maybe still a guy in a cabin in the woods."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
