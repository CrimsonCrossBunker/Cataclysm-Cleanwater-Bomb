local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL_JACK",
    line = ccb.content.text("You should get off my land, the government proved its incompetence with this catastrophe."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
