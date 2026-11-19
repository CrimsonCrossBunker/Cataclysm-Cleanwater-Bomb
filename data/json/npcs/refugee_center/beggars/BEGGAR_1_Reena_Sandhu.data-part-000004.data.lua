local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_JOIN",
    line = ccb.content.text("That's a kind offer of you, but I think I'd rather take my chances here than risking it out there again.  I remember <the_cataclysm>, I'm not in any hurry to face that again."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_LEAVE",
        },
        {
            text = ccb.content.text("Why don't you scavenge your own food?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_SCAVENGE",
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_1_EXPERTISE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}
