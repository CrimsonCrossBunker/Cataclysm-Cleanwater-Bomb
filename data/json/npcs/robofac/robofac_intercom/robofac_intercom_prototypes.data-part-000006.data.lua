local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
    line = ccb.content.text("We will begin work shortly.  Report back in two weeks for pickup."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG",
    line = ccb.content.text("We will begin work shortly.  Report back in around one and a half months for pickup."),
}
