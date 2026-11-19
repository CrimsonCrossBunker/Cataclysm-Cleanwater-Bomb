local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_FIELD_ASK_PURCHASE",
    line = ccb.content.text("We'll help plow the land and put up a sign to let everybody know it's yours.  Once it's plowed, you can hire some workers to plant or harvest the crops for a small fee of course.  Oh, and if you're growing anything we have a demand for, we'll gladly take it off your hands after the harvest."),
    replies = {
        {
            text = ccb.content.text("I'm interested.  How much is it going to cost?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_PURCHASE_FIELD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
