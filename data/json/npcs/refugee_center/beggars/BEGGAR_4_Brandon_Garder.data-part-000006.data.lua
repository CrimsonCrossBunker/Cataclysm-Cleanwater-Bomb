local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_JOIN",
    line = ccb.content.text("It's sweet of you to say that, but I'm just not up to the wandering life, not with these knees."),
    replies = {
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
