local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_A_PRIEST",
    line = ccb.content.gendered_line("I'm a priest or guide of a sort.  I sing the hymns along my companions so that we may learn to live in unity, both with each other and with our ailing world.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Alright."), next_topic = "TALK_MARLOSS_VOICE" },
        {
            text = ccb.content.text("Can I join you?"),
            next_topic = "TALK_MARLOSS_VOICE_WITH_US",
            when = predicates.has_flag("speaker", "mycus"),
        },
        {
            text = ccb.content.text("Understood.  Can I join you?"),
            next_topic = "TALK_MARLOSS_VOICE_OFFER_BERRY",
            when = predicates.all({ predicates.negate(predicates.has_flag("speaker", "mycus")), predicates.negate(predicates.has_effect("speaker", "u_given_berry")) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
