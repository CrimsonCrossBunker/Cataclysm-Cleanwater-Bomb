local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_COMPLAIN",
    line = ccb.content.text("They're 'too full'.  Won't share fuck-all."),
    replies = {
        {
            text = ccb.content.text("Why are you living here then?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_COMPLAIN2",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Well, they might not share, but I can.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_COMPLAIN2",
    line = ccb.content.text("Even without them helping, it's the safest place to squat.  As long as we keep it clean up here and don't cause sanitation problems, they don't mind us sitting around the entryway.  So kind and generous of them, to let us sit here and slowly starve."),
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Well, they might not share, but I can.  Are you hungry?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
