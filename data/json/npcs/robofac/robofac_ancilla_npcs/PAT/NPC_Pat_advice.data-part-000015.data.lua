local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_CONTACT_HUB",
    line = ccb.content.text("Yeah, don't cross our employahs.  Just tell them the basics, get paid, move on."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}
