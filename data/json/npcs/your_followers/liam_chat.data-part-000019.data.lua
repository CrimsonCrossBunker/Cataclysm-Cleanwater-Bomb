local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
    line = ccb.content.text("I guess I get why the one Boris guy can't do it but I don't quite see why we have to go around asking everyone for him.  He lives here!  Anyway, you know I'm okay with getting my hands dirty, if you want to go offer to help him out I'll get busy with a scrubby.  I've cleaned worse things out of the Foodplace washroom.  Hell, I've cleaned worse things out of the back of my van when I was running for Amazon.\"  He gets a thousand-yard-stare for a moment.  \"Let's not discuss this any more."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_ec2c95793aea") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks Liam, I knew I could count on you."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
