local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_APOLOGY",
    line = ccb.content.text("Thanks for saying it.  So, what brings you around?"),
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("What's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text("Just wanted to get square.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
