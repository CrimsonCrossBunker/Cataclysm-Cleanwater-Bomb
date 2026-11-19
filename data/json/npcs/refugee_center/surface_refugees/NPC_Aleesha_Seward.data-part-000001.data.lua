local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Aleesha_2", "TALK_REFUGEE_Aleesha_Background",
        "TALK_REFUGEE_Aleesha_Background_caretaker", "TALK_REFUGEE_Aleesha_Background_influencers",
        "TALK_REFUGEE_Aleesha_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "TALK_REFUGEE_Accept_Boris_Mission_1" },
            failure = { next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Aleesha_Background",
        },
        {
            text = ccb.content.text("What's your take on the situation here?"),
            next_topic = "TALK_REFUGEE_Aleesha_Situation",
        },
    },
}
