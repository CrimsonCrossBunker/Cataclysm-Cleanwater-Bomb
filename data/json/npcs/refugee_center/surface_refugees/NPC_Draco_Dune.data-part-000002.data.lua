local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1a",
    line = ccb.content.gendered_line("Always good to see you, friend.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi, Draco, how are you doing?"),
            next_topic = "TALK_REFUGEE_Draco_2",
            when = predicates.handler("dlg_p_dda_6f5900f35a2a"),
        },
        {
            text = ccb.content.text("Hi again, Draco, nice to see you too."),
            next_topic = "TALK_REFUGEE_Draco_5a",
            when = predicates.handler("dlg_p_dda_dd80a02d9880"),
        },
        {
            text = ccb.content.text("Hi again, Draco, nice to see you too."),
            next_topic = "TALK_REFUGEE_Draco_7",
            when = predicates.handler("dlg_p_dda_0b77d9b346c2"),
        },
        {
            text = ccb.content.text("Hi Draco, nice to see you too.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
