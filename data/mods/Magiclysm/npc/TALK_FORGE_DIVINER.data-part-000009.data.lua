local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MI_GO",
    line = ccb.content.text("Right.  Fungal crustaceans from space.  Mighty unpleasant fellas, if you ask me.  But, uh, don't tell them I said so.  The forge lord says they mean no offense, that cutting people up is just their way of saying 'hi'.  Personally I find it rude, but perhaps that's anthropocentric of me.  But I digress.  Are you interested in an encampment or a scout tower?"),
    replies = {
        {
            text = ccb.content.text("An encampment."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MI_GO_ENCAMPMENT",
        },
        {
            text = ccb.content.text("A scout tower."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MI_GO_TOWER",
        },
        { text = ccb.content.text("On second thought…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
