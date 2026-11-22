local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Alonso_2", "TALK_REFUGEE_Alonso_Background", "TALK_REFUGEE_Alonso_Situation" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Alonso_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("You seem a little forward…"),
            next_topic = "TALK_REFUGEE_Alonso_Forward",
        },
        {
            text = ccb.content.text("[PER 10] What is up with you?  What's with the fake accent, and speaking in the third person?"),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut1",
            when = predicates.all({ predicates.minimum_attribute("speaker", "perception", 10), predicates.negate(predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } })), predicates.negate(predicates.any_equal({ "accepted", { scope = "interlocutor", key = "general_none_Alonso_accent" } })) }),
        },
        {
            text = ccb.content.text("Why aren't you wearing any pants?"),
            next_topic = "TALK_REFUGEE_Alonso_Pants1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Alonso_pants" } })),
        },
        {
            text = ccb.content.text("About those special pants a sexy clown hid in a shop for mysterious reasons…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.any_equal({ "in_progress", { scope = "speaker", key = "mission_flag_Alonso_pants" } }),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_REFUGEE_Alonso_Background",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_REFUGEE_Alonso_Situation",
        },
        {
            text = ccb.content.text("[PRETTY] Remember that nice thing I did for you?  Can you do something nice for me?"),
            next_topic = "TALK_REFUGEE_Alonso_Pretty_Action",
            when = predicates.handler("dlg_p_dda_78ae1d01ea65"),
        },
        {
            text = ccb.content.text("So about those condoms.  I thought of a good use for them…"),
            next_topic = "TALK_REFUGEE_Alonso_Normal_Action",
            when = predicates.handler("dlg_p_dda_70c3c5fe68ba"),
        },
        {
            text = ccb.content.text("[UGLY] I'm desperate.  You're my only chance."),
            next_topic = "TALK_REFUGEE_Alonso_Ugly_Action",
            when = predicates.handler("dlg_p_dda_a48324f18173"),
        },
        {
            text = ccb.content.text("So about those condoms.  I thought of a good use for them…"),
            next_topic = "TALK_REFUGEE_Alonso_Too_Young",
            when = predicates.handler("dlg_p_dda_4a83d5269f04"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1",
    line = {
        joined = {
            ccb.content.text("*is an uncharacteristically well-groomed young man, his hair trim and slicked back.  In this stark setting, he looks like a cartoon character on a live-action set piece.  \""),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("Oh my, it's good to see such a strong and handsome fellow around here"),
                no = ccb.content.text("Oh my, you're a beautiful lady, so nice to see you"),
            },
            ccb.content.text(".\"  He slides his hand through his hair and smiles, his eyes half-lidded.  \"They call me Alonso.\""),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Alonso_Lautrec", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Alonso_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Alonso."),
            next_topic = "TALK_REFUGEE_Alonso_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Alonso, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
