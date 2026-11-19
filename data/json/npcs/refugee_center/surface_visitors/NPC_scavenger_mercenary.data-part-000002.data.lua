local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_NEW",
    line = ccb.content.text("I'm just a hired hand.  Someone pays me and I do what needs to be done."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_SCAVENGER_MERC" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_TIPS",
    line = ccb.content.text("If you have to fight your way out of an ambush, the only thing that is going to save you is having a party that can return fire.  People who work alone are easy pickings for monsters and bandits."),
    replies = {
        {
            text = ccb.content.text("I suppose I should hire a party then?"),
            next_topic = "TALK_SCAVENGER_MERC",
        },
    },
}
