local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_JENNY_2", "TALK_REFUGEE_JENNY_Background1", "TALK_REFUGEE_JENNY_Personal1", "TALK_REFUGEE_JENNY_Project1", "TALK_REFUGEE_JENNY_Project2", "TALK_REFUGEE_JENNY_Project3", "TALK_REFUGEE_JENNY_Refugees1", "TALK_REFUGEE_JENNY_FreeMerchants", "TALK_REFUGEE_JENNY_Refugees2_Fatima", "TALK_REFUGEE_JENNY_Refugees2_Friends", "TALK_REFUGEE_JENNY_Refugees2_Borichenko", "TALK_REFUGEE_JENNY_Refugees2_Singh", "TALK_REFUGEE_JENNY_Refugees2_Others" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("What are you working on?"),
            next_topic = "TALK_REFUGEE_JENNY_Project1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_3" } })),
        },
        {
            text = ccb.content.text("How's everything going with that defense system?"),
            next_topic = "TALK_REFUGEE_JENNY_Project3",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_3" } }),
        },
        {
            text = ccb.content.text("Tell me a bit about your background."),
            next_topic = "TALK_REFUGEE_JENNY_Background1",
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_REFUGEE_JENNY_Personal1",
        },
        {
            text = ccb.content.text("Are you free to teach me anything today?"),
            next_topic = "TALK_REFUGEE_JENNY_Teach2",
            when = predicates.handler("dlg_p_dda_dc1bf359f426"),
        },
        {
            text = ccb.content.text("Can you tell me anything about the other refugees here?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees1",
        },
        {
            text = ccb.content.text("How did you make it here during the chaos?"),
            next_topic = "TALK_REFUGEE_JENNY_Survival",
        },
        {
            text = ccb.content.text("What do you think happened to the world?"),
            next_topic = "TALK_REFUGEE_JENNY_World",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_1",
    line = ccb.content.text("*is a thin woman in her early thirties, with the sort of pale, freckled skin that looks like it would burn if she thought too hard about the sun.  Her clothes and bearing suggest she might once have been carefully put-together, but she now has the harried look of someone with too many worries and too little sleep.  She looks up from a laptop and smiles as you approach.  \"Hi there.  Haven't see you around here before.  I'm Jenny, Jenny Forcette.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Jenny_Forcette", "yes"),
                actions.set_first_topic("TALK_REFUGEE_JENNY_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice meeting you.  What are you doing on that computer?"),
            next_topic = "TALK_REFUGEE_JENNY_2",
        },
        {
            text = ccb.content.text("Nice meeting you.  I'd best get going, though."),
            next_topic = "TALK_DONE",
        },
    },
}
