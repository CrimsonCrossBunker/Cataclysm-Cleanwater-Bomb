local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_MISSION_DESCRIBE_URGENT", "TALK_MISSION_DESCRIBE" },
    replies = {
        { text = ccb.content.text("What's the matter?"), next_topic = "TALK_MISSION_OFFER" },
        { text = ccb.content.text("I don't care."), next_topic = "TALK_MISSION_REJECTED" },
    },
}
