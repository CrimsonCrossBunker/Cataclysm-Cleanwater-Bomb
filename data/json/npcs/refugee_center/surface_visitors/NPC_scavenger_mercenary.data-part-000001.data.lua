local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.gendered_line("I haven't done anything wrong…", { "interlocutor" }),
        no = ccb.content.text("…"),
    },
    replies = {
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_SCAVENGER_MERC_NEW" },
        {
            text = ccb.content.text("Any tips for surviving?"),
            next_topic = "TALK_SCAVENGER_MERC_TIPS",
        },
        {
            text = ccb.content.text("What would it cost to hire you?"),
            next_topic = "TALK_SCAVENGER_MERC_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
