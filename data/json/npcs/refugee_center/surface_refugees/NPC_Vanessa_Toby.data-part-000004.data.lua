local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Background",
    line = ccb.content.text("I don't really want to talk about my life before this shit-show, if that's what you mean.\"  She shrugs.  \"I don't need a shoulder to cry on.  I'm a hairdresser, is that enough personal information for you?"),
    replies = {
        {
            text = ccb.content.text("Could you give me a haircut?"),
            next_topic = "TALK_REFUGEE_Vanessa_Haircut_no",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } })),
        },
    },
}
