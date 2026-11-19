local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_FOOD",
    line = ccb.content.text("I've always loved crêpes."),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_KINDRED_COOPER" } },
}
