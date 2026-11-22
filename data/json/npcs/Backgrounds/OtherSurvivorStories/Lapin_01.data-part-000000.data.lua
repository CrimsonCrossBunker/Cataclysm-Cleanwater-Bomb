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
