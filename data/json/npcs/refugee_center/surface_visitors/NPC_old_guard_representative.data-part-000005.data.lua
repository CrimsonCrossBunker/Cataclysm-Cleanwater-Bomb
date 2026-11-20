local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_Refuse_Boris_Mission_1",
    line = ccb.content.text("I'm sorry, but I can't leave my post here, and I just don't have the human resources even for a project like that."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_OLD_GUARD_REP" } },
}
