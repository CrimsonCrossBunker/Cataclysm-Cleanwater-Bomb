local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_HUNTER",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.gendered_line("I thought I smelled a pig.  I jest… please don't arrest me.", { "interlocutor" }),
        no = ccb.content.gendered_line("Huh, thought I smelled someone new.  Can I help you?", { "interlocutor" }),
    },
    replies = {
        { text = ccb.content.text("You… smelled me?"), next_topic = "TALK_EVAC_HUNTER_SMELL" },
        {
            text = ccb.content.text("What do you do around here?"),
            next_topic = "TALK_EVAC_HUNTER_DO",
        },
        { text = ccb.content.text("Got anything for sale?"), next_topic = "TALK_EVAC_HUNTER_SALE" },
        {
            text = ccb.content.text("Got any survival advice?"),
            next_topic = "TALK_EVAC_HUNTER_ADVICE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_EVAC_HUNTER_BYE",
        },
    },
}
