local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Stan_2", "TALK_REFUGEE_Stan_Background", "TALK_REFUGEE_Stan_Situation",
        "TALK_REFUGEE_Stan_Boris", "TALK_REFUGEE_Stan_Garry",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("Do you want to talk about your story?"),
            next_topic = "TALK_REFUGEE_Stan_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Stan_Situation",
        },
    },
}
