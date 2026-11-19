local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Firstmeet",
    line = ccb.content.text("I have a name, you know.  It's Jeremiah, but people just call me Jerry."),
    replies = {
        {
            text = ccb.content.text("Sorry, Jerry.  What's up?"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text("Sorry, Jeremiah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
