local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
    line = {
        choices = {
            ccb.content.text("Unfortunately, I don't have anything that can help."),
            ccb.content.text("I don't know what I could offer."),
            ccb.content.text("Afraid not.  Maybe somebody else could help."),
            ccb.content.gendered_line("Have you asked the scavenger boss if they'd have anything?", { "speaker" }),
            ccb.content.text("Maybe the scrapper would have some spare parts?"),
        },
    },
    replies = {
        { text = ccb.content.text("OK."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
