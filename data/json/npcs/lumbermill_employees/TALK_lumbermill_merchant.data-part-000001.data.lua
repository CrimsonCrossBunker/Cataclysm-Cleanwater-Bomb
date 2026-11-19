local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LUMBERMILL_RESTOCK",
    line = ccb.content.text("Workers will bring in a new shipment of lumber after <restock_time_point>."),
}
