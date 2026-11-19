local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Uyen_2", "TALK_REFUGEE_Uyen_Background", "TALK_REFUGEE_Uyen_Situation",
        "TALK_REFUGEE_Uyen_Training", "TALK_REFUGEE_Uyen_World", "TALK_REFUGEE_Uyen_Kaiju",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_REFUGEE_Accept_Boris_Mission_1" },
            failure = { next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Uyen_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Uyen_Situation",
        },
        {
            text = ccb.content.text("Could you teach me a bit about first aid?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_Uyen_teach" } }),
            next_topic = "TALK_REFUGEE_Uyen_Teach",
        },
        {
            text = ccb.content.text("What do you think happened to the world?"),
            next_topic = "TALK_REFUGEE_Uyen_World",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
