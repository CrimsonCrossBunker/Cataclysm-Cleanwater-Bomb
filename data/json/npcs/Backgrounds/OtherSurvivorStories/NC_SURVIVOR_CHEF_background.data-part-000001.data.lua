local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BOSS_NC_SURVIVOR_CHEF_Story2",
    line = ccb.content.text("*shows you on your map where to find it.  \"This looks right to me.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}
