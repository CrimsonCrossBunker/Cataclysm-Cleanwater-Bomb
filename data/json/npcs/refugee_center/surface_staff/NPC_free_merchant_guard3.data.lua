local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_WASTE",
    line = ccb.content.text("If you don't get on with your business I'm going to have to ask you to leave and not come back."),
    replies = { { text = ccb.content.text("Sorry."), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_DEAD",
    line = ccb.content.text("That's it, you're dead!"),
    replies = {
        { text = ccb.content.text("I didn't mean it!"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_HOSTILE",
    line = ccb.content.text("You must really have a death wish!"),
    replies = {
        { text = ccb.content.text("I didn't mean it!"), next_topic = "TALK_DONE" },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_INSULT",
    line = ccb.content.text("We don't put-up with garbage like you, finish your business and get the hell out."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
