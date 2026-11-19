local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY_NOT_ENOUGH",
    line = {
        choices = {
            ccb.content.text("It just seemed like it wouldn't be enough.  I know it's silly but I have to do more than that."),
        },
    },
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Is there anything I can do?"),
            next_topic = "TALK_BLACKSMITH_JAY_QUEST",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
