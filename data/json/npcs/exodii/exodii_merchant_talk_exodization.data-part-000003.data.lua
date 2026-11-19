local ccb = require("ccb")

-- Rubik is skeptical of you if you are over-eager to get dissected down to your guts.
-- No, I don't think so.  Not today.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Cyberframe_trust_no_weirdo",
    line = ccb.content.text("&Rubik is quiet for a long moment, and is clearly sizing you up.  \"No, methinks not today.\""),
    replies = {
        {
            text = ccb.content.text("Well, I guess I'll ask again another time.  <end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
