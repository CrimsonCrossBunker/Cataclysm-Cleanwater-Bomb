local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data",
    line = ccb.content.text("Backup complete!"),
    replies = {
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5c7b220017bf") },
        },
    },
}
