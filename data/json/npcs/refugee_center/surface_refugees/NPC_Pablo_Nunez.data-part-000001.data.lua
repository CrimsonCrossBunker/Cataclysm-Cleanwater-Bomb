local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Pablo_1_firstmeet", "TALK_REFUGEE_Pablo_2", "TALK_REFUGEE_Pablo_Background1",
        "TALK_REFUGEE_Pablo_Background2_pregnancy", "TALK_REFUGEE_Pablo_Background2_sorry",
        "TALK_REFUGEE_Pablo_Background2_survivors", "TALK_REFUGEE_Pablo_Background2_cleared",
        "TALK_REFUGEE_Pablo_Situation", "TALK_REFUGEE_Pablo_Tacoma", "TALK_REFUGEE_Pablo_Tacoma2",
        "TALK_REFUGEE_Pablo_Recruit",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Pablo_Background1",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Pablo_Situation",
        },
        {
            text = ccb.content.text("Dana wanted me to be the one to let you know: they've got work for you over at the ranch.  You could get out of here if you want."),
            next_topic = "TALK_REFUGEE_Pablo_Tacoma2",
            when = predicates.all({ predicates.has_mission("MISSION_TACOMA_Nunez"), predicates.any_equal({ "phase_3", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Pablo."), next_topic = "TALK_DONE" },
    },
}
