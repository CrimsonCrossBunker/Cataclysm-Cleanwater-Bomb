local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER_FRIENDS",
    line = ccb.content.text("They should be around here somewhere.  We usually go out in teams to scavenge, and they haven't told me about anything yet.  They might have something for you to do."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}
