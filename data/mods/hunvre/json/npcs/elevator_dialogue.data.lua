local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "elevator_controls_call_success",
    line = ccb.content.text("&You hear the elevator arrive."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

-- TODO: Make this have actual consequences
ccb.content.define_dialogue_topic {
    id = "elevator_controls_call_fail",
    line = ccb.content.text("&You fail to make the elevator move."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}
