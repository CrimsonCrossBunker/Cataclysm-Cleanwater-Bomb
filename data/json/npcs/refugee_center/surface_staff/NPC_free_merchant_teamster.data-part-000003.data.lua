local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
    line = ccb.content.text("*shows you on your map where to find it.  \"That should get you there.  Good luck, I 'spect you'll need it.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}
