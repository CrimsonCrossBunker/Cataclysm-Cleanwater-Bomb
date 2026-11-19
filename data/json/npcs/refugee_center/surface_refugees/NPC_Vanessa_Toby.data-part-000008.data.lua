local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Refuse_Boris_Mission_1",
    line = ccb.content.text("Ha ha ha ha!  No."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("I don't know what I expected."), next_topic = "TALK_DONE" } },
}
