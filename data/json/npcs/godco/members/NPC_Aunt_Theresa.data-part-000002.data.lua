local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_2",
    line = {
        choices = {
            ccb.content.text("Just fine.  Nice of you to ask.  How's it going, <granny_name_g>?"),
            ccb.content.text("I'm doing as well as can be expected.  How's everything, <granny_name_g>?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm here about the scarf."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_56f3a4b9bb1e"),
            actions = { actions.handler("dlg_a_dda_4e9bbce8c9e2") },
        },
        {
            text = ccb.content.text("I'm here about the blanket."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_9dec920460e6"),
            actions = { actions.handler("dlg_a_dda_a026e5b0762a") },
        },
        {
            text = ccb.content.text("I'm here about the quilt."),
            next_topic = "TALK_GODCO_Theresa_Knit_Done",
            when = predicates.handler("dlg_p_dda_5f469fab0828"),
            actions = { actions.handler("dlg_a_dda_cae2469c91fb") },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
