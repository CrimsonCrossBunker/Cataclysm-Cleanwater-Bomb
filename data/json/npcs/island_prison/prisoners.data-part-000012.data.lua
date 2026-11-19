local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_LEADER_DEMANDED_SUBSTANTIAL_REWARD",
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "mission_military_id_prisoner_leader_mission", "yes"),
            },
        },
    },
    line = ccb.content.text("I'm afraid you're not in the position to demand anything from me, <name_b>.  You're done here, leave."),
    replies = {
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!  You'll regret that!"),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
        { text = ccb.content.text("Okay, fine.  Cheapskate!"), next_topic = "TALK_DONE" },
    },
}
