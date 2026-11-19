local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_fail",
    line = ccb.content.text("<name_g>… I entrusted you with the most valuable thing that I have left, and you…"),
    replies = {
        {
            text = ccb.content.text("I'm sorry…"),
            next_topic = "TALK_DONE",
            native_actions = { "mission_failure", "clear_mission", "end_conversation" },
        },
    },
}
