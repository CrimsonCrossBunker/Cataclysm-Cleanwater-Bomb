local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Robofac_Start",
    line = ccb.content.text("I was hoping you'd say that.  It's an old isolated building not too far from here; you should probably just leave the drive to whoever's there and be on your way.  And like I said, be careful approaching the place.  I wouldn't like leading you straight into your death."),
    replies = {
        {
            text = ccb.content.text("Don't worry, I'll be careful.  I'll let you know when it's done."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I'm sure I'll manage."), next_topic = "TALK_DONE" },
    },
}
