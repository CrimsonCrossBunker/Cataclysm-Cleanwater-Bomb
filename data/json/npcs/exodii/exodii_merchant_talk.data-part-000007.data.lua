local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_TalkJob",
    line = ccb.content.text("Aye, business afore, 'tis said.  What'll ye tass to ol' Rubik?"),
    replies = {
        {
            text = ccb.content.text("Do the Exodii have any work I could do?"),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
        {
            text = ccb.content.text("Are there any materials the Exodii need?"),
            next_topic = "TALK_EXODII_MERCHANT_ANUS_FETICK_ALT",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "CBM_Interface"), predicates.has_trait("speaker", "NL_CBM_Interface") }), predicates.negate(predicates.has_mission("RUBIK_ANUS_FETICK")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_anusfetick" } })) }),
        },
        {
            text = ccb.content.text("I've brought the anesthetic for you.  Can you help me out?"),
            next_topic = "TALK_EXODII_MERCHANT_ExodizeMe2",
            when = predicates.all({ predicates.has_inventory("speaker", "anesthetic", 1000), predicates.has_mission("RUBIK_ANUS_FETICK") }),
            actions = { actions.transfer_items("anesthetic", 1000), actions.finish_mission("RUBIK_ANUS_FETICK", { success = true }) },
        },
        {
            text = ccb.content.text("I paid a visit to the bunker."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_complete",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_u_scouted_bunker" } }) }),
            actions = { actions.clear_actor_value("speaker", "mission_completed_u_scouted_bunker"), actions.handler("dlg_a_dda_e3d719172842") },
        },
        {
            text = ccb.content.text("I found the warehouse."),
            next_topic = "TALK_EXODII_MERCHANT_mission_2_complete",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_u_found_warehouse" } }) }),
            actions = { actions.clear_actor_value("speaker", "mission_completed_u_found_warehouse"), actions.handler("dlg_a_dda_ca47b5501c73") },
        },
        {
            text = ccb.content.text("I found the missing Exodii.  I'm sorry to say that they're dead, but I recovered their head."),
            next_topic = "TALK_EXODII_MERCHANT_mission_3_complete",
            when = predicates.all({ predicates.has_inventory("speaker", "exodii_chop_shop_head", 1), predicates.has_mission("EXODII_MISSION_CHOP_SHOP") }),
            actions = { actions.handler("dlg_a_dda_d1be8bff804a"), actions.finish_mission("EXODII_MISSION_CHOP_SHOP", { success = true }) },
        },
        {
            text = ccb.content.text("So, we seem to be done with the negotiations.  Let's talk payment."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete",
            when = predicates.handler("dlg_p_dda_103fd2568028"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }) },
        },
        {
            text = ccb.content.text("Well, the deal went through.  I did my best, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete_partial",
            when = predicates.handler("dlg_p_dda_5246ac7028f5"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }) },
        },
        {
            text = ccb.content.text("Those negotiations didn't go so well, did they?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_4_complete_failed",
            when = predicates.handler("dlg_p_dda_9ea6d88123e8"),
            actions = { actions.finish_mission("EXODII_MISSION_MEET_FREE_MERCHANTS", { success = true }), actions.adjust_faction_trust(-10) },
        },
        {
            text = ccb.content.text("I managed to find a computer in that other-Exodii place we talked about.  Here's the data."),
            next_topic = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Complete",
            when = predicates.all({ predicates.has_inventory("speaker", "exodii_usb_stick_full", 1), predicates.has_mission("EXODII_MISSION_STRING_DIMENSION_EXODII") }),
            actions = { actions.handler("dlg_a_dda_cac82ea89c70"), actions.finish_mission("EXODII_MISSION_STRING_DIMENSION_EXODII", { success = true }) },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Actually, I changed my mind.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
