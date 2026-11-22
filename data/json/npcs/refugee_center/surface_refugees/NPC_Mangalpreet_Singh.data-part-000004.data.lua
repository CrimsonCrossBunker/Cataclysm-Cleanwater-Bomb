local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_Situation",
    line = {
        joined = {
            ccb.content.text("I have my family.  I have the Guru Granth Sahib"),
            {
            when = predicates.handler("dlg_p_dda_f4f8d93f10a9"),
            yes = ccb.content.text(".  For a while, I thought these might not be enough but… I am allowing myself to hope"),
            no = ccb.content.text(".  I have these things, but I do not have peace.  No one here does"),
        },
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }),
            yes = ccb.content.text(".  Still, we have so much work to do to make a home here."),
            no = ccb.content.text(".  We are crowded, we are plagued by the sounds and the memories of the dead.  The situation is grim."),
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
