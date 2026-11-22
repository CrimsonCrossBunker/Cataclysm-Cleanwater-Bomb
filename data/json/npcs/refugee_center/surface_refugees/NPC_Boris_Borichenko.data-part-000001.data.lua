local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Boris_2", "TALK_REFUGEE_Boris_3", "TALK_REFUGEE_Boris_Background", "TALK_REFUGEE_Boris_Background_B", "TALK_REFUGEE_Boris_Background_loss", "TALK_REFUGEE_Boris_Work1", "TALK_REFUGEE_Boris_Situation" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Boris_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("Boris, I'm sorry, but I could only find two people willing to help.  Can I pitch in myself?  [Spend 5 hours helping]"),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith2",
            when = predicates.handler("dlg_p_dda_681194643ca7"),
        },
        {
            text = ccb.content.text("Boris, I'm sorry, but I could only find three people willing to help.  Can I pitch in myself?  [Spend 4 hours helping]"),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith3",
            when = predicates.handler("dlg_p_dda_7ee9ed104324"),
        },
        {
            text = ccb.content.text("I spoke with everyone I could, but only four people agreed to help.  I can pitch in if you want."),
            next_topic = "TALK_REFUGEE_Boris_MakeDoWith4",
            when = predicates.handler("dlg_p_dda_b5e60d60a9f0"),
        },
        {
            text = ccb.content.text("Is there anything I can help you out with?"),
            next_topic = "TALK_REFUGEE_Boris_Work1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } })),
        },
        {
            text = ccb.content.text("Got anything else I can help out with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_1" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } })) }),
        },
        {
            text = ccb.content.text("So, have you had a chance to get that laptop working and look at it yet?"),
            next_topic = "TALK_REFUGEE_Boris_ReadLaptop1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Boris_mission_3" } }),
        },
        {
            text = ccb.content.text("Now that you've got your tools and shop set up, do you think you could teach me a thing or two about construction?"),
            next_topic = "TALK_REFUGEE_Boris_Teach",
            when = predicates.handler("dlg_p_dda_7202e00080e0"),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Boris_Background",
        },
        {
            text = ccb.content.text("You don't seem to be doing great."),
            next_topic = "TALK_REFUGEE_Boris_Background_B",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Boris_Situation",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1",
    line = ccb.content.text("Ah, another new face.  Hello.  I am Boris."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Boris_Borichenko", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Boris_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Boris."),
            next_topic = "TALK_REFUGEE_Boris_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Boris, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
