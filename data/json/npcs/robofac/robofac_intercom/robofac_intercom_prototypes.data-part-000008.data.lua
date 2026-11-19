local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_STARTED",
    line = ccb.content.text("Lovely.  Research will begin within the next few hours."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_STARTED",
    line = ccb.content.text("The combination should be a fairly simple matter.  Return in two days to pick up the finished product."),
}
