local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LUKE_Truck_Bomb_Plan_Done",
    line = ccb.content.text("I've got everything I need to make this breaching truck for us.  Thanks!"),
    replies = { { text = ccb.content.text("[heck yeah]"), next_topic = "TALK_ISHERWOOD_LUKE_TOPICS" } },
}
