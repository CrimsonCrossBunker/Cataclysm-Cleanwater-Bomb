local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- common talk responses
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_Dana_1", "TALK_REFUGEE_Dana_Background", "TALK_REFUGEE_Dana_Background_baking",
        "TALK_REFUGEE_Dana_Background_baking_revival", "TALK_REFUGEE_Dana_Situation",
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
        },
        {
            text = ccb.content.text("I spoke to the foreman over at Tacoma Ranch.  If you're willing to put in the work, they'll find some work for you over there."),
            next_topic = "TALK_REFUGEE_Dana_Tacoma2",
            when = predicates.all({ predicates.has_mission("MISSION_TACOMA_Nunez"), predicates.any_equal({ "phase_2", { scope = "speaker", key = "recruit_general_Nunez_Tacoma" } }) }),
            actions = { actions.set_actor_value("speaker", "recruit_general_Nunez_Tacoma", "phase_3") },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Dana_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Dana_Situation",
        },
        {
            text = ccb.content.text("I spoke to your husband about getting you a job at the Tacoma Ranch.  What would you think about that?"),
            next_topic = "TALK_REFUGEE_Dana_Tacoma",
            when = predicates.has_mission("MISSION_TACOMA_Nunez"),
        },
        {
            text = ccb.content.text("Your husband said to ask you what you'd think about getting out of this place and coming to work for me at my own camp."),
            next_topic = "TALK_REFUGEE_Dana_Recruit",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "recruit_general_Pablo_ask_recruit" } }),
        },
        {
            text = ccb.content.text("You seem pretty unhappy about the quality of your bread.  Is there something I can do to help?"),
            next_topic = "TALK_DANA_Sourdough",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_Dana_Sourdough" } }) }),
        },
        {
            text = ccb.content.text("I've got your sourdough."),
            next_topic = "TALK_DANA_Sourdough3",
            when = predicates.has_item("speaker", "landough_calrisean"),
        },
        {
            text = ccb.content.text("Got any more bread I can trade flour for?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_trade_Dana_Bread_Sales" } }), predicates.negate(predicates.has_effect("interlocutor", "dana_sourdough_revival")) }),
        },
        {
            text = ccb.content.text("Got any more bread I can trade flour for?"),
            next_topic = "TALK_REFUGEE_Dana_Background_baking_revival",
            when = predicates.has_effect("interlocutor", "dana_sourdough_revival"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_1_firstmeet",
    line = ccb.content.text("*is a pale woman with a broad, friendly face.  She seems to start opening with a wide grin, then notices her somber surroundings and dials it back to a pleasant smile.  \"Hi there.  I'm Dana, Dana Nunez.  Nice to see a new face.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Dana_Nunez", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Dana_1"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Dana, hey?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_REFUGEE_Dana_Situation",
        },
        {
            text = ccb.content.text("Nice to meet you, Dana.  What's your story?"),
            next_topic = "TALK_REFUGEE_Dana_Background",
        },
        {
            text = ccb.content.text("Hi Dana, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
