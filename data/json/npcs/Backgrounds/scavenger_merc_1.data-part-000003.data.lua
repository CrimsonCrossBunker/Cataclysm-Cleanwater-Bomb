local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY2",
    line = ccb.content.text("Oh, yeah, this is a good choice.  Hold on to it for me, let's have a drink later.  Right now we're practically swimming in good whisky, but some day the last bottle will get drunk.  It's gonna be a long time before any of us is brewing nice scotch, and we ain't never gettin' peat from Islay ever again.  Makes me shed a tear just thinking about it."),
    on_enter = {
        { opinion = { trust = 1, value = 1 } },
    },
    replies = {
        {
            text = ccb.content.text("You owe me a story."),
            next_topic = "BGSS_SCAVENGER_MERC_1_STORY3",
            actions = { actions.add_effect("interlocutor", "BGSS_Merc_haswhisky", { permanent = true }) },
        },
    },
}
