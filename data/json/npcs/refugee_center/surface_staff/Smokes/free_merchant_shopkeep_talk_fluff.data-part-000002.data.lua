local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes",
    line = ccb.content.text("*rolls his eyes.  \"Tell me about it.  My actual name is Gavin, which I think I told you.  I used to be a firefighter, and people started recognizing me because of the helmet.  Someone called me 'smokes' because of it, and it stuck.  I hate it.  I've never even touched a cigarette.\""),
    replies = {
        {
            text = ccb.content.text("[PER 8] If you hate it, then why are you smiling?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe_Smokes2",
            when = predicates.minimum_attribute("speaker", "perception", 8),
        },
        {
            text = ccb.content.text("Can't say I blame you."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe",
        },
    },
}
