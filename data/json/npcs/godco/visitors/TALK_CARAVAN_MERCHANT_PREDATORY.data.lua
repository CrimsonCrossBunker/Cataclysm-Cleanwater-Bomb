local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_NoTalk",
    line = ccb.content.text("Get out of here, <name_b>."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_DONE" } },
}
