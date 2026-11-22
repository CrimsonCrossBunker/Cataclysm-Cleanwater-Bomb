local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_machineIcon",
    line = ccb.content.text("Here's your money.  Don't spend it all in one place."),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_DONE",
            actions = { actions.clear_actor_value("speaker", "mission_completed_godco_corrie_machine"), actions.set_actor_value("speaker", "mission_reward_godco_machine_reward", "icon"), actions.set_actor_value("speaker", "mission_reward_unclaimed_machine_reward", "yes"), actions.handler("dlg_a_dda_5b6141887928") },
        },
    },
}
