local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_machineFood",
    line = ccb.content.text("A generous soul, are we?  That's not what I was expecting, but I'll see to it."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            actions = {
                actions.clear_actor_value("speaker", "mission_completed_godco_corrie_machine"),
                actions.set_actor_value("speaker", "mission_reward_godco_machine_reward", "ration"),
                actions.set_actor_value("speaker", "mission_reward_unclaimed_machine_reward", "yes"),
            },
            next_topic = "TALK_DONE",
        },
    },
}
