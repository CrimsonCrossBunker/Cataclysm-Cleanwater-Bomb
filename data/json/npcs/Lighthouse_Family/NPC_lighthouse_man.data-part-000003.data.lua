local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaned",
    line = ccb.content.text("<its_safe>  Let's clean the next floor."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_cleaned_done",
    line = ccb.content.text("<its_safe>  Let's return to the first floor."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
