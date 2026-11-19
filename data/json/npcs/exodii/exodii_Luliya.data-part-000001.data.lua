local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_PULSE",
    line = ccb.content.text("&You press your stethoscope to the chest of the figure and hear a clear, strong heartbeat and a strange whirring sound that sounds like clockwork."),
    replies = {
        { text = ccb.content.text("So she's alive then."), next_topic = "TALK_LULIYA" },
        {
            text = ccb.content.text("Probably fine then.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
