local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_LEARNS_U_CYBORG_2",
    line = ccb.content.text("Curious.  Very curious.  We'll be interested to follow your… let us say, progress, with these Exodii.  We are glad you still seem so human."),
    replies = {
        {
            text = ccb.content.text("So about those services…"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("Right… maybe we'll talk again sometime soon."),
            next_topic = "TALK_DONE",
        },
    },
}
