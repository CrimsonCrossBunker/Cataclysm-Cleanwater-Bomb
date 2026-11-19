local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CYBORG_1_STORY1",
    line = ccb.content.text("Oh God… *Zzzzt* I… I don't know what ha-happened.  *BEEEEEEP* They told me I was going to become the very b-best!  And then I c-can only remember pain and screams.  P-Please don't *Zzzt* leave me here!"),
    replies = {
        {
            text = ccb.content.text("You're okay, it's over now."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
