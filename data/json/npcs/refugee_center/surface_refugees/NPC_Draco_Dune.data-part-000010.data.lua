local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_Dance",
    line = ccb.content.gendered_line("Sure thing, friend!  Let's see how you can move to this one.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Just a sec, got something I need to do first."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[Shuffle back and forth a little.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_1",
            when = predicates.handler("dlg_p_dda_a34118e38e05"),
            switch = true,
        },
        {
            text = ccb.content.text("[Do a little dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_2",
            when = predicates.handler("dlg_p_dda_9623c8d7a546"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a decent dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_3",
            when = predicates.handler("dlg_p_dda_f008b74ca526"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform an impressive dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_4",
            when = predicates.handler("dlg_p_dda_507a9328c34f"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a masterful dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_5",
            when = predicates.handler("dlg_p_dda_228162772555"),
            switch = true,
        },
        {
            text = ccb.content.text("[Perform a legendary dance.]"),
            next_topic = "TALK_REFUGEE_Draco_Dance_6",
            when = predicates.handler("dlg_p_dda_e3c0424690ab"),
            switch = true,
            default = true,
        },
    },
}
