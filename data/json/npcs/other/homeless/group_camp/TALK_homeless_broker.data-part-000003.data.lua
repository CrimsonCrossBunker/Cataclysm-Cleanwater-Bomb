local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_MASSTRADE",
    line = ccb.content.text("Sure!  It turned out well enough for us, and it's one of the few fresh meats we can find.  I'll pay fairly for it."),
    repeat_replies = {
        {
            items = { "mutant_meat" },
            reply = { text = ccb.content.text("I have <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("I have nothing."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
        },
        {
            text = ccb.content.text("I have nothing.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
