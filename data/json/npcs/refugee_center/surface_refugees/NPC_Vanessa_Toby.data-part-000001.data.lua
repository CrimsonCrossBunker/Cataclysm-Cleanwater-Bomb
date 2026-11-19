local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Vanessa_1_firstmeet", "TALK_REFUGEE_Vanessa_2", "TALK_REFUGEE_Vanessa_Background",
        "TALK_REFUGEE_Vanessa_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Vanessa_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Vanessa_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Vanessa_Situation",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I'd like to hire out those scissors of yours."),
            next_topic = "TALK_REFUGEE_Vanessa_Haircut",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "vanessa_haircut_in_progress")), predicates.negate(predicates.has_effect("interlocutor", "vanessa_shave_in_progress")), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Vanessa_Mission1" } }) }),
        },
        {
            text = ccb.content.text("Hmm, can we change this haircut a little please?"),
            next_topic = "TALK_CUT_YOUR_HAIR",
            when = predicates.has_effect("interlocutor", "vanessa_haircut_in_progress"),
        },
        {
            text = ccb.content.text("Hmm, can we change this shave a little please?"),
            next_topic = "TALK_CUT_YOUR_BEARD",
            when = predicates.has_effect("interlocutor", "vanessa_shave_in_progress"),
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
