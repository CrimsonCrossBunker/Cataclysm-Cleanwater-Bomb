local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Wanderer",
    line = ccb.content.text("Just like all the sinners, roaming through Hell."),
    replies = {
        {
            text = ccb.content.text("It certainly seems like it."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("See ya later, crazy lady."),
            opinion = { value = -1, anger = 1 },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Joinee",
    line = ccb.content.gendered_line("I'm glad you could make it here.  May the Lord have mercy on you.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Thank you, I hope he shares that sentiment."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        { text = ccb.content.text("Thank you.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
