local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "BEM_CHATTING_VETERANS_1" },
    line = ccb.content.text("&A pair of veteran mercenaries share stories between bouts of heavy drinking.  You could probably join them if you wanted to."),
    replies = {
        {
            text = ccb.content.text("[Join and hear them out for a while.]"),
            next_topic = "BEM_CHATTING_VETERANS_HEAR",
        },
        {
            text = ccb.content.text("[Join them in their heavy drinking.]"),
            next_topic = "BEM_CHATTING_VETERANS_DRINKING",
        },
        {
            text = ccb.content.text("[Join them with a story of your own.]"),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY",
        },
        { text = ccb.content.text("[Just move along.]"), next_topic = "TALK_DONE" },
    },
}
