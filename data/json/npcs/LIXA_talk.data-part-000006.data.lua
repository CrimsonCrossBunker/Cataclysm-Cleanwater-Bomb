local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data_need_id",
    line = ccb.content.text("ERROR:  access denied!  Reason: insufficient clearance level."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data_no_drive",
    line = ccb.content.text("ERROR:  no secure USB drive detected!  Please insert an appropriately secured USB drive before attempting to copy files."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}
