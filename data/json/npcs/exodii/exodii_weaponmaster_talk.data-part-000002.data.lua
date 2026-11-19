local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_5",
    line = ccb.content.text("&They do not move and do not say anything."),
    replies = {
        {
            text = ccb.content.text("Hey?  Do you understand me?"),
            next_topic = "TALK_WEAPONMASTER_INTRO_6",
        },
    },
}
