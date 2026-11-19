local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_danger_sense" },
    line = ccb.content.text("&You extend your senses, alert for danger, and are surprised at the result.  There is danger here, but it's muted, and certainly Rubik doesn't seem to bear you any malice.  If any place is safe in the hell that the Earth has become, this is it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EXODII_MERCHANT_Talk" } },
}

-- TODO: Change this depending on how much Rubik trusts the PC.
ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_sense_hostility" },
    line = ccb.content.text("&You extend your senses, probing at Rubik's attitude, and come away with a sense of relief.  Rubik certainly doesn't plan any violent action at this moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EXODII_MERCHANT_Talk" } },
}
