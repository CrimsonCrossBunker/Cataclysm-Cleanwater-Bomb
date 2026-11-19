local ccb = require("ccb")

-- In the future this should start a quest line or allow free merchant caravans to sometimes show up near the Exodii base.
ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_1",
    line = ccb.content.text("Well now, that's a hell of a story.  Some day, I'll see if we can get out there an' look into it.  Sounds like there'd be some real interestin' trade."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
    },
}
